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
RUN adduser --uid 9999 --disabled-password --gecos "" cdx-sync
RUN mkdir /home/cdx-sync/sync
RUN mkdir /home/cdx-sync/.ssh
RUN chown cdx-sync:cdx-sync /home/cdx-sync/sync
RUN chown cdx-sync:cdx-sync /home/cdx-sync/.ssh

VOLUME /etc/ssh/keys
VOLUME /home/cdx-sync/sync
VOLUME /home/cdx-sync/.ssh

EXPOSE 22

CMD /usr/local/bin/sshd.sh
