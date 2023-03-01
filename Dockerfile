FROM code-dal1.penguintech.group:5050/ptg/standards/docker-ansible-image:stable
LABEL company="Penguin Tech Group LLC"
LABEL org.opencontainers.image.authors="info@penguintech.group"
LABEL license="GNU AGPL3"

# GET THE FILES WHERE WE NEED THEM!
COPY . /opt/manager/
WORKDIR /opt/manager

# UPDATE as needed
RUN apt update && apt dist-upgrade -y && apt auto-remove -y && apt clean -y

# PUT YER ARGS in here
# Change this to actual title for Default
ARG APP_TITLE="Hadoop"
ARG HADOOP_LINK="https://archive.apache.org/dist/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz"
ARG HADOOP_ARC_VERSION="hadoop-3.3.4.tar.gz"
ARG HADOOP_VERSION="hadoop-3.3.4"

#ARG JAVAX_TITLE="JavaX"
#ARG JAVAX_LINK="https://jcenter.bintray.com/javax/activation/javax.activation-api/1.2.0/javax.activation-api-1.2.0.jar"
#ARG JAVAX_JAR="javax.activation-api-1.2.0.jar"

# BUILD IT!
RUN ansible-playbook build.yml -c local

# PUT YER ENVS in here
# ENV FOO="BAR"

# added by KP
EXPOSE 22

# Switch to non-root user
USER ptg-user

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]
