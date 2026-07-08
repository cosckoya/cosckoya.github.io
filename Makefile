.PHONY: help serve build validate clean venv deps lint health

help:
	@echo "Zensical Documentation Site"
	@echo ""
	@echo "Available commands:"
	@echo "  make serve        - Start local dev server (localhost:8000)"
	@echo "  make build        - Build static site to site/"
	@echo "  make validate     - Build with strict mode (warnings as errors)"
	@echo "  make clean        - Remove site/ directory"
	@echo "  make venv         - Create Python virtual environment"
	@echo "  make deps         - Install Zensical"
	@echo "  make lint         - Run ruff, codespell, yamllint"
	@echo "  make health       - Check placeholders, orphans, Vibe Checks"

serve:
	@bash -c "source venv/bin/activate && zensical serve"

build:
	@bash -c "source venv/bin/activate && zensical build"

validate:
	@bash -c "source venv/bin/activate && zensical build --strict"

clean:
	@python3 -c "import shutil; shutil.rmtree('site', ignore_errors=True)"

venv:
	python3 -m venv venv

deps:
	@bash -c "source venv/bin/activate && pip install -r requirements.txt"

lint:
	@bash -c "source venv/bin/activate && ruff check docs/"
	@bash -c "source venv/bin/activate && codespell docs/ --skip='*.png,*.jpg,*.svg'"
	@bash -c "source venv/bin/activate && yamllint -c .yamllint.yml mkdocs.yml"

health:
	@bash -c "source venv/bin/activate && python3 scripts/health.py"
