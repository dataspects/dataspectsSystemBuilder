IMAGENAME=mediawiki
VERSION=211026

packages=(
    "dataspects-mediawiki-root-w-folder-1.36.2-3.2.3.tar.gz"
)

# Rename ./versions folders first!!!
versions=(
    "1.36.2-3.2.3"
)

ARCH=`arch`

# rm -rf versions/*
for p in ${!packages[@]}
do
    # mkdir --parents versions/${versions[$p]}
    # tar -xzf ${packages[$p]} -C versions/${versions[$p]}
    cat require_customizations.sh >> ./versions/${versions[$p]}/LocalSettings.php
    echo "Appended require_customizations.sh to ./versions/${versions[$p]}/LocalSettings.php"
    echo "{}" > ./versions/${versions[$p]}/composer.local.json
    echo "{}" > ./versions/${versions[$p]}/composer.local.lock
    echo "Building Docker image $IMAGENAME:${versions[$p]}_$VERSION-$ARCH"
    docker build \
        -t dataspects/$IMAGENAME:${versions[$p]}_$VERSION-$ARCH \
        --build-arg CURRENTW=./versions/${versions[$p]} \
        --build-arg ARCH=$ARCH \
        .
    echo "Pushing Docker image $IMAGENAME:${versions[$p]}_$VERSION-$ARCH"
    docker login
    docker push dataspects/$IMAGENAME:${versions[$p]}_$VERSION-$ARCH
done