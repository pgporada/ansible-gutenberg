FROM ubuntu-upstart:14.04
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt update
RUN apt upgrade -y
RUN apt-get install -y python-pip libffi-dev libssl-dev python-dev sudo curl tar
RUN apt install -f -y
RUN pip install --upgrade --ignore-installed pip
RUN pip install setuptools==33.1.1 --ignore-installed
RUN pip install python-logstash --ignore-installed --no-cache-dir
RUN pip install ansible --ignore-installed
