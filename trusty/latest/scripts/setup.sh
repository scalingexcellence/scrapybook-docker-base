#!/bin/bash

# Repo for Java
add-apt-repository -y ppa:webupd8team/java

# Update apt from repos
apt-get -y update

# Install scrapy prerequisites
apt-get -y install python-pip python-lxml python-crypto \
    python-cssselect python-openssl python-w3lib \
    python-pyasn1-modules python-twisted python-imaging

# Ohter dev tools. apache2-utils for the useful ab benchmark
apt-get -y install git curl apache2-utils mysql-client redis-tools telnet tree vim nano ftp

# Prereq and core
pip install characteristic scrapy==1.0.3 scrapyd==1.1.0

# Useful libs
pip install treq boto scrapyapperyio

# Deployment tools
pip install shub scrapyd-client

# Add scrapy user
adduser --system --home /var/lib/scrapyd --gecos "scrapy" \
    --no-create-home --disabled-password --quiet scrapy

# Create essential directories
mkdir -p /var/log/scrapyd \
    /var/lib/scrapyd /var/lib/scrapyd/eggs \
    /var/lib/scrapyd/dbs /var/lib/scrapyd/items

# Chown the directories
chown scrapy:nogroup /var/log/scrapyd \
    /var/lib/scrapyd /var/lib/scrapyd/eggs \
    /var/lib/scrapyd/dbs /var/lib/scrapyd/items

# Install Java (irrelevant to Scrapy)
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
echo "debconf shared/accepted-oracle-license-v1-1 seen true" | sudo debconf-set-selections
apt-get -y install oracle-java8-installer >/dev/null 2>&1

export JAVA_HOME=/usr/lib/jvm/java-8-oracle

echo '' >> /etc/profile
echo '# JDK' >> /etc/profile
echo "export JAVA_HOME=$JAVA_HOME" >> /etc/profile
echo 'export PATH="$PATH:$JAVA_HOME/bin"' >> /etc/profile
echo '' >> /etc/profile

# Clean up APT and other temp directories
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

