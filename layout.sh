#!/bin/bash
# AUTHOR: Phil Porada - philporada@gmail.com

ELASTICSEARCH_CID=$(docker run -d -p 9200:9200 elasticsearch)
ELASTICSEARCH_IPADDR=$(docker inspect $ELASTICSEARCH_CID | grep IPAddress | tail -n1 | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g')

curl -s -XPUT 'http://localhost:9200/_template/ansible' -d@"plugins/ansible.template"

LOGSTASH_CID=$(docker run -d -p 5000:5000 --rm logstash -e "input {tcp {port => 5000 codec => json}} output {elasticsearch { hosts => [\"$ELASTICSEARCH_IPADDR:9200\"] ssl_certificate_verification => false}}")

docker logs -f $LOGSTASH_CID
