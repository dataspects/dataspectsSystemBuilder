#!/bin/bash

################################################################################
: "${DOCKER_NETWORK_MODE:?MISSING - must be one of docker|host}"
printf "\tDOCKER_NETWORK_MODE = $DOCKER_NETWORK_MODE\n"
if [ $DOCKER_NETWORK_MODE = "docker" ]
then
  printf "\t-> Using Docker network\n"
  printf "\t-> Starting proxy service\n"
else
  printf "\t-> Skipping Docker network\n"
  printf "\t-> Skipping proxy service\n"
fi
read -p "Continue build? (y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi
################################################################################

################################################################################
# Available Ansible tags in dataspectsSystem
printf "\n\t\e[1mAvailable Ansible tags in dataspectsSystem\e[0m\n"
printf "\t------------------------------------------\n"
egrep --no-filename -r "^ *\- [0-9]{3,3}_.+ *$" ./* | sort | uniq
################################################################################

################################################################################
# Check whether there's an existing instance at $CONTROL_FOLDER_PATH
printf "\n"
echo "Checking for existing instance at $CONTROL_FOLDER_PATH:"
echo "#------------------------------------------------------------------------"
if [ -f $CONTROL_FOLDER_PATH/docker-compose.yml ]; then
  printf "\n\tWARNING: $CONTROL_FOLDER_PATH/docker-compose.yml already exists!\n";
  printf "\n\tINFO: sudo docker container ls -a\n"; docker container ls -a --format "table {{.Names}}\t{{.Ports}}"
  printf "\n\tINFO: sudo docker ps -aq\n"; docker ps -aq
  printf "\n\tINFO: sudo docker volume ls\n"; docker volume ls
  printf '\n\tCONSIDER: sudo docker stop $(sudo docker ps -aq); sudo docker rm $(sudo docker ps -aq); sudo docker volume prune'
  printf " && rm -r $CONTROL_FOLDER_PATH/*\n\n"
  read -p "Continue build? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
      exit 1
  fi
else
  printf "\tINFO: No existing system found at $CONTROL_FOLDER_PATH.\n"
fi
