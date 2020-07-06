    docker login --username=yourhubusername --password=yourpassword

    docker build -t $DOCKER_ACC/$DOCKER_REPO:$IMG_TAG .

    sudo docker push $DOCKER_ACC/$DOCKER_REPO:$IMG_TAG