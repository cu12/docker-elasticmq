FROM gliderlabs/alpine:latest

ENV ELASTICMQ_VERSION 0.8.12
ENV PACKAGES openjdk7-jre-base python py-pip tini
ENV PACKAGES_CLEANUP py-pip

COPY custom.conf /elasticmq/custom.conf

# Install packages
RUN apk --update --repository http://dl-1.alpinelinux.org/alpine/edge/community/ add ${PACKAGES}

# Add Tini
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# Install awscli
RUN pip install awscli

# Cleanup
RUN apk --purge -v del ${PACKAGES_CLEANUP} && \
    rm /var/cache/apk/*

ADD https://s3-eu-west-1.amazonaws.com/softwaremill-public/elasticmq-server-${ELASTICMQ_VERSION}.jar /elasticmq/server.jar

RUN chmod 544 /elasticmq/server.jar

EXPOSE 9324

ENTRYPOINT ["/tini", "--"]

USER nobody

CMD java -jar -Dconfig.file=/elasticmq/custom.conf /elasticmq/server.jar
