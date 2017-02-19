#!/bin/bash
# AUTHOR: Phil Porada - philporada@gmail.com

CPU_COUNT=$(( $(grep "^processor" /proc/cpuinfo | awk '{print $3}' | wc -l) + 2 ))

if [ ! -f Gemfile.lock ]; then
    bundle install
    bundle update
fi

bundle exec kitchen create -c $CPU_COUNT

if [ $? -ne 0 ]; then
    bundle exec kitchen create -c $CPU_COUNT
fi

bundle exec kitchen list

LOGSTASH_CID=$(docker ps | grep logstash | awk '{print $1}')
LOGSTASH_SERVER=$(docker inspect $LOGSTASH_CID | grep IPAddress | tail -n1 | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g')
echo "+) Logstash server ip address is: $LOGSTASH_SERVER"

LOGSTASH_SERVER=$LOGSTASH_SERVER bundle exec kitchen converge -c $CPU_COUNT

#bundle exec kitchen destroy
