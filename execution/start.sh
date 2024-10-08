#!/usr/bin/env bash

set -e

SECRET_FILE=/tmp/validator_secret.${RANDOM}.txt
HTTP_PORT=8545
AUTH_RPC_PORT=8551
NODE_PORT=30303
SYNC_MODE=full

# Function to store the validator secret in a file
function store_secret {
  if [ -z "${VALIDATOR_SECRET}" ]
  then
    echo "VALIDATOR_SECRET is not set"
    exit 1
  fi
  echo ${VALIDATOR_SECRET} > ${SECRET_FILE}
  chmod 400 ${SECRET_FILE}
}

function start_geth {

  if [ -z "${EXEC_DATADIR}" ]
  then
    echo "EXEC_DATADIR is not set"
    exit 1
  fi

  if [ -z "${HTTP_PORT}" ]
  then
    echo "HTTP_PORT is not set"
    exit 1
  fi

  if [ -z "${AUTH_RPC_PORT}" ]
  then
    echo "AUTH_RPC_PORT is not set"
    exit 1
  fi

  if [ -z "${NODE_PORT}" ]
  then
    echo "NODE_PORT is not set"
    exit 1
  fi

  if [ -z "${SYNC_MODE}" ]
  then
    echo "SYNC_MODE is not set"
    exit 1
  fi

  if [ -z "${VALIDATOR_ACCOUNT}" ]
  then
    echo "VALIDATOR_ACCOUNT is not set"
    exit 1
  fi

  if [ ! -f ${SECRET_FILE} ]
  then
    echo "Validator secret file not found"
    exit 1
  fi

  geth \
    --identity geth \
    --datadir ${EXEC_DATADIR} \
    --http \
    --http.addr 0.0.0.0 \
    --http.port ${HTTP_PORT} \
    --http.api eth,net,web3 \
    --http.corsdomain "*" \
    --http.vhosts "*" \
    --ws \
    --ws.addr 0.0.0.0 \
    --ws.api eth,net,web3 \
    --ws.origins "*" \
    --authrpc.addr 0.0.0.0 \
    --authrpc.port ${AUTH_RPC_PORT} \
    --authrpc.vhosts "*" \
    --port ${NODE_PORT} \
    --nodiscover \
    --syncmode ${SYNC_MODE} \
    --allow-insecure-unlock \
    --unlock ${VALIDATOR_ACCOUNT} \
    --password ${SECRET_FILE}
}

store_secret
start_geth
