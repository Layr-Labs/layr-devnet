.PHONY: deploy

start-docker:
	docker compose build && docker compose down --volumes && docker compose build --progress=plain && docker compose up

deploy-eigen:
	git clone https://github.com/Layr-Labs/eigenlayer-contracts.git contracts
	cd contracts && ls -lar . && forge install
	cd contracts && ls -lar . && RUST_LOG=forge,foundry=trace forge script script/deploy/local/Deploy_From_Scratch.s.sol --rpc-url "http://geth:8545" --private-key $(PRIVATE_KEY) --broadcast --sig "run(string memory configFile)" -- devnet/deploy_from_scratch.anvil.config.json
