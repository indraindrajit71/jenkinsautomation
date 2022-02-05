FROM jenkins/jenkins
USER root

ENV JENKINS_HOME /var/jenkins
#RUN useradd -d "$JENKINS_HOME" -u 1010 -m -s /bin/bash jenkins

VOLUME /var/jenkins 

#VOLUME /var/run/docker.sock


RUN chown jenkins:jenkins -R $JENKINS_HOME

EXPOSE 8080

# Install Ansible

#RUN apt-add-repository ppa:ansible/ansible && \
RUN apt update && \
apt install ansible -y

# Install Docker

RUN apt-get update -y && \
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable" && \
   apt-get update -y && \
   apt-get install -y docker-ce

RUN groupmod -g 127 docker && \
  usermod -aG docker jenkins
#RUN chown root:docker /var/run/docker.sock

USER jenkins
