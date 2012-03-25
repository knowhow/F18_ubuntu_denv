variant = node[:master][:variant]

build_harbour = node[:master][:build_harbour]
build_f18 = node[:master][:build_f18]
build_xtuple = node[:master][:build_xtuple]

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
["bluez", "apport", "update-notifier", "oneconf", "telepathy-indicator" ].each do |item|
    package item do
       action :purge
    end
end

if variant == "lxde"

	package "xscreensaver" do
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
[ "cups-pdf", "wine", "winetricks", "vim-gtk"].each do |item|

   package item do
      action :install
   end

end

service "cups" do
   action :stop
end


service "postgresql" do
   action :start
end

script "postgres password admin" do
    user "postgres"
    interpreter "sh"
    code "echo \"ALTER USER postgres WITH PASSWORD \'admin\'\" | psql"
end

service "postgresql" do
   action :stop
end


file "/etc/profile.d/F18_knowhowERP.sh" do
    content <<-CFILE
export KNOWHOW_ERP_ROOT=/opt/knowhowERP
export HARBOUR_ROOT=/opt/knowhowERP/hbout
PATH=$KNOWHOW_ERP_ROOT/bin:$KNOWHOW_ERP_ROOT/util:$KNOWHOW_ERP_ROOT/lib;$HARBOUR_ROOT/bin:$PATH
CFILE
    mode "0755"
end

knowhowERP_root = "/opt/knowhowERP"
directory knowhowERP_root do
  owner "vagrant" 
  group "vagrant"
  mode  "0755"
end

directory knowhowERP_root + "/bin" do
  owner "vagrant" 
  group "vagrant"
  mode  "0755"
end

directory knowhowERP_root + "/util" do
  owner "vagrant" 
  group "vagrant"
  mode  "0755"
end

directory "/home/vagrant/github" do
  owner "vagrant" 
  group "vagrant"
  mode  "0755"
end


REPOS = "F18_ubuntu_3rd_party_install"

git GIT_ROOT + "/" + REPOS do
      user "vagrant"
      group "vagrant"
      repository "git://github.com/knowhow/" + REPOS
      reference "master"
      action :sync
end


switch = ''

# ako ne buildas, onda instaliraj harbour sa gcode

if not build_harbour
  switch = '--hbout'
end

bash "install F18 3rd party" do
      user "vagrant"
      group "vagrant"
      cwd "/home/vagrant/github"
      code <<-EOH

export HOME=/home/vagrant

REPOS=F18_ubuntu_3rd_party_install

cd $REPOS

./F18_3rd_party_ubuntu_install.sh #{switch}

EOH
end




git GIT_ROOT + "/harbour" do
      user "vagrant"
      group "vagrant"

      repository "git://github.com/hernad/harbour.git"
      reference "master"
      action :sync
end


if build_harbour

bash "build harbour compiler, librarires" do
      user "vagrant"
      cwd GIT_ROOT + "/harbour"
      code <<-EOH

   source ./set_envars_ubuntu.sh
   cd harbour
   make install

EOH

end

end

git GIT_ROOT + "/F18_knowhow" do
      user "vagrant"
      group "vagrant"

      repository "git://github.com/knowhow/F18_knowhow.git"
      reference "master"
      action :sync
end

HOME="/home/vagrant"


if variant == "unity"

	directory HOME + "/.config/autostart" do
	  owner "vagrant" 
	  group "vagrant"
	  mode  "0755"
	end


	cookbook_file  HOME + "/.config/autostart/gnome-terminal.desktop" do
	      owner "vagrant"
	      group "vagrant"
	      mode 0755
	      source "gnome-terminal.desktop"
	      notifies :run, "execute[gnome_logout]"
	end


	execute "gnome_logout" do
	  user  "vagrant"
	  command "export DISPLAY=:0 ; gnome-session-quit --force --logout"
	  action :nothing
	end

end


if build_f18

bash "build " do
      user "vagrant"
      group "vagrant"
      cwd "/home/vagrant/github"

      code <<-EOH
REPOS=F18_knowhow

cd $REPOS
source scripts/ubuntu_set_envars.sh 
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


if build_xtuple

log "GIT clone xtuple repositories -------"

REPOS = "openrpt"
git GIT_ROOT + "/" + REPOS do
      user "vagrant"
      group "vagrant"
      repository "git://github.com/knowhow/" + REPOS
      reference "master"
      action :sync
end


REPOS = "csvimp"
git GIT_ROOT + "/" + REPOS do
      user "vagrant"
      group "vagrant"
      repository "git://github.com/knowhow/" + REPOS
      reference "master"
      action :sync
end


REPOS = "xtuple"
git GIT_ROOT + "/" + REPOS do
      user "vagrant"
      group "vagrant"
      repository "git://github.com/knowhow/" + REPOS
      reference "knowhow"
      action :sync
end


REPOS = "updater"
git GIT_ROOT + "/" + REPOS do
      user "vagrant"
      group "vagrant"
      repository "git://github.com/knowhow/" + REPOS
      reference "master"
      action :sync
end

log "build xtuple library-ja i paketa .... mozete komotno pristaviti kahvu ..."


["openrpt", "csvimp", "xtuple", "updater"].each do |item|

bash "build & install xtuple " + item do
      user "vagrant"
      group "vagrant"
      cwd "/home/vagrant/github"
      code <<-EOH

export HOME=/home/vagrant

REPOS=#{item}
cd $REPOS
qmake
make
make install

EOH
end

end


end

