.PHONY: deploy

deploy-eigen:
	git clone -b madhur/add-missing-deployment-script https://github.com/Layr-Labs/eigenlayer-contracts.git contracts
	cd contracts && ls -lar . && forge install
	cd contracts && ls -lar . && RUST_LOG=forge,foundry=trace forge script script/deploy/devnet/Deploy_From_Scratch.s.sol --rpc-url $(RPC_URL) --private-key 0x$(PRIVATE_KEY) --broadcast --sig "run(string memory configFile)" -- deploy_from_scratch.anvil.config.json
