FROM jenkins/jenkins:lts-alpine

# Switch to root in order to install sshpass
USER root
RUN apk add --no-cache openssh sshpass

USER jenkins
