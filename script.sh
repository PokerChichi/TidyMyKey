#!/bin/bash

# the round function:
round()
{
echo $(printf %.$2f $(echo "scale=$2;(((10^$2)*$1)+0.5)/(10^$2)" | bc))
};

# Checking parameters
if [ $# = 0 ]; then
	rep="."
	typ="-s"
elif [ $# = 1 ]; then
	rep=$1
	typ="-s"
elif [ $# = 2 ]; then
	if [ $2 != "-s" ] && [ $2 != "-r" ]; then
		echo "Usage: script [directory] [type]"
		echo "Usage: type: -s:sort -r:rename"
		exit 1
	fi
	rep=$1
	typ=$2
else
	echo "Usage: script [directory] [type]"
	echo "Usage: type: -s:sort -r:rename"
	exit 1
fi

# List of dangerous extention
dan=("exe" "pif" "application" "gadget" "msi" "msp" "com" "scr" "hta" "cpl" "msc" "jar" "bat" "cmd" "vb" "vbs" "vbe" "js" "jse" "ws" "wsf" "wsc" "wsh" "ps1" "ps1xml" "ps2" "ps2xml" "psc1" "psc2" "msh" "msh1" "msh1" "mshxml" "msh1xml" "msh2xml" "scf" "lnk" "inf" "reg" "docm" "dotm" "xlsm" "xltm" "xlam" "pptm" "potm" "ppam" "ppsm" "sldm")

# Directories creation
#if [ $typ = "-s" ]; then
#	for (( i=0; i<11; i++ )); do mkdir -p lvl$i; done
#fi

# Creation of files list
find $rep/ -type f > tmp.txt

# Analyse all files
while read line  
do   
	sum=0;	# sum
	com=0;	# meter
	
   # type of file
   ft=`file -bz --mime-type $line | cut -d'/' -f2`
      
   # lvl dangerosity
   ave=0;	# average

	# go in directory   
   cd cve-search

	# use search function
	python3.3 search.py -f $ft | grep -o "cvss': '[0-9]*.[0-9]" | cut -d"'" -f3 > tmp2.txt
   
   # read the ranking
   while read line2  
	do   
		sum=`echo "scale=1;($sum+$line2)" | bc`
		com=$(($com+1))
		
	# fin de boucle   
	done < tmp2.txt
	rm tmp2.txt

	# check entention
   extention="${line##*.}"
   for i in ${dan[@]}; do
   	if [ "$i" = "$extention" ]; then
   		lvl=$(($lvl+5))
   		com=$(($com+1))
   	fi
   done
   
   # average calculation
	if [ $com = 0 ]; then
		ave=1
		lvl=1	
	else
		ave=`echo "($sum/$com)" | bc`
		lvl=$(round $ave 0)
	fi

	# go on source directory	
	cd ..   
   
   if [ $typ = "-s" ]; then
   	# mv of file in the directory
   	mkdir -p lvl$lvl
   	mv $line lvl$lvl
   else
   	# add security lvl before extention
   	filename="${line%.*}"
   	
   	echo "filename:$filename::"
   	mv $line $filename.$lvl.$extention
   fi
   
# end  
done < tmp.txt
rm tmp.txt

exit 0

