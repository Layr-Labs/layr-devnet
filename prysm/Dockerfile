FROM debian:stable-slim AS go-builder
# defined from build kit
# DOCKER_BUILDKIT=1 docker build . -t ...
ARG TARGETARCH

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt install -y -q --no-install-recommends \
    libz3-dev z3 \
    git curl gnupg2 build-essential coreutils \
    openssl libssl-dev pkg-config \
    ca-certificates apt-transport-https \
    python3 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

## Go Lang
ARG GO_VERSION=1.22.4
ADD https://go.dev/dl/go${GO_VERSION}.linux-$TARGETARCH.tar.gz /goinstall/go${GO_VERSION}.linux-$TARGETARCH.tar.gz
RUN echo 'SHA256 of this go source package...'
RUN cat /goinstall/go${GO_VERSION}.linux-$TARGETARCH.tar.gz | sha256sum 
RUN tar -C /usr/local -xzf /goinstall/go${GO_VERSION}.linux-$TARGETARCH.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
RUN go version

# Prysm
RUN git clone --quiet --branch v5.0.3 https://github.com/prysmaticlabs/prysm /prysm
WORKDIR /prysm
RUN go build -ldflags="-s -w" -o=/usr/local/bin/beacon-chain ./cmd/beacon-chain
RUN go build -ldflags="-s -w" -o=/usr/local/bin/validator ./cmd/validator
RUN go build -ldflags="-s -w" -o=/usr/local/bin/prysmctl ./cmd/prysmctl

FROM debian:stable-slim

RUN export DEBIAN_FRONTEND=noninteractive && \
  apt update && \
  apt install -y -q --no-install-recommends \
    ca-certificates apt-transport-https \
    curl && \
  apt clean && \
    rm -rf /var/lib/apt/lists/*

# Prysm
RUN mkdir -p /usr/local/prysm
COPY --from=go-builder /prysm/prysm.sh /usr/local/prysm/prysm.sh
COPY --from=go-builder /usr/local/bin/beacon-chain /usr/local/bin/beacon-chain
COPY --from=go-builder /usr/local/bin/validator /usr/local/bin/validator
COPY --from=go-builder /usr/local/bin/prysmctl /usr/local/bin/prysmctl

# requires setup profile build
COPY --chown=victor:victor ./consensus /consensus
RUN if [ -f /consensus/genesis.ssz ]; then chmod 644 /consensus/genesis.ssz; fi

RUN useradd --create-home -s /bin/bash -u 2001 -U victor
RUN usermod -a -G sudo victor
RUN echo '%victor ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

VOLUME ["/home/alice"]
VOLUME ["/home/victor"]
WORKDIR /home/victor

RUN chown -R victor:victor /home/victor

USER victor:victor
ENV USER=victor
ENV PATH=${PATH}:/usr/local/bin
