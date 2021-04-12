IMAGENAME=mediawiki

packages=(
    "mediawiki-root-w-folder-1.35.0-3.2.1.tar.gz"
    "mediawiki-root-w-folder-1.35.1-3.2.2.tar.gz"
)

versions=(
    "1.35.0-2104121740"
    "1.35.1-2104121740"
)

# rm -rf versions/*
for p in ${!packages[@]}
do
    # mkdir --parents versions/${versions[$p]}
    # tar -xzf ${packages[$p]} -C versions/${versions[$p]}
    echo "Building Docker image..."
    sudo docker build \
        -t dataspects/$IMAGENAME:${versions[$p]} \
        --build-arg CURRENTW=versions/${versions[$p]} \
        .
    echo "Pushing Docker image..."
    sudo docker login
    sudo docker push dataspects/$IMAGENAME:${versions[$p]}
done

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# $wgDBtype = "mysql";
# $wgDBserver = getenv("MYSQL_HOST");
# $wgDBname = getenv("DATABASE_NAME");
# $wgDBuser = getenv("MYSQL_USER");
# $wgDBpassword = getenv("WG_DB_PASSWORD");
# $wgSiteNotice = "================ MWM Safe Mode ================";
# $wgReadOnly = true; 