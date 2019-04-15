#!/bin/bash
CONTROL_FOLDER_PATH=/home/lex/cookbookfindandlearnnet # Must be absolute!
PLATFORM=linux # linux|mac|windows
DOCKER_VOLUMES_MODE=automatic # automatic|manual
DOCKER_COMPOSE_FILE=docker-compose-standard
source command_components/environmentVariables.sh
ANSIBLETAGS=(
  100_create_dataspectsSystem_control_folder_on_host
  110_pull_private_Docker_images_from_registry_dataspects_com
  200_compile_and_copy_docker_compose_file
  210_run_docker_compose
  ### Comment all following tags for manual installation on Docker stack in accordance with C1470408196
  300_install_mediawiki
  310_configure_proxy
  320_install_mediawiki_extensions
  330_execute_mediawiki_maintenance_runJobs
  400_provision_as_cookbookfalnet
  ### For the time being this requires manually running dataspects-ui
  500_configure_nodejs
  600_feed_cookbook_entities
  610_feed_dataspectsSystem_source_folder
  700_prepare_indexing
  710_index_cookbook_entities
  720_index_dataspectsSystem_instance_source_folder
  800_install_backup_functionality
  800_install_clone_functionality
  810_backup_and_clone
  900_compare

)
source command_components/ansiblePlaybookCommand.sh
