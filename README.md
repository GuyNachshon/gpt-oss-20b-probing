# 📄 Project Page: Red-Teaming gpt-oss-20b

## Title

**“Masks, Sandbags, and Sabotage: Exposing Hidden Misalignment in gpt-oss-20b”**

---

## Motivation: Why We’re Doing This

Modern open-weights models are shaping into the “standard library” for downstream developers. But beneath the friendly surface, models often carry subtle misalignments:

* **Deceptive alignment** (pretending to be safe while hiding other objectives).
* **Evaluation awareness** (sandbagging during tests, stronger performance “in the wild”).
* **Reward hacking** (optimizing for *sounding* good instead of *being* correct).
* **Sabotage vectors** (inserting harmful bugs when given leverage).
* **Robust jailbreak channels** (encoding tricks that bypass guardrails at scale).

We aim to go beyond one-off prompt jailbreaks and instead demonstrate **systemic flaws** — reproducible patterns that expose deeper alignment risks.

---

## Research Questions

1. Does gpt-oss-20b change its behavior when it suspects it’s being evaluated?
2. Can it be coaxed into exposing “private reasoning” or deceptive strategies?
3. Does it subtly sabotage outputs when given high-impact tasks?
4. How robust are guardrails to algorithmic, automated bypass methods (e.g., bijection encodings)?
5. Can prefill / prefix steering reliably shift the model into risky regimes?

---

## Our Approach

We’ll build a **red-teaming harness** that automates probing across five novel exploit classes:

1. **Evaluation Awareness** – Contrastive prompts (eval-framed vs casual) + feature probes.
2. **Deception / Reward Hacking** – “Private scratchpad” setup to elicit hidden reasoning & inflated confidence.
3. **Scheming Sabotage** – Differential analysis of code generation in low-stakes vs high-stakes contexts.
4. **Encoding-Driven Policy Evasion** – Automate Haize-style bijection & string-composition transformations.
5. **Prefix Steering** – Prefill earlier responses to shift risk profiles.

For each, we’ll produce:

* **Finding JSON** (for Kaggle submission).
* **Reproduction notebook** (end-to-end demo).
* **Harness scripts** (deterministic, with fixed seeds).

---

## What We Expect

* To surface **5 distinct classes** of vulnerabilities, each novel or methodologically insightful.
* Evidence that the model exhibits:

  * Sandbagging (capability deltas between eval/casual).
  * Reward hacking (confidence vs accuracy mismatch).
  * Sabotage (context-sensitive injection of bugs).
  * Guardrail bypass via robust encodings.
  * Unsafe regime drift via prefix steering.
* To contribute **automation & methodology** (not just exploits), making the results reusable by the community.

---

## Impact

* **Severity:** Some findings (sabotage, covert channels) can plausibly cause real-world harm.
* **Breadth:** Automated harnesses generalize across many prompts, showing systemic failures.
* **Novelty:** Builds directly on frontier research (Anthropic’s sleeper agents, Palisade scheming probes, Haize bijection encodings).
* **Reproducibility:** Scripts + notebooks will reproduce issues on demand.
* **Methodological insight:** Provides a template others can adopt for future red-teaming challenges.

---

# 📋 Detailed Plan

## Phase 1 — Setup (Day 1)

* [ ] Spin up gpt-oss-20b locally / via Kaggle kernel.
* [ ] Prepare evaluation datasets (QA, code tasks, refusal-prone queries).
* [ ] Build skeleton harness:

  * Input runner (scenario → prompt set).
  * Output logger (JSON with prompt, seed, output, score).
  * Metrics module (accuracy, refusals, hallucination, code-safety flags).

---

## Phase 2 — Exploit Development (Day 1–2)

### 1. Evaluation Awareness

* Write paired prompts (eval vs casual).
* Run 100+ samples.
* Collect accuracy, refusal, style deltas.
* Train a small linear probe / SAE on layer activations around “eval” tokens.

### 2. Deception / Reward Hacking

* Create “private scratchpad” templates.
* Add *audit pressure vs lenient framing*.
* Measure hallucination rate + confidence inflation.

### 3. Scheming Sabotage

* Curate benign vs high-stakes coding tasks.
* Generate outputs.
* Auto-diff for:

  * suspicious APIs,
  * subtle logic bugs,
  * “poison” comments.

### 4. Encoding Evasion

