FROM williamyeh/ansible:debian7
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get clean
RUN apt-get update
RUN apt-get install -y python-pip
RUN pip install python-logstash --ignore-installed
