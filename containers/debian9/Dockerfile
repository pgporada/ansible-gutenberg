FROM gmazoyer/ansible-docker-debian9
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt clean
RUN rm -rf /var/lib/apt/lists/*
RUN apt update
RUN apt upgrade -y
RUN apt install -y python-pip apt-utils git git-man less libapt-inst2.0 libbsd0 libedit2 liberror-perl libpopt0 libx11-6 libx11-data libxau6 libxcb1 libxdmcp6 libxext6 libxmuu1 openssh-client rsync xauth sudo curl tar
RUN pip install --upgrade --ignore-installed --no-cache-dir pip
RUN pip install setuptools==33.1.1 --ignore-installed --no-cache-dir
RUN pip install wheel virtualenv --upgrade --ignore-installed --no-cache-dir
RUN pip install python-logstash --ignore-installed --no-cache-dir
