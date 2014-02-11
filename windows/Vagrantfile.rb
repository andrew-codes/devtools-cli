# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
	git clone git@github.com:jamesandrewsmith/devtools.git .vagrant/devtools
	cd .vagrant/devtools/windows
	. 'install-package.ps1'
	foreach ($package in $args) {
		install-package($package)
	}
SCRIPT

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "windows8"
  config.vm.guest = :windows
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  
  config.vm.provider :vmware do |v|
     v.gui = true
     v.vmx["memsize"] = "9182"
     v.vmx["numvcpus"] = "2"
   end
   config.vm.network :forwarded_port, guest: 3389, host: 3389
   config.vm.network :forwarded_port, guest: 80, host: 8080
   config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
   config.windows.halt_timeout = 30
   config.winrm.username = "vagrant"
   config.winrm.password = "vagrant"

   config.vm.provision "shell" do |s|
    	s.inline = $script
    	s.args = [
    		"git"
    	]
	end
end
