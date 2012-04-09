#!/bin/bash

if [[ "$WINEPREFIX" == "" ]];then
   export WINEPREFIX=~/.wine_tremol
fi

echo $WINEPREFIX

cd $WINEPREFIX/

OLE_ERROR=`cat wine.log | grep -c fixme:ole:Context_CC_ContextCallback.*d7174f82-36b8-4aa8-800a-e963ab2dfab9`

if [[ ! $OLE_ERROR -eq 0 ]] ; then
  echo u logu sam nasao ole errore ... restartujem server
  ./fp_server.sh
else
  echo nema ole errora u log ... nema potrebe za restartom fp_server-a
fi

