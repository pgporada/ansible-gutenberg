#!/bin/bash
# AUTHOR: Phil Porada - philporada@gmail.com
# WHAT: Builds and tags all of our testing containers

BLD=$(tput bold)
RST=$(tput sgr0)

cd containers
for i in $(find -type d | sed -e 's|./||g' -e 's/\.//g' -e '/^$/d'); do
    echo "${BLD}Building container: ${i}${RST}"
    cd $i
    docker build -t c6h12o6-$i .
    cd ..
done
