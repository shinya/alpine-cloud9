FROM alpine
LABEL maintainer "pemopemo"

RUN apk add --update --no-cache bash git nodejs make gcc g++ python curl wget build-base openssl-dev apache2-utils libxml2-dev sshfs tmux supervisor \
	&& rm -f /var/cache/apk/* \
	&& npm install n -g \
	&& npm cache verify \
	&& adduser -D -h /home/cloud9 -s /bin/bash -u 1020 cloud9 \
	&& mkdir -p /workspace \

USER 1020
RUN cd /home/cloud9 \
	&& git clone https://github.com/c9/core.git c9 \
	&& curl -s -L https://raw.githubusercontent.com/c9/install/master/link.sh | bash \
	&& cd c9 \
	&& ./scripts/install-sdk.sh

USER root

VOLUME ["/workspace"]
WORKDIR /workspace

RUN chown cloud9:cloud9 /workspace


# Expose ports.
EXPOSE 8080

ENV USERNAME user
ENV PASSWORD pass

USER 1020
ENTRYPOINT ["sh", "-c", "/usr/bin/node /home/cloud9/c9/server.js -l 0.0.0.0 -p 8080 -w /workspace -a $USERNAME:$PASSWORD"]
