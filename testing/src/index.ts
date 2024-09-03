import {createWalletClient, getContract} from 'viem';
import {abi} from './DepositContract.abi';
import {mainnet} from 'viem/chains';
import { createTestClient, http, publicActions, walletActions } from 'viem'

import { foundry } from 'viem/chains'

type TValidatorRequest = {
    status: number,
    balance: number
    isSlashed: boolean,
}

type TEigenpodRequest = {
    validators: TValidatorRequest[]
}

type TValidator = {
    validatorMnemonic: string
    validatorBalance: number
}

type TConfig = {
    depositAddress: `0x${string}`
    ethNodeUrl: string
}

type TEigenpodReponse = {
    podAddress: `0x${string}`
    podPrivateKey: string
    podValidators: TValidator[]
}

export const getClient = (url: string) => createTestClient({
    chain: foundry,
    mode: 'anvil',
    transport: http(url), 
  })
    .extend(publicActions) 
    .extend(walletActions) 

export async function setupWithPods(config: TConfig, ...pods: TEigenpodRequest[]): Promise<TEigenpodReponse[]> {
    
    const client = getClient(config.ethNodeUrl);
    const deposit = getContract({abi, address: config.depositAddress, client})

    // deposit
    const tx = await deposit.write.deposit([pubkey, withdrawal_credentials, signature, deposit_data_root], {})
    await client.waitForTransactionReceipt(tx)

    return [{
        podAddress: '0x0000000000000000',
        podPrivateKey: "00000000000",
        podValidators: []
    }]
}
