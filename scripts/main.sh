#!/bin/bash
clear

BOXES="precise-desktop-i386 precise-desktop-lxde"

echo "ova skripta ucitava sa gcode vagrant box-ove:"
echo " "
echo $BOXES
echo "-----------------------------------------------------------------"
echo " "
echo "ako ih nemate u tekucem direktoriju. Nakon toga, box-ovi se instaliraju"
echo "na kraju pokrece instalaciju F18 ubuntu developerskog okruženja, pri čemu je $BOX_NAME template"
echo "instalacija se vrši prema receptima (cookbooks) definisani u Vagrantfile-u"
echo " "
echo "1) download sa gcode-a traje za ovde dvije sesije (cca 1.3 GB) cca 1h pri brzini 490 KB/sec"
echo " "
echo "2) nakon toga slijedi instalacija sesija koja traje dodatnih 15-ak min ... "
echo " "
echo "3) na kraju se pokreću cookbok-ovi koji instaliraju i konfigurišu sve što sesije trebaju"
echo "te instaliraju git repos-e harbour, F18_knowhow i rade build-ove harbour-a i F18"
echo "ovaj dio traje nekih 30-tak minuta"
echo " "
echo "Ova skripta instalira samo sesiju f18_dev_1. Ostale sesije se instaliraju ručnim pokretanjem komande:"
echo "vagrant up <ime_sesije>"
echo "npr. vagrant up f18_dev_1, fmk_dev_1"
echo ""
echo " "
echo "Predradnje:"
echo "a) U Vagrantfile pronađite linije:"
echo "ubuntu_archive_url = http://archive.bring.out.ba/ubuntu/, pa ih zamijenite sa svojim mirorrom"
echo " "
echo "b) Takođe, podesite pojedine varijable build_xxxx po želji"
echo " "
echo "c) Tu je i ranije pomenuto podešenje memorije koja se alocira za pojedine sesije".
echo " "
echo "suma-sumarum, 2,5 - 3 sahata je potrebno da se čitav proces završi"
echo " "
echo "u periodu instalacija opterećenje mašine je veliko, zato je najbolje da se ovo uradi kada vam računar nije potreban"
echo 
echo "Stoga, pristavite kahvu, odmorite se i pustite mašinu da radi svoj posao ..."
echo " "
echo "Ostale napomene:"
echo "- ako imate mašinu sa malo RAM-a, spustite u Vagranfile-u količinu memorije za sesije"
echo " "
echo "pritisni bilo koju tipku za nastavak ... good luck ..." 
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


for item in $BOXES
do

BOX_NAME=$item
scripts/download_box_from_gcode.sh $BOX_NAME 
FILE_NAME=$BOX_NAME.box

if [[ -f $FILE_NAME ]]; then

  echo instaliram vagrant box $FILE_NAME 
  . scripts/switch_box.sh $BOX_NAME

fi

done

BOX_INSTALLED=`vagrant box list | grep -c $BOX_NAME`

if [[ "$BOX_INSTALLED" != "1" ]]; then
  echo "vagrant box $BOX_NAME nije instaliran ?"
  exit 1
fi


echo "VirtualBOX - GUI/SuuppressMessages"

VBoxManage setextradata global "GUI/SuppressMessages" "remindAboutAutoCapture,remindAboutMouseIntegrationOn,showRuntimeError.warning.HostAudioNotResponding,remindAboutGoingSeamless,remindAboutInputCapture,remindAboutGoingFullscreen,remindAboutMouseIntegrationOff,confirmGoingSeamless,confirmInputCapture,remindAboutPausedVMInput,confirmVMReset,confirmGoingFullscreen,remindAboutWrongColorDepth"

echo "pokrecem instalaciju F18-dev sesije f18_dev_1:"
vagrant up f18_dev_1

echo " "
echo " "
echo "ostale sesije kreirajte sa komandama:"
echo "$ vagrant up f18_dev_2"
echo "$ vagrant up fmk_dev_1"
echo " ..."
echo " "
echo "kraj priče"

#if [[ ! $? -eq  0 ]] ; then
#   echo "vagrant nije zavrsio posao do kraja .... ovo se zna cesto desiti pri instalaciji ubuntu paketa  ... "
#   echo "interesantno, desava se na razlicitim paketima"
#   echo "... kako god, vagrant provision nastavlja tamo gdje je prednodna operacija stala :)"
#   echo " "
#   echo "vagrant provision, na tebe je red !"
#   vagrant provision
#fi


