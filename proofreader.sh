#!/bin/bash
# AUTHOR: Phil Porada

if [ ! -f Gemfile.lock ]; then
    bundle install
else
    bundle update
fi

bundle exec kitchen create

if [ $? -ne 0 ]; then
    bundle exec kitchen create
fi

bundle exec kitchen list

bundle exec kitchen converge
