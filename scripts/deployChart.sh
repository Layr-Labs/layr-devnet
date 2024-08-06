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
    --set images.geth.tag="d00a2fa0021e3fc76c9b711456ceb355ea1531dc" \
    --set images.prysm.tag="d00a2fa0021e3fc76c9b711456ceb355ea1531dc" \
    --set common.jwtSecret.values.jwtSecret=some-jwt-secret \
    --set common.gethPassword.values.gethPassword=some-password \
    --set common.secret.values.VALIDATOR_SECRET=some-validator-secret \
    layr-devnet ./layr-devnet
