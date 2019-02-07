# -*- mode: ruby -*-
# vi: set ft=ruby :
# [[HasQualityAssuredBy::https://cookbook.findandlearn.net/wiki/DataspectsLinuxTeam]]
# https://docs.vagrantup.com

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"
  config.vm.hostname = "dataspectsSystem"
  config.vm.box_check_update = true
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.provider "virtualbox" do |vb|
    vb.name = "dataspectsSystem"
    vb.memory = "4096"
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get -y upgrade
    apt-get -y install docker.io git ansible vim ruby
    curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    git clone https://github.com/dataspects/dataspectsSystem.git
    cd dataspectsSystem
    ./build_dataspectsSystem.sh
  SHELL

  config.vm.post_up_message = "Now add '127.0.0.1 wikidataspectssystem' to your hosts file and visit http://wikidataspectssystem:8080"

end
