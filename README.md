# Overview: ansible-gutenberg
[![License](https://img.shields.io/badge/license-GPLv3-brightgreen.svg)](LICENSE)

Some helper scripts and stuff that help me print out (play)book after (play)book. Get it. Gutenberg. Ha! :D

- - - -

# Usage

Requires
* `sudo npm install -g elasticdump`
* `python-pip`
* `pip install tox`

### Manually
Start the logging infrastructure

    ./layout.sh

Create playbook(s)

    ./printer.sh

Generate all the data

    ./proofreader.sh

Get the data out of Elasticsearch

    ./publisher.sh

Get stats out of the logs stored in elasticsearch

    ./reviewer.sh

### Really really manually

    bundle install
    bundle update

    # Installs all the containers from .kitchen.yml
    bundle exec kitchen create

    # Let's say you have the following 2 playbooks, you can specify the path to them
    PLAYBOOK=test/integration/default/phil1.yml bundle exec kitchen converge
    PLAYBOOK=test/integration/default/phil2.yml bundle exec kitchen converge

    # Assume you have a requirement file in some path other than test/requirements.yml on your host machine
    REQUIREMENTS_PATH=/home/phil/requirements.yml bundle exec kitchen converge

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
[David Dondero - Rothko Chapel](https://www.youtube.com/watch?v=SMLlp_7yNNc)
