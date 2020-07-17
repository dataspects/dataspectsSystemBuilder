#!/bin/bash

# ds@dserver:~$ mkdir search
# user@host:~$  scp -P 2222 -r /home/lex/search/public/* ds@dserver:/home/ds/search
# ds@dserver:~$ sudo python3 -m http.server 81 --directory /home/ds/search

# SEE https://github.com/neo4j-drivers/seabolt/releases
# ds@dserver:~$ wget https://github.com/neo4j-drivers/seabolt/releases/download/v1.7.4/seabolt-1.7.4-Linux-ubuntu-18.04.deb
# ds@dserver:~$ sudo apt install ./seabolt-1.7.4-Linux-ubuntu-18.04.deb
# user@host:~$  scp -P 2222 -r /home/lex/go/src/github.com/dataspects/dataspectsd/dataspectsd ds@dserver:/home/ds

config.yml

apikey: "ping"
url:
  activate: http://localhost:3000/activate
  reset: http://localhost:3000/reset
elastic-search:
  host: http://localhost
  port: 9200
  username:
  password:
neo4j:
  host: bolt://localhost
  port: 7687
  username:
  password:
smtp:
  from:
  server:
  port:
  username:
  password:
cors:
  allowedOrigins:
    - "http://dserver:8000"
    - "http://dserver:9000"
    - "http://p51:8000"