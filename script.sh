#!/bin/bash

# Checking parameters number
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
if [ $typ = "-s" ]; then
	for (( i=0; i<11; i++ )); do mkdir lvl$i; done
fi

echo $rep

# Creation of files list
find $rep/ -type f > tmp.txt

# Analyse all files
while read line  
do   

	val=0;
	
   # type of file
   ft=`file -bz --mime-type $line`
      
   # lvl dangerosity
   echo $ft
   
   
   # check entention
   extention="${line##*.}"
   for i in ${dan[@]}; do
   	if [ "$i" = "$extention" ]; then
   		val=$(($val+5))
   	fi
   done
   
   echo $val
   
   lvl=5;
   
   if [ $typ = "-s" ]; then
   	# mv of file in the directory
   	mv $line $lvl
   else
   	# add security lvl before extention
   	filename="${line%.*}"
   	mv $line $filename.$lvl.$extention
   fi
   
# fin de boucle   
done < tmp.txt

exit 0


