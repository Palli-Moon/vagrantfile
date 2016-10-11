# -*- mode: ruby -*-
# vi: set ft=ruby :

#---------------------------#
# Vagrantfile by Palli Moon #
#---------------------------#

# Install required plugins
required_plugins = %w( vagrant-vbguest vagrant-winnfsd )
required_plugins.each do |plugin|
  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

Vagrant.configure(2) do |config|
  # Box version
  config.vm.box = "ubuntu/trusty64"
  
  # Virtual box config
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
	v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  # Use ssh key
  config.ssh.insert_key = false
  config.ssh.private_key_path = File.expand_path('~/.vagrant.d/insecure_private_key')
    
  # Disables box update check, not recommended
  # config.vm.box_check_update = false
  
  # Forwards port 80 to 8080
  config.vm.network "forwarded_port", guest: 80, host: 8080
  
  # Opens private network and set ip to 55.55.55.5
  config.vm.network "private_network", ip: "55.55.55.5"
  config.vm.network "private_network", type: "dhcp"
  
  # Opens public network
  # config.vm.network "public_network"
  
  # Sync guest folders with host folders
  config.vm.synced_folder "../../www", "/home/vagrant/www", type: "nfs"
  config.vm.synced_folder "../../code", "/home/vagrant/code", type: "nfs"
  
  # Copy ssh key to guest
  if Vagrant::Util::Platform.windows?
    if File.exists?(File.join(Dir.home, ".ssh", "id_rsa")) && File.exists?(File.join(Dir.home, ".ssh", "id_rsa.pub"))
      private_key = File.read(File.join(Dir.home, ".ssh", "id_rsa"))
		public_key = File.read(File.join(Dir.home, ".ssh", "id_rsa.pub"))
      config.vm.provision "shell", inline: "echo 'Copying local private SSH Key to VM for provisioning...' && mkdir -p ~vagrant/.ssh && echo '#{private_key}' > ~vagrant/.ssh/id_rsa && chmod 600 ~vagrant/.ssh/id_rsa && chown vagrant ~vagrant/.ssh/id_rsa"
		config.vm.provision "shell", inline: "echo 'Copying local public SSH Key to VM for provisioning...' && mkdir -p ~vagrant/.ssh && echo '#{public_key}' > ~vagrant/.ssh/id_rsa.pub && chmod 600 ~vagrant/.ssh/id_rsa.pub && chown vagrant ~vagrant/.ssh/id_rsa.pub"
    else
      # Else, throw a Vagrant Error. Cannot successfully startup on Windows without a SSH Key!
      raise Vagrant::Errors::VagrantError, "\n\nERROR: SSH Key not found at ~/.ssh/id_rsa and ~/.ssh/id_rsa.pub.\n\n"
    end
  end
  
  # Install provisions through script
  config.vm.provision "shell", path: "provisions.sh"
  # config.vm.provision "shell", path: "https://raw.githubusercontent.com/Palli-Moon/vagrantfile/master/provisions.sh"
end
