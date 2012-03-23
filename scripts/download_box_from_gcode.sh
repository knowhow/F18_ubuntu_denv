#!/bin/bash

BOX_NAME=$1
FILE_NAME=$BOX_NAME.box


DARWIN=`uname -a | grep -c Darwin`

if [[ "$DARWIN" == "1" ]]
then
    SHA_CMD=shasum
else
    SHA_CMD=sha1sum
fi

case "$BOX_NAME" in
   
precise-desktop-i386)
   FILE_SIZE=925013504
   PART_NAMES="aa ab ac ad ae af ag ah"
   PARTS_RANGE=a-h
   ;;

precise-desktop-lxde)
   FILE_SIZE=502779904
   PART_NAMES="aa ab ac ad"
   PARTS_RANGE=a-d
   ;;

*)  exit 1
    ;;

esac


URL=http://knowhow-erp.googlecode.com/files

sha1_sum() 
{
echo "provjeravam $FILE_NAME sha1 sume"

RET=`$SHA_CMD -c scripts/${BOX_NAME}_parts.sha1`

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

for item in $PART_NAMES
do
    echo wget $URL/$FILE_NAME.part_$item
    wget --continue  $URL/$FILE_NAME.part_$item
    if [[ ! -f $FILE_NAME.part_$item ]] ; then
       echo pokusavam wget  $URL/${FILE_NAME}_part_${item}
       wget --continue  $URL/${FILE_NAME}_part_${item} -O $FILE_NAME.part_$item
    fi
done

cat $FILE_NAME.part_a[$PARTS_RANGE] > $FILE_NAME

sha1_sum

if [[  "$SH1SUM_OK" == "1" ]]
then
   echo brisem $FILE_NAME download-ovane dijelove ... vise mi ne trebaju.
   rm $FILE_NAME.part_a[$PARTS_RANGE]
fi

}



SIZE_OK=`ls -l $FILE_NAME | grep -c $FILE_SIZE`

if [[ "$SIZE_OK" != "1" ]]
then
  echo $FILE_NAME velicina nije dobra $FILE_SIZE  
  echo brisem ga ...
  rm $FILE_NAME
fi

echo $FILE_NAME

if [[ ! -f $FILE_NAME ]]
then
   download_merge_parts  
fi 

