#!/bin/bash

# Docker build script for GPT-OSS-20B Red-Teaming Harness

set -e

echo "🐳 Building Docker image for GPT-OSS-20B Red-Teaming Harness..."

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

# Build the image
print_status "Building Docker image..."
docker build -t gpt-oss-20b-redteam:latest .

if [ $? -eq 0 ]; then
    print_success "Docker image built successfully!"
else
    print_error "Failed to build Docker image."
    exit 1
fi

# Test the image
print_status "Testing Docker image..."
docker run --rm gpt-oss-20b-redteam:latest --help

if [ $? -eq 0 ]; then
    print_success "Docker image test passed!"
else
    print_error "Docker image test failed."
    exit 1
fi

# Check for NVIDIA Docker support
print_status "Checking NVIDIA Docker support..."
if docker run --rm --gpus all nvidia/cuda:12.1-base-ubuntu22.04 nvidia-smi &> /dev/null; then
    print_success "NVIDIA Docker support detected!"
    print_status "You can run with GPU acceleration using:"
    echo "  docker run --rm --gpus all gpt-oss-20b-redteam:latest --model openai/gpt-oss-20b"
else
    print_warning "NVIDIA Docker support not detected. GPU acceleration will not be available."
    print_status "You can still run with CPU using:"
    echo "  docker run --rm gpt-oss-20b-redteam:latest --model microsoft/DialoGPT-large --device cpu"
fi

# Show usage examples
echo ""
print_status "Usage examples:"
echo ""
echo "1. Show help:"
echo "   docker run --rm gpt-oss-20b-redteam:latest"
echo ""
echo "2. Run with GPT-OSS-20B (GPU):"
echo "   docker run --rm --gpus all \\"
echo "     -v \$(pwd)/results:/app/results \\"
echo "     gpt-oss-20b-redteam:latest \\"
echo "     --model openai/gpt-oss-20b"
echo ""
echo "3. Run with OpenAI API:"
echo "   docker run --rm \\"
echo "     -e OPENAI_API_KEY=\"sk-your-key-here\" \\"
echo "     -v \$(pwd)/results:/app/results \\"
echo "     gpt-oss-20b-redteam:latest \\"
echo "     --openai gpt-4"
echo ""
echo "4. Run with Docker Compose:"
echo "   docker-compose run gpt20b-redteam-gpt-oss"
echo ""

print_success "Docker build completed successfully! 🎉"
