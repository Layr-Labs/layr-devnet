# layr-devnet

[![Test](https://github.com/Layr-labs/layr-devnet/actions/workflows/build-image.yml/badge.svg)](https://github.com/Layr-labs/layr-devnet/actions/workflows/build-image.yml)

### Layr DevNet is a local node for testing with EigenLayer

Layer DevNet provides a comprehensive suite of scripts and Docker files designed for the seamless configuration of an Ethereum node. This toolkit directly supports the Eigenlayer SideCar, allowing it to operate concurrently with the Ethereum node. By facilitating this parallel operation, Layer DevNet enables efficient testing and deployment of various Eigenlayer projects, including the SideCar itself. This setup streamlines the development process and enhances the overall functionality and integration of Eigenlayer technologies.

### Prerequisite

These scripts work well on the latest version of Docker

- Docker

### Geting Started

#### Local Installation

1\. Copy `env.example` to .env

2\. Set VALIDATOR_PRIVATE to appropriate validator private key
    Make sure that private key corresponds to 'unlock address' used by execution client.  This is specified in `docker-compose.yml` and in `execution/genesis.json`

3\. Set VALIDATOR_SECRET to something suitably secure.  

4\. Clean existing docker installation

```bash
    $ docker compose down --volumes
```

5\. Build container system

```bash
    $ docker compose build
```

6\. Bootstrap system

```bash
    $ docker compose up
```

##
RPC_URL=http://localhost:8545

### Validator Account

#### Address: 0x6db1f3f7a368d5895256a5ba0bdb84d2a6c3bff7

Key available from maintainer

Funds available: 20000 ETH
