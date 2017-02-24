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
SIDS=( $(for i in $LOGFILES; do jq -r '._source.session' $i; done 2>&1 | sed -e '/parse error/d' -e '/^null$/d' | sort -u) )
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
PLAYBOOKS=( $(for i in $LOGFILES; do jq -r '._source.ansible_playbook' $i; done 2>&1 | sed -e '/parse error/d' -e '/^null$/d') )
for i in ${PLAYBOOKS[@]}; do
    echo ${i}
done
echo
# #-------
#
# #-------

# 6) Display all play IDs
echo "+------------------------+"
echo "+ # Display all play IDs +"
echo "+------------------------+"
declare -a PLAYIDS
PLAYIDS=( $(for i in $LOGFILES; do jq -r '._source.ansible_play_id' $i; done 2>&1 | sed -e '/parse error/d' -e '/^null$/d') )
for i in ${PLAYIDS[@]}; do
    echo "${i}"
done
echo
# #-------
# 1c5f35bf-c7ba-4e8c-84c4-7b44992d4943
# faf21b87-a808-462e-98d4-0b349210c3ce
# faf21b87-a808-462e-98d4-0b349210c3ce
# 3344b2e4-32e3-4565-ab0a-9605093f7782
# #-------

# 7) Count the # of Play IDs, this will be the number of plays run
echo "+------------------+"
echo "+ # of Play IDs +"
echo "+------------------+"
echo ${#PLAYIDS[@]}
echo
# #-------
# 256
# #-------

# 8) Get names of all the roles from each session id
echo "+----------------------------------+"
echo "+ # Display names of all roles run +"
echo "+----------------------------------+"
for SID in ${SIDS[@]}; do
	jq -r ". | select(._source.session==\"$SID\") | ._source.ansible_task" *.data.json | sed -e '/^null$/d' | awk '{print $1}'
done | sort -u
echo
# #-------
# kbrebanov.ntp
# mamercad.ntp
# manala.ntp
# olibob.ntp
# pgporada.ntp
# ragingbal.ntp
# #-------
