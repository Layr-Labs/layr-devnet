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
    --set images.geth.tag="d9c6a69d12ab84c70cb6fa9305749d185dfe4649" \
    --set images.prysm.tag="d9c6a69d12ab84c70cb6fa9305749d185dfe4649" \
    --set common.jwtSecret.values.jwtSecret=some-jwt-secret \
    --set common.gethPassword.values.gethPassword=some-password \
    --set common.secret.values.VALIDATOR_SECRET=some-validator-secret \
    layr-devnet ./layr-devnet
