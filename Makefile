PUBLIC_REGISTRY_HOST=docker.io
PUBLIC_REGISTRY_OWNER=novermore26
PUBLIC_REGISTRY_APP_NAME=module-39

CI_COMMIT_REF_NAME=latest

IMAGE_NAME=${PUBLIC_REGISTRY_HOST}/${PUBLIC_REGISTRY_OWNER}/${PUBLIC_REGISTRY_APP_NAME}:${CI_COMMIT_REF_NAME}

all: deps build test

deps:
	@go mod download
	@echo "Dependencies installed successfully"

build:
	@go build ./

test:
	@go test -v ./...

lint:
	@golangci-lint run ./...

image:
	@docker build -t ${IMAGE_NAME} ./
	@docker push ${IMAGE_NAME}
	@echo "New ${PUBLIC_REGISTRY_HOST}/${PUBLIC_REGISTRY_OWNER}/${PUBLIC_REGISTRY_APP_NAME} image ready! Version ${CI_COMMIT_REF_NAME}!"
