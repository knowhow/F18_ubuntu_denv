tremol_ver = node[:fmk][:tremol_ver]

USER="vagrant"
HOME="/home/vagrant"
GCODE_URL_FMK="http://knowhow-erp-fmk.googlecode.com/files"


#bash "install mono" do
#    user "root"
#    cwd HOME
    
#code <<-EOH

#    export USER=#{USER}
#    # ovaj sudo unutar -c je neophodan jer vagrant/.wine posjeduje root
#    DISPLAY=:0 sudo su -c "sudo winetricks -q mono210" #{USER}
#
#
#EOH
#end

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

