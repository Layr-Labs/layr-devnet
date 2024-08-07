#!/usr/bin/env bash

GETH_ENDPOINT="${GETH_ENDPOINT:-http://geth:8545}"
DATA_DIR="${DATA_DIR:-/home/victor/beacon-chain}"
SLASHER_DIR="${SLASHER_DIR:-/home/victor/slasher}"
GENESIS_FILE="${GENESIS_FILE:-/consensus/genesis.ssz}"
CHAIN_CONFIG_FILE="${CHAIN_CONFIG_FILE:-/consensus/config.yml}"
JWT_SECRET="${JWT_SECRET:-/home/victor/geth/jwtsecret}"
ADDITIONAL_VARS="${ADDITIONAL_VARS:-}"

execCmd="beacon-chain
    --execution-endpoint=${GETH_ENDPOINT} \
    --datadir=${DATA_DIR} \
    --slasher-datadir=${SLASHER_DIR} \
    --genesis-state=${GENESIS_FILE} \
    --interop-eth1data-votes \
    --chain-config-file=${CHAIN_CONFIG_FILE} \
    --contract-deployment-block=0 \
    --chain-id=11155151 \
    --accept-terms-of-use \
    --grpc-gateway-corsdomain=* \
    --grpc-gateway-host=0.0.0.0 \
    --rpc-host=0.0.0.0 \
    --jwt-secret=${JWT_SECRET} \
    --suggested-fee-recipient=0x123463a4B065722E99115D6c222f267d9cABb524 \
    --bootstrap-node=0 \
    --min-sync-peers=0 \
    --minimum-peers-per-subnet=0 \
    --enable-debug-rpc-endpoints \
    --verbosity=debug
"

if [ ! -z "${ADDITIONAL_VARS}" ]
then
    execCmd="${execCmd} ${ADDITIONAL_VARS}"
fi

eval $execCmd
