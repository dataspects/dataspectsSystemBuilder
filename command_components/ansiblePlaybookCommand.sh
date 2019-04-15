#!/bin/bash
time ansible-playbook \
  --extra-vars @command_components/generalVariables.yml \
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
      ansible_playbooks/100_Prepare/100_create_dataspectsSystem_control_folder_on_host.yml \
      ansible_playbooks/100_Prepare/110_pull_private_Docker_images_from_registry_dataspects_com.yml \
      ansible_playbooks/200_Docker-Compose/200_compile_and_copy_docker_compose_file.yml \
      ansible_playbooks/200_Docker-Compose/210_run_docker_compose.yml \
      ansible_playbooks/300_MediaWiki/300_install_mediawiki.yml \
      ansible_playbooks/300_MediaWiki/310_configure_proxy.yml \
      ansible_playbooks/300_MediaWiki/320_install_mediawiki_extensions.yml \
      ansible_playbooks/300_MediaWiki/330_execute_mediawiki_maintenance_runJobs.yml \
      ansible_playbooks/400_Ontologies/400_provision_as_cookbookfalnet.yml \
      ansible_playbooks/500_NodeJS/500_configure_nodejs.yml \
      ansible_playbooks/600_Feeding_Raw_Data/600_feed_cookbook_entities.yml \
      ansible_playbooks/600_Feeding_Raw_Data/610_feed_dataspectsSystem_source_folder.yml \
      ansible_playbooks/700_Indexing/700_prepare_indexing.yml \
      ansible_playbooks/700_Indexing/710_index_cookbook_entities.yml \
      ansible_playbooks/700_Indexing/720_index_dataspectsSystem_instance_source_folder.yml \
      ansible_playbooks/800_Backup_and_Clone/800_install_backup_and_clone_functionality.yml \
      ansible_playbooks/800_Backup_and_Clone/810_backup_and_clone.yml \
      ansible_playbooks/900_Tools/900_compare.yml
