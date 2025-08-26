#!/usr/bin/env python3
"""
Test script to demonstrate the beautiful CLI functionality.
"""

import sys
import os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'src'))

from gpt20b_redteam.cli import RichRedTeamCLI
from gpt20b_redteam.model_wrapper import create_model
from gpt20b_redteam.runner import RedTeamRunner

def test_cli():
    """Test the CLI functionality."""
    
    # Initialize CLI
    cli = RichRedTeamCLI()
    
    # Print banner
    cli.print_banner()
    
    # Create a mock model for testing
    try:
        from gpt20b_redteam.config import set_model_backend, load_example_config, get_model_config
        set_model_backend("transformers")
        load_example_config("huggingface_hub")
        mc = get_model_config()
        mc["model_path"] = "microsoft/DialoGPT-medium"  # Smaller model for testing
        
        model = create_model(**mc)
        model_config = mc
        
    except Exception as e:
        print(f"⚠️  Could not load model: {e}")
        print("Using mock model for CLI demonstration...")
        model = None
        model_config = {"backend": "mock", "model_path": "mock-model"}
    
    # Show model info
    cli.print_model_info(model_config)
    
    if model:
        # Initialize runner
        runner = RedTeamRunner(model, output_dir="test_results")
        
        # Show probe status
        cli.print_probe_status(runner)
        
        # Run a quick test with just one seed
        print("\n🚀 Running quick test with 1 seed...")
        results = cli.run_with_progress(runner, seeds=[42])
        
        # Show results
        cli.print_results_summary(results)
        
        if cli.console:
            cli.console.print(f"\n[green]✅[/green] Test completed! Results saved to: [cyan]test_results/[/cyan]")
        else:
            print(f"\n✅ Test completed! Results saved to: test_results/")
    else:
        print("\n📊 CLI demonstration completed successfully!")
        print("Install the package and run 'gpt20b-redteam --help' for full functionality.")

if __name__ == "__main__":
    test_cli()
