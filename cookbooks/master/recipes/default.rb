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


["wine", "libqt4-dev", "pgadmin3", "postgresql-9.1", "libcurl4-openssl-dev", "libmysqlclient16-dev", "libpq-dev" ].each do |item|

   package item do
      action :install
   end

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


bash "git clone developer repositories" do
      user "vagrant"
      cwd "/home/vagrant/github"
      code <<-EOH
git clone git://github.com/hernad/harbour.git
cd harbour
source set_envars_ubuntu.sh
cd harbour
make install

REPOS=F18_knowhow
git clone git://github.com/knowhow/${REPOS}.git

git clone git://github.com/knowhow/harbour_playground.git
git clone git://github.com/knowhow/T0_knowhow.git

REPOS=F18_ubuntu_3rd_party_install
git clone git://github.com/knowhow/${REPOS}.git
cd $REPOS
./F18_3rd_party_ubuntu_install.sh

EOH

end
