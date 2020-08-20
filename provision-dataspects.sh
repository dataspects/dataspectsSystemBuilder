#!/bin/bash

ANSIBLETAGS=(
  500_install_dataspects_search
)

################################################################################

time ansible-playbook \
  --inventory ./inventory \
  --tags $(IFS=, eval 'echo "${ANSIBLETAGS[*]}"') \
  --become-method sudo \
      ./ansible_playbooks/500_dataspects/500_install_dataspects_search.yml

# dserver@dserver:~$ git clone https://github.com/dataspects/search.git
# dserver@dserver:~$ git clone https://github.com/dataspects/dataspectsd-templates.git
# dserver@dserver:~/go/src/github.com/dataspects$ git clone https://github.com/dataspects/dataspectsd.git


# dserver@dserver:~$ yarn install
Add "export PATH=$PATH:~/.yarn/bin" to dserver@dserver:~$ .bashrc
# dserver@dserver:~$ yarn global add gatsby-cli

# dserver@dserver:~/go/src/github.com/dataspects/dataspectsd/cmd/dataspectsd$ clear; go run dataspectsd.go --c config.yml --p 3001 -t /home/dserver/dataspectsd-templates

# dserver@dserver:~/search$ gatsby develop -H 0.0.0.0 -p 8082