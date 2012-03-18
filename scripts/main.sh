#!/bin/bash

BOX_NAME=precise-desktop-i386

clear

echo "ova skripta ucitava sa gcode vagrant box $BOX_NAME, ako ga nemate u tekucem direktoriju"
echo "nakon toga, taj box instalira"
echo "na kraju pokrece instalaciju F18 ubuntu developerskog okruženja, pri čemu je $BOX_NAME tempalte"
echo "instalacija se vrši prema receptima (cookbooks) definisani u Vagrantfile-u"
echo " "
echo "download sa gcode-a traje 45-60 min "
echo "nakon toga slijedi instalacija sesije .. 5-10 minuta ... "
echo "i na kraju se pokreću cookbok-ovi koji instaliraju na sesiju potrebne dev i runtime knowhowERP pakete"
echo "te instaliraju git repos-e harbour, F18_knowhow i rade build-ove harbour-a i F18"
echo "ovaj dio traje nekih 30-tak minuta"
echo " "
echo "suma-sumarum, 1:30 - 2 sahata je potrebno da se čitav proces završi"
echo "u periodu instalacija opterećenje mašine je veliko, zato je najbolje da se ovo uradi kada vam računar nije potreban"
echo 
echo "Stoga, pristavite kahvu, odmorite se i pustite mašinu da radi svoj posao ..."
echo " "
echo "Ostale napomene:"
echo "- ako imate mašinu sa malo RAM-a, spustite u Vagranfile-u količinu memorije za sesiju - sada je predviđeno 1024 MB."
echo " "
echo "pretisni bilo koju thipku za pokretanje ovog procesa ... good lak ..." 
echo " "
read

echo "provjeravam je li ruby ispravno instaliran"

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


FILE_NAME=$BOX_NAME.box

if [[ -f $FILE_NAME ]]; then

  echo instaliram vagrant box $FILE_NAME 
  . scripts/switch_box_desktop-precise-i386.sh

fi

BOX_INSTALLED=`vagrant box list | grep -c $BOX_NAME`

if [[ "$BOX_INSTALLED" != "1" ]]; then
  echo "vagrant box $BOX_NAME nije instaliran ?"
  exit 1
fi


echo "VirtualBOX - GUI/SuuppressMessages"

VBoxManage setextradata global "GUI/SuppressMessages" "remindAboutAutoCapture,remindAboutMouseIntegrationOn,showRuntimeError.warning.HostAudioNotResponding,remindAboutGoingSeamless,remindAboutInputCapture,remindAboutGoingFullscreen,remindAboutMouseIntegrationOff,confirmGoingSeamless,confirmInputCapture,remindAboutPausedVMInput,confirmVMReset,confirmGoingFullscreen,remindAboutWrongColorDepth"

echo "pokrecem instalaciju F18-dev sesije"
vagrant up

if [[ ! $? -eq  0 ]] ; then
   echo "vagrant nije zavrsio posao do kraja .... ovo se zna cesto desiti pri instalaciji ubuntu paketa  ... "
   echo "interesantno, desava se na razlicitim paketima"
   echo "... kako god, vagrant provision nastavlja tamo gdje je prednodna operacija stala :)"
   echo " "
   echo "vagrant provision, na tebe je red !"
   vagrant provision
fi


