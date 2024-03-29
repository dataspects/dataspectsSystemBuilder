#!/bin/bash

if [[ -z "${VMNAME}" ]]; then
  echo "VMNAME not set! Choose one:"
  VBoxManage list vms
  exit
fi

# In VM
ssh -t -p 2222 dserver@localhost \
    'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg \
    | sudo apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" \
    | sudo tee /etc/apt/sources.list.d/yarn.list \
    && sudo apt update && sudo apt -y upgrade \
    && sudo apt -y install git tree curl ruby lynx restic net-tools \
        sshfs wget pkg-config jq yarn virtualbox-guest-utils \
        virtualbox-guest-additions-iso sqlite3 jq uidmap \
    && sudo snap install go --classic \
    && sudo usermod -aG vboxsf $(whoami)'

# Rootless Docker
ssh -t -p 2222 dserver@localhost \
    'curl -sSL https://get.docker.com | sh \
    && sudo systemctl disable --now docker.service docker.socket \
    && dockerd-rootless-setuptool.sh install \
    && systemctl --user enable docker \
    && sudo loginctl enable-linger $(whoami) \
    && docker context use rootless \
    && sudo apt install docker-compose \
    && echo "export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock" >> ~/.profile'

ssh -t -p 2222 dserver@localhost \
    "sudo sed -i 's/GRUB_CMDLINE_LINUX=\"\"/GRUB_CMDLINE_LINUX=\"systemd.unified_cgroup_hierarchy=1\"/' /etc/default/grub && sudo update-grub"

# # On host
VBoxManage controlvm $VMNAME poweroff

sleep 10
# On Linux distributions, shared folders are mounted with 770 file permissions with root user and vboxsf as the group.
VBoxManage sharedfolder add $VMNAME -automount \
    --name "system_root" \
    --hostpath "/home/lex/dserver-system_root" \
    --auto-mount-point "/home/dserver/system_root"
VBoxManage sharedfolder add $VMNAME -automount \
    --name "mediawiki-cli" \
    --hostpath "/home/lex/mediawiki-cli" \
    --auto-mount-point "/home/dserver/mediawiki-cli"

VBoxManage startvm $VMNAME

# Following step not necessary?
# dserver@dserver:~$ sudo mount -o loop /usr/share/virtualbox/VBoxGuestAdditions.iso /media/ && sudo /media/VBoxLinuxAdditions.run

# https://techoverflow.net/2021/01/05/how-to-install-podman-on-ubuntu-20-04-in-25-seconds/

# PODMAN
#  \
#     && . /etc/os-release \
#     && echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" \
#     | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list \
#     && curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key \
#     | sudo apt-key add - && sudo apt-get update \
#     && sudo apt-get -y upgrade  && sudo apt-get -y install podman