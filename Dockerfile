FROM jenkins:latest

MAINTAINER Boris Mikhaylov

ENV DEBIAN_FRONTEND noninteractive

USER root
# install docker client
RUN wget -qO- https://get.docker.com/ | sh \
		&& apt-get clean \
		&& rm -rf /var/lib/apt/lists/*

# install docker compose
ENV DOCKER_COMPOSE_VERSION 1.7.0
RUN wget https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose \
 && chmod +x /usr/local/bin/docker-compose

RUN usermod -a -G docker jenkins
RUN chown -R jenkins:jenkins /var/jenkins_home

USER jenkins

ADD config/ /usr/share/jenkins/ref/init.groovy.d/
ADD plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt
