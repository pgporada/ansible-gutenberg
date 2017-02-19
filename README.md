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

    # Installs all the containers from .kitchen.yml
    bundle exec kitchen create

    # Let's say you have the following 2 playbooks, you can specify the path to them
    PLAYBOOK=test/integration/default/phil1.yml bundle exec kitchen converge
    PLAYBOOK=test/integration/default/phil2.yml bundle exec kitchen converge

    # Assume you have a requirement file in some path other than test/requirements.yml on your host machine
    REQUIREMENTS=/home/phil/requirements.yml bundle exec kitchen converge

    # This still runs the default.yml playbook
    bundle exec kitchen converge

    # Cleanup
    bundle exec kitchen destroy

- - - -

# Testing information

This project utilizes the `kitchen` project and `docker`. You'll need a docker environment running at least docker 1.11 and a ruby environment.

- - - -

# Author Information and License

GPLv3

Phil Porada - philporada@gmail.com
