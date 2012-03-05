#!/usr/bin/env ruby

Vagrant::Config.run do |config|
  

  config.vm.define :f18_dev_1 do |vm_config|

      ip_addr = "55.55.55.100"
      #host_name = "f18-dev-1.knowhow-erp.local"
      host_name = "precise-desktop-i386"
      ubuntu_archive_url = "http://archive.bring.out.ba/ubuntu/"

      vm_config.vm.customize ["modifyvm", :id, "--name",  host_name]

      vm_config.vm.box = "precise-desktop-i386"
     
#      vm_config.vm.network(:hostonly, ip_addr)

#      vm_config.vm.provision :chef_solo do |chef|
#            chef.cookbooks_path =  "cookbooks"
#            chef.add_recipe "master"
#            chef.add_recipe "hosts"
#            chef.json.merge!({ 
#                    :master => { :ubuntu_archive_url => ubuntu_archive_url }, 
#                    :hosts =>  { :hostname => host_name, :ip_addr => ip_addr }
#            })
#      end

  end

end
