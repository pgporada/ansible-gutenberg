#!/bin/bash
# AUTHOR: Phil Porada - philporada@gmail.com

CPU_COUNT=$(( $(grep "^processor" /proc/cpuinfo | awk '{print $3}' | wc -l) + 2 ))

if [ ! -f Gemfile.lock ]; then
    bundle install
else
    bundle update
fi

bundle exec kitchen create -c $CPU_COUNT

if [ $? -ne 0 ]; then
    bundle exec kitchen create -c $CPU_COUNT
fi

bundle exec kitchen list

bundle exec kitchen converge -c $CPU_COUNT
