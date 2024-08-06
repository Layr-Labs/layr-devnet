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
    --set images.geth.tag="524cbde68612329877b2c1ace2f335c70cd5c441" \
    --set images.prysm.tag="524cbde68612329877b2c1ace2f335c70cd5c441" \
    --set common.jwtSecret.values.jwtSecret=some-jwt-secret \
    --set common.gethPassword.values.gethPassword=some-password \
    --set common.secret.values.VALIDATOR_SECRET=some-validator-secret \
    layr-devnet ./layr-devnet
