.PHONY: help serve build clean validate lint

help:
	@echo "MkDocs Documentation Site"
	@echo ""
	@echo "Available commands:"
	@echo "  make serve       - Start local dev server (localhost:8000)"
	@echo "  make build       - Build static site to site/"
	@echo "  make validate    - Build with strict mode (warnings as errors)"
	@echo "  make clean       - Remove site/ and .cache/ directories"
	@echo "  make venv        - Create Python virtual environment"
	@echo "  make deps        - Install dependencies into venv"
	@echo "  make setup       - Create venv and install deps (run once)"

# Phony target to activate venv - used as dependency for other targets
.activate:
	@bash -c "source venv/bin/activate && exec $$SHELL"

serve:
	@bash -c "source venv/bin/activate && mkdocs serve"

build:
	@bash -c "source venv/bin/activate && mkdocs build"

validate:
	@bash -c "source venv/bin/activate && mkdocs build --strict"

clean:
	rm -rf site/ .cache/

venv:
	python3 -m venv venv

deps:
	@bash -c "source venv/bin/activate && pip install -r requirements.txt"

setup: venv deps
	@echo "Setup complete. Run 'make serve' to start the dev server."
