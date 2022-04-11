# syntax=docker/dockerfile:1.3-labs
FROM alpine:3.15.4

RUN set -ex \
    && apk add --update \
    python3 \
    py-pip \
    py-cffi \
    py-cryptography \
    bash \
    curl \
    && pip install --upgrade pip \
    && apk add --virtual build-deps \
    gcc \
    libffi-dev \
    python3-dev \
    linux-headers \
    musl-dev \
    openssl-dev \
    && ln -sf python3 /usr/bin/python \
    && pip install gsutil \
    && pip install awscli \
    && curl -Ls https://dl.k8s.io/release/v1.23.1/bin/linux/amd64/kubectl -o /bin/kubectl \
    && chmod +x /bin/kubectl \
    && apk del build-deps \
    && rm -rf /var/cache/apk/*

COPY docker-entrypoint.sh /usr/local/bin
RUN ln -s usr/local/bin/docker-entrypoint.sh /
ENTRYPOINT ["docker-entrypoint.sh"]

