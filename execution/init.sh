#!/usr/bin/env bash

set -e

GENESIS_FILE=/shared/genesis.json

function remove_db {
    if [ -z "${EXEC_DATADIR}" ]
    then
        echo "EXEC_DATADIR is not set"
        exit 1
    fi

    if [ -d ${EXEC_DATADIR}/geth ]
    then
        rm -rf ${EXEC_DATADIR}/geth
    fi
}

function geth_genesis {

    if [ -z "${EXEC_DATADIR}" ]
    then
        echo "EXEC_DATADIR is not set"
        exit 1
    fi

    if [ ! -f ${GENESIS_FILE} ]
    then
        echo "Genesis file not found"
        exit 1
    fi
    
    geth \
      --datadir=${EXEC_DATADIR} \
      init \
      ${GENESIS_FILE}
}

# fixup docker mount perms
sudo mkdir -p ${EXEC_DATADIR}
echo Removing exec datadir
remove_db
echo Init geth genesis
geth_genesis

# setup keystore
echo Initialize keystore
sudo mkdir -p ${EXEC_DATADIR}/keystore
sudo cp -fv /execution/UTC--* ${EXEC_DATADIR}/keystore/
