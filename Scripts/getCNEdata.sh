#==============================================================================
# Copyright (c) Indizen Technologies,
# Hugo M. Marrao Rodrigues <hmarrao@indizen.com>
#==============================================================================
# getCNEData.sh:
#
# Usage: 
# 	"just execute"
#
# Output: 
#	"energy prices by year" 20NN.data 
#
# Description: 
#		This script download the files with the energy prices from the 
# www.cne.es repository and edit them for a proper use. The years are 2007, 
# 2008, 2009, 2010 and the past months from 2011
#
# Update: 
# 	to update the data just add the proper file in the FILES 
# variable.
#	added the PFMHORAS_DEM_201106.1.zip file
#	added the PFMHORAS_DEM_201107.1.zip file
#	added the PFMHORAS_DEM_201108.1.zip file
#==============================================================================

#!/bin/bash
#Raw data directory
RAWDATADIR="rawdata"
#Files url to download from
FILESURL="http://www.cne.es/cne/doc/precios"
#Files to process
FILES=(
"PFMHORAS_DEM_200701.1.zip" 
"PFMHORAS_DEM_200702.1.zip"
"PFMHORAS_DEM_200701.1.zip"
"PFMHORAS_DEM_200702.1.zip"
"PFMHORAS_DEM_200703.1.zip"
"PFMHORAS_DEM_200704.1.zip"
"PFMHORAS_DEM_200705.1.zip"
"PFMHORAS_DEM_200706.1.zip"
"PFMHORAS_DEM_200707.1.zip"
"PFMHORAS_DEM_200708.1.zip"
"PFMHORAS_DEM_200709.1.zip"
"PFMHORAS_DEM_200710.1.zip"
"PFMHORAS_DEM_200711.1.zip"
"PFMHORAS_DEM_200712.1.zip"
"PFMHORAS_DEM_200801.1.zip"
"PFMHORAS_DEM_200802.1.zip"
"PFMHORAS_DEM_200803.1.zip"
"PFMHORAS_DEM_200804.1.zip"
"PFMHORAS_DEM_200805.1.zip"
"PFMHORAS_DEM_200806.1.zip"
"PFMHORAS_DEM_200807.1.zip"
"PFMHORAS_DEM_200808.1.zip"
"PFMHORAS_DEM_200809.1.zip"
"PFMHORAS_DEM_200810.1.zip"
"PFMHORAS_DEM_200811.1.zip"
"PFMHORAS_DEM_200812.1.zip"
"PFMHORAS_DEM_200901.1.zip"
"PFMHORAS_DEM_200902.1.zip"
"PFMHORAS_DEM_200903.1.zip"
"PFMHORAS_DEM_200904.1.zip"
"PFMHORAS_DEM_200905.1.zip"
"PFMHORAS_DEM_200906.1.zip"
"PFMHORAS_DEM_200907.1.zip"
"PFMHORAS_DEM_200908.1.zip"
"PFMHORAS_DEM_200909.1.zip"
"PFMHORAS_DEM_200910.1.zip"
"PFMHORAS_DEM_200911.1.zip"
"PFMHORAS_DEM_200912.1.zip"
"PFMHORAS_DEM_201001.1.zip"
"PFMHORAS_DEM_201002.3.zip"
"PFMHORAS_DEM_201003.1.zip"
"PFMHORAS_DEM_201004.1.zip"
"PFMHORAS_DEM_201005.1.zip"
"PFMHORAS_DEM_201006.1.zip"
"PFMHORAS_DEM_201007.1.zip"
"PFMHORAS_DEM_201008.1.zip"
"PFMHORAS_DEM_201009.1.zip"
"PFMHORAS_DEM_201010.1.zip"
"PFMHORAS_DEM_201011.1.zip"
"PFMHORAS_DEM_201012.1.zip"
"PFMHORAS_DEM_201101.1.zip"
"PFMHORAS_DEM_201102.2.zip"
"PFMHORAS_DEM_201103.1.zip"
"PFMHORAS_DEM_201104.1.zip"
"PFMHORAS_DEM_201105.1.zip"
"PFMHORAS_DEM_201106.1.zip"
"PFMHORAS_DEM_201107.1.zip"
"PFMHORAS_DEM_201108.1.zip"
)

#check and if Raw data dir exists; nothing else ifnot; creates it.
mkdir -p $RAWDATADIR

for (( i = 0; i < ${#FILES[@]}; i++ ))
do
echo "Processing ${FILES[$i]}"
wget $FILESURL/${FILES[$i]}
unzip -qo ${FILES[$i]} -x *htm *xls
mv ${FILES[$i]} rawdata/${FILES[$i]}
rm -rf ${THE_FILES[$i]}
echo "Removing ${FILES[$i]}"
done
echo "Processing 2007 data"
tail PFMHORAS_DEM_2007* --quiet --lines=+14 | cut -d\; -f1,2,4 > 2007.data
echo "Processing 2008 data"
tail PFMHORAS_DEM_2008* --quiet --lines=+14 | cut -d\; -f1,2,4 > 2008.data
echo "Processing 2009 data"
tail PFMHORAS_DEM_2009* --quiet --lines=+14 | cut -d\; -f1,2,4 > 2009.data
echo "Processing 2010 data"
tail PFMHORAS_DEM_2010* --quiet --lines=+14 | cut -d\; -f1,2,4 > 2010.data
echo "Processing 2011 data"
tail PFMHORAS_DEM_2011* --quiet --lines=+14 | cut -d\; -f1,2,4 > 2011.data
rm -rf PFMHORAS*

#=======================================================================
# getCNEData.sh END
#=======================================================================
# Copyright (c) Indizen Technologies,
# Hugo M. Marrao Rodrigues <hmarrao@indizen.com>
#=======================================================================
