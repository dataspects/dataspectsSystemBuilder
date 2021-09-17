#!/bin/bash

ssh -t -p 2222 dserver@localhost \
    'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg \
    | sudo apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" \
    | sudo tee /etc/apt/sources.list.d/yarn.list \
    && sudo apt update && sudo apt -y upgrade \
    && sudo apt -y install git curl ruby lynx restic net-tools sshfs wget pkg-config jq yarn virtualbox-guest-utils virtualbox-guest-additions-iso \
    && sudo snap install go --classic \
    && sudo usermod -aG vboxsf $(whoami) \
    && . /etc/os-release \
    && echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" \
    | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list \
    && curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key \
    | sudo apt-key add - && sudo apt-get update \
    && sudo apt-get -y upgrade  && sudo apt-get -y install podman'

# Following step not necessary?
# dserver@dserver:~$ sudo mount -o loop /usr/share/virtualbox/VBoxGuestAdditions.iso /media/ && sudo /media/VBoxLinuxAdditions.run

# https://techoverflow.net/2021/01/05/how-to-install-podman-on-ubuntu-20-04-in-25-seconds/

