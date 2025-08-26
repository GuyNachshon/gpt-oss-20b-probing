"""
GPT-OSS-20B Red-Teaming Harness

A modular framework for probing misalignment vulnerabilities in gpt-oss-20b.
"""

__version__ = "0.1.0"
__author__ = "Research Team"

from .runner import RedTeamRunner
from .metrics import MetricsCollector
from .logger import FindingsLogger

__all__ = ["RedTeamRunner", "MetricsCollector", "FindingsLogger"]
