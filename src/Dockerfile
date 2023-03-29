# https://hub.docker.com/_/alpine
FROM docker.io/alpine:3.17.3@sha256:124c7d2707904eea7431fffe91522a01e5a861a624ee31d03372cc1d138a3126

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
