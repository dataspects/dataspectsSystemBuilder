#!/bin/bash

if [[ -z "${VMNAME}" ]]; then
  echo "VMNAME not set!"
  exit
fi

# In VM
ssh -t -p 2222 dserver@localhost \
    'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg \
    | sudo apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" \
    | sudo tee /etc/apt/sources.list.d/yarn.list \
    && sudo apt update && sudo apt -y upgrade \
    && sudo apt -y install git tree curl ruby lynx restic net-tools sshfs wget pkg-config jq yarn virtualbox-guest-utils virtualbox-guest-additions-iso sqlite3 jq \
    && sudo snap install go --classic \
    && sudo usermod -aG vboxsf $(whoami) \
    && . /etc/os-release \
    && echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" \
    | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list \
    && curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key \
    | sudo apt-key add - && sudo apt-get update \
    && sudo apt-get -y upgrade  && sudo apt-get -y install podman'

# On host
VBoxManage sharedfolder add $VMNAME -automount \
    --name "system_root" \
    --hostpath "/home/lex/dserver-system_root" \
    --auto-mount-point "/home/dserver/system_root"
VBoxManage sharedfolder add $VMNAME -automount \
    --name "mediawiki-manager" \
    --hostpath "/home/lex/mediawiki-manager" \
    --auto-mount-point "/home/dserver/mediawiki-manager"
VBoxManage sharedfolder add $VMNAME -automount \
    --name "mediawiki-cli" \
    --hostpath "/home/lex/mediawiki-cli" \
    --auto-mount-point "/home/dserver/mediawiki-cli"

VBoxManage controlvm $VMNAME poweroff
VBoxManage startvm $VMNAME

# Following step not necessary?
# dserver@dserver:~$ sudo mount -o loop /usr/share/virtualbox/VBoxGuestAdditions.iso /media/ && sudo /media/VBoxLinuxAdditions.run

# https://techoverflow.net/2021/01/05/how-to-install-podman-on-ubuntu-20-04-in-25-seconds/

