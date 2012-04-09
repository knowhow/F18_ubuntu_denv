tremol_user = node[:fiscal_wine][:user]
tremol_ver  = node[:fiscal_wine][:version]

knowhowERP_root = "/opt/knowhowERP"

USER=tremol_user
HOME= "/home/" + tremol_user

GCODE_URL_FMK="http://knowhow-erp-fmk.googlecode.com/files"

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


["fp_server.sh", "oposmgr.sh", "comtool.sh", "fix_ole_error.sh"].each do |file|

    cookbook_file knowhowERP_root + "/util/" + file    do
        owner USER
        group USER
        mode 0755
        source "tremol/" + file
    end

end


bash "ln-s fiscal tremol - tops"   do
      user "root"
      cwd HOME
      code <<-EOH

   export HOME=#{HOME}

   DIR=$HOME/.wine_tremol/fiscal
   DIR_DEST=$HOME/tops/fiscal

   if [ -d $DIR ] && [ ! -d $DIR_DEST ]; then
      ln -s $DIR $DIR_DEST
   done

EOH

end

