# -*- mode: ruby -*-
# vi: set ft=ruby :

box_ip = "192.168.33.10"

$script = <<SCRIPT
echo installing base dependencies
dnf upgrade -y
dnf install -y python2 ansible python2-dnf libselinux-python
date > /etc/vagrant_provisioned_at
SCRIPT

Vagrant.configure("2") do |config|
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "fedora/24-cloud-base"

  config.vm.network "private_network", ip: box_ip

 # set auto_update to false, if you do NOT want to check the correct
  # additions version when booting this machine
  config.vbguest.auto_update = true

  # do NOT download the iso file from a webserver
  config.vbguest.no_remote = false

  # source: http://stackoverflow.com/questions/17845637/how-to-change-vagrant-default-machine-name
  config.vm.define "hyena_org" do |hyena_org|
  end
  config.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = 'hyena_org'

      # user modifiable memory/cpu settings
      vb.memory = 6048
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "75"]
      vb.customize ["modifyvm", :id, "--chipset", "ich9"]
  end

  public_key = ENV['HOME'] + '/dev/vagrant-box/fedora/keys/vagrant.pub'

  # install sysadmin basics
  config.vm.provision "shell", inline: $script
  config.vm.provision "shell", path: "https://gist.githubusercontent.com/bossjones/acb7520c78e145308340cc7445268aaf/raw/5dd9572be3bffec843b6a7ffbe19798a3768082f/python_tools.sh"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.verbose = "-v"
    ansible.sudo = true
    ansible.host_key_checking = false
    ansible.limit = 'all'
    ansible.extra_vars = {
      public_key: public_key
    }
  end

  config.push.define "atlas" do |push|
    push.app = "bossjones/oh-my-fedora24"
  end

  config.vm.hostname = 'hyena.org'
  config.vm.boot_timeout = 400

  # network
  config.vm.network "public_network", :bridge => 'en0: Wi-Fi (AirPort)'
  config.vm.network "forwarded_port", guest: 19360, host: 1936
  config.vm.network "forwarded_port", guest: 139, host: 1139
  config.vm.network "forwarded_port", guest: 8081, host: 8881
  config.vm.network "forwarded_port", guest: 2376, host: 2376
  config.vm.network "forwarded_port", guest: 1999, host: 19999

  # ssh
  config.ssh.username = "vagrant"
  config.ssh.host = "127.0.0.1"
  config.ssh.guest_port = "2222"
  config.ssh.private_key_path = ENV['HOME'] + '/dev/bossjones/oh-my-fedora24/keys/vagrant_id_rsa'
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true
  config.ssh.insert_key = false
  config.ssh.keep_alive  = 5
end
