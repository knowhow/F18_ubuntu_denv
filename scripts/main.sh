#!/bin/bash

ruby -e "require 'openssl'"

#echo $?

if [[ ! $? -eq  0 ]] ; then
   echo "ruby openssl mora biti instaliran"
   exit 1
fi

VAGRANT=`vagrant --version | grep -c 'Vagrant version'`

if [[ "$VAGRANT" != "1" ]]; then
  echo "ruby gem vagrant mora biti instaliram"
  exit 1
fi

. scripts/download_box_from_gcode.sh  


FILE_NAME=precise-desktop-i386.box

if [[ -f $FILE_NAME ]]; then

  echo instaliram vagrant box $FILE_NAME 
  . scripts/switch_box_desktop-precise-i386.sh

fi
