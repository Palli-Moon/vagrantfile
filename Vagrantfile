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
  
  # Copy ssh key to guest
  if Vagrant::Util::Platform.windows?
    if File.exists?(File.join(Dir.home, ".ssh", "id_rsa"))
        ssh_key = File.read(File.join(Dir.home, ".ssh", "id_rsa"))
        config.vm.provision :shell, :inline => "echo 'Copying local SSH Key to VM for provisioning...' && mkdir -p ~vagrant/.ssh && echo '#{ssh_key}' > ~vagrant/.ssh/id_rsa && chmod 600 ~vagrant/.ssh/id_rsa && chown vagrant ~vagrant/.ssh/id_rsa"
    else
        # Else, throw a Vagrant Error. Cannot successfully startup on Windows without a SSH Key!
        raise Vagrant::Errors::VagrantError, "\n\nERROR: SSH Key not found at ~/.ssh/id_rsa.\n\n"
    end
	if File.exists?(File.join(Dir.home, ".ssh", "id_rsa.pub"))
        ssh_key = File.read(File.join(Dir.home, ".ssh", "id_rsa.pub"))
        config.vm.provision :shell, :inline => "echo 'Copying local SSH Key to VM for provisioning...' && mkdir -p ~vagrant/.ssh && echo '#{ssh_key}' > ~vagrant/.ssh/id_rsa.pub && chmod 600 ~vagrant/.ssh/id_rsa.pub && chown vagrant ~vagrant/.ssh/id_rsa.pub"
    else
        # Else, throw a Vagrant Error. Cannot successfully startup on Windows without a SSH Key!
        raise Vagrant::Errors::VagrantError, "\n\nERROR: PUBLIC SSH Key not found at ~/.ssh/id_rsa.pub.\n\n"
    end
  end
  
  # Install provisions through script
  # Switch to second line if first link is not working
  # config.vm.provision "shell", path: "https://raw.githubusercontent.com/Palli-Moon/vagrantfile/master/provisions.sh"
  config.vm.provision "shell", path: "provisions.sh"
end
