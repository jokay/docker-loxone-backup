# https://hub.docker.com/_/alpine
FROM docker.io/alpine:3.17.2@sha256:8a81a7c2af9caf25aa960c6ef70e198b2d7194841546d3b26c9a1eb308a360b3

ARG VERSION

ENV VERSION "${VERSION}"
ENV TZ "UTC"
ENV LOXONE_IP ""
ENV LOXONE_USERNAME ""
ENV LOXONE_PASSWORD ""
ENV INTERVAL 86400
ENV KEEP_DAYS 30
ENV VERBOSE false
ENV EXCLUDE_DIRS ""

RUN apk add --update --no-cache  \
        tzdata \
        lftp

WORKDIR /data

VOLUME ["/data"]

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
