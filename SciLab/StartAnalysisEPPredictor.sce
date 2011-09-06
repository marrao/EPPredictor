// UI utility for selecting the working directory example: /SomePath/EPPredictor/
WorkingDirectory=uigetdir();
chdir(WorkingDirectory);
datafile=uigetfile();//select the file to be used
tic();//start timer
M = read_csv(datafile,';');//Reads the data from csv file and remember result is a string matrix
M = strtod(M);//Transform strings into Doubles
DaysInYear = (size(M,1)+1)/24;//Number of days in data set
DaysInColumns = matrix(M(:,3),24,DaysInYear);//Transform M into a day per Column Madrix
disp(toc(),'time used in data PreProcessing:');//elapsed time
matrix(DaysInColumns(:,1),1,24)// get day1 in vector form

//so we have all the 2010 data in memory now!
//in order to continue with calculations we must define the norms to be used.

//EuclidianNorm l2 norm

function distance = EuclidianDistance(DayVector1, DayVector2)
  distance=norm(DayVector1-DayVector2,2)//+norm(diff(DayVector1)-diff(DayVector2))
endfunction

//GradientNorm l2 norm
function distance = GradientNorm(DayVector1, DayVector2)
  distance=norm(diff(DayVector1)-diff(DayVector2))
endfunction

//MaximumNorm l2 norm
function distance = MaximumNorm(DayVector1, DayVector2)
  distance=max(DayVector1-DayVector2)-min(DayVector1-DayVector2)
endfunction

//MinimumNorm l2 norm
function distance = MinimumNorm(DayVector1, DayVector2)
  distance=min(DayVector1-DayVector2)
endfunction

//MiniMaxNorm l2 norm
function distance = MiniMax(DayVector1, DayVector2)
  distance=min(DayVector1-DayVector2)
endfunction

//alphas values

function alphai = AlphaRule(DayVectord, DayVectori, DayVectork, DayVector1)
  alphai = (EuclidianDistance(DayVectord, DayVectork)-EuclidianDistance(DayVectord, DayVectori))/(EuclidianDistance(DayVectord, DayVectork)-EuclidianDistance(DayVectord, DayVector1))
endfunction


//lets use all data set to predic the 1st january 2011.
listDistances=[];
for i = 1:DaysInYear-1,
  listDistances=[listDistances;[EuclidianDistance(DaysInColumns(:,DaysInYear),DaysInColumns(:,i)) i]],
end
listDistances=gsort(listDistances,'lr','i');//sorted list
//now lets define the value for k aka KKK
KKK=6;
ListKNN=[];
for i = 1:KKK,
  ListKNN=[ListKNN;listDistances(i,:)],
end
ListKNN=gsort(ListKNN,'lr','i');//sorted in descending order

alphas=[];
for i = 1:KKK,
  alphai=AlphaRule(DaysInColumns(:,DaysInYear),DaysInColumns(:,ListKNN(i,2)),DaysInColumns(:,ListKNN(KKK,2)),DaysInColumns(:,ListKNN(1,2))),
  alphas=[alphas;alphai]
end


//Prediction
NextDay =alphas(1)*DaysInColumns(:,ListKNN(1,2)+1)
for i=2:KKK
  NextDay = NextDay + alphas(i)*DaysInColumns(:,ListKNN(i,2)+1),
end
predition=(1/sum(alphas))*NextDay


