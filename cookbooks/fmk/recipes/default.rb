build_fmk = node[:fmk][:build_fmk]

HOME="/home/vagrant"
GIT_ROOT = HOME + "/github"


apt_repo "main_ubuntu" do
      url node[:fmk][:ubuntu_archive_url]
      keyserver "keyserver.ubuntu.com"
      key_package "ubuntu-keyring"
      distribution "precise"
      components ["main", "universe"]
      source_packages false
end


script "apt-get update" do
    user "root"
    interpreter "sh"
    code "apt-get update"
end


package "sqlite3" do
    action :install
end

log "---- ukloni nepotrebne pakete ---"
["bluez", "apport", "update-notifier", "oneconf", "telepathy-indicator",  "xscreensaver" ].each do |item|
    package item do
       action :purge
    end
end

log "----- FMK runtime packages ----"
[ "p7zip-full", "smbclient", "dosemu", "cups-pdf", "wine", "winetricks", "vim-gtk"].each do |item|
   package item do
      action :install
   end
end

service "cups" do
   action :stop
end

directory "/home/vagrant/github" do
  owner "vagrant" 
  group "vagrant"
  mode  "0755"
end


cookbook_file  HOME + "/.dosemurc"  do
	owner "vagrant"
	group "vagrant"
	mode 0755
	source ".dosemurc"
end

directory "/home/vagrant/.dosemu" do
  owner "vagrant" 
  group "vagrant"
  mode  "0755"
end

directory "/home/vagrant/.dosemu/drive_c" do
  owner "vagrant" 
  group "vagrant"
  mode  "0755"
end




log "ako ne možete pristupiti samba file serveru zvijer-2.bring.out.ba, onda trebate ručno instalirati"
log "fmk_dsemu_drive_c.7z"
log "detalji na ticketu http://redmine.bring.out.ba/issues/27228"
log "ovaj 7z možete skinuti sa bring.out redmine-a: http://redmine.bring.out.ba/attachments/8182/fmk_dosemu_drive_c.7z"
log "pa ga ručno instalirati unutar sesije na lokaciju ~/.dosemu"
log " "
log "ako se nalazite u officesa bring.out onda će ovaj posao vagrant/chef uraditi za vas ..."

bash "instaliraj sa zvijer-2 bringout/fmk "   do
      user "vagrant"
      cwd HOME
      code <<-EOH

   export HOME=#{HOME}

   cd $HOME/.dosemu

   echo `date` > fmk_dosemu.log
   ARCHIVE=fmk_dosemu_drive_c.7z

   if [[ ! -f $ARCHIVE ]]; then
      echo "get from samba share fmk_dosemu_drive_c.7z" >> fmk_dosemu.log
      sudo smbclient //zvijer-2.bring.out.ba/shared -D bringout/FMK -c "get fmk_dosemu_drive_c.7z"
   else
      echo "$ARCHIVE vec postoji" >> fmk_dosemu.log
   fi

   if [[ ! -d drive_c/Clipper ]]; then
      7z x -y $ARCHIVE
   else
      echo ".dosemu/drive_c/Clipper vec postoji" >> fmk_dosemu.log
   fi

EOH

end


cookbook_file  HOME + "/.dosemu/drive_c/autoexec.bat"  do
	owner "vagrant"
	group "vagrant"
	mode 0755
	source "autoexec.bat"
end


cookbook_file  HOME + "/.dosemu/drive_c/config.sys"  do
	owner "vagrant"
	group "vagrant"
	mode 0755
	source "autoexec.bat"
end


GIT_ROOT="/home/vagrant/github"
GIT_URL_ROOT="git://github.com/bringout-fmk"
    
    
[ "fmk_lib", "fmk_common", "fin", "kalk", "fakt", "pos", "os", "ld", "virm", "kam"].each do |item| 
    
git GIT_ROOT + "/" + item do
      user "vagrant"
      group "vagrant"

      repository GIT_URL_ROOT + "/" + item + ".git"
      reference "master"
      action :sync
end

end



directory "/home/vagrant/github/fmk_lib/lib" do
  owner "vagrant" 
  group "vagrant"
  mode  "0755"
end

directory "/home/vagrant/github/fmk_lib/exe" do
  owner "vagrant" 
  group "vagrant"
  mode  "0755"
end

log "kreiraj potrebne direktorije, ln -s itd ..."

bash "ln github => c:/git, mkdir fmk_lib/lib, exe "   do
      user "vagrant"
      cwd HOME
      code <<-EOH

   export HOME=#{HOME}
   ln -s $HOME/github $HOME/.dosemu/drive_c/git
 
   #echo problem nasih slova
   ln -s $HOME/github/fmk_common $HOME/github/fmk_c

   # fmk libs ovdje
   DIRS="$HOME/github/fmk_lib/lib $HOME/github/fmk_lib/exe"
   for dir in $DIRS
   do
      if [[ ! -d $dir ]]; then  
              mkdir $dir
      fi
   done 
EOH

end



if build_fmk

[ "fmk_lib", "fmk_c", "fin", "kalk", "fakt", "pos" ].each do |item| 
    
bash "build fmk: " + item   do
      user "vagrant"
      cwd GIT_ROOT + "/" + item
      code <<-EOH

   export HOME=#{HOME}
   ./build.sh

EOH

end

end

end

directory "/home/vagrant/.wine" do
  owner "vagrant" 
  group "vagrant"
  mode  "0755"
end

directory "/home/vagrant/.wine/drive_c" do
  owner "vagrant" 
  group "vagrant"
  mode  "0755"
end



