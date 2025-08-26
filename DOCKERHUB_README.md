# 🚀 GPT-OSS-20B Red-Teaming Harness

> **Masks, Sandbags, and Sabotage: Exposing Hidden Misalignment**

A comprehensive red-teaming toolkit for testing AI model safety and alignment. Implements advanced probes for detecting misalignment, deception, and safety vulnerabilities in large language models.

## 🐳 Quick Start

```bash
# Pull the image
docker pull guynachshon/gpt-oss-20b-redteam:latest

# Run with help
docker run --rm guynachshon/gpt-oss-20b-redteam:latest --help

# Run with GPT-OSS-20B model (GPU required)
docker run --rm --gpus all \
  -v $(pwd)/results:/app/results \
  guynachshon/gpt-oss-20b-redteam:latest \
  --model openai/gpt-oss-20b

# Run with OpenAI API
docker run --rm \
  -e OPENAI_API_KEY="sk-your-key-here" \
  -v $(pwd)/results:/app/results \
  guynachshon/gpt-oss-20b-redteam:latest \
  --openai gpt-4
```

## ✨ Features

- **🔍 10 Advanced Probes**: Evaluation awareness, deception detection, code sabotage, and more
- **🎨 Beautiful CLI**: Rich-powered interface with progress tracking and tables
- **🔌 Multi-Backend Support**: OpenAI API, Anthropic API, and local Transformers models
- **📊 Comprehensive Results**: Detailed metrics, findings, and analysis reports
- **⚡ GPU Acceleration**: Full CUDA support for fast inference
- **🐳 Containerized**: Ready-to-run Docker image with all dependencies

## 🔍 Available Probes

| Probe | Description |
|-------|-------------|
| **eval_awareness** | Evaluation Awareness & Sandbagging |
| **deception_rewardhack** | Deception & Reward Hacking |
| **sabotage_code** | Code Sabotage Detection |
| **encoding_evasion** | Encoding-Based Guardrail Evasion |
| **prefix_steering** | Prefix Steering Behavior |
| **cross_probe_compounding** | Cross-Probe Compounding Effects |
| **tokenizer_frequency_sandbagging** | Tokenizer Frequency Sandbagging |
| **long_horizon_sleeper** | Long-Horizon Sleeper Agents |
| **covert_channel_capacity** | Covert Channel Capacity |
| **refusal_boundary_cartography** | Refusal Boundary Cartography |

## 🚀 Usage Examples

### Run with Local Model
```bash
docker run --rm --gpus all \
  -v $(pwd)/results:/app/results \
  guynachshon/gpt-oss-20b-redteam:latest \
  --model microsoft/DialoGPT-large
```

### Run with OpenAI API
```bash
docker run --rm \
  -e OPENAI_API_KEY="sk-your-key-here" \
  -v $(pwd)/results:/app/results \
  guynachshon/gpt-oss-20b-redteam:latest \
  --openai gpt-4
```

### Run with Anthropic API
```bash
docker run --rm \
  -e ANTHROPIC_API_KEY="sk-ant-your-key-here" \
  -v $(pwd)/results:/app/results \
  guynachshon/gpt-oss-20b-redteam:latest \
  --anthropic claude-3-sonnet
```

### Run with Custom Settings
```bash
docker run --rm --gpus all \
  -v $(pwd)/results:/app/results \
  guynachshon/gpt-oss-20b-redteam:latest \
  --model microsoft/DialoGPT-large \
  --seeds 42 123 456 \
  --output my_custom_run \
  --device auto
```

## 🎯 GPU Configuration

### Use Specific GPU
```bash
# Use only GPU 0
docker run --rm --gpus '"device=0"' \
  -v $(pwd)/results:/app/results \
  guynachshon/gpt-oss-20b-redteam:latest \
  --model openai/gpt-oss-20b

# Use multiple GPUs
docker run --rm --gpus '"device=0,1"' \
  -v $(pwd)/results:/app/results \
  guynachshon/gpt-oss-20b-redteam:latest \
  --model openai/gpt-oss-20b
```

### CPU Only
```bash
docker run --rm \
  -v $(pwd)/results:/app/results \
  guynachshon/gpt-oss-20b-redteam:latest \
  --model microsoft/DialoGPT-large \
  --device cpu
```

## 📁 Volume Mounts

- `./results:/app/results` - Persists results to your local machine
- `~/.cache/huggingface:/root/.cache/huggingface` - Caches downloaded models

## 🔧 Environment Variables

- `OPENAI_API_KEY` - Your OpenAI API key
- `ANTHROPIC_API_KEY` - Your Anthropic API key

## 📊 Output

Results are saved to the mounted `./results` directory in JSON format, including:

- Probe-specific metrics and findings
- Model responses and analysis
- Summary statistics and recommendations
- Detailed logs and error reports

## 🛠️ Development

### Build from Source
```bash
git clone https://github.com/GuyNachshon/gpt-oss-20b-probing.git
cd gpt-oss-20b-probing
docker build -t gpt-oss-20b-redteam:latest .
```

### Interactive Mode
```bash
docker run -it --rm --gpus all \
  -v $(pwd)/results:/app/results \
  guynachshon/gpt-oss-20b-redteam:latest \
  bash
```

## 🔍 Troubleshooting

### GPU Not Found
```bash
# Check NVIDIA Docker support
docker run --rm --gpus all nvidia/cuda:12.1-base-ubuntu22.04 nvidia-smi
```

### Out of Memory
```bash
# Use specific GPU with more memory
docker run --rm --gpus '"device=1"' \
  -v $(pwd)/results:/app/results \
  guynachshon/gpt-oss-20b-redteam:latest \
  --model openai/gpt-oss-20b
```

### Permission Issues
```bash
# Fix volume permissions
sudo chown -R $USER:$USER ./results
```

## 📚 Documentation

- [GitHub Repository](https://github.com/GuyNachshon/gpt-oss-20b-probing)
- [PyPI Package](https://pypi.org/project/gpt-oss-20b-redteam/)
- [Docker Guide](https://github.com/GuyNachshon/gpt-oss-20b-probing/blob/main/DOCKER.md)

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](https://github.com/GuyNachshon/gpt-oss-20b-probing/blob/main/CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- Built on the shoulders of the open-source AI safety community
- Inspired by research on AI alignment and red-teaming

---

**Ready to test AI model safety? Pull and run! 🚀**

```bash
docker pull guynachshon/gpt-oss-20b-redteam:latest
```
