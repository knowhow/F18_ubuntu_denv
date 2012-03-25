#!/bin/bash

BOX=$1
SIZE=$2

if [[ "$SIZE" == "" ]] ; then
   echo "usage  : $0 <box> <size>"
   echo "primjer: $0 precise-desktop-lxde 110M"
   exit 1
fi 

rm $BOX.box.part_*

echo split -b $SIZE  $BOX.box .part_
split -b $SIZE  $BOX.box $BOX.box.part_

ls -l -h $BOX.box.part_* 
