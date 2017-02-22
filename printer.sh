#!/bin/bash
# AUTHOR: Phil Porada - philporada@gmail.com
# WHAT: Prints out playbook after playbook

CPU_COUNT=$(( $(grep "^processor" /proc/cpuinfo | awk '{print $3}' | wc -l) + 2 ))

declare -a NTP_ROLES
NTP_ROLES=( $(ansible-galaxy search ntp | awk 'NR>5' | awk '{print $1}' | sed 's/[[:space:]]//g') )

mkdir -p playbooks/{ntp}

rm -f chapters.txt

for ROLE in ${NTP_ROLES[@]}; do
    mkdir -p playbooks/ntp/$ROLE
    cat << REQ > playbooks/ntp/$ROLE/requirements.yml
---
- src: $ROLE
...
REQ

    cat << PLAYBOOK > playbooks/ntp/$ROLE/playbook_ntp_$ROLE.yml
---
- name: Installs and configures an ntp daemon with a role from Ansible Galaxy
  hosts: all
  roles:
    - $ROLE
...
PLAYBOOK

echo "PLAYBOOK=playbooks/ntp/$ROLE/playbook_ntp_$ROLE.yml REQUIREMENTS_PATH=playbooks/ntp/$ROLE/requirements.yml bundle exec kitchen converge -c $CPU_COUNT" >> chapters.txt
done
