#!/bin/bash
# AUTHOR: Phil Porada - philporada@gmail.com

echo "+) Getting elasticsearch information"
ELASTICSEARCH_CID=$(docker ps | grep elasticsearch | awk '{print $1}')
ELASTICSEARCH_SERVER=$(docker inspect $ELASTICSEARCH_CID | grep IPAddress | tail -n1 | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g')

echo "+) Running elasticdump over the elasticsearch indices"
export NODE_TLS_REJECT_UNAUTHORIZED=0
INDICES=$(curl -skXGET http://${ELASTICSEARCH_SERVER}:9200/_cat/indices?pretty | cut -d $' ' -f3)
for INDEX in $INDICES; do
    echo $INDEX - mapping
    elasticdump \
        --bulk \
        --type=mapping \
        --input=http://${ELASTICSEARCH_SERVER}:9200/${INDEX} \
        --output=$ | gzip > ${INDEX}.mapping.json.gz

    echo $INDEX - data
    elasticdump \
        --bulk \
        --type=data \
        --input=http://${ELASTICSEARCH_SERVER}:9200/${INDEX} \
        --output=$ | gzip > ${INDEX}.data.json.gz
done
