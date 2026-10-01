OCI_REGISTRY	?= ghcr.io
NAMESPACE		?= kesha123
REPOSITORY		?= mkdocs-toolset
OCI_IMAGE		?= $(OCI_REGISTRY)/$(NAMESPACE)/$(REPOSITORY)

BUILD_TAG		?= $(shell git rev-parse --short HEAD 2>/dev/null || echo dev)

PLATFORM		?= linux/amd64

DOCKER		?= docker

CACHE		?=


.PHONY: build publish

build:
	$(DOCKER) buildx build \
		--load \
		--platform $(PLATFORM) \
		$(CACHE) \
		-t $(OCI_IMAGE):$(BUILD_TAG) \
		-t $(OCI_IMAGE):latest \
		-f Containerfile \
		.

publish:
	$(DOCKER) buildx build \
		--push \
		--platform $(PLATFORM) \
		--sbom=true --provenance=mode=max \
		$(CACHE) \
		-t $(OCI_IMAGE):$(BUILD_TAG) \
		-t $(OCI_IMAGE):latest \
		-f Containerfile \
		.
