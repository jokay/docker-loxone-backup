# https://hub.docker.com/_/alpine
FROM docker.io/alpine:3.17.0@sha256:8914eb54f968791faf6a8638949e480fef81e697984fba772b3976835194c6d4

ARG VERSION

ENV VERSION "${VERSION}"
ENV TZ "UTC"
ENV LOXONE_IP ""
ENV LOXONE_USERNAME ""
ENV LOXONE_PASSWORD ""
ENV INTERVAL 86400
ENV BACKUP_LIMIT 30

RUN apk add --update --no-cache lftp

WORKDIR /data

VOLUME ["/data"]

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
