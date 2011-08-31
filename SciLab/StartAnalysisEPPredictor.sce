// UI utility for selecting the working directory example: /SomePath/EPPredictor/
WorkingDirectory=uigetdir();
chdir(WorkingDirectory);
// read the csv data files
tic();//start timer
M = read_csv('Observations/2010_Price.csv',';');//Reads the data fro csv file and remember result is a string matrix
M = strtod(M);//Transform strings into Doubles
DaysInYear = size(M,1)/24;//Number of days in data set
DaysInColumns = matrix(M(:,3),24,DaysInYear);//Transform M into a day per Column Madrix
disp(toc(),'time used in data PreProcessing:');//elapsed time
matrix(DaysInColumns(:,1),1,24)// get day1 in vector form

//so we have all the 2010 data in memory now!
//in order to continue with calculations we must

//EuclidianNorm
//lets use all data set to predic the january 2011.

function EuclidianDistance = EuclidianDistance(DayVector1, DayVector2)
  distance=norm(DayVector1-DayVector2,2)+norm(diff(DayVector1)-diff(DayVector2))
endfunction