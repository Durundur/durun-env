FROM jenkins/jenkins:alpine-jdk17

ENV JENKINS_HOME="/var/jenkins_home"
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

COPY casc.yaml /var/jenkins_home/casc.yaml
ENV CASC_JENKINS_CONFIG="/var/jenkins_home/casc.yaml"