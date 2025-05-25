# Variables
IMAGE_NAME := zen00326598/accounting
IMAGE_TAG := latest
FULL_IMAGE_NAME := $(IMAGE_NAME):$(IMAGE_TAG)

# Build the Docker image
.PHONY: docker-build
docker-build:
	@echo "Building Docker image: $(FULL_IMAGE_NAME)"
	docker build -t $(FULL_IMAGE_NAME) .

# Run the Docker container
.PHONY: docker-run
docker-run:
	@echo "Running Docker container from image: $(FULL_IMAGE_NAME)"
	docker run -p 8081:8081 $(FULL_IMAGE_NAME)

# Push the Docker image to registry
.PHONY: docker-push
docker-push:
	@echo "Pushing Docker image to registry: $(FULL_IMAGE_NAME)"
	docker push $(FULL_IMAGE_NAME)

# All-in-one target for build and push
.PHONY: docker-build-push
docker-build-push: docker-build docker-push
		@echo "Docker image built and pushed successfully."

# Help message
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  docker-build      - Build the Docker image"
	@echo "  docker-run        - Run the Docker container locally"
	@echo "  docker-push       - Push the Docker image to registry"
	@echo "  docker-build-push - Build and push the Docker image"
	@echo "  help              - Display this help message"

# Default target
.DEFAULT_GOAL := help