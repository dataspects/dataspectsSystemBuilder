# dataspectsSystemBuilder

See [Setup "dataspectsSystem"](https://wiki.dataspects.com/wiki/C1898799575)

## Create a plain vanilla Ubuntu dataspectsServer

    admin@workstation:~/dataspectsSystemBuilder$ ./VBoxManage-create-ubuntu-server.sh

## SCP docker-compose.yml

    admin@workstation:~/dataspectsSystemBuilder$ scp -P 2222 docker-compose.yml dataspects@localhost:/home/dataspects/

## Run docker-compose

TODO: Get wget into mediawiki container!

    admin@workstation:~$ ssh -p 2222 dataspects@localhost
    dataspects@dataspects:~$ chmod -R 777 ./elasticsearch_data
    dataspects@dataspects:~$ sudo docker-compose up

Now it's ready to receive a MediaWiki installation.

## Provision MediaWiki

    admin@workstation:~/dataspectsSystemBuilder$ ./provision-mediawiki.sh