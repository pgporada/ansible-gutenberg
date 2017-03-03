#!/bin/bash
# AUTHOR: Phil Porada - philporada@gmail.com
# WHAT: Prints out playbook after playbook

function usage {
    echo -e "
    USAGE:

    ./$(basename $0) -t ntp -d 'Install and configure an ntp daemon from Ansible Galaxy' -r docker
    ./$(basename $0) -t java -d 'Install a java role from Ansible Galaxy' -r ec2
    "
}

function print_docker {
    local ROLE="${1}"
    local DESC="${2}"
    declare -a ROLES
    rm -f chapter_$ROLE.txt
    ROLES=( $(ansible-galaxy search $ROLE | awk 'NR>5' | awk '{print $1}' | sed 's/[[:space:]]//g') )

    for ROLE in ${ROLES[@]}; do
        mkdir -p playbooks/$TYPE/$ROLE
        # We already built the containers, let's blow them away and start them up immediately
        echo "bundle exec kitchen destroy -c10; PLAYBOOK=playbooks/$ROLE/$ROLE/playbook_$ROLE_$ROLE.yml REQUIREMENTS_PATH=playbooks/$ROLE/$ROLE/requirements.yml bundle exec kitchen converge -c $CPU_COUNT; bundle exec kitchen create -c10;" >> chapter_$ROLE.txt
        cat << REQ > playbooks/$TYPE/$ROLE/requirements.yml
---
- src: $ROLE
...
REQ

        cat << PLAYBOOK > playbooks/$TYPE/$ROLE/playbook_$ROLE_$ROLE.yml
---
- name: "${DESC}"
  hosts: all
  roles:
    - $ROLE
...
PLAYBOOK
    done
}

function print_ec2 {
    local ROLE="${1}"
    local DESC="${2}"
    declare -a ROLES
    rm -f chapter_$ROLE.txt
    ROLES=( $(ansible-galaxy search $ROLE | awk 'NR>5' | awk '{print $1}' | sed 's/[[:space:]]//g') )

    for ROLE in ${ROLES[@]}; do
        mkdir -p playbooks/$TYPE/$ROLE
        # We already built the containers, let's blow them away and start them up immediately
        echo "bundle exec kitchen destroy -c10; PLAYBOOK=playbooks/$ROLE/$ROLE/playbook_$ROLE_$ROLE.yml REQUIREMENTS_PATH=playbooks/$ROLE/$ROLE/requirements.yml bundle exec kitchen converge -c $CPU_COUNT; bundle exec kitchen create -c10;" >> chapter_$ROLE.txt
        cat << REQ > playbooks/$TYPE/$ROLE/requirements.yml
---
- src: $ROLE
...
REQ

        cat << PLAYBOOK > playbooks/$TYPE/$ROLE/playbook_$ROLE_$ROLE.yml
---
- name: "${DESC}"
  hosts: all
  gather_facts: true
  become: true
  become_method: sudo
  roles:
    - $ROLE
...
PLAYBOOK
    done
}

while getopts ":t:r:d:" opt; do
  case $opt in
    t) TYPE="${OPTARG}" ;;
    r) ROLE="${OPTARG}" ;;
    d) DESC="${OPTARG}" ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

for i in TYPE ROLE DESC; do
    if [ -z ${!i} ]; then
        usage
        echo $i was not set
        exit 1
    fi
done

CPU_COUNT=$(( $(grep "^processor" /proc/cpuinfo | awk '{print $3}' | wc -l) + 2 ))
printer_${TYPE} "${ROLE}" "${DESC}"
