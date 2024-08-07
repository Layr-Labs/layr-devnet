#!/usr/bin/env bash

if [[ -z "${EXEC_DATADIR}" ]]
then
    echo "EXEC_DATADIR is not set"
    exit 1
fi

if [[ ! -f ${GENESIS_FILE} ]]
then
    echo "Genesis file not found"
    exit 1
fi

if [[ -f $EXEC_DATADIR/initialized ]]; then
    echo "Already initialized"
    exit 0
fi

geth \
  --datadir=${EXEC_DATADIR} \
  init \
  ${GENESIS_FILE}

touch $EXEC_DATADIR/initialized

# Due to limitations of helm, we base64 encode the contents of the keystore files
# and then have to decode them some way
for i in $(ls $KEYSTORE_SOURCE_DIR); do
    contents=$(cat $EXEC_DATADIR/keystore/$i | base64 --decode)
    echo $contents > $EXEC_DATADIR/keystore/$i
done


