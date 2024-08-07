#!/usr/bin/env bash

DATA_DIR="${DATA_DIR:-/home/victor/validator-1}"
BEACON_RPC_PROVIDER="${BEACON_RPC_PROVIDER:-beacon-chain:4000}"
CHAIN_CONFIG_FILE="${CHAIN_CONFIG_FILE:-/consensus/config.yml}"
ADDITIONAL_VARS="${ADDITIONAL_VARS:-}"

execCmd="validator
    --datadir=${DATA_DIR}
    --beacon-rpc-provider=${BEACON_RPC_PROVIDER}
    --accept-terms-of-use
    --interop-num-validators=64
    --interop-start-index=0
    --chain-config-file=${CHAIN_CONFIG_FILE}
    --verbosity=warn
"

if [ ! -z "${ADDITIONAL_VARS}" ]
then
    execCmd="${execCmd} ${ADDITIONAL_VARS}"
fi

eval $execCmd
