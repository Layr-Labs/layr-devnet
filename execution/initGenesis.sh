#!/usr/bin/env bash

OVERWRITE="${OVERWRITE:-false}"
CONFIG_FILE="${CONFIG_FILE:-/consensus/config.yml}"
GENESIS_INPUT="${GENESIS_INPUT:-/execution/genesis.json}"
GENESIS_OUTPUT="${GENESIS_OUTPUT:-/execution/genesis.json}"
OUTPUT_SSZ="${OUTPUT_SSZ:-/consensus/genesis.ssz}"

if [[ (-f $GENESIS_OUTPUT || -f $OUTPUT_SSZ) && $OVERWRITE == "false" ]]; then
    echo "Genesis file already exists. Set OVERWRITE=true to overwrite."
    exit 0
fi

rm $GENESIS_OUTPUT || true
rm $OUTPUT_SSZ || true

mkdir -p "$(dirname $GENESIS_OUTPUT)" || true
mkdir -p "$(dirname $OUTPUT_SSZ)" || true

prysmctl testnet generate-genesis \
    --fork=capella \
    --num-validators=64 \
    --genesis-time-delay=15 \
    --output-ssz=$OUTPUT_SSZ \
    --chain-config-file=$CONFIG_FILE \
    --geth-genesis-json-in=$GENESIS_INPUT \
    --geth-genesis-json-out=$GENESIS_OUTPUT
