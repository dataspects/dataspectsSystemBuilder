# {{Annotation
#   |TakesAnEnvironmentVariable=PASSPHRASE
#   |EnvironmentVariableNameIsDefinedBy=duplicity
#   |EnvironmentVariableIsUsedFor=This passphrase is passed to GnuPG.
# }}
# {{Annotation
#   |TakesAnEnvironmentVariable=ENCRYPTKEYID
#   |EnvironmentVariableNameIsDefinedBy=container
# }}
# [[TakesASingleURL::BackupDestination]]
# [[TakesASingleUser::UserRunningTheBackup]]

FROM alpine:3.7

# The “HOME” variable stores the default location of Docker configuration files.
ENV HOME=/home/duplicity

RUN set -x \
 && apk add --no-cache \
        ca-certificates \
        duplicity \
        lftp \
        openssh \
        openssl \
        py-crypto \
        py-pip \
        py-paramiko \
        py-setuptools \
        rsync \
 && update-ca-certificates \
 && pip install \
      pydrive==1.3.1 \
      fasteners==0.14.1 \
 && apk del --purge py-pip \
 && adduser -D -u 1896 duplicity \
 && mkdir -p /home/duplicity/.cache/duplicity \
 && mkdir -p /home/duplicity/.gnupg \
 && chmod -R go+rwx /home/duplicity/ \
 && su - duplicity -c 'duplicity --version'

VOLUME ["/home/duplicity/.cache/duplicity", "/home/duplicity/.gnupg"]

# QUESTION: Why is this necessary since we add --user $UID to docker run?
USER duplicity

# https://www.ctl.io/developers/blog/post/dockerfile-entrypoint-vs-cmd/
CMD ["duplicity"]

# docker run --rm \
#   --user `id -u smwckmain` \
#   -v /mnt/source/:/home/vagrant/Backup_SMWCK \
#   -v /mnt/target/:/home/vagrant/Restored_SMWCK \
# dataspects/duplicity \
#   duplicity restore file:///home/vagrant/Backup_SMWCK /home/vagrant/Restored_SMWCK

# docker run --rm dataspects/duplicity --version
