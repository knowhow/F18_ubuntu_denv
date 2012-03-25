install_harbour = node[:F18_3rd][:install_harbour]

HOME="/home/vagrant"
GIT_ROOT = HOME + "/github"


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

if install_harbour
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





