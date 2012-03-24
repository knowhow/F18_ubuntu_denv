#!/usr/bin/env ruby

Vagrant::Config.run do |config|
  

  config.vm.define :f18_dev_1 do |vm_config|

      ip_addr = "55.55.55.100"
      host_name = "f18-dev-1.knowhow-erp.local"

      variant= "unity"
      build_xtuple = true
      build_harbour = true
      build_f18 = true
 
      #host_name = "precise-desktop-i386"
      ubuntu_archive_url = "http://archive.bring.out.ba/ubuntu/"

      vm_config.vm.customize ["modifyvm", :id, "--memory",  1024]
      vm_config.vm.customize ["modifyvm", :id, "--name",  host_name]

      vm_config.vm.box = "precise-desktop-i386"
     
      vm_config.vm.network(:hostonly, ip_addr)

      vm_config.vm.provision :chef_solo do |chef|
            chef.cookbooks_path =  "cookbooks"
            chef.add_recipe "master"
            chef.add_recipe "hosts"
            chef.json.merge!({ 
                    :master => { :variant => variant, :ubuntu_archive_url => ubuntu_archive_url, :build_xtuple => build_xtuple, :build_harbour => build_harbour, :build_f18 => build_f18 }, 
                    :hosts =>  { :hostname => host_name, :ip_addr => ip_addr }
            })
      end

  end

  config.vm.define :f18_dev_2 do |vm_config|

      ip_addr = "55.55.55.101"
      host_name = "f18-dev-2.knowhow-erp.local"
      build_xtuple = false
      build_harbour = false
      build_f18 = false
      variant = "lxde"

      ubuntu_archive_url = "http://archive.bring.out.ba/ubuntu/"

      vm_config.vm.customize ["modifyvm", :id, "--memory",  512]
      vm_config.vm.customize ["modifyvm", :id, "--name",  host_name]

      vm_config.vm.box = "precise-desktop-lxde"
     
      vm_config.vm.network(:hostonly, ip_addr)

      vm_config.vm.provision :chef_solo do |chef|
            chef.cookbooks_path =  "cookbooks"
            chef.add_recipe "master"
            chef.add_recipe "hosts"
            chef.json.merge!({ 
                    :master => { :variant => variant, :ubuntu_archive_url => ubuntu_archive_url, :build_xtuple => build_xtuple, :build_harbour => build_harbour, :build_f18 => build_f18 }, 
                    :hosts =>  { :hostname => host_name, :ip_addr => ip_addr }
            })
      end

  end


end
