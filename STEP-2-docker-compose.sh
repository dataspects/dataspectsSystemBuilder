#!/bin/bash

NOW DONE BY ANSIBLE TAG "200_place_docker_compose"

# user@host:~/dataspectsSystemBuilder$ scp -P 2222 docker-compose-base.yml dserver@localhost:/home/dserver/

# dserver@dserver:~$ sudo docker-compose --file docker-compose-base.yml up -d
# dserver@dserver:~$ sudo chown -R www-data:dserver ./mediawiki_root
# dserver@dserver:~$ sudo chmod -R 777 ./elasticsearch_data