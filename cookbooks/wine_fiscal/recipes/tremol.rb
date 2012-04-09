tremol_user = node[:wine_fiscal][:user]
tremol_ver  = node[:wine_fiscal][:tremol_ver]

USER=tremol_user
HOME= "/home/" + tremol_user

GCODE_URL_FMK="http://knowhow-erp-fmk.googlecode.com/files"

user USER do
   comment "knowhowERP user"
   uid 1000
   gid "users"
   home HOME
   shell "/bin/bash"
   password "$1$ueVC4w6g$4uREUclhxAclbcHXcBnLz/"
end

bash "update user " + USER + "dialout, adm" do
    user  root
    group root

code <<-EOH
usermod -a -G dialout, adm #{USER}
EOH

end

log "----- fiscal runtime packages ----"
[ "p7zip-full", "wine", "winetricks"].each do |item|
   package item do
      action :install
   end
end


if tremol_ver == "225"

    remote_file HOME + "/wine_tremol.7z" do
        source GCODE_URL_FMK + "/wine_tremol_225.7z"
        mode "0644"
        #sha256
        checksum = "23062cd56255cada20db230e4369e26f9134d38b"
    end

end


bash "install wine_tremol.7z" do
    user  USER
    group USER
    cwd HOME
    
code <<-EOH

    export USER=#{USER}
    
    if [[ ! -d .wine_tremol ]]; then
        7z x -y wine_tremol.7z
    fi

EOH
end


cookbook_file  HOME + "/.dosemurc"  do
	owner USER
	group USER
	mode 0755
	source ".dosemurc"
end
