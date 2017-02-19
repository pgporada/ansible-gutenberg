# Overview: ansible-gutenberg

Some helper scripts and stuff that help me print out (play)book after (play)book. Get it. Gutenberg. Ha! :D

- - - -

# Usage

### Automagic
Create a playbook

    ./printer.sh

Run tests

    ./proofreader.sh

### Manually

    bundle install
    bundle update
    bundle exec kitchen create
    PLAYBOOK=test/integration/default/phil1.yml bundle exec kitchen converge
    PLAYBOOK=test/integration/default/phil2.yml bundle exec kitchen converge
    PLAYBOOK=test/integration/default/phil3.yml bundle exec kitchen converge
    bundle exec kitchen destroy

- - - -

# Testing information

This project utilizes the `kitchen` project and `docker`. You'll need a docker environment running at least docker 1.11 and a ruby environment.

- - - -

# Author Information and License

GPLv3

Phil Porada - philporada@gmail.com
