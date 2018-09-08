FROM golang:alpine3.7
LABEL maintainer "pemopemo"

RUN apk add --update --no-cache bash git nodejs make gcc g++ python curl wget build-base openssl-dev apache2-utils libxml2-dev sshfs tmux supervisor \
	&& rm -f /var/cache/apk/* \
	&& git clone https://github.com/c9/core.git /c9 \
	&& curl -s -L https://raw.githubusercontent.com/c9/install/master/link.sh | bash \
	&& mkdir -p /workspace \
	&& cd /c9 \
	&& ./scripts/install-sdk.sh

VOLUME ["/workspace"]
WORKDIR /workspace


# Expose ports.
EXPOSE 8080

ENV USERNAME user
ENV PASSWORD pass

ADD env /root/.bashrc 
ADD env /root/.profile

ENTRYPOINT ["sh", "-c", "/usr/bin/node /c9/server.js -l 0.0.0.0 -p 8080 -w /workspace -a $USERNAME:$PASSWORD"]
