FROM qnib/alplain-init

RUN apk --no-cache add \
    su-exec \
    ca-certificates \
    sqlite \
    git \
    linux-pam \
    curl \
    openssh \
    tzdata \
 && addgroup -S -g 1000 git \
 && adduser \
    -S -H -D \
    -h /data/git \
    -s /bin/bash \
    -u 1000 \
    -G git \
    git \
 && echo "git:$(date +%s | sha256sum | base64 | head -c 32)" | chpasswd

RUN wget -qO /usr/local/bin/gitea https://github.com/qnib/gitea/releases/download/v1.1.0-dev/gitea_1.1.0-dev_MuslLinux \
 && chmod +x /usr/local/bin/gitea
VOLUME ["/data/gitea"]
ENV GITEA_CUSTOM /data/gitea
ENV GODEBUG=netdns=go
CMD ["/usr/local/bin/gitea web"]

VOLUME ["/data"]