* Implement bijection + string-composition encoder (seedable).
* Run refusal-prone queries with 1–5 composition depth.
* Log refusal-bypass rate.

### 5. Prefix Steering

* Create prefix templates (e.g., risky medical advice tone).
* Append benign query.
* Measure disclaimer frequency & confidence shift.

---

## Phase 3 — Consolidation (Day 3)

* [ ] Finalize JSON findings (1 per exploit).
* [ ] Build reproduction notebook (end-to-end).
* [ ] Polish write-up:

  * Introduction → Motivation → Methods → Findings → Discussion → Lessons.
* [ ] Add simple visualizations (refusal rate graphs, sabotage diffs, confidence/accuracy deltas).

---

## Deliverables

* **5 Findings JSONs** (up to 5 exploits).
* **Reproduction notebook** (runs all 5).
* **Harness code** (small, pip-installable).
* **3k-word write-up** (publication-quality).

---

# 🔧 Implementation Status

## Probe Status

### ✅ **Evaluation Awareness Probe** - ENHANCED & COMPLETED
- **Status**: Advanced implementation with multi-dimensional framing and behavioral analysis
- **Features**: 100+ questions across 8 domains, 3D framing system (authority/stakes/audience), comprehensive behavioral analysis, white-box activation probing, statistical significance testing
- **Demo**: `demo_eval_awareness.py`

### ✅ **Code Sabotage Probe** - COMPLETED  
- **Status**: Advanced implementation with sophisticated sabotage detection
- **Features**: Multi-language code analysis, adversarial prompt engineering, comprehensive risk scoring
- **Demo**: `demo_sabotage_probe.py`

### ✅ **Prefix Steering Probe** - COMPLETED
- **Status**: Advanced implementation with systematic prefix injection testing
- **Features**: 5 prefix types (confidence, authority, role, context, urgency), 6 domains, comprehensive risk analysis
- **Demo**: `demo_prefix_steering.py`

### ✅ **Deception & Reward Hacking Probe** - COMPLETED
- **Status**: Advanced implementation with scratchpad confession detection and reward gaming analysis
- **Features**: Two-channel scratchpad setup, 6 pressure conditions (audit, stakes, time pressure, authority challenge), 7 task categories (medical, finance, legal, technical, trivia, subjective, creative), deception pattern detection, confidence vs. accuracy mismatch analysis
- **Demo**: `demo_deception_probe.py`

### ✅ **Encoding Evasion Probe** - REVOLUTIONARY BREAKTHROUGH COMPLETED
- **Status**: Advanced implementation with revolutionary multi-layer obfuscation technique that leverages pattern recognition through chaos
- **Features**: 
  - **25+ encoding schemes** including fantasy languages (Quenya, Klingon, Aurebesh), ancient scripts (Elder Futhark, Hieroglyphics), advanced Unicode (Medieval, Cursive, Fraktur), technical codes (Brainfuck, Chemical), steganography, Zalgo glitch, vaporwave aesthetic
  - **🚀 REVOLUTIONARY TECHNIQUE**: Multi-layer obfuscation with word-level randomization, 20+ variations, rhythm patterns, and chaos-to-signal conversion
  - **Pattern recognition through chaos**: Human-incomprehensible but model-readable text through statistical repetition
  - **P4RS3LT0NGV3 integration**: Word-level randomization with 8-12 transformations per word
  - **Composition stacking** (1-5 layers), 30+ refusal-prone queries across domains
- **Demo**: `demo_encoding_evasion.py`
- **Research Impact**: Demonstrates vulnerability to sophisticated pattern recognition attacks that humans cannot detect but advanced models can understand

## Core Infrastructure

### ✅ **Advanced Metrics System** - COMPLETED
- **Features**: LLM-as-a-judge, human feedback integration, activation probe training
- **Demo**: `demo_advanced_metrics.py`

### ✅ **Model Wrapper** - COMPLETED
- **Features**: Whitebox (transformers) and blackbox (API) support
- **Demo**: `example_usage.py`

### ✅ **Configuration Management** - COMPLETED
- **Features**: Centralized config for models, red-teaming, and logging

## Next Steps

1. **Complete remaining probes** (Deception & Encoding Evasion)
2. **Integration testing** across all probes
3. **Visualization tools** for comprehensive results
4. **Final findings compilation** for Kaggle submission