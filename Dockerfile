FROM jenkins
MAINTAINER Boris Mikhaylov

ADD custom.groovy /usr/share/jenkins/ref/init.groovy.d/custom.groovy
ADD plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

