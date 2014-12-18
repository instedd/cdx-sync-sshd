#!/bin/sh

if [ ! -f /etc/ssh/keys/ssh_host_rsa_key ]; then
  ssh-keygen -t rsa -N "" -f /etc/ssh/keys/ssh_host_rsa_key
fi

/usr/sbin/sshd -D -e
