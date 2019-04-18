# -*- mode: ruby -*-
# vi: set ft=ruby :
# [[HasQualityAssuredBy::https://cookbook.findandlearn.net/wiki/DataspectsLinuxTeam]]
# https://docs.vagrantup.com

system_tag = "build_mediawiki_only"

port = 8080
docker_compose_version = "1.22.0"

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"
  config.vm.hostname = system_tag
  config.vm.box_check_update = true
  config.vm.network "forwarded_port", guest: 80, host: port
  config.vm.synced_folder ".", "/var/dataspectsSystem"
  config.vm.provider "virtualbox" do |vb|
    vb.name = system_tag.gsub!("_", "")
    vb.memory = "4096"
  end

  mediawiki_root = "/var/lib/docker/volumes/#{system_tag}_mediawiki_root/_data/w"

  config.vm.provision "shell", name: system_tag, inline: <<-SHELL
    # Copy dataspectsSystem
    cp -r /var/dataspectsSystem /home/vagrant/
    # System upgrade
    apt-get update
    apt-get -y upgrade
    # Install Docker and docker-compose
    apt-get -y install docker.io git ansible vim ruby
    curl -L https://github.com/docker/compose/releases/download/#{docker_compose_version}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    # Build dataspectsSystem
    cd /home/vagrant/dataspectsSystem
    CONTROL_FOLDER_PATH=/home/vagrant/#{system_tag} DOCKER_VOLUMES_MODE=automatic ./#{system_tag}.sh
  SHELL

  if(system_tag == "build_mediawiki_only")
    config.vm.provision "shell", name: "configure_mediawiki", inline: <<-SHELL
      # Configure MediaWiki LocalSettings.php
      echo "#{mediawiki_root}"
      sudo sed 's|$wgServer = "http://.*|$wgServer = "http://#{system_tag}:#{port}";|i' \
        #{mediawiki_root}/LocalSettings.php \
        > #{mediawiki_root}/LocalSettings.changed.php
      mv #{mediawiki_root}/LocalSettings.changed.php \
        #{mediawiki_root}/LocalSettings.php
    SHELL
  end

  config.vm.post_up_message = "Now add '127.0.0.1 #{system_tag}' to your hosts file and visit http://#{system_tag}:#{port}"

end
