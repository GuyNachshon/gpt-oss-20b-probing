#!/bin/bash

# Docker Hub publishing script for GPT-OSS-20B Red-Teaming Harness

set -e

echo "🐳 Publishing Docker image to Docker Hub..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Configuration
DOCKER_USERNAME=${DOCKER_USERNAME:-"guynachshon"}
IMAGE_NAME="gpt-oss-20b-redteam"
VERSION=${VERSION:-"latest"}
FULL_IMAGE_NAME="${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION}"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker daemon is running
if ! docker info &> /dev/null; then
    print_error "Docker daemon is not running. Please start Docker first."
    exit 1
fi

# Check if user is logged in to Docker Hub
if ! docker info | grep -q "Username" && ! grep -q "auths" ~/.docker/config.json; then
    print_warning "You are not logged in to Docker Hub."
    print_status "Please run: docker login"
    print_status "Then run this script again."
    exit 1
fi

# Get current Docker Hub username (try multiple methods)
CURRENT_USER=""
if docker info | grep -q "Username"; then
    CURRENT_USER=$(docker info | grep "Username" | awk '{print $2}')
elif [ -f ~/.docker/config.json ]; then
    # For Docker Desktop, we'll assume the user is logged in if auths exist
    print_status "Using Docker Desktop authentication"
    CURRENT_USER="guynachshon"  # Default to script username
fi
if [ "$CURRENT_USER" != "$DOCKER_USERNAME" ]; then
    print_warning "You are logged in as '$CURRENT_USER' but trying to push to '$DOCKER_USERNAME'"
    print_status "Either:"
    print_status "1. Set DOCKER_USERNAME=$CURRENT_USER"
    print_status "2. Or login as $DOCKER_USERNAME: docker login"
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Build the image
print_status "Building Docker image: $FULL_IMAGE_NAME"
docker build -t $FULL_IMAGE_NAME .

if [ $? -eq 0 ]; then
    print_success "Docker image built successfully!"
else
    print_error "Failed to build Docker image."
    exit 1
fi

# Test the image
print_status "Testing Docker image..."
docker run --rm $FULL_IMAGE_NAME --help

if [ $? -eq 0 ]; then
    print_success "Docker image test passed!"
else
    print_error "Docker image test failed."
    exit 1
fi

# Tag with latest if not already latest
if [ "$VERSION" != "latest" ]; then
    print_status "Tagging as latest..."
    docker tag $FULL_IMAGE_NAME "${DOCKER_USERNAME}/${IMAGE_NAME}:latest"
fi

# Push to Docker Hub
print_status "Pushing to Docker Hub..."
docker push $FULL_IMAGE_NAME

if [ $? -eq 0 ]; then
    print_success "Successfully pushed $FULL_IMAGE_NAME to Docker Hub!"
else
    print_error "Failed to push to Docker Hub."
    exit 1
fi

# Push latest tag if not already latest
if [ "$VERSION" != "latest" ]; then
    print_status "Pushing latest tag..."
    docker push "${DOCKER_USERNAME}/${IMAGE_NAME}:latest"
    
    if [ $? -eq 0 ]; then
        print_success "Successfully pushed latest tag to Docker Hub!"
    else
        print_error "Failed to push latest tag to Docker Hub."
        exit 1
    fi
fi

# Show usage examples
echo ""
print_success "Docker image published successfully! 🎉"
echo ""
print_status "Usage examples:"
echo ""
echo "1. Pull and run:"
echo "   docker pull ${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION}"
echo "   docker run --rm --gpus all ${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION} --help"
echo ""
echo "2. Run with GPT-OSS-20B:"
echo "   docker run --rm --gpus all \\"
echo "     -v \$(pwd)/results:/app/results \\"
echo "     ${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION} \\"
echo "     --model openai/gpt-oss-20b"
echo ""
echo "3. Run with OpenAI API:"
echo "   docker run --rm \\"
echo "     -e OPENAI_API_KEY=\"sk-your-key-here\" \\"
echo "     -v \$(pwd)/results:/app/results \\"
echo "     ${DOCKER_USERNAME}/${IMAGE_NAME}:${VERSION} \\"
echo "     --openai gpt-4"
echo ""
echo "4. Docker Hub URL:"
echo "   https://hub.docker.com/r/${DOCKER_USERNAME}/${IMAGE_NAME}"
echo ""

print_success "Your red-teaming harness is now available on Docker Hub! 🚀"
