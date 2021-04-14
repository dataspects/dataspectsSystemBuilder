IMAGENAME=mediawiki

packages=(
    "mediawiki-root-w-folder-1.35.0-3.2.1.tar.gz"
    "mediawiki-root-w-folder-1.35.1-3.2.2.tar.gz"
)

# Rename ./versions folders first!!!
versions=(
    "1.35.0-2104141705"    
    "1.35.1-2104141705"
)

# rm -rf versions/*
for p in ${!packages[@]}
do
    # mkdir --parents versions/${versions[$p]}
    # tar -xzf ${packages[$p]} -C versions/${versions[$p]}
    echo "Building Docker image $IMAGENAME:${versions[$p]}"
    sudo docker build \
        -t dataspects/$IMAGENAME:${versions[$p]} \
        --build-arg CURRENTW=versions/${versions[$p]} \
        .
    echo "Pushing Docker image $IMAGENAME:${versions[$p]}"
    sudo docker login
    sudo docker push dataspects/$IMAGENAME:${versions[$p]}
done

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# $wgDBtype = "mysql";
# $wgDBserver = getenv("MYSQL_HOST");
# $wgDBname = getenv("DATABASE_NAME");
# $wgDBuser = getenv("MYSQL_USER");
# $wgDBpassword = getenv("WG_DB_PASSWORD");
# # MWStake MediaWiki Manager
# $mwmls = "../mwmLocalSettings.php";
# if(file_exists($mwmls)) {
# 	require_once($mwmls);
# } else { 
# 	echo "ERROR: ../mwmLocalSettings.php include not loaded.";
# }