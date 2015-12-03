#!/bin/bash

apt-get -y update 

apt-get -y install python-pip python-lxml python-crypto \
    python-cssselect python-openssl python-w3lib \
    python-pyasn1-modules python-twisted python-imaging

# Ohter dev tools. apache2-utils for the useful ab benchmark
apt-get -y install git curl apache2-utils mysql-client redis-tools telnet tree

# Prereq and core
pip install characteristic scrapy==1.0.3 scrapyd==1.1.0

# Useful libs
pip install treq scrapyapperyio boto

# Deployment tools
pip install shub scrapyd-client


# Setup scrapyd

# Add scrapy user
adduser --system --home /var/lib/scrapyd --gecos "scrapy" \
    --no-create-home --disabled-password --quiet scrapy

# Create essential directories
mkdir -p /etc/service/scrapyd /var/log/scrapyd \
    /var/lib/scrapyd /var/lib/scrapyd/eggs \
    /var/lib/scrapyd/dbs /var/lib/scrapyd/items \
    /etc/scrapyd/conf.d

# Add our defaults file for increasing file limit
mv /tmp/scripts/scrapyd /etc/default/
mv /tmp/scripts/scrapyd.sh /etc/service/scrapyd/run
mv /tmp/scripts/000-default /etc/scrapyd/conf.d/

# Chown the directories
chown scrapy:nogroup /var/log/scrapyd \
    /var/lib/scrapyd /var/lib/scrapyd/eggs \
    /var/lib/scrapyd/dbs /var/lib/scrapyd/items


# Clean up APT when done.
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /tmp/scripts

