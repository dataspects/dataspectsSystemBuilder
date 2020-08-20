#!/bin/bash

ssh -p 2222 dserver@localhost
# dserver@dserver:~$ curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# dserver@dserver:~$ sudo apt update && sudo apt upgrade && sudo apt install git docker-compose curl ruby lynx restic net-tools sshfs wget yarn pkg-config
# dserver@dserver:~$ sudo snap install go --classic

# dserver@dserver:~$ sudo apt install virtualbox-guest-utils virtualbox-guest-additions-iso
# dserver@dserver:~$ sudo mount -o loop /usr/share/virtualbox/VBoxGuestAdditions.iso /media/ && sudo /media/VBoxLinuxAdditions.run