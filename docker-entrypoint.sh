#!/bin/bash

# NOTE: sed -i doesn't work when configs are mount points

# set OTS secret if supplied by ENV or if default

# start Redis
#/etc/init.d/redis-server start
redis-server /etc/onetime/redis.conf

# start OTS
cd /var/lib/onetime && bundle exec thin -e dev -R config.ru -p 7143 start