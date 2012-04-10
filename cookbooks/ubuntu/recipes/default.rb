USER = node[:ubuntu][:user]
ARCHIVE = node[:ubuntu][:ubuntu_archive_url]
HOME = "/home/" + USER

apt_repo "main_ubuntu" do
      url ARCHIVE
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

template "/etc/sudoers" do
    source "sudoers.erb"
    mode 0440
    owner "root"
    group "root"
    variables(
        :passwordless => true,
        :sudoers_groups => node[:ubuntu][:sudo][:groups],
        :sudoers_users  => node[:ubuntu][:sudo][:users]
    )
end

gem_package "ruby-shadow" do
   action :install
end

user "bringout" do
   comment "bring.out admin"
   gid "adm"
   home HOME
   shell "/bin/bash"
   supports( :manage_home => true, :non_unique => false )
   password "$1$ueVC4w6g$4uREUclhxAclbcHXcBnLz/"
end

bash "update user bringout dialout, adm, sudo" do
    user  "root"
    group "root"

code <<-EOH
usermod -a -G dialout,adm,sudo bringout
EOH

end


log "---- install ---"
["network-manager-openvpn", "git"].each do |item|
    package item do
       action :install
    end
end
