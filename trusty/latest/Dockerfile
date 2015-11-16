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

RUN apt-get -y update \
    && apt-get -y install \
    python-pip \
    python-lxml \
    python-crypto \
    python-cssselect \
    python-openssl \
    python-w3lib \
    python-pyasn1-modules \
    python-twisted \
    git \
    curl \
    apache2-utils \
    mysql-client \
    redis-tools \
    && pip install \
    treq \
    characteristic \
    scrapyapperyio \
    shub \
    scrapyd-client \
    scrapy==1.0.3 \
    scrapyd==1.1.0 \
    && mkdir -p \
    /var/log/scrapyd \
    /var/lib/scrapyd \
    /var/lib/scrapyd/eggs \
    /var/lib/scrapyd/dbs \
    /var/lib/scrapyd/items \
    /etc/scrapyd/conf.d \
    && ln -s /lib/init/upstart-job /etc/init.d/scrapyd \
    && adduser --system --home /var/lib/scrapyd --gecos "scrapy" --no-create-home --disabled-password --quiet scrapy \
    && chown scrapy:nogroup /var/log/scrapyd /var/lib/scrapyd /var/lib/scrapyd/eggs /var/lib/scrapyd/dbs /var/lib/scrapyd/items

# Add our defaults file for increasing file limit
COPY scrapyd /etc/default/
COPY scrapyd.conf /etc/init/
COPY 000-default /etc/scrapyd/conf.d/

EXPOSE 6800

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
