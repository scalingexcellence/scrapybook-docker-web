#!/bin/sh
# Scrapy service

logdir=/var/log/scrapyd
exec /usr/local/bin/scrapyd -u scrapy -g nogroup \
            --pidfile /var/run/scrapyd.pid -l $logdir/scrapyd.log \
            >$logdir/scrapyd.out 2>$logdir/scrapyd.err

