# layr-devnet

[![Test](https://github.com/Layr-labs/layr-devnet/actions/workflows/build-image.yml/badge.svg)](https://github.com/Layr-labs/layr-devnet/actions/workflows/build-image.yml)

### Layr DevNet is a local node for testing with EigenLayer

Layer DevNet provides a comprehensive suite of scripts and Docker files designed for the seamless configuration of an Ethereum node. This toolkit directly supports the Eigenlayer SideCar, allowing it to operate concurrently with the Ethereum node. By facilitating this parallel operation, Layer DevNet enables efficient testing and deployment of various Eigenlayer projects, including the SideCar itself. This setup streamlines the development process and enhances the overall functionality and integration of Eigenlayer technologies.

### Prerequisite

These scripts work well on the latest version of Docker

- Docker

### Geting Started

#### All Profiles - Setup

1\. Copy `env.example` to .env
  Make a note especially of DATA_VOLUME variable and make sure this points at the local storage or data volume intended

2\. Set VALIDATOR_SECRET to the password for the validator account

3\. build the setup profile

```bash
    $ docker compose --profile setup build
```

4\. execute the setup profile to create the genesis files
  This will store the genesis files for the environment in the appropriate locations.

```bash
    $ docker compose --profile setup run create-beacon-chain-genesis
```

#### Local Installation

1\. Clean existing docker installation

```bash
    $ docker compose down --volumes
```

2\. Build container system

```bash
    $ docker compose build
```

3\. Bootstrap system

```bash
    $ docker compose up
```

## local deployment RPC_URL
RPC_URL=http://localhost:8545

#### Deploy to Remote context (AWS EC2)

1\. Create remote context for EC2

```bash
   $ docker context create devnet-remote --docker "host=ssh://ubuntu@XX.XX.XX.XX"
```

2\. Clean existing docker installation

```bash
    $ docker -c devnet-remote compose down --volumes
```

3\. Build container system

```bash
    $ docker -c devnet-remote compose build
```

4\. Bootstrap system
  Check the environment variable `DATA_VOLUME`.  Make sure this is set to the location of the storage on the remote context.   For example `DATA_VOLUME=/storage`

```bash
    $ docker -c devnet-remote  compose up -d
```

5\. Check services on the remote system

```bash
    $ docker -c devenet-remote ps
```

6\. Follow the logs on the remote context

```bash
    $ docker compose -c devnet-remote logs -f
```    

#### Deploy to ECS

1\. Create docker context for ECS

```bash
$ docker context create ecs layr-devnet-ecs
```


### Important Account Information

| Account                                    | Name              | Funds     | Description                          |
| ------------------------------------------ | ----------------- | --------- | ------------------------------------ |
| 0x6DB1F3F7a368d5895256A5BA0bdB84d2a6C3bFF7 | Validator Account | 20000 ETH | Suggested fee recipient              |
| 0xbb422b2e8cac43a908764a8d3d225392c8e855a9 | Faucet Account    | 20000 ETH | used to distribute funds for testing |
| 0x4a3Ee341f8ceEdB790F511A18899fBC1fdEb35af | Deployer Account  | 100 ETH   | deployer admin used for deployments  |

## Tests
Test that the beacon node is running
- `curl http://localhost:3500/eth/v1/beacon/genesis`

Test that the geth node is running
- `curl http://localhost:8545 -X POST -H "Content-Type: application/json" --data '{"method":"eth_chainId","params":[],"id":1,"jsonrpc":"2.0"}'`