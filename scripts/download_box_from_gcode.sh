#!/bin/bash

FILE_NAME=precise-desktop-i386.box
FILE_SIZE=925013504
URL=http://knowhow-erp.googlecode.com/files

sha1_sum() 
{
echo "provjeravam $FILE_NAME sha1 sume"

RET=`sha1sum -c scripts/parts.sha1`

if [[ $? -eq 0 ]]
then
 echo "sha1 sum ok"
 SH1SUM_OK=1
else
 echo "sha1 sum ne valja, brisem $FILE_NAME !"
 rm $FILE_NAME
 SH1SUM_OK=0
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

sha1_sum

if [[  $SH1SUM_OK == "1" ]]
then
   brisem $FILE_NAME download-ovane dijelove ... vise mi ne trebaju.
   rm $FILE_NAME.part_a[a-h]
fi

}



SIZE_OK=`ls -l $FILE_NAME | grep -c $FILE_SIZE`

if [[ "$SIZE_OK" != "1" ]]
then
  echo $FILE_NAME velicina nije dobra $FILE_SIZE  
  echo brisem ga ...
  rm $FILE_NAME
fi

if [[ ! -f $FILE_NAME ]]
then
   download_merge_parts  
fi 

