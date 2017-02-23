FROM williamyeh/ansible:debian7
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN sudo apt-get clean
RUN sudo apt-get update
RUN sudo apt-get install -y python-pip
RUN sudo pip install python-logstash --ignore-installed
