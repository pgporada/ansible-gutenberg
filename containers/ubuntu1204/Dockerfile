FROM ubuntu-upstart:12.04
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y python-pip iso-codes lsb-release python-apt python-apt-common python-gnupginterface python-pycurl ucf unattended-upgrades xz-utils
RUN pip install setuptools==33.1.1 --ignore-installed
RUN pip install python-logstash --ignore-installed
RUN apt-get install -y sudo curl tar
