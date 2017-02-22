#!/bin/bash
# AUTHOR: Phil Porada - philporada@gmail.com
# WHAT: Prints out playbook after playbook

ansible-galaxy search ntp | awk 'NR>5' | awk '{print $1}' | sed 's/[[:space:]]//g'
