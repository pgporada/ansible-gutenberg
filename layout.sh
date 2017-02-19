#!/bin/bash
# AUTHOR: Phil Porada - philporada@gmail.com

docker run -d -p 9200:9200 elasticsearch

LOGSTASH_CID=$(docker run -d -p 5000:5000 --rm logstash -e 'input {tcp {port => 5000 codec => json}} output {elasticsearch { hosts => ["localhost:9200"] ssl_certificate_verification => false}}')

docker logs -f $LOGSTASH_CID
