#!/bin/bash
time ansible-playbook \
  --extra-vars @$DATASPECTSSYSTEM_CORE/command_components/generalVariables.yml \
  --extra-vars docker_volumes_mode=$DOCKER_VOLUMES_MODE \
  --extra-vars dockerComposeFileType=$DOCKER_COMPOSE_FILE \
  --extra-vars dataspectsSystem_control_folder_on_host=$CONTROL_FOLDER_PATH \
  --extra-vars mediawikiDomainNameInHostFile=$DOMAIN_NAME \
  --extra-vars aws_access_key_id=$AWS_ACCESS_KEY_ID \
  --extra-vars aws_secret_access_key=$AWS_SECRET_ACCESS_KEY \
  --extra-vars ui_session_secret=$UI_SESSION_SECRET \
  --extra-vars tika_username=$TIKA_USERNAME \
  --extra-vars tika_password=$TIKA_PASSWORD \
  --extra-vars ui_feed_service_api_key=$UI_FEED_SERVICE_API_KEY \
  --extra-vars registry_dataspects_com_user=$REGISTRY_DATASPECTS_COM_USER \
  --extra-vars registry_dataspects_com_password=$REGISTRY_DATASPECTS_COM_PASSWORD \
  --extra-vars platform=$PLATFORM \
  --tags $(IFS=, eval 'echo "${ANSIBLETAGS[*]}"') \
  $PRIVILEGE_ESCALATION \
      $DATASPECTSSYSTEM_CORE/ansible_playbooks/100_Prepare/100_create_dataspectsSystem_control_folder_on_host.yml \
      $DATASPECTSSYSTEM_CORE/ansible_playbooks/100_Prepare/110_pull_private_Docker_images_from_registry_dataspects_com.yml \
      $DATASPECTSSYSTEM_CORE/ansible_playbooks/200_Docker-Compose/200_compile_and_copy_docker_compose_file.yml \
      $DATASPECTSSYSTEM_CORE/ansible_playbooks/200_Docker-Compose/210_run_docker_compose.yml \
      $DATASPECTSSYSTEM_CORE/ansible_playbooks/300_MediaWiki/300_install_mediawiki.yml \
      $DATASPECTSSYSTEM_CORE/ansible_playbooks/300_MediaWiki/310_configure_proxy.yml \
      $DATASPECTSSYSTEM_CORE/ansible_playbooks/300_MediaWiki/320_install_mediawiki_extensions.yml \
      $DATASPECTSSYSTEM_CORE/ansible_playbooks/300_MediaWiki/330_execute_mediawiki_maintenance_runJobs.yml \
      $DATASPECTSSYSTEM_CORE/ansible_playbooks/500_NodeJS/500_configure_nodejs.yml \
      $DATASPECTSSYSTEM_CORE/ansible_playbooks/800_Backup_and_Clone/800_install_backup_and_clone_functionality.yml \
      $DATASPECTSSYSTEM_CORE/ansible_playbooks/800_Backup_and_Clone/810_backup_and_clone.yml \
      $DATASPECTSSYSTEM_CORE/ansible_playbooks/900_Tools/900_compare.yml
