#https://github.com/kubernetes-retired/contrib/tree/master/statefulsets/zookeeper
#https://github.com/yasammez/openshift-zookeeper
FROM ubuntu:16.04

ENV ZK_USER=zookeeper \
    ZK_DATA_DIR=/var/lib/zookeeper/data \
    ZK_DATA_LOG_DIR=/var/lib/zookeeper/log \
    ZK_LOG_DIR=/var/log/zookeeper \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64


ARG ZK_VERSION=zookeeper-3.5.5
ARG ZK_DIST=apache-zookeeper-3.5.5-bin


RUN apt-get update \
    && apt-get install -y openjdk-8-jre-headless wget netcat-openbsd \
    && wget -q "https://www-us.apache.org/dist/zookeeper/$ZK_VERSION/$ZK_DIST.tar.gz" \
    && export GNUPGHOME="$(mktemp -d)" \
    && tar -xzf "$ZK_DIST.tar.gz" -C /opt \
    && rm -r "$GNUPGHOME" "$ZK_DIST.tar.gz" \
    && ln -s /opt/$ZK_DIST /opt/zookeeper \
    && rm -rf /opt/zookeeper/CHANGES.txt \
    /opt/zookeeper/README.txt \
    /opt/zookeeper/NOTICE.txt \
    /opt/zookeeper/CHANGES.txt \
    /opt/zookeeper/README_packaging.txt \
    /opt/zookeeper/build.xml \
    /opt/zookeeper/config \
    /opt/zookeeper/contrib \
    /opt/zookeeper/dist-maven \
    /opt/zookeeper/docs \
    /opt/zookeeper/ivy.xml \
    /opt/zookeeper/ivysettings.xml \
    /opt/zookeeper/recipes \
    /opt/zookeeper/src \
    /opt/zookeeper/$ZK_DIST.jar.asc \
    /opt/zookeeper/$ZK_DIST.jar.md5 \
    /opt/zookeeper/$ZK_DIST.jar.sha1 \
    && apt-get autoremove -y wget \
    && rm -rf /var/lib/apt/lists/*


COPY fix-permissions /usr/local/bin


RUN /usr/local/bin/fix-permissions /opt/$ZK_DIST && \
    ln -s /opt/$ZK_DIST /opt/zookeeper


COPY zkGenConfig.sh zkOk.sh zkMetrics.sh /opt/zookeeper/bin/


RUN useradd -u 1002 -r -c "Zookeeper User" $ZK_USER && \
    mkdir -p $ZK_DATA_DIR $ZK_DATA_LOG_DIR $ZK_LOG_DIR /usr/share/zookeeper /tmp/zookeeper && \
    chown -R 1002:0 $ZK_DATA_DIR $ZK_DATA_LOG_DIR $ZK_LOG_DIR /tmp/zookeeper && \
    /usr/local/bin/fix-permissions $ZK_DATA_DIR && \
    /usr/local/bin/fix-permissions $ZK_DATA_LOG_DIR && \
    /usr/local/bin/fix-permissions $ZK_LOG_DIR && \
    /usr/local/bin/fix-permissions /tmp/zookeeper

WORKDIR "/opt/zookeeper"

USER 1002