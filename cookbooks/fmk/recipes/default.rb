build_fmk = node[:fmk][:build_fmk]

HOME="/home/vagrant"
GIT_ROOT = HOME + "/github"


apt_repo "main_ubuntu" do
      url node[:master][:ubuntu_archive_url]
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
[ "dosemu", "cups-pdf", "wine", "winetricks", "vim-gtk"].each do |item|

   package item do
      action :install
   end

end

service "cups" do
   action :stop
end


GIT_ROOT="/home/vagrant/github"
GIT_URL_ROOT="git://github.com/bringout-fmk"
    
    
[ "fmk_lib", "fmk_common", "fin", "fakt"].each do |item| 
    
git GIT_ROOT + "/" + item do
      user "vagrant"
      group "vagrant"

      repository GIT_URL_ROOT + item + ".git"
      reference "master"
      action :sync
end

end

if build_fmk

[ "fmk_lib", "fmk_common", "fin", "fakt"].each do |item| 
    
bash "build fmk: " + item   do
      user "vagrant"
      cwd GIT_ROOT + "/" + item
      code <<-EOH

   ./build.sh

EOH

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



