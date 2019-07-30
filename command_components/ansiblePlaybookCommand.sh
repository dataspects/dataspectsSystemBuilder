#!/bin/bash

: "${CONTROL_FOLDER_PATH:?MISSING}"
: "${PLATFORM:?MISSING - must be one of linux|mac|windows}"
: "${DOCKER_VOLUMES_MODE:?MISSING - must be one of automatic|manual}"
: "${DOCKER_COMPOSE_FILE:?MISSING}"
: "${DATASPECTS_API_KEY:?MISSING}"

if [[ ! $UI_SESSION_SECRET ]]; then UI_SESSION_SECRET=dummy; fi
if [[ ! $TIKA_USERNAME ]]; then TIKA_USERNAME=dummy; fi
if [[ ! $TIKA_PASSWORD ]]; then TIKA_PASSWORD=dummy; fi
if [[ $PLATFORM == "linux" ]]; then PRIVILEGE_ESCALATION="--ask-become-pass --become-method sudo"; else PRIVILEGE_ESCALATION=""; fi

time ansible-playbook \
  --extra-vars @$RESOURCES_PATH/dataspectsSystem/command_components/generalVariables.yml \
  --extra-vars docker_volumes_mode=$DOCKER_VOLUMES_MODE \
  --extra-vars docker_network_mode=$DOCKER_NETWORK_MODE \
  --extra-vars dockerComposeFileType=$DOCKER_COMPOSE_FILE \
  --extra-vars dataspectsSystem_control_folder_on_host=$CONTROL_FOLDER_PATH \
  --extra-vars mediawikiDomainNameInHostFile=$DOMAIN_NAME \
  --extra-vars aws_access_key_id=$AWS_ACCESS_KEY_ID \
  --extra-vars aws_secret_access_key=$AWS_SECRET_ACCESS_KEY \
  --extra-vars ui_session_secret=$UI_SESSION_SECRET \
  --extra-vars tika_username=$TIKA_USERNAME \
  --extra-vars tika_password=$TIKA_PASSWORD \
  --extra-vars ui_feed_service_api_key=$DATASPECTS_API_KEY \
  --extra-vars registry_dataspects_com_user=$REGISTRY_DATASPECTS_COM_USER \
  --extra-vars registry_dataspects_com_password=$REGISTRY_DATASPECTS_COM_PASSWORD \
  --extra-vars platform=$PLATFORM \
  --extra-vars wgMediaWikiMongoID=$WG_MEDIAWIKI_MONGO_ID \
  --extra-vars wgDataspectsApiKey=$DATASPECTS_API_KEY \
  --extra-vars wgDataspectsApiURL=$DATASPECTS_API_URL \
  --tags $(IFS=, eval 'echo "${ANSIBLETAGS[*]}"') \
  $PRIVILEGE_ESCALATION \
      $RESOURCES_PATH/dataspectsSystem/ansible_playbooks/100_Prepare/100_create_dataspectsSystem_control_folder_on_host.yml \
      $RESOURCES_PATH/dataspectsSystem/ansible_playbooks/200_Docker-Compose/200_compile_and_copy_docker_compose_file.yml \
      $RESOURCES_PATH/dataspectsSystem/ansible_playbooks/200_Docker-Compose/210_run_docker_compose.yml \
      $RESOURCES_PATH/dataspectsSystem/ansible_playbooks/300_MediaWiki/300_install_mediawiki.yml \
      $RESOURCES_PATH/dataspectsSystem/ansible_playbooks/300_MediaWiki/310_configure_proxy.yml \
      $RESOURCES_PATH/dataspectsSystem/ansible_playbooks/300_MediaWiki/320_install_mediawiki_extensions.yml \
      $RESOURCES_PATH/dataspectsSystem/ansible_playbooks/300_MediaWiki/330_execute_mediawiki_maintenance_runJobs.yml \
      $RESOURCES_PATH/dataspectsSystem/ansible_playbooks/800_Backup_and_Clone/800_install_backup_and_clone_functionality.yml \
      $RESOURCES_PATH/dataspectsSystem/ansible_playbooks/800_Backup_and_Clone/810_backup_and_clone.yml \
      $RESOURCES_PATH/dataspectsSystem/ansible_playbooks/900_Tools/900_compare.yml
