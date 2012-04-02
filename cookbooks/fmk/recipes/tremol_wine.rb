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
          checksum "68fa6393ccf210efc96686b566215a61cffbbfd4"
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

