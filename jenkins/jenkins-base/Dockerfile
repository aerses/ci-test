# images/jenkins-base/Dockerfile
FROM openjdk:8u171-jdk-alpine

# arguments, variable and labels
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

ENV JENKINS_HOME=/var/jenkins_home \
    JENKINS_ROOT=/usr/share/jenkins \
    JENKINS_WAR=/usr/share/jenkins/ref/warfile/jenkins.war \
    JENKINS_SLAVE_AGENT_PORT=50000 \
    JENKINS_VERSION=2.121.2 \
    JENKINS_URL=https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war \
    JENKINS_SHA=da0f9d106e936246841a898471783fb4fbdbbacc8d42a156b7306a0855189602 \
    TINI_VERSION=0.14.0 \
    TINI_SHA=6c41ec7d33e857d4779f14d9c74924cab0c7973485d2972419a3b7c7620ff5fd

LABEL image_name=relabs/jenkins/base:${JENKINS_VERSION} \
      base_image=openjdk:8u171-jdk-alpine

# Jenkins is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN addgroup -g ${gid} ${group} \
    && adduser -h "${JENKINS_HOME}" -u ${uid} -G ${group} -s /bin/bash -D ${user}

# Install support tools and make them executable
COPY jenkins-support /usr/local/bin/jenkins-support
RUN mkdir -p ${JENKINS_ROOT} \
    && chown ${user}:${group} /usr/local/bin/* ${JENKINS_ROOT} \
    && chmod +x /usr/local/bin/*

# Install Jenkins dependencies
RUN apk add --no-cache git openssh-client curl unzip bash ttf-dejavu coreutils

# Use tini as subreaper in Docker container to adopt zombie processes
RUN curl -fsSL https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static-amd64 -o /bin/tini && chmod +x /bin/tini \
  && echo "$TINI_SHA  /bin/tini" | sha256sum -c -
