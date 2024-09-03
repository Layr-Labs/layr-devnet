.PHONY: deploy

deploy-eigen:
	# git clone https://github.com/Layr-Labs/eigenlayer-contracts contracts
	cd contracts && forge install && RUST_LOG=forge,foundry=trace forge script script/deploy/devnet/M2_Deploy_From_Scratch.s.sol --rpc-url $(RPC_URL) --private-key 0x$(PRIVATE_KEY) --broadcast --sig "run(string memory configFile)" -- M2_deploy_from_scratch.anvil.config.json
