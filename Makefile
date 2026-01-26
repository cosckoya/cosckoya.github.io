.PHONY: help install dev build serve clean test deploy

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

venv: ## Create virtual environment
	python3 -m venv venv
	@echo "Virtual environment created. Activate with: source venv/bin/activate"

install: ## Install dependencies from pyproject.toml
	pip install --upgrade pip setuptools wheel
	pip install -e .

dev: venv install ## Setup development environment with dev tools
	pip install -e .[dev]
	pip install pre-commit
	pre-commit install || echo "Pre-commit hooks not configured (optional)"
	@echo "Development environment ready!"

build: ## Build the site
	mkdocs build --strict

serve: ## Serve the site locally with live reload
	mkdocs serve

clean: ## Clean build artifacts
	rm -rf site/ test/
	find . -type d -name '__pycache__' -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name '*.pyc' -delete

test: ## Run pre-commit hooks and build
	pre-commit run --all-files
	mkdocs build --strict

deploy: ## Deploy to GitHub Pages
	mkdocs gh-deploy --force

update: ## Update dependencies to latest compatible versions
	pip install --upgrade pip setuptools wheel
	pip install --upgrade -e .[dev]
	@echo "Dependencies updated. Run 'pip freeze' to see installed versions."
