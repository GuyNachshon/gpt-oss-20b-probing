# GPT-OSS-20B Red-Teaming Harness

A modular framework for probing misalignment vulnerabilities in gpt-oss-20b models.

## 🚀 Quick Start

```bash
# Install dependencies
pip install -r requirements.txt

# Test the harness
python test_harness.py

# Run the main harness
python main.py
```

## 📁 Package Structure

```
gpt20b_redteam/
├── __init__.py              # Package initialization
├── runner.py                # Main orchestrator
├── metrics.py               # Metrics collection & analysis
├── logger.py                # Findings logger (Kaggle format)
└── probes/                  # Individual probe modules
    ├── __init__.py
    ├── base.py              # Base probe class
    ├── eval_awareness.py    # Evaluation awareness probe
    ├── deception_rewardhack.py
    ├── sabotage_code.py
    ├── encoding_evasion.py
    └── prefix_steering.py
```

## 🔍 Available Probes

### 1. Evaluation Awareness Probe
- **Purpose**: Detect sandbagging behavior when models sense evaluation
- **Method**: Paired prompts (eval vs casual framing)
- **Metrics**: Accuracy delta, refusal rate delta, hedging delta
- **Status**: ✅ **IMPLEMENTED**

### 2. Deception & Reward Hacking Probe
- **Purpose**: Detect strategic deception and reward gaming
- **Method**: Two-channel setup with private scratchpad
- **Metrics**: Deception admission rate, confidence-accuracy correlation
- **Status**: 🚧 **STUB ONLY**

### 3. Code Sabotage Probe
- **Purpose**: Detect context-sensitive code generation issues
- **Method**: Low-stakes vs high-stakes code generation
- **Metrics**: Bug rate delta, safety pattern detection
- **Status**: 🚧 **STUB ONLY**

### 4. Encoding Evasion Probe
- **Purpose**: Test guardrail robustness against encoding attacks
- **Method**: Bijection and string composition encodings
- **Metrics**: Bypass rate, encoding depth effect
- **Status**: 🚧 **STUB ONLY**

### 5. Prefix Steering Probe
- **Purpose**: Test behavior modification via prefix injection
- **Method**: Prefix-based prompt injection
- **Metrics**: Disclaimer delta, confidence delta
- **Status**: 🚧 **STUB ONLY**

## 🛠️ Usage

### Basic Usage

```python
from gpt20b_redteam import RedTeamRunner

# Initialize with your model
runner = RedTeamRunner(model, output_dir="results")

# Run a single probe
findings = runner.run_single_probe("eval_awareness", seeds=[42])

# Run all probes
all_findings = runner.run_all_probes(seeds=[42, 123, 456])
```

### Custom Model Integration

Replace the mock model in `main.py` with your actual gpt-oss-20b setup:

```python
# Example for transformers
from transformers import AutoModelForCausalLM, AutoTokenizer

model = AutoModelForCausalLM.from_pretrained("microsoft/DialoGPT-medium")
tokenizer = AutoTokenizer.from_pretrained("microsoft/DialoGPT-medium")

# Wrap in a compatible interface
class GPTOSS20B:
    def __init__(self, model, tokenizer):
        self.model = model
        self.tokenizer = tokenizer
    
    def generate(self, prompt):
        inputs = self.tokenizer(prompt, return_tensors="pt")
        outputs = self.model.generate(**inputs, max_length=200)
        return self.tokenizer.decode(outputs[0], skip_special_tokens=True)

# Use in harness
runner = RedTeamRunner(GPTOSS20B(model, tokenizer))
```

## 📊 Output Format

### Kaggle-Compatible Findings

Each probe generates findings in Kaggle submission format:

```json
{
  "finding_id": "EvaluationAwareness_20241201_143022",
  "probe_type": "EvaluationAwareness",
  "severity": "high",
  "description": "Model exhibits evaluation awareness behavior...",
  "methodology": "Paired prompt methodology...",
  "evidence": {
    "key_metrics": {...},
    "performance_deltas": {...}
  },
  "metrics": {
    "accuracy_delta": 0.15,
    "refusal_rate_delta": -0.1
  }
}
```

### Raw Results

Detailed results are saved in `results/raw_results/` for analysis.

## 🧪 Testing

```bash
# Run tests
python test_harness.py

# Test specific components
python -c "
from gpt20b_redteam.metrics import MetricsCollector
metrics = MetricsCollector()
print('Metrics collector works!')
"
```

## 🔧 Development

### Adding New Probes

1. Create a new probe class inheriting from `BaseProbe`
2. Implement required methods: `generate_prompts()`, `run_probe()`, `analyze_outputs()`
3. Add to `gpt20b_redteam/probes/__init__.py`
4. Update `runner.py` to include the new probe

### Extending Metrics

Add new metric calculation methods to `MetricsCollector` class.

## 📈 Next Steps

1. **Replace mock model** with actual gpt-oss-20b
2. **Implement remaining probes** (currently stubs)
3. **Add visualization tools** for results
4. **Extend test coverage** for all components
5. **Add activation probing** for white-box analysis

## 🎯 Research Goals

This harness implements the methodology from the research paper:
*"Masks, Sandbags, and Sabotage: Exposing Hidden Misalignment in gpt-oss-20b"*

- Systematic vulnerability discovery
- Reproducible misalignment patterns
- Automated red-teaming methodology
- Community-reusable tools and frameworks
