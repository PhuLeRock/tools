#PhuLTV 

decompressss()
{
if [ -n "$(echo $(file $1) | grep tar.gz)" ]; then 
		tar -vzxf $1;
		GoogleHere="$PWD/$(echo $1 | awk -F .tar.gz '{print$1"/"}')";
elif [ -n "$(echo $(file $1) | grep .bz2)" ];  then
		tar -vjxf $1;
		GoogleHere="$PWD/$(echo $1 | awk -F .bz2 '{print$1"/"}')";
elif [ -n "$(echo $(file $1) | grep .zip)" ]; then
		unzip $1;
		GoogleHere="$PWD/$(echo $1 | awk -F .zip '{print$1"/"}')";
		
fi
	}


google()
{
cd $GoogleHere;
echo right here $PWD 
#echo grep --exclude=*.xlsx --exclude=*.pdf --exclude=*.doc --exclude=*.docx --exclude=*.rar  -nIroP '(?<=").*(?=")' . > /tmp/list.file
}	

exportcsv()
{
echo while read line do 

echo done < $Goutput
	}
decompressss $1
google
