cdx-sync-sshd
=============

This repository contains the necessary files to build the 'cdx-sync-sshd' Docker image.
The image can host a SSH server that receives _rsync_ sessions from [cdx-sync-client](https://github.com/instedd/cdx-sync-client).

The first time the container is run it will generate a keypair and store it on `/etc/ssh/keys`. This directory should be externally mapped to make the keys persistent.

The user _cdx-sync_ is preconfigured and it's expected that the remote client will connect using it as the login name.

Build the image
---------------

To build the Docker image you can use `docker build .` directly or run `make` which will create the image and tag it with the *cdx-sync-sshd* name.

Automated build
---------------

There is a configured repository in [Docker Hub](https://registry.hub.docker.com/u/instedd/cdx-sync-sshd/) that automatically build an image every time the repository receives a push.


Run from the working copy
-------------------------

Once the image is built, there is another Makefile target to run a test server. It can started running `make testrun`. Two directories will be created in the host machine and mapped to the volumes in the container:

  * *keys*: The first time the container is run it will generate the keypair and store it in this directory
  * *home*: This will be the home directory of the _cdx-sync_ user

Optionally the *home* directory can be changed passing the *SYNC_HOME* variable:

`make testrun SYNC_HOME=/path/to/home`.

Also, the *keys* directory can be changed by setting the *SYNC_KEYS* variable:

`make testrun SYNC_KEYS=/path/to/keys`.

Execute from Docker image directly
----------------------------------

At the server or if you prefer to not checkout this repository and build the image yourself, the container can be run pulling the image from the Docker registry:

```
$ docker pull instedd/cdx-sync-sshd

$ docker run -it --rm \
    -p 2222:22 \
    -v /path/to/keys:/etc/ssh/keys \
    -v /path/to/home:/home/cdx-sync \
    cdx-sync-sshd
```


Ports forwarding - Mac Only
---------------------------

If you are running from a Mac with ```boot2docker``` ports exported by docker will not be exposed to you machine by default. Check [this issue](https://github.com/docker/docker/issues/4007). 
