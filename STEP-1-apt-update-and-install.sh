#!/bin/bash

ssh -p 2222 dserver@localhost
# dserver@dserver:~$ curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# dserver@dserver:~$ sudo apt update && sudo apt upgrade && sudo apt install git curl ruby lynx restic net-tools sshfs wget pkg-config jq yarn
# dserver@dserver:~$ sudo snap install go --classic

# dserver@dserver:~$ sudo apt install virtualbox-guest-utils virtualbox-guest-additions-iso
# Following step not necessary?
# dserver@dserver:~$ sudo mount -o loop /usr/share/virtualbox/VBoxGuestAdditions.iso /media/ && sudo /media/VBoxLinuxAdditions.run

sudo usermod -aG vboxsf $(whoami)

https://techoverflow.net/2021/01/05/how-to-install-podman-on-ubuntu-20-04-in-25-seconds/

. /etc/os-release
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | sudo apt-key add -
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install podman