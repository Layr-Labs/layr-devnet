#!/usr/bin/env bash

set -e

GENESIS_FILE=/execution/genesis.json

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
sudo chown -R alice:alice ${EXEC_DATADIR}
remove_db
geth_genesis
