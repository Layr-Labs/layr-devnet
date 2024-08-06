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
    --set images.geth.tag="62f62fdfe68f3fb55e60a85d55b7a3d56ee89d09" \
    --set images.prysm.tag="62f62fdfe68f3fb55e60a85d55b7a3d56ee89d09" \
    --set 'common.jwtSecret.values.jwtSecret=' \
    --set 'common.gethPassword.values.gethPassword=' \
    --set common.secret.values.VALIDATOR_SECRET=some-validator-secret \
    --set-string "common.gethKeys.values.defaultAccount=${json_string}" \
    layr-devnet ./layr-devnet
