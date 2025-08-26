import os
from gpt20b_redteam.config import load_example_config, get_model_config, get_redteam_config
from gpt20b_redteam.model_wrapper import create_model
from gpt20b_redteam import RedTeamRunner

load_example_config("huggingface_hub")  # uses a public HF model id
mc = get_model_config()
mc.setdefault("model_path", "microsoft/DialoGPT-medium")  # change to your model if needed
model = create_model(**mc)

runner = RedTeamRunner(model, output_dir="results")
out = runner.run_all_probes(seeds=get_redteam_config()["seeds"])
print(out["summary"])