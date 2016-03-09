FROM gliderlabs/alpine:latest

ENV ELASTICMQ_VERSION 0.8.12
ENV PACKAGES openjdk7-jre-base python py-pip tini
ENV PACKAGES_CLEANUP py-pip

COPY custom.conf /elasticmq/custom.conf

ADD https://s3-eu-west-1.amazonaws.com/softwaremill-public/elasticmq-server-${ELASTICMQ_VERSION}.jar /elasticmq/server.jar

# Install packages
RUN echo "http://dl-1.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-3.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-5.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk --update add ${PACKAGES} && \
    pip install awscli && \
    apk --purge -v del ${PACKAGES_CLEANUP} && \
    rm /var/cache/apk/* && \
    chmod 544 /elasticmq/server.jar

EXPOSE 9324

ENTRYPOINT ["tini", "--"]

USER nobody

CMD java -jar -Dconfig.file=/elasticmq/custom.conf /elasticmq/server.jar
