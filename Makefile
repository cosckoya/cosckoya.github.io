.PHONY: help serve build validate clean venv deps deps-lock update-lock lint health

help:
	@echo "MkDocs Documentation Site"
	@echo ""
	@echo "Available commands:"
	@echo "  make serve        - Start local dev server (localhost:8000)"
	@echo "  make build        - Build static site to site/"
	@echo "  make validate     - Build with strict mode (warnings as errors)"
	@echo "  make clean        - Remove site/ and .cache/ directories"
	@echo "  make venv         - Create Python virtual environment"
	@echo "  make deps         - Install pinned dev deps (requirements.txt)"
	@echo "  make deps-lock    - Install exact locked deps (requirements-lock.txt)"
	@echo "  make update-lock  - Upgrade packages and regenerate requirements-lock.txt"
	@echo "  make lint         - Run ruff, codespell, yamllint"
	@echo "  make health       - Check placeholders, orphans, Vibe Checks"

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

deps-lock:
	@bash -c "source venv/bin/activate && pip install -r requirements-lock.txt"

update-lock:
	@bash -c "source venv/bin/activate && pip install -r requirements.txt --upgrade && pip freeze | grep -v '^-e git+' > requirements-lock.txt"
	@echo "requirements-lock.txt updated — review diff before committing"

lint:
	@bash -c "source venv/bin/activate && ruff check docs/"
	@bash -c "source venv/bin/activate && codespell docs/ --skip='*.png,*.jpg,*.svg'"
	@bash -c "source venv/bin/activate && yamllint -c .yamllint.yml mkdocs.yml"

health:
	@bash -c "source venv/bin/activate && python3 scripts/health.py"
