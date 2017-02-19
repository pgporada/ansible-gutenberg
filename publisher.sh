#!/bin/bash
# AUTHOR: Phil Porada - philporada@gmail.com

# 1) Get all logstash-2017.02.14.data.json files
echo "+-----------+"
echo "+ Log Files +"
echo "+-----------+"
cd elasticsearch-logs
LOGFILES=$(find . -type f -name "logstash-*.data.json" | sed 's|^./||')
for i in ${LOGFILES}; do
    echo ${i}
done
echo
# #-------
# logstash-2017.02.14.data.json
# logstash-2017.02.15.data.json
# #-------

# 2) Get all session IDs in all logstash data files. A single instance of a SID is a playbook run.
echo "+-------------+"
echo "+ Session IDs +"
echo "+-------------+"
declare -a SIDS
SIDS=( $(for i in $LOGFILES; do jq -r '._source.session' $i; done 2>&1 | sed '/parse error/d' | sort -u) )
for i in ${SIDS[@]}; do
    echo ${i}
done
echo
# #-------
# ab28360e-f27b-11e6-b8cx-0242ac110004
# ff0b955e-f27b-11e6-822x-0242ac110004
# #-------

# 3) Count the # of SIDS
echo "+------------------+"
echo "+ # of Session IDs +"
echo "+------------------+"
echo ${#SIDS[@]}
echo
# #-------
# 256
# #-------

# 4) Get number of steps per SID
echo "+---------------------------+"
echo "+ # of steps per Session ID +"
echo "+---------------------------+"
# declare -A SIDCOUNT
# for FILE in ${LOGFILES}; do \
#     for SID in ${SIDS[@]}; do \
#         jq -r ". | select(._source.session==\"${SID}\") | ._source.session" ${FILE} 2>&1 | sed '/parse error/d'; \
#     done; \
# done; \
# sed '/^$/d' | sort -u | wc -l
echo
# #-------
# ff0b955e-f27b-11e6-822x-0242ac110004: 7 tasks
# bnkw4kxe-vsdk-23e6-482x-0242ac110004: 1 task
# #-------


# 5) Get names of all the playbooks
echo "+---------------------------------+"
echo "+ # Display name of playbooks ran +"
echo "+---------------------------------+"
LOGFILES=$(find . -type f -name "logstash-*.data.json" | sed 's|^./||')
declare -a PLAYBOOKS
PLAYBOOKS=( $(for i in $LOGFILES; do jq -r '._source.ansible_playbook' $i; done 2>&1 | sed '/parse error/d') )
for i in ${PLAYBOOKS[@]}; do
    echo ${i}
done
# #-------
#
# #-------

