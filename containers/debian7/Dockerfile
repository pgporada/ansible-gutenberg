FROM huxy/docker-debian:latest
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get clean
RUN apt-get update
RUN apt-get install -y python-pip
RUN pip install python-logstash --ignore-installed
RUN apt-get install -y sudo curl tar
