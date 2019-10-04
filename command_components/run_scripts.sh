#!/bin/bash

# Feed & Index
for script in "${SCRIPTS[@]}"
do
  if [[ $DATASPECTS_UI_HOST ]]
  then
    docker-compose --file $CONTROL_FOLDER_PATH/docker-compose.yml stop ui
    read -p "Press ENTER when development nodemon is running..."
    ruby "$CUSTOMIZATION_REPO/$script"
  else
    docker run \
      --network="dataspects" -it --rm --name dataspectsrubygem \
      -e DATASPECTS_API_KEY=$DATASPECTS_API_KEY \
      -e DATASPECTS_API_URL=$DATASPECTS_API_URL \
      -e DOMAIN_NAME=mediawikiservice \
      -e RESOURCES_PATH=$RESOURCES_PATH \
      -v "$CUSTOMIZATION_REPO/":/rubyfiles \
      -v "$RESOURCES_PATH/:$RESOURCES_PATH" \
      -w /rubyfiles dataspects/dataspects:$DATASPECTS_DOCKER_IMAGE_VERSION \
        ruby "$script"
  fi
done

# FIXME: Strange error message after running this script...
# ./build_search.sh: line 84: -v: command not found
# ./build_search.sh: line 88: syntax error near unexpected token `fi'
# ./build_search.sh: line 88: `  fi'
