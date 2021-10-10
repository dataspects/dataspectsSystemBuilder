# dataspectsSystemBuilder

## Build VirtualBox machine

1. user@host:~/Downloads$ wget https://releases.ubuntu.com/20.04.3/ubuntu-20.04.3-live-server-amd64.iso
2. user@host:~/dataspectsSystemBuilder$ `VMNAME=DSERVER210917 ./STEP-0-VBoxManage-create-ubuntu-server.sh`
    * Set all prompted user/server data to "dserver"
    * In that file set VMNAME, HOSTPATH, ISO and NETWORKINTERFACE
    * Set everything to "dserver"
3. Restart VMNAME.
4. user@host:~/dataspectsSystemBuilder$ `VMNAME=DSERVER210917 ./STEP-1-apt-update-and-install.sh`

## Build MediaWiki

### Build base dataspects/php:7.4.16-apache container

    user@workstation:~/dataspectsSystemBuilder/docker-images/php-apache$ build-php-apache-docker-image.sh

Check

    user@workstation:~$ sudo docker image ls | grep php-apache
    https://hub.docker.com/r/dataspects/php-apache/tags

### docker-compose

### Provision MediaWiki

    user@workstation:~/dataspectsSystemBuilder$ provision-mediawiki.sh



## Build Docker image for MediaWiki

## Install MediaWiki

1.  dserver@dserver:~/**mediawiki-cli**$ `./check-and-complete-environment.sh`
2.  dserver@dserver:~/**mediawiki-installer**$ `./report-podman.sh`
3.  dserver@dserver:~/**mediawiki-installer**$ `vi my-system.env`
4.  dserver@dserver:~/**mediawiki-installer**$ `ENVmwins=my-system.env ENVmwcli=../mediawiki-cli/my-system.env ./install-system/install-system-Ubuntu-20.04.sh`

## Links

* https://wiki.dataspects.com/wiki/Dataspects:Build_a_dataspects_development_environment (https://wiki.dataspects.com/wiki/C1898799575)