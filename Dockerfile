FROM alpine:3.10
LABEL maintainer "shinya"

RUN apk add --update --no-cache bash git make gcc g++ python curl wget build-base openssl-dev apache2-utils libxml2-dev sshfs tmux supervisor ca-certificates ncurses coreutils libgcc linux-headers grep util-linux binutils findutils \
	&& touch ~/.bashrc \
	&& curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash \
	&& export NVM_DIR="$HOME/.nvm" \
	&& source $NVM_DIR/nvm.sh \
	&& nvm install -s 8 \
	&& nvm use 8 \
	&& nvm alias default 8 \
	&& git clone https://github.com/c9/core.git /c9 \
	&& curl -s -L https://raw.githubusercontent.com/c9/install/master/link.sh | bash \
	&& mkdir -p /workspace \
	&& cd /c9 \
	&& ./scripts/install-sdk.sh \
	&& cp $NVM_DIR/versions/node/v8.16.2/bin/node /usr/local/bin/node \
	&& apk del curl python linux-headers git wget make g++ build-base ca-certificates ncurses coreutils libgcc grep util-linux binutils findutils \
	&& rm -fr /tmp/* /var/cache/apk/* /usr/share/man/* /usr/share/doc /root/.npm /root/.node-gyp /root/.config \
		/usr/lib/gcc /usr/lib/python2.7 /usr/lib/libcrypto.a /usr/lib/libstdc++.a \
		/usr/libexec/gcc/x86_64-alpine-linux-musl/8.3.0/cc1 \
		/usr/libexec/gcc/x86_64-alpine-linux-musl/8.3.0/cc1obj \
		/usr/libexec/gcc/x86_64-alpine-linux-musl/8.3.0/lto1 \
		$NVM_DIR \
		~/.bashrc \
		/usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html /usr/lib/node_modules/npm/scripts


VOLUME ["/workspace"]
WORKDIR /workspace

# Expose ports.
EXPOSE 8080

ENV USERNAME user
ENV PASSWORD pass


ENTRYPOINT ["sh", "-c", "/usr/local/bin/node /c9/server.js -l 0.0.0.0 -p 8080 -w /workspace -a $USERNAME:$PASSWORD"]