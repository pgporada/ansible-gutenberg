FROM minimum2scp/debian-wheezy:latest
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get clean
RUN apt-get update
RUN apt-get install -y python-pip sudo curl tar python-dev libssl-dev libffi-dev libyaml-dev iso-codes lsb-release python-apt python-apt-common python-gnupginterface python-pycurl ucf unattended-upgrades xz-utils
RUN pip install python-logstash --ignore-installed
RUN pip install setuptools==33.1.1
RUN pip install ansible
