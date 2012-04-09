CUR_DIR=`pwd`

DIALOUT=`groups $USER | grep -c dialout`

if [[ $DIALOUT -eq 0 ]]
then
    echo user mora biti u dialout grupi da bi pristupio /dev/ttyACM0, /dev/ttyS0
    echo porkeni users-admin
    echo ili pokreni:
    echo usermod -a -G dialout $USER
    exit -1
fi

if [[ "$WINEPREFIX" == "" ]];then
   export WINEPREFIX=~/.wine_tremol
fi

echo WINEPREFIX=$WINEPREFIX

cd $WINEPREFIX/drive_c/Tremol/Tools
wine CommTool.exe
cd $CUR_DIR

