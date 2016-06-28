# -*- mode: ruby -*-
# vi: set ft=ruby :

#---------------------------#
# Vagrantfile by Palli Moon #
#---------------------------#

# Install required plugins
required_plugins = %w( vagrant-vbguest vagrant-berkshelf vagrant-omnibus )
required_plugins.each do |plugin|
  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

Vagrant.configure(2) do |config|
  # Box version
  config.vm.box = "ubuntu/trusty64"
  
  # Virtual box config
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
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
  
  # Opens public network
  # config.vm.network "public_network"
  
  # Sync guest folders with host folders
  config.vm.synced_folder "../../www", "/home/vagrant/www"
  config.vm.synced_folder "../../code", "/home/vagrant/code"
  
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
  
  # Install Docker
  config.vm.provision "docker"

  # Workaround due to bug: https://github.com/chef/chef/issues/4948
  config.omnibus.chef_version = '12.10.24'
  
  # Enable berkshelf
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "cookbooks/dev/Berksfile"

  # Provision with Chef
  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "nodejs"
    chef.add_recipe "mongodb"
    
    chef.json = {
      "nodejs" => {
        "install_method" => "binary",
        "binary" => {
          "checksum" => "ab28c6af235045def1f65fca7f4848de3c2de4fb62ebce37052f1a10f0b40263"
        },
        "version" => "6.2.0"
      }
    }
  end
end
