### Most of whats done in CI/CD can be done in bash

```bash
#!/bin/bash

# Set variables
IMAGE_NAME="dulc3/ubuntu-env"
TAG="latest"
FULL_IMAGE="$IMAGE_NAME:$TAG"
PLATFORMS="linux/amd64,linux/arm64"

# Setting variables is similar to python

# Ensure script exits on failure
set -e

# Check if Buildx is available
if ! docker buildx version &>/dev/null; then
  echo "Docker Buildx is not available. Ensure you have Docker Buildx installed."
  exit 1
fi

# Ensure the Docker Buildx builder exists
if ! docker buildx inspect mybuilder &>/dev/null; then
  echo "Creating a new Docker Buildx builder..."
  docker buildx create --name mybuilder --use
fi

# Inspect the builder to verify
docker buildx inspect --bootstrap

# Log in to Docker Hub (Modify for private registries)
echo "Logging into Docker Hub..."
docker login

# Build and push the Docker image using Buildx
echo "Building and pushing Docker image..."
docker buildx build --platform $PLATFORMS -t $FULL_IMAGE --push .

# Pull the image to verify
echo "Pulling the image to verify..."
docker pull $FULL_IMAGE

# List images to confirm it exists locally
echo "Verifying image exists locally..."
docker images | grep "$IMAGE_NAME"

echo "CI/CD Docker pipeline complete!
```
