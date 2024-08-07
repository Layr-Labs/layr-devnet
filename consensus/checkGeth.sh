#!/usr/bin/env bash

while true; do
    curl -XPOST -H 'content-type: application/json' $GETH_RPC_ENDPOINT -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}'
    code=$?
    if [[ $code -eq 0 ]]; then
        echo "Geth is up"
        break
    else
        echo "Geth is not up yet"
        sleep 5
    fi
done
