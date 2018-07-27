# images/jenkins-plugins/Dockerfile
FROM relabs/jenkins/base:latest

LABEL image_name=relabs/jenkins/master:2.121.2-alpine \
      base_image=relabs/jenkins/base:latest

ENV JENKINS_URL="https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war" \
    JENKINS_UC=https://updates.jenkins.io

# Add our plugin installation tool. Can be found here and is modified from the
# upstream version.
# https://raw.githubusercontent.com/technolo-g/modern-jenkins/master/images/jenkins-plugins/files/install-plugins.sh
ADD install-plugins.sh /usr/local/bin/
RUN chown ${user}:${group} /usr/local/bin/* \
    && chmod +x /usr/local/bin/*

# Add our groovy init files
ADD init.groovy.d /usr/share/jenkins/ref/init.groovy.d

# Download the Jenkins war
# JENKINS_URL, JENKINS_ROOT, JENKINS_WAR, and JENKINS_SHA are set in the parent
RUN mkdir -p ${JENKINS_ROOT}/ref/warfile \
  && curl -fsSL ${JENKINS_URL} -o ${JENKINS_WAR} \
  && echo "${JENKINS_SHA}  ${JENKINS_WAR}" | sha256sum -c - \
  && chown -R ${user}:${group} ${JENKINS_ROOT}

# We will run all of this as the jenkins user as is dictated by the base imge
USER ${user}

# Install our base set of plugins and their depdendencies that are listed in
# plugins.txt
ADD plugins.txt /tmp/plugins-main.txt
RUN install-plugins.sh $(cat /tmp/plugins-main.txt)

# Export our war and plugin set as volumes
VOLUME /usr/share/jenkins/ref/plugins
VOLUME /usr/share/jenkins/ref/warfile
VOLUME /usr/share/jenkins/ref/init.groovy.d

# It's easy to get confused when just a volume is being used, so let's just keep
# the container alive for clarity. This entrypoint will keep the container
# running for... infinity!
ENTRYPOINT ["sleep", "infinity"]
