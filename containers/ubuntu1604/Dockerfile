FROM geerlingguy/docker-ubuntu1604-ansible:latest
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -f
RUN apt-get install -y python-pip
RUN pip install --upgrade --ignore-installed --no-cache-dir pip
RUN pip install setuptools==33.1.1 --ignore-installed --no-cache-dir
RUN pip install wheel virtualenv --upgrade --ignore-installed --no-cache-dir
RUN pip install python-logstash --ignore-installed --no-cache-dir
RUN apt-get install -y sudo curl tar
