FROM jenkins/jenkins:lts

USER root

# Установка Docker CLI (опционально, если требуется)
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli

USER jenkins

# Установка порта из переменной окружения $PORT
ENV PORT 8080
ENV JENKINS_OPTS --httpPort=$PORT

ENTRYPOINT ["/bin/sh", "-c", "exec java -jar /usr/share/jenkins/jenkins.war $JENKINS_OPTS"]
