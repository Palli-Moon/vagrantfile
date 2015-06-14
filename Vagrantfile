# -*- mode: ruby -*-
# vi: set ft=ruby :

#---------------------------#
# Vagrantfile by Palli Moon #
#---------------------------#

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  # config.vm.box_check_update = false
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "55.55.55.5"
  # config.vm.network "public_network"
  config.vm.synced_folder "D:\\Users\\Palli\\Documents\\www", "/home/vagrant/www"
  config.vm.synced_folder "D:\\Users\\Palli\\Documents\\code", "/home/vagrant/code"
  config.vm.provision "shell", path: "provisions.sh"
end
