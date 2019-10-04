#!/bin/bash

printf "\n\t\e[1mEnvironment and build configuration\e[0m\n"
printf "\t-----------------------------------\n"
printf "\tINFO: Sourcing $1\n"
source $1
source ./command_components/check_environment.sh

################################################################################
# Docker
printf "\tINFO: Sourcing Docker image envs\n"
source docker_images
printf "\tINFO: You need to export GITHUB_PKG_USER and GITHUB_PKG_PERSONAL_ACCESS_TOKEN\n"
printf "\tINFO: Logging into docker.pkg.github.com as $GITHUB_PKG_USER\n"
# sudo docker login docker.pkg.github.com -u $GITHUB_PKG_USER -p $GITHUB_PKG_PERSONAL_ACCESS_TOKEN
################################################################################
source ./command_components/ansiblePlaybookCommand.sh

printf "\tINFO: MediaWiki admin user password is: $MEDIAWIKI_ADMIN_PASSWORD\n"
