#https://github.com/kubernetes-retired/contrib/tree/master/statefulsets/kafka
FROM ubuntu:16.04 

ENV KAFKA_USER=kafka \
    KAFKA_DATA_DIR=/var/lib/kafka/data \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    KAFKA_HOME=/opt/kafka \
    PATH=$PATH:/opt/kafka/bin


ARG KAFKA_VERSION=2.2.0
ARG KAFKA_DIST=kafka_2.12-2.2.0


RUN apt-get update \
    && apt-get install -y openjdk-8-jre-headless wget \
    && wget -q "https://www-us.apache.org/dist/kafka/$KAFKA_VERSION/$KAFKA_DIST.tgz" \
    && export GNUPGHOME="$(mktemp -d)" \
    && tar -xzf "$KAFKA_DIST.tgz" -C /opt \
    && rm -r "$GNUPGHOME" "$KAFKA_DIST.tgz" \
    && apt-get autoremove -y wget


COPY log4j.properties /opt/$KAFKA_DIST/config/

RUN set -x \
    && ln -s /opt/$KAFKA_DIST $KAFKA_HOME \
    && useradd $KAFKA_USER \
    && [ `id -u $KAFKA_USER` -eq 1000 ] \
    && [ `id -g $KAFKA_USER` -eq 1000 ] \
    && mkdir -p $KAFKA_DATA_DIR \
    && chown -R "$KAFKA_USER:$KAFKA_USER"  /opt/$KAFKA_DIST \
    && chown -R "$KAFKA_USER:$KAFKA_USER"  $KAFKA_DATA_DIR



COPY server.properties /opt/kafka/config/

CMD ./opt/kafka/bin/kafka-server-start.sh ./opt/kafka/config/server.properties