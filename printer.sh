#!/bin/bash
# AUTHOR: Phil Porada - philporada@gmail.com
# WHAT: Prints out playbook after playbook

function usage {
    echo -e "
    USAGE:

    ./$(basename $0) ntp 'Install and configure an ntp daemon from Ansible Galaxy'
    ./$(basename $0) java 'Install a java role from Ansible Galaxy'
    "
}

function printer {
    local CPU_COUNT=$(( $(grep "^processor" /proc/cpuinfo | awk '{print $3}' | wc -l) + 2 ))
    local TYPE="${1}"
    local DESC="${2}"
    declare -a ROLES

    rm -f chapter_$TYPE.txt
    ROLES=( $(ansible-galaxy search $TYPE | awk 'NR>5' | awk '{print $1}' | sed 's/[[:space:]]//g') )

    for ROLE in ${ROLES[@]}; do
        mkdir -p playbooks/$TYPE/$ROLE
        echo "bundle exec kitchen destroy; PLAYBOOK=playbooks/$TYPE/$ROLE/playbook_$TYPE_$ROLE.yml REQUIREMENTS_PATH=playbooks/$TYPE/$ROLE/requirements.yml bundle exec kitchen converge -c $CPU_COUNT; bundle exec kitchen create;" >> chapter_$TYPE.txt
        cat << REQ > playbooks/$TYPE/$ROLE/requirements.yml
---
- src: $ROLE
...
REQ

        cat << PLAYBOOK > playbooks/$TYPE/$ROLE/playbook_$TYPE_$ROLE.yml
---
- name: "${DESC}"
  hosts: all
  roles:
    - $ROLE
...
PLAYBOOK
    done
}

if [ $# -ne 2 ]; then
    usage
    exit 1
else
    TYPE="${1}"
    DESC="${2}"
    printer "${TYPE}" "${DESC}"
fi
