FROM geerlingguy/docker-ubuntu1604-ansible:latest
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN sudo apt-get clean
RUN sudo apt-get update
RUN sudo apt-get upgrade -y
RUN sudo apt-get install -f
RUN sudo apt-get install -y python-pip
RUN sudo pip install --upgrade --ignore-installed --no-cache-dir pip
RUN sudo pip install setuptools==33.1.1 --ignore-installed --no-cache-dir
RUN sudo pip install wheel virtualenv --upgrade --ignore-installed --no-cache-dir
RUN sudo pip install python-logstash --ignore-installed --no-cache-dir
