USER = node[:ubuntu][:user]
ARCHIVE = node[:ubuntu][:ubuntu_archive_url]
HOME = "/home/" + USER

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


["Desktop", "Radna\ Površ"].each do |item|
    cookbook_file HOME + '/' + item + '/lxterminal.desktop' do
        owner USER
        group USER
        source 'lxterminal.desktop'
        ignore_failure true
    end
end

