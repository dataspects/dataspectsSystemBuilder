# -*- mode: ruby -*-
# vi: set ft=ruby :
# [[HasQualityAssuredBy::https://cookbook.findandlearn.net/wiki/DataspectsLinuxTeam]]
# https://docs.vagrantup.com

system_name = "dataspectssystemwiki"
system_tag = "mediawiki_only"
system_tag = "emwcon2019wiki"

port = 8080
docker_compose_version = "1.22.0"

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"
  config.vm.hostname = system_name
  config.vm.box_check_update = true
  config.vm.network "forwarded_port", guest: 80, host: port
  config.vm.provider "virtualbox" do |vb|
    vb.name = system_name
    vb.memory = "4096"
  end

  mediawiki_root = "/var/lib/docker/volumes/#{system_name}_mediawiki_root/_data/w"
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get -y upgrade
    apt-get -y install docker.io git ansible vim ruby
    curl -L https://github.com/docker/compose/releases/download/#{docker_compose_version}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    git clone --branch #{system_tag} --depth 1 --single-branch https://github.com/dataspects/dataspectsSystem.git
    cd dataspectsSystem
    CONTROL_FOLDER_PATH=/home/vagrant/#{system_name} DOCKER_VOLUMES_MODE=automatic ./build_dataspectsSystem.sh
    sudo sed 's|$wgServer = "http://.*|$wgServer = "http://#{system_name}:#{port}";|i' \
      #{mediawiki_root}/LocalSettings.php \
      > #{mediawiki_root}/LocalSettings.changed.php
    mv #{mediawiki_root}/LocalSettings.changed.php \
      #{mediawiki_root}/LocalSettings.php
  SHELL

  config.vm.post_up_message = "Now add '127.0.0.1 #{system_name}' to your hosts file and visit http://#{system_name}:#{port}"

end
