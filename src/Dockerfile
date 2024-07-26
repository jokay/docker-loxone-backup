# kics-scan disable=fd54f200-402c-4333-a5a4-36ef6709af2f,b03a748a-542d-44f4-bb86-9199ab4fd2d5,d3499f6d-1651-41bb-a9a7-de925fea487b

# https://hub.docker.com/_/alpine
FROM docker.io/alpine:3.20.2@sha256:0a4eaa0eecf5f8c050e5bba433f58c052be7587ee8af3e8b3910ef9ab5fbe9f5

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

RUN apk add --no-cache \
        tzdata \
        lftp

WORKDIR /data

VOLUME ["/data"]

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
