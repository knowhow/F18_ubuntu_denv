USER = node[:lxde][:user]
ARCHIVE = node[:lxde][:ubuntu_archive_url]
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


package "sqlite3" do
    action :install
end

log "---- ukloni nepotrebne pakete ---"
["bluez", "apport", "update-notifier", "oneconf", "telepathy-indicator" ].each do |item|
    package item do
       action :purge
    end
end

package "xscreensaver" do
	   action :purge
end

cookbook_file HOME + '/Desktop/lxterminal.desktop' do
    source 'lxterminal.desktop'
end
