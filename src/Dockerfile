# kics-scan disable=fd54f200-402c-4333-a5a4-36ef6709af2f,b03a748a-542d-44f4-bb86-9199ab4fd2d5,d3499f6d-1651-41bb-a9a7-de925fea487b

# https://hub.docker.com/_/alpine
FROM docker.io/alpine:3.23.4@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11

ARG VERSION

ENV VERSION="${VERSION}"
ENV TZ="UTC"
ENV LOXONE_IP=""
ENV LOXONE_USERNAME=""
ENV LOXONE_PASSWORD=""
ENV INTERVAL=86400
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
