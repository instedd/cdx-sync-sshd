#!/bin/sh

if [ ! -f /etc/ssh/keys/ssh_host_rsa_key ]; then
  ssh-keygen -t rsa -N "" -f /etc/ssh/keys/ssh_host_rsa_key
fi

EXISTING_SYNC_UID=`id -u cdx-sync`

if [ $? -eq 0 ]; then
  if [ $EXISTING_SYNC_UID -ne $SYNC_UID ]; then
    echo "The cdx-sync user is already created but the UID is different from the one specified: $EXISTING_SYNC_UID"
    exit 1
  fi
else
  adduser --uid $SYNC_UID --disabled-password --gecos "" cdx-sync
  mkdir -p /home/cdx-sync/tmp/sync /home/cdx-sync/.ssh
  chown cdx-sync:cdx-sync -R /home/cdx-sync
fi

exec /usr/sbin/sshd -D -e 2>&1
