#!/usr/bin/env ruby

Vagrant::Config.run do |config|
  

  config.vm.define :f18_dev_1 do |vm_config|

      ip_addr = "55.55.55.100"
      host_name = "f18-dev-1.knowhow-erp.local"

      variant= "unity"
      build_harbour = true
      build_f18 = true
      build_xtuple = false
      user = "vagrant"

      ubuntu_archive_url = "http://archive.bring.out.ba/ubuntu/"

      vm_config.vm.customize ["modifyvm", :id, "--memory",  1024]
      vm_config.vm.customize ["modifyvm", :id, "--name",  host_name]

      vm_config.vm.box = "precise-desktop-i386"
     
      vm_config.vm.network(:hostonly, ip_addr)

      vm_config.vm.provision :chef_solo do |chef|
            chef.cookbooks_path =  "cookbooks_knowhow"
            chef.add_recipe "master"
            chef.add_recipe "F18_3rd"
            chef.add_recipe "hosts"
            chef.json.merge!({
                    :F18_3rd => { :install_harbour => (not build_harbour) }, 
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
      user = "vagrant"

      ubuntu_archive_url = "http://archive.bring.out.ba/ubuntu/"

      vm_config.vm.customize ["modifyvm", :id, "--memory",  512]
      vm_config.vm.customize ["modifyvm", :id, "--name",  host_name]

      vm_config.vm.box = "precise-desktop-lxde"
     
      vm_config.vm.network(:hostonly, ip_addr)

      vm_config.vm.provision :chef_solo do |chef|
            chef.cookbooks_path =  "cookbooks_knowhow"
            chef.add_recipe "F18_3rd"
            #chef.add_recipe "master"
            chef.add_recipe "hosts"
            chef.json.merge!({ 
                   :F18_3rd => { :install_harbour => (not build_harbour) }, 
                   :master => { :variant => variant, :ubuntu_archive_url => ubuntu_archive_url, :build_xtuple => build_xtuple, :build_harbour => build_harbour, :build_f18 => build_f18 }, 
                   :hosts =>  { :hostname => host_name, :ip_addr => ip_addr }
            })
      end

  end


  config.vm.define :fmk_dev_1 do |vm_config|

      ip_addr = "55.55.55.102"
      host_name = "fmk-dev-1.knowhow-erp.local"
      build_fmk = true
      role = "fmk"
      user = "vagrant"
    
      ubuntu_archive_url = "http://archive.bring.out.ba/ubuntu/"

      vm_config.vm.customize ["modifyvm", :id, "--memory",  1024]
      vm_config.vm.customize ["modifyvm", :id, "--name",  host_name]

      vm_config.vm.box = "precise-desktop-lxde"
     
      vm_config.vm.network(:hostonly, ip_addr)

      vm_config.vm.provision :chef_solo do |chef|
            chef.cookbooks_path =  "cookbooks_knowhow"
            chef.add_recipe "fmk"
            chef.add_recipe "hosts"
            chef.json.merge!({  
                    :F18_3rd => { :install_harbour => false }, 
                    :fmk => { :user => user,  :role => role, :ubuntu_archive_url => ubuntu_archive_url,  :build_fmk => build_fmk }, 
                    :hosts =>  { :hostname => host_name, :ip_addr => ip_addr }
            })
      end

  end

  config.vm.define :fmk_pos_1 do |vm_config|

      ip_addr = "55.55.55.201"
      host_name = "fmk-pos-1.knowhow-erp.local"
      build_fmk = false
      role = "tops"
      sql_site = "10"
      admin = "vagrant"
      user  = "bringout"
      fiscal_type = "tremol"
      fiscal_version = "224"
     
      ubuntu_archive_url = "http://archive.bring.out.ba/ubuntu/"

      vm_config.vm.customize ["modifyvm", :id, "--memory",  512]
      vm_config.vm.customize ["modifyvm", :id, "--name",  host_name]

      vm_config.vm.box = "precise-desktop-lubuntu"
     
      vm_config.vm.network(:hostonly, ip_addr)

      vm_config.vm.provision :chef_solo do |chef|
            chef.cookbooks_path =  "cookbooks_knowhow"
            chef.add_recipe "ubuntu"
            chef.add_recipe "lxde"
            chef.add_recipe "hosts"
            chef.add_recipe "F18_3rd"
            chef.add_recipe "fmk"
            chef.add_recipe "fiscal_wine::tremol"
            chef.json.merge!({ 
                    :ubuntu => { 
                         :user => user, :admin => admin, :ubuntu_archive_url => ubuntu_archive_url,
                         :sudo => { :users => ["vagrant"], :groups => ["adm"] }
                    }, 
                    :lxde    => {}, 
                    :F18     => { :user => user }, 
                    :F18_3rd => { :install_harbour => false }, 
                    :fmk     => { :user => user, :role => role, :ubuntu_archive_url => ubuntu_archive_url,  :build_fmk => build_fmk, :sql_site => sql_site }, 
                    :fiscal_wine  => { :user => user, :type => fiscal_type, :version => fiscal_version}, 
                    :hosts =>  { :hostname => host_name, :ip_addr => ip_addr }
            })
      end

  end


  config.vm.define :fmk_pos_2 do |vm_config|

      ip_addr = "55.55.55.202"
      host_name = "fmk-pos-2.knowhow-erp.local"
      build_fmk = false
      role = "tops"
      sql_site = "50"
      admin = "vagrant"
      user  = "bringout"
      fiscal_type = "tremol"
      fiscal_version = "224"
     
      ubuntu_archive_url = "http://archive.bring.out.ba/ubuntu/"

      vm_config.vm.customize ["modifyvm", :id, "--memory",  512]
      vm_config.vm.customize ["modifyvm", :id, "--name",  host_name]

      vm_config.vm.box = "precise-desktop-lubuntu"
     
      vm_config.vm.network(:hostonly, ip_addr)

      vm_config.vm.provision :chef_solo do |chef|
            chef.cookbooks_path =  "cookbooks_knowhow"
            chef.add_recipe "ubuntu"
            chef.add_recipe "lxde"
            chef.add_recipe "hosts"
            chef.add_recipe "F18_3rd"
            chef.add_recipe "fmk"
            chef.add_recipe "fiscal_wine::tremol"
            chef.json.merge!({ 
                    :ubuntu => { 
                         :user => user, :admin => admin, :ubuntu_archive_url => ubuntu_archive_url,
                         :sudo => { :users => ["vagrant"], :groups => ["adm"] }
                    }, 
                    :lxde    => {}, 
                    :F18     => { :user => user }, 
                    :F18_3rd => { :install_harbour => false }, 
                    :fmk     => { :user => user, :role => role, :ubuntu_archive_url => ubuntu_archive_url,  :build_fmk => build_fmk, :sql_site => sql_site }, 
                    :fiscal_wine  => { :user => user, :type => fiscal_type, :version => fiscal_version}, 
                    :hosts =>  { :hostname => host_name, :ip_addr => ip_addr }
            })
      end

  end

  config.vm.define :fmk_pos_knjig do |vm_config|

      ip_addr = "55.55.55.203"
      host_name = "fmk-pos-knjig.knowhow-erp.local"
      build_fmk = false
      role = "tops_knjig"
      user = "vagrant"

      ubuntu_archive_url = "http://archive.bring.out.ba/ubuntu/"

      vm_config.vm.customize ["modifyvm", :id, "--memory",  512]
      vm_config.vm.customize ["modifyvm", :id, "--name",  host_name]

      vm_config.vm.box = "precise-desktop-lxde"
     
      vm_config.vm.network(:hostonly, ip_addr)

      vm_config.vm.provision :chef_solo do |chef|
            chef.cookbooks_path =  "cookbooks_knowhow"
            chef.add_recipe "fmk"
            chef.add_recipe "F18_3rd"
            chef.add_recipe "hosts"
            chef.json.merge!({ 
                    :F18_3rd => { :install_harbour => false }, 
                    :fmk => { :user => user, :role => role, :ubuntu_archive_url => ubuntu_archive_url,  :build_fmk => build_fmk }, 
                    :hosts =>  { :hostname => host_name, :ip_addr => ip_addr }
            })
      end

  end




end
