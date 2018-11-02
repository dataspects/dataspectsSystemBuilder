# Base MediaWiki Containers.

You need to export the current user and group so that the docker containers for nginx and php can access the web files on the local host.

```
export GID="$(id -g $(whoami))"
export UID
```

You also need to set the root password for MariaDB in the docker compose file.
