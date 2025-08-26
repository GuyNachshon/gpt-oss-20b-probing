# Use NVIDIA CUDA base image for GPU support
FROM nvidia/cuda:13.0.0-tensorrt-devel-ubuntu24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-dev \
    python3-pip \
    git \
    curl \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files
COPY pyproject.toml requirements.txt ./
COPY README.md ./
COPY MANIFEST.in ./

# Copy source code
COPY src/ ./src/
COPY examples/ ./examples/
COPY tests/ ./tests/

# Install Python dependencies
RUN pip install --break-system-packages -r requirements.txt
RUN pip install --break-system-packages .

# Create a non-root user
RUN useradd -m -u 1001 redteam && chown -R redteam:redteam /app
USER redteam

# Set default command
ENTRYPOINT ["gpt20b-redteam"]

# Default arguments (can be overridden)
CMD ["--help"]
