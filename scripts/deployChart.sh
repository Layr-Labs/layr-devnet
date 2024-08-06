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
    --set images.geth.tag="12ef5889a2cc2cf7131b09ada326752d5a701873" \
    --set images.prysm.tag="12ef5889a2cc2cf7131b09ada326752d5a701873" \
    --set common.jwtSecret.values.jwtSecret=some-jwt-secret \
    --set common.gethPassword.values.gethPassword=some-password \
    --set common.secret.values.VALIDATOR_SECRET=some-validator-secret \
    layr-devnet ./layr-devnet
