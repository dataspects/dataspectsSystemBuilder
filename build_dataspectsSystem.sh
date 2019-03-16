#!/bin/bash

source ../dataspectsSystemCONFIG

if [[ ! $CONTROL_FOLDER_PATH ]]; then CONTROL_FOLDER_PATH=/home/lex/cookbookfindandlearnnet; fi
DOMAIN_NAME="$(basename -- $CONTROL_FOLDER_PATH)"
if [[ ! $AWS_ACCESS_KEY_ID ]]; then AWS_ACCESS_KEY_ID=dummy; fi
if [[ ! $AWS_SECRET_ACCESS_KEY ]]; then AWS_SECRET_ACCESS_KEY=dummy; fi
if [[ ! $UI_SESSION_SECRET ]]; then UI_SESSION_SECRET=dummy; fi

ANSIBLETAGS=(
  ### 010_Prepare
    create_dataspectsSystem_control_folder_on_host
    # pull_private_Docker_images_from_registry_dataspects_com
  ### 020_Docker-Compose
    compile_and_copy_docker_compose_file
    run_docker_compose
  # ### Comment all following tags for manual installation on Docker stack in accordance with C1470408196
  # ### 030_MediaWiki
  #   install_mediawiki
  #   configure_proxy
  #   install_mediawiki_extensions
  #   execute_mediawiki_maintenance_runJobs
  # ### 040_Ontologies
  #   provision_as_cookbookfalnet
  ### 045 Feeding
    feed_cookbook_entities
  #  feed_dataspectsSystem_source_folder
  # ### 050_Indexing
    index_cookbook_entities
  #   index_dataspectsSystem_source_folder
  # ### 060_Backup_and_Clone
  #   install_backup_functionality
  #   install_clone_functionality
  #   backup_and_clone
  # ### 070_Tools
  #   compare

)

time ansible-playbook \
  --extra-vars @build_dataspectsSystem_ANSIBLE_VARS.yml \
  --extra-vars dataspectsSystem_control_folder_on_host=$CONTROL_FOLDER_PATH \
  --extra-vars mediawikiDomainNameInHostFile=$DOMAIN_NAME \
  --extra-vars aws_access_key_id=$AWS_ACCESS_KEY_ID \
  --extra-vars aws_secret_access_key=$AWS_SECRET_ACCESS_KEY \
  --extra-vars ui_session_secret=$UI_SESSION_SECRET \
  --extra-vars registry_dataspects_com_user=$REGISTRY_DATASPECTS_COM_USER \
  --extra-vars registry_dataspects_com_password=$REGISTRY_DATASPECTS_COM_PASSWORD \
  --tags $(IFS=, eval 'echo "${ANSIBLETAGS[*]}"') \
  --ask-become-pass \
  --become-method sudo \
      ansible_playbooks/010_Prepare/create_dataspectsSystem_control_folder_on_host.yml \
      ansible_playbooks/010_Prepare/pull_private_Docker_images_from_registry_dataspects_com.yml \
      ansible_playbooks/020_Docker-Compose/compile_and_copy_docker_compose_file.yml \
      ansible_playbooks/020_Docker-Compose/run_docker_compose.yml \
      ansible_playbooks/030_MediaWiki/install_mediawiki.yml \
      ansible_playbooks/030_MediaWiki/install_mediawiki_extensions.yml \
      ansible_playbooks/030_MediaWiki/execute_mediawiki_maintenance_runJobs.yml \
      ansible_playbooks/040_Ontologies/provision_as_cookbookfalnet.yml \
      ansible_playbooks/045_Feeding_Raw_Data/feed_cookbook_entities.yml \
      ansible_playbooks/045_Feeding_Raw_Data/feed_dataspectsSystem_source_folder.yml \
      ansible_playbooks/050_Indexing/index_cookbook_entities.yml \
      ansible_playbooks/050_Indexing/index_dataspectsSystem_source_folder.yml \
      ansible_playbooks/060_Backup_and_Clone/install_backup_and_clone_functionality.yml \
      ansible_playbooks/060_Backup_and_Clone/backup_and_clone.yml \
      ansible_playbooks/070_Tools/compare.yml
