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

remote_file HOME + "/wine_tremol.7z" do
	  source GCODE_URL_FMK + "/wine_tremol.7z"
	  mode "0644"
          #sha256
          checksum "2231323b4c455639aad6240a1140e32565e1d0bfc6ce46de3ac2c354d8ca78b1"
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

