# https://hub.docker.com/_/alpine
FROM docker.io/alpine:3.17.2@sha256:ff6bdca1701f3a8a67e328815ff2346b0e4067d32ec36b7992c1fdc001dc8517

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
