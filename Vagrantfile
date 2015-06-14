# -*- mode: ruby -*-
# vi: set ft=ruby :

#---------------------------#
# Vagrantfile by Palli Moon #
#---------------------------#

Vagrant.configure(2) do |config|
  # Box version
  config.vm.box = "ubuntu/trusty64"
  
  # Disables box update check, not recommended
  # config.vm.box_check_update = false
  
  # Forwards port 80 to 8080
  config.vm.network "forwarded_port", guest: 80, host: 8080
  
  # Opens private network and set ip to 55.55.55.5
  config.vm.network "private_network", ip: "55.55.55.5"
  
  # Opens public network
  # config.vm.network "public_network"
  
  # Sync guest folders with host folders
  config.vm.synced_folder "D:\\Users\\Palli\\Documents\\www", "/home/vagrant/www"
  config.vm.synced_folder "D:\\Users\\Palli\\Documents\\code", "/home/vagrant/code"
  
  # Install provisions through script
  # Switch to second line if first link is not working
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/Palli-Moon/vagrantfile/master/provisions.sh"
  # config.vm.provision "shell", path: "provisions.sh"
end
