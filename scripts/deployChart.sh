#!/usr/bin/env bash


helm --kube-context=protocol-preprod upgrade --install \
    --atomic \
    --cleanup-on-fail \
    --timeout 2m \
    --force \
    --debug \
    --wait  \
    --version=$(date +%s) \
    --namespace layr-devnet \
    --set images.geth.tag="158bb69c338347d8760edfdb98122c1694bcf74f" \
    --set images.prysm.tag="158bb69c338347d8760edfdb98122c1694bcf74f" \
    --set common.jwtSecret.values.jwtSecret=some-jwt-secret \
    --set common.gethPassword.values.gethPassword=some-password \
    --set common.secret.values.VALIDATOR_SECRET=some-validator-secret \
    layr-devnet ./layr-devnet
