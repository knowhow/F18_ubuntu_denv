apt_repo "main_ubuntu" do
      url node[:master][:ubuntu_archive_url]
      keyserver "keyserver.ubuntu.com"
      key_package "ubuntu-keyring"
      distribution "precise"
      components ["main", "universe"]
      source_packages false
end

package "sqlite3" do
    action :install
end

log "---- ukloni nepotrebne pakete ---"
["bluez", "apport", "update-notifier", "oneconf", "telepathy-indicator" ].each do |item|
    package item do
       action :purge
    end
end

log "----- F18 dev packages ----"


["libqt4-dev", "pgadmin3", "postgresql-9.1", "libcurl4-openssl-dev", "libmysqlclient16-dev", "libpq-dev" ].each do |item|

   package item do
      action :install
   end

end

log "----- F18 runtime packages ----"
["wine", "winetricks", "vim-gtk"].each do |item|

   package item do
      action :install
   end

end

service "cups" do
   action :stop
end

service "postgresql" do
   action :stop
end


file "/etc/profile.d/F18_knowhowERP.sh" do
    content <<-CFILE
#!/bin/bash
export KNOWHOW_ERP_ROOT=/opt/knowhowERP
export HARBOUR_ROOT=$KNOWHOW_ERP_ROOT/hbout
PATH=$KNOWHOW_ERP_ROOT/bin:$KNOWHOW_ERP_ROOT/util:$HARBOUR_ROOT/bin:$PATH
CFILE
    mode "0755"
end

knowhowERP_root = "/opt/knowhowERP"
directory knowhowERP_root do
  owner "vagrant" 
  group "admin"
  mode  "0755"
end

directory knowhowERP_root + "/bin" do
  owner "vagrant" 
  group "admin"
  mode  "0755"
end

directory knowhowERP_root + "/util" do
  owner "vagrant" 
  group "admin"
  mode  "0755"
end

directory "/home/vagrant/github" do
  owner "vagrant" 
  group "admin"
  mode  "0755"
end


HOME="/home/vagrant"
GIT_ROOT = HOME + "/github"

git GIT_ROOT + "/harbour" do
      repository "git://github.com/hernad/harbour.git"
      reference "master"
      action :sync
end


bash "git clone build harbour developer repository" do
      user "vagrant"
      cwd GIT_ROOT + "/harbour"
      code <<-EOH

   source ./set_envars_ubuntu.sh
   cd harbour
   make install

EOH

end


cookbook_file "/usr/local/bin/install-gecko.sh" do
      mode 0755
      source "install-gecko.sh"
      owner "root"
      group "root"
end

git GIT_ROOT + "/F18_knowhow" do
      repository "git://github.com/knowhow/F18_knowhow.git"
      reference "master"
      action :sync
end


bash "build F18 repository" do
      user "vagrant"
      user "vagrant"
      cwd "/home/vagrant/github"

      code <<-EOH
REPOS=F18_knowhow

cd $REPOS
source scripts/ubuntu_set_envars.sh 
./build.sh

EOH

end


directory "/home/vagrant/.wine" do
  owner "vagrant" 
  group "admin"
  mode  "0755"
end

directory "/home/vagrant/.wine/drive_c" do
  owner "vagrant" 
  group "admin"
  mode  "0755"
end


bash "install wine-gecko" do
      user "vagrant"
      group "vagrant"
      cwd "/home/vagrant/github"
      code <<-EOH

/usr/local/bin/install-gecko.sh
EOH
end

REPOS = "F18_ubuntu_3rd_party_install"

git GIT_ROOT + "/" + REPOS do
      repository "git://github.com/knowhow/" + REPOS
      reference "master"
      action :sync
end



bash "install F18 3rd party" do
      user "vagrant"
      group "vagrant"
      cwd "/home/vagrant/github"
      code <<-EOH

export HOME=/home/vagrant

REPOS=F18_ubuntu_3rd_party_install

cd $REPOS

source ./F18_3rd_party_ubuntu_install.sh

EOH
end
