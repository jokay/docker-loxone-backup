# kics-scan disable=fd54f200-402c-4333-a5a4-36ef6709af2f,b03a748a-542d-44f4-bb86-9199ab4fd2d5,d3499f6d-1651-41bb-a9a7-de925fea487b

# https://hub.docker.com/_/alpine
FROM docker.io/alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b

ARG VERSION

ENV VERSION="${VERSION}"
ENV TZ="UTC"
ENV LOXONE_IP=""
ENV LOXONE_USERNAME=""
ENV LOXONE_PASSWORD=""
ENV INTERVAL=86400
ENV CRON=""
ENV KEEP_DAYS=30
ENV VERBOSE=false
ENV EXCLUDE_DIRS=""

RUN apk add --no-cache \
        tzdata \
        lftp

WORKDIR /data

VOLUME ["/data"]

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

HEALTHCHECK --interval=60s --timeout=10s --start-period=30s --retries=3 \
    CMD if [ -n "${CRON}" ]; then pgrep crond > /dev/null; else find /tmp -name .health -mmin -$(( (${INTERVAL:-86400} + 3600) / 60 )) | grep -q .; fi
