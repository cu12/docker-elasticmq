FROM alpine:latest

ENV ELASTICMQ_VERSION 0.8.12
ENV PACKAGES openjdk7-jre-base python py-pip
ENV PACKAGES_CLEANUP py-pip

COPY custom.conf /elasticmq/custom.conf

# Install packages
RUN apk --update add ${PACKAGES}

# Install awscli
RUN pip install awscli

# Cleanup
RUN apk --purge -v del ${PACKAGES_CLEANUP} && \
    rm /var/cache/apk/*

ADD https://s3-eu-west-1.amazonaws.com/softwaremill-public/elasticmq-server-${ELASTICMQ_VERSION}.jar /elasticmq/server.jar

EXPOSE 9324

USER nobody

CMD ["java", "-jar", "-Dconfig.file=/elasticmq/custom.conf", "/elasticmq/server.jar"]
