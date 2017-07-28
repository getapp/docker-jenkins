FROM jenkins:latest

MAINTAINER Boris Mikhaylov

ENV DEBIAN_FRONTEND noninteractive

USER root
# install docker client
ENV DOCKER_VERSION 17.06.0
RUN wget -qO- https://get.docker.com/ | sh \
    && apt-get install -y --force-yes docker-сe=${DOCKER_VERSION}~ce-0~debian-jessie \
		&& apt-get clean \
		&& rm -rf /var/lib/apt/lists/*

# install docker compose
ENV DOCKER_COMPOSE_VERSION 1.15.0
RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose \
 && chmod +x /usr/local/bin/docker-compose

RUN groupadd -f --gid 1002 docker_default
RUN usermod -a -G docker_default jenkins
RUN chown -R jenkins:jenkins /var/jenkins_home

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

USER jenkins

ADD config/ /usr/share/jenkins/ref/init.groovy.d/
ADD plugins.txt /usr/share/jenkins/ref/
RUN cat /usr/share/jenkins/ref/plugins.txt | xargs /usr/local/bin/install-plugins.sh
