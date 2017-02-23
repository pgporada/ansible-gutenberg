FROM geerlingguy/docker-centos6-ansible:latest
RUN yum install -y python-pip
RUN pip install --upgrade --ignore-installed --no-cache-dir pip
RUN pip install setuptools==33.1.1 --ignore-installed --no-cache-dir
RUN pip install python-logstash --ignore-installed --no-cache-dir
RUN yum install -y sudo curl tar wget
