FROM debian

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server rsync && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Remove generated keys during install
RUN rm /etc/ssh/ssh_host*
RUN mkdir /etc/ssh/keys
RUN mkdir /var/run/sshd
ADD files/sshd_config /etc/ssh/sshd_config
ADD files/sshd.sh /usr/local/bin/sshd.sh
ADD files/rrsync /usr/local/bin/rrsync

# Create user
RUN adduser --disabled-password --gecos "" cdx-sync

VOLUME /etc/ssh/keys
VOLUME /home/cdx-sync

EXPOSE 22

CMD /usr/local/bin/sshd.sh
