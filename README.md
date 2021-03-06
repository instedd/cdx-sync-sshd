cdx-sync-sshd
=============

This repository contains the necessary files to build the 'cdx-sync-sshd' Docker image.
The image can host a SSH server that receives _rsync_ sessions from [cdx-sync-client](https://github.com/instedd/cdx-sync-client).

The first time the container is run it will generate a keypair and store it on `/etc/ssh/keys`. This directory should be externally mapped to make the keys persistent.

The user _cdx-sync_ is preconfigured and it's expected that the remote client will connect using it as the login name.

Build the image
---------------

To build the Docker image you can use `docker build .` directly or run `make` which will create the image and tag it with the *instedd/cdx-sync-sshd* name.

Automated build
---------------

There is a configured repository in [Docker Hub](https://registry.hub.docker.com/u/instedd/cdx-sync-sshd/) that automatically build an image every time the repository receives a push.


Run from the working copy
-------------------------

Docker compose configuration is included. To build and start the container run: `docker-compose up` on the project directory.


Execute from Docker image directly
----------------------------------

At the server or if you prefer to not checkout this repository and build the image yourself, the container can be run pulling the image from the Docker registry:

```
$ docker pull instedd/cdx-sync-sshd

$ docker run -it --rm \
    -p 2222:22 \
    -v /path/to/keys:/etc/ssh/keys \
    -v /path/to/ssh:/home/cdx-sync/.ssh \
    -v /path/to/sync:/home/cdx-sync/tmp/sync \
    instedd/cdx-sync-sshd
```


Ports forwarding - Mac Only
---------------------------

If you are running from a Mac with ```boot2docker``` ports exported by docker will not be exposed to you machine by default. Check [this issue](https://github.com/docker/docker/issues/4007).


Connecting to the server
------------------------

If you have deployed your server locally, you can check ssh connection setup is working propertly by running

```
ssh cdx-sync@localhost -p 2222
```
