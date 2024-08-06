FROM debian:stable-slim
ARG HTTP_PORT=8545

RUN export DEBIAN_FRONTEND=noninteractive && \
  apt update && \
  apt install -y -q --no-install-recommends \
    ca-certificates apt-transport-https \
    curl tar gzip sudo && \
  apt clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./go-ethereum/install-geth.sh /go-ethereum/install-geth.sh

WORKDIR /go-ethereum
RUN /go-ethereum/install-geth.sh

RUN useradd --create-home -s /bin/bash -u 1001 -U alice
RUN usermod -a -G sudo alice
RUN echo '%alice ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

LABEL org.label-schema.name="layr-devnet" \
    org.label-schema.description="Ethereum Node for Layr Devnet" \
    org.label-schema.url="https://github.com/layr-labs/layr-devnet/" \
    org.label-schema.vcs-url="git@github.com:layr-labs/layr-devnet.git" \
    org.label-schema.vendor="Eigen Labs" \
    org.label-schema.schema-version="1.0.0" \
    org.opencontainers.image.description="Ethereum Node for Layr Devnet"

VOLUME ["/home/alice"]
WORKDIR /home/alice

COPY . /layr-devnet

RUN chown -R alice:alice /home/alice

ENV USER=alice
USER alice:alice

ENV PATH=${PATH}:/usr/local/bin
ENV HTTP_PORT=${HTTP_PORT}

HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:${HTTP_PORT} || exit 1
