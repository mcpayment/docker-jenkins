FROM jenkins/jenkins:lts-alpine

# Switch to root in order to install dependencies
USER root

ENV DOCKER_DL_URL="https://download.docker.com/linux/static/stable/x86_64/docker-17.06.2-ce.tgz"

# Install sshpass, docker-client, awscli
# then cleanup
RUN apk add --no-cache openssh sshpass && \
    \
    \
    apk --update add curl && \
    mkdir -p /tmp/download && \
    curl -L $DOCKER_DL_URL | tar -xz -C /tmp/download && \
    mv /tmp/download/docker/docker /usr/local/bin/ && \
    rm -rf /tmp/download && \
    \
    \
    apk --update add groff less python py-pip && \
    pip install awscli && \
    \
    \
    apk del curl && \
    rm -rf /var/cache/apk/*

# Switch back to jenkins user
USER jenkins
