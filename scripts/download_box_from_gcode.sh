#!/bin/bash

FILE_NAME=precise-desktop-i386.box

URL=http://knowhow-erp.googlecode.com/files

md5_sum() 
{
echo "provjeravam $FILE_NAME md5 sumu" 

RET=`md5sum $FILE_NAME`

if [[ "$RET" ==  "97202c5fdbfcb1ad543c8decbec36994  $FILE_NAME" ]]
then
 echo "md5 sum ok, brisem dijelove a-h" 
 rm $FILE_NAME.part_a[a-h] 2> /dev/null
 MD5_OK=1
else
 echo "md5 sum ne valja, brisem box fajl !" 
 rm $FILE_NAME 2> /dev/null
 MD5_OK=0
fi

}

download_merge_parts()
{

for item in aa ab ac ad ae af ag ah
do
    echo wget $URL/$FILE_NAME.part_$item
    wget --continue  $URL/$FILE_NAME.part_$item
done

cat $FILE_NAME.part_a[a-h] > $FILE_NAME

md5_sum
}

MD5_OK=0

if [[ -f $FILE_NAME ]]
then 
 md5_sum
fi

if [[ Md5_OK -eq 0 ]]
then
   download_merge_parts  
fi 
