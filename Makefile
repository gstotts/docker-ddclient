# Load environment variables from .env file
include .env
export $(shell sed 's/=.*//' .env)

IMAGE_NAME := ddclient-dnsomatic

.PHONY: build run stop clean

build:
	@echo "Building Docker image..."
	docker build --build-arg USER=$(USERNAME) --build-arg PASSWORD=$(PASSWORD) -t $(IMAGE_NAME) .

run:
	@echo "Running Docker container..."
	docker run -d --name $(IMAGE_NAME)_container $(IMAGE_NAME)

stop:
	@echo "Stopping Docker container..."
	docker stop $(IMAGE_NAME)_container

clean: stop
	@echo "Removing Docker container and image..."
	docker rm $(IMAGE_NAME)_container
	docker rmi $(IMAGE_NAME)
