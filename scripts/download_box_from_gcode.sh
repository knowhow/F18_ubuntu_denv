#!/bin/bash

FILE_NAME=precise-desktop-i386.box

URL=http://knowhow-erp.googlecode.com/files

download_merge_parts()
{

for item in aa ab ac ad ae af ag ah
do
    echo wget $URL/$FILE_NAME.part_$item
    wget -c -nc $URL/$FILE_NAME.part_$item
done

cat $FILE_NAME.part_a[a-h] > $FILE_NAME


RET=`md5sum $FILE_NAME`


if [[ "$RET" ==  "97202c5fdbfcb1ad543c8decbec36994  $FILE_NAME" ]]
then
 echo "md5 sum ok, brisem dijelove a-h"
 rm $FILE_NAME.part_a[a-h]
fi



}

if [[ ! -f $FILE_NAME ]]
then
   download_merge_parts
  
fi 

