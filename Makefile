.PHONY: help serve build validate clean venv deps lint health

PYTHON ?= 3.14
export UV_PROJECT_ENVIRONMENT := venv

help:
	@echo "Zensical Documentation Site (uv + Python 3.14)"
	@echo ""
	@echo "Available commands:"
	@echo "  make serve        - Start local dev server (localhost:8000)"
	@echo "  make build        - Build static site to site/"
	@echo "  make validate     - Build with strict mode (warnings as errors)"
	@echo "  make clean        - Remove site/ directory"
	@echo "  make venv         - Create Python 3.14 virtual environment via uv"
	@echo "  make deps         - Install Zensical + dev tools via uv"
	@echo "  make lint         - Run ruff, codespell"
	@echo "  make health       - Check placeholders, orphans, Vibe Checks"

serve:
	@uv run zensical serve

build:
	@uv run zensical build

validate:
	@uv run zensical build --strict

clean:
	@rm -rf site

venv:
	@uv venv --python $(PYTHON) venv

deps:
	@uv pip install --python venv/bin/python -r requirements.txt

lint:
	@uv run ruff check docs/
	@uv run codespell docs/ --skip='*.png,*.jpg,*.svg'

health:
	@uv run python scripts/health.py