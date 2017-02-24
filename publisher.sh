#!/bin/bash
# AUTHOR: Phil Porada - philporada@gmail.com
echo "+) Clearing old logs"
mkdir -p elasticsearch-logs
rm -f elasticsearch-logs/*.json*

echo "+) Getting elasticsearch information"
ELASTICSEARCH_CID=$(docker ps | grep elasticsearch | awk '{print $1}')
ELASTICSEARCH_SERVER="http://$(docker inspect $ELASTICSEARCH_CID | grep IPAddress | tail -n1 | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g'):9200"




echo "+) Running elasticdump over the elasticsearch indices"
export NODE_TLS_REJECT_UNAUTHORIZED=0
INDICES=$(curl -sLk -XGET ${ELASTICSEARCH_SERVER}/_cat/indices?pretty | cut -d $' ' -f3)
for INDEX in $INDICES; do
    echo $INDEX - mapping
    elasticdump \
        --bulk \
        --type=mapping \
        --input=${ELASTICSEARCH_SERVER}/${INDEX} \
        --output=elasticsearch-logs/${INDEX}.mapping.json

    echo $INDEX - data
    elasticdump \
        --bulk \
        --type=data \
        --input=${ELASTICSEARCH_SERVER}/${INDEX} \
        --output=elasticsearch-logs/${INDEX}.data.json
done
