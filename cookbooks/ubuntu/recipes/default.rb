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
    variables (
        :passwordless => true,
        :sudoers_groups => node[:ubuntu][:sudo][:groups],
        :sudoers_users  => node[:ubuntu][:sudo][:users]
    )
end
