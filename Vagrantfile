# -*- mode: ruby -*-
# vi: set ft=ruby :

box_ip = "192.168.33.10"

$script = <<SCRIPT
echo installing base dependencies
dnf install -y python2 ansible python2-dnf libselinux-python
date > /etc/vagrant_provisioned_at
SCRIPT

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "fedora/24-cloud-base"
  # config.vm.define :hyena do |hyena_config|
  #   hyena_config.vm.box = "hyena-org"
  #   web_config.vm.forward_port 80, 8080
  # end
  config.vm.box = 'hyena-org'

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false
  #

  public_key = ENV['HOME'] + '/dev/vagrant-box/fedora/keys/vagrant.pub'

  # install sysadmin basics
  config.vm.provision "shell", inline: $script
  config.vm.provision "shell", path: "https://gist.githubusercontent.com/bossjones/acb7520c78e145308340cc7445268aaf/raw/5dd9572be3bffec843b6a7ffbe19798a3768082f/python_tools.sh"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.verbose = "v"
    ansible.sudo = true
    ansible.host_key_checking = false
    ansible.limit = 'all'
    ansible.extra_vars = {
      public_key: public_key
    }
  end

  # config.vm.define "default" do |node|
  #   node.vm.network "private_network", ip: box_ip
  # end

  config.vm.provider :virtualbox do |vb|
    # Don't boot with headless mode
    vb.gui = false
    vb.name = 'hyena-org'

    # user modifiable memory/cpu settings
    vb.memory = 2048
    vb.cpus = 2
  end

  config.vm.hostname = 'hyena.org'
  config.vm.boot_timeout = 400

  # network
  config.vm.network "public_network", :bridge => 'en0: Wi-Fi (AirPort)'
  config.vm.network "forwarded_port", guest: 19360, host: 1936
  config.vm.network "forwarded_port", guest: 139, host: 1139
  config.vm.network "forwarded_port", guest: 8081, host: 8881
  config.vm.network "forwarded_port", guest: 2376, host: 2376

  # ssh
  config.ssh.username = "vagrant"
  config.ssh.host = "127.0.0.1"
  config.ssh.guest_port = "2222"
  config.ssh.private_key_path = ENV['HOME'] + '/dev/vagrant-box/fedora/keys/vagrant_id_rsa'
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true
  config.ssh.insert_key = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
