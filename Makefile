

.PHONY: build-geth-container
build-geth-container:
	docker-buildx build --platform linux/amd64 --push \
		-t "767397703211.dkr.ecr.us-east-1.amazonaws.com/layr-devnet/geth:$(shell git rev-parse HEAD)" \
		-f ./go-ethereum/Dockerfile .

.PHONY: build-prysm-container
build-prysm-container:
	docker-buildx build --platform linux/amd64 --push \
		-t "767397703211.dkr.ecr.us-east-1.amazonaws.com/layr-devnet/prysm:$(shell git rev-parse HEAD)" \
		-f ./prysm/Dockerfile .

all-containers: build-geth-container build-prysm-container
