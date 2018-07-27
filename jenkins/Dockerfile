FROM jenkins/jenkins:2.121.2-alpine

LABEL image_name=relabs/jenkins/master:2.121.2-alpine \
      base_image=jenkins/jenkins:2.121.2-alpine

USER ${user}

# # Disable the upgrade banner & admin pw (we will add one later)
# RUN echo 2.121.2 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state \
#     && echo 2.121.2 > ${JENKINS_HOME}/jenkins.install.InstallUtil.lastExecVersion

# Add our groovy init files
ADD init.groovy.d /usr/share/jenkins/ref/init.groovy.d

ADD plugins.txt /tmp/plugins-main.txt
RUN install-plugins.sh $(cat /tmp/plugins-main.txt)
