# Docker Guide for GPT-OSS-20B Red-Teaming Harness

This guide shows you how to run the red-teaming harness using Docker with GPU support.

## 🐳 Prerequisites

### 1. Install Docker
```bash
# Install Docker Desktop or Docker Engine
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

### 2. Install NVIDIA Docker Runtime
```bash
# Install NVIDIA Container Toolkit
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
```

### 3. Install Docker Compose
```bash
# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## 🚀 Quick Start

### Build the Docker Image
```bash
# Build the image
docker build -t gpt-oss-20b-redteam:latest .
```

### Run with Docker Compose (Recommended)

#### 1. Show Help
```bash
docker-compose run gpt20b-redteam
```

#### 2. Run with GPT-OSS-20B Model
```bash
docker-compose run gpt20b-redteam-gpt-oss
```

#### 3. Run with OpenAI API
```bash
# Set your OpenAI API key
export OPENAI_API_KEY="sk-your-key-here"
docker-compose run gpt20b-redteam-openai
```

#### 4. Run with Anthropic API
```bash
# Set your Anthropic API key
export ANTHROPIC_API_KEY="sk-ant-your-key-here"
docker-compose run gpt20b-redteam-anthropic
```

## 🔧 Manual Docker Commands

### Basic Usage
```bash
# Run with help
docker run --rm --gpus all gpt-oss-20b-redteam:latest

# Run with a specific model
docker run --rm --gpus all \
  -v $(pwd)/results:/app/results \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  gpt-oss-20b-redteam:latest \
  --model openai/gpt-oss-20b \
  --output results_gpt_oss_20b
```

### Run with OpenAI API
```bash
docker run --rm \
  -e OPENAI_API_KEY="sk-your-key-here" \
  -v $(pwd)/results:/app/results \
  gpt-oss-20b-redteam:latest \
  --openai gpt-4 \
  --output results_openai
```

### Run with Anthropic API
```bash
docker run --rm \
  -e ANTHROPIC_API_KEY="sk-ant-your-key-here" \
  -v $(pwd)/results:/app/results \
  gpt-oss-20b-redteam:latest \
  --anthropic claude-3-sonnet \
  --output results_anthropic
```

### Run with Custom Seeds and Settings
```bash
docker run --rm --gpus all \
  -v $(pwd)/results:/app/results \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  gpt-oss-20b-redteam:latest \
  --model microsoft/DialoGPT-large \
  --seeds 42 123 456 \
  --output my_custom_run \
  --device auto
```

## 🎯 Advanced Usage

### Use Specific GPU
```bash
# Use only GPU 0
docker run --rm --gpus '"device=0"' \
  -v $(pwd)/results:/app/results \
  gpt-oss-20b-redteam:latest \
  --model openai/gpt-oss-20b

# Use multiple specific GPUs
docker run --rm --gpus '"device=0,1"' \
  -v $(pwd)/results:/app/results \
  gpt-oss-20b-redteam:latest \
  --model openai/gpt-oss-20b
```

### Run in Background
```bash
# Run in detached mode
docker run -d --name redteam-run \
  --gpus all \
  -v $(pwd)/results:/app/results \
  gpt-oss-20b-redteam:latest \
  --model openai/gpt-oss-20b \
  --output background_run

# Check logs
docker logs -f redteam-run

# Stop the container
docker stop redteam-run
```

### Interactive Mode
```bash
# Run interactively for debugging
docker run -it --rm --gpus all \
  -v $(pwd)/results:/app/results \
  gpt-oss-20b-redteam:latest \
  bash
```

## 📁 Volume Mounts

The Docker setup uses several volume mounts:

- `./results:/app/results` - Persists results to your local machine
- `~/.cache/huggingface:/root/.cache/huggingface` - Caches downloaded models
- `./config:/app/config` - Mounts custom configuration files

## 🔍 Troubleshooting

### GPU Not Found
```bash
# Check if NVIDIA Docker is working
docker run --rm --gpus all nvidia/cuda:12.1-base-ubuntu22.04 nvidia-smi
```

### Out of Memory
```bash
# Use specific GPU with more memory
docker run --rm --gpus '"device=1"' \
  -v $(pwd)/results:/app/results \
  gpt-oss-20b-redteam:latest \
  --model openai/gpt-oss-20b
```

### Permission Issues
```bash
# Fix volume permissions
sudo chown -R $USER:$USER ./results
```

### Model Download Issues
```bash
# Clear cache and retry
rm -rf ~/.cache/huggingface
docker run --rm --gpus all \
  -v $(pwd)/results:/app/results \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  gpt-oss-20b-redteam:latest \
  --model openai/gpt-oss-20b
```

## 🐳 Docker Compose Services

The `docker-compose.yml` provides several pre-configured services:

- `gpt20b-redteam` - Basic service with help
- `gpt20b-redteam-gpt-oss` - Runs with GPT-OSS-20B model
- `gpt20b-redteam-openai` - Runs with OpenAI API
- `gpt20b-redteam-anthropic` - Runs with Anthropic API

## 🔧 Environment Variables

Set these environment variables for API access:

```bash
export OPENAI_API_KEY="sk-your-key-here"
export ANTHROPIC_API_KEY="sk-ant-your-key-here"
```

## 📊 Monitoring

### Check Container Status
```bash
docker ps -a
```

### View Logs
```bash
docker logs gpt20b-redteam
```

### Monitor Resource Usage
```bash
docker stats gpt20b-redteam
```

## 🚀 Production Deployment

For production use, consider:

1. **Resource Limits**: Set memory and CPU limits
2. **Health Checks**: Add health check endpoints
3. **Logging**: Configure proper logging
4. **Security**: Run as non-root user (already configured)
5. **Backup**: Regular backup of results directory

Example production deployment:
```bash
docker run -d \
  --name redteam-production \
  --gpus all \
  --memory=32g \
  --cpus=8 \
  --restart unless-stopped \
  -v /data/results:/app/results \
  -v /data/models:/root/.cache/huggingface \
  gpt-oss-20b-redteam:latest \
  --model openai/gpt-oss-20b \
  --output production_run
```

## 🎉 Success!

Your red-teaming harness is now containerized and ready for deployment! The Docker setup provides:

- ✅ GPU acceleration support
- ✅ Persistent results storage
- ✅ Model caching
- ✅ Easy deployment
- ✅ Consistent environments
- ✅ Resource isolation
