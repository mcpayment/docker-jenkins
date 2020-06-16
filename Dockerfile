FROM jenkins/jenkins:2.222.1-jdk11

# Switch to root in order to install dependencies
USER root

ENV DOCKER_DL_URL="https://download.docker.com/linux/static/stable/x86_64/docker-19.03.9.tgz"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
	apt-get install -y curl openssh-client sshpass groff less python3 python3-pip jq maven && \
	mkdir -p /tmp/download && \
	curl -L $DOCKER_DL_URL | tar -xz -C /tmp/download && \
	mv /tmp/download/docker/docker /usr/local/bin/ && \
	rm -rf /tmp/download && \
	rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN pip3 install --upgrade pip cffi && \
    pip install awscli boto boto3 ansible && \
    pip install mitogen ansible-lint && \
    pip install --upgrade pywinrm

# Lazy hack to add docker group
RUN addgroup --gid 999 docker && \
    addgroup jenkins docker

# Switch back to jenkins user
USER jenkins
