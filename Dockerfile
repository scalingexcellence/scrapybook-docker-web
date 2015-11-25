# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.17

# Use baseimage-docker's init system.

# Using https://hub.docker.com/r/phusion/baseimage/
CMD ["/sbin/my_init"]

# ...put your own build instructions here...

# Enabling ssh
RUN rm -f /etc/service/sshd/down
# Enable insecure key
RUN /usr/sbin/enable_insecure_key

COPY scripts /tmp/scripts

RUN /tmp/scripts/setup.sh

# Custom part for web's image
COPY app app

RUN mkdir /etc/service/bookweb
ADD start.sh /etc/service/bookweb/run
# Don't start scrapyd
RUN rm /etc/service/scrapyd/run

EXPOSE 9312

# Commented out because it's done in setup.sh
# Clean up APT when done.
#RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
