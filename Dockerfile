FROM jenkins:latest

MAINTAINER Boris Mikhaylov

# install docker client
RUN wget -qO- https://get.docker.com/ | sh \
		&& apt-get -f clean \
		&& rm -rf /var/lib/apt/lists/*

ADD custom.groovy /usr/share/jenkins/ref/init.groovy.d/custom.groovy
ADD plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

EXPOSE 8080
