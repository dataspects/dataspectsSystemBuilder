IMAGENAME=mediawiki

packages=(
    "mediawiki-root-w-folder-1.35.0-3.2.1.tar.gz"
    "mediawiki-root-w-folder-1.35.1-3.2.2.tar.gz"
)

versions=(
    "1.35.0-2103040820"
    "1.35.1-2103040820"
)

# rm -rf versions/*
# sudo docker login
for p in ${!packages[@]}
do
    # mkdir --parents versions/${versions[$p]}
    # tar -xzf ${packages[$p]} -C versions/${versions[$p]}
    echo "Building Docker image..."
    sudo docker build \
        -t dataspects/$IMAGENAME:${versions[$p]} \
        --build-arg CURRENTW=versions/${versions[$p]} \
        .
    sudo docker push dataspects/$IMAGENAME:${versions[$p]}
done

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# $wgDBtype = "mysql";
# $wgDBserver = "mysql";
# $wgDBname = "mediawiki";
# $wgDBuser = "mediawiki";
# $wgDBpassword = "wgdbpassword";
# $wgSiteNotice = '================ MWM Safe Mode ================';