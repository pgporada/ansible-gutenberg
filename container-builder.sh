#!/bin/bash
# AUTHOR: Phil Porada - philporada@gmail.com
# WHAT: Builds and tags all of our testing containers

cd containers
for i in $(find -type d | sed -e 's|./||g' -e 's/\.//g' -e '/^$/d'); do
    cd $i
    docker build -t c6h12o6-$i .
    cd ..
done
