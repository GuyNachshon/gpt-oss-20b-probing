# Use NVIDIA CUDA base image for GPU support
FROM nvidia/cuda:13.0.0-tensorrt-devel-ubuntu24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-dev \
    python3-pip \
    git \
    curl \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install uv for faster package management
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:$PATH"

# Set working directory
WORKDIR /app

# Copy package files
COPY pyproject.toml uv.lock ./
COPY README.md ./
COPY MANIFEST.in ./

# Copy source code
COPY src/ ./src/
COPY examples/ ./examples/
COPY tests/ ./tests/

# Install Python dependencies
RUN uv pip install --system .

# Create a non-root user
RUN useradd -m -u 1000 redteam && chown -R redteam:redteam /app
USER redteam

# Set default command
ENTRYPOINT ["gpt20b-redteam"]

# Default arguments (can be overridden)
CMD ["--help"]
