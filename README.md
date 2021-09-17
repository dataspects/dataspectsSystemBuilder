# dataspectsSystemBuilder

## Build VirtualBox machine

1. user@host:~/Downloads$ wget https://releases.ubuntu.com/20.04.3/ubuntu-20.04.3-live-server-amd64.iso
2. user@host:~/dataspectsSystemBuilder$ ./STEP-0-VBoxManage-create-ubuntu-server.sh
    * Set all prompted user/server data to "dserver"
    * In that file set VMNAME, HOSTPATH, ISO and NETWORKINTERFACE
    * Set everything to "dserver"
3. Restart VMNAME.
4. user@host:~/dataspectsSystemBuilder$ ./STEP-1-apt-update-and-install.sh

## Build Docker image for MediaWiki


## Links

* https://wiki.dataspects.com/wiki/Dataspects:Build_a_dataspects_development_environment (https://wiki.dataspects.com/wiki/C1898799575)