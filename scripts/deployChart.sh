#!/usr/bin/env bash

json_string=$(echo '{"address":"6db1f3f7a368d5895256a5ba0bdb84d2a6c3bff7","crypto":{"cipher":"aes-128-ctr","ciphertext":"153449b35b81a31cbebad447e8c3f817b5ad9becf2957785c71a8cdefd974a3f","cipherparams":{"iv":"53d6da17d0469c2b02427dd29d00dfe0"},"kdf":"scrypt","kdfparams":{"dklen":32,"n":262144,"p":1,"r":8,"salt":"6b84899c2fbadfe3b5e15ef72921b45bddd9a2ed69e87adba2788f36e0036723"},"mac":"12ad7e87f7c5a88706e89b8f2d762a4984e2a24cc2565f272123e229392550ee"},"id":"16eb1704-3e32-480b-9502-75fa72e044c1","version":3}' | base64)

helm --kube-context=protocol-preprod upgrade --install \
    --atomic \
    --cleanup-on-fail \
    --timeout 2m \
    --force \
    --debug \
    --wait  \
    --version=$(date +%s) \
    --namespace layr-devnet \
    --set images.geth.tag="9318eb732083af55c2ce37a8e9a154a1f1100fc1" \
    --set images.prysm.tag="9318eb732083af55c2ce37a8e9a154a1f1100fc1" \
    --set 'common.jwtSecret.values.jwtSecret=b63545e10dad71fc76a95bc3ab9d7c525077b35896178a3501349ae2d7f9367c' \
    --set 'common.gethPassword.values.gethPassword=protractor accident backfire rebel 71' \
    --set common.secret.values.VALIDATOR_SECRET=some-validator-secret \
    --set-string "common.gethKeys.values.defaultAccount=${json_string}" \
    layr-devnet ./layr-devnet
