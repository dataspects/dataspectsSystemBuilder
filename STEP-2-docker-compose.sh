#!/bin/bash

user@host:~/dataspectsSystemBuilder$ scp -P 2222 docker-compose.yml ds@localhost:/home/ds/

# ds@dataspects:~$ sudo docker-compose up -d
# ds@dataspects:~$ sudo chmod -R 777 ./elasticsearch_data