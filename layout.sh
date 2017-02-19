#!/bin/bash
# AUTHOR: Phil Porada - philporada@gmail.com

echo "+) Starting elasticsearch"
ELASTICSEARCH_CID=$(docker run -d -p 9200:9200 --rm elasticsearch)
ELASTICSEARCH_IPADDR=$(docker inspect $ELASTICSEARCH_CID | grep IPAddress | tail -n1 | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g')
echo

echo "+) Starting logstash"
LOGSTASH_CID=$(docker run -d -p 5000:5000 --rm logstash -e "input {tcp {port => 5000 codec => json}} output {elasticsearch { hosts => [\"$ELASTICSEARCH_IPADDR:9200\"] ssl_certificate_verification => false} stdout {codec => rubydebug }}")
echo

echo "+) Loading ansible template into elasticsearch"
curl -s -XPUT 'http://localhost:9200/_template/ansible' -d@"plugins/ansible.template"
echo
echo

echo "+) Tailing docker logs"
docker logs -f $LOGSTASH_CID
