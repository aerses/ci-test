# images/jenkins-base/Dockerfile
FROM openjdk:8u171-jdk-alpine

# arguments, variable and labels
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG http_port=8080
ARG agent_port=50000
ARG jenkins_version=2.121.2
ARG jenkins_version_war_sha=b46ff03ae2898694d0cbb9ede823fef6090216ca
ARG jenkins_home=/var/jenkins_home
ARG jenkins_root=/usr/share/jenkins
ARG jenkins_war=/usr/share/jenkins/ref/warfile/jenkins.war

ENV JENKINS_HOME ${jenkins_home}
ENV JENKINS_ROOT ${jenkins_root}
ENV JENKINS_WAR ${jenkins_war}
ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}
ENV JENKINS_VERSION ${jenkins_version}
ENV JENKINS_SHA ${jenkins_version_war_sha}

LABEL image_name=relabs/jenkins/base:${jenkins_version} \
      base_image=openjdk:8u171-jdk-alpine

# These URLs can be swapped out for internal repos if needed. Secrets required may vary :)
ENV JENKINS_UC https://updates.jenkins.io
ENV JENKINS_URL http://mirrors.jenkins.io/war/${JENKINS_VERSION}/jenkins.war

# Jenkins is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN groupadd -g ${gid} ${group} \
    && useradd -d "$JENKINS_HOME" -u ${uid} -g ${group} -s /bin/bash ${user}

# Install our tools and make them executable
COPY files/jenkins-support /usr/local/bin/jenkins-support
RUN mkdir -p ${JENKINS_ROOT}
RUN chown jenkins /usr/local/bin/* ${JENKINS_ROOT} \
    && chmod +x /usr/local/bin/*

# Configure to Denver timezone. I dislike debugging failures in UTC
RUN unlink /etc/localtime && ln -s /usr/share/zoneinfo/America/Denver /etc/localtime

# Install Java, Git, and Unzip
RUN yum install -y java-1.8.0-openjdk-devel tzdata-java git unzip \
    && yum clean all
