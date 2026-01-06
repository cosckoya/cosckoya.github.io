---
title: Pip - Python Package Manager
description: Complete guide to pip, the Python package manager. Learn installation, dependency management, virtual environments, and best practices.
---

# Pip - Python Package Manager

Pip is the standard package manager for Python, allowing you to install and manage packages from the [Python Package Index (PyPI)](https://pypi.org/) and other sources.

!!! abstract "Quick Reference"
    - **Install package**: `pip install package-name`
    - **Uninstall package**: `pip uninstall package-name`
    - **List packages**: `pip list`
    - **Update pip**: `python3 -m pip install --upgrade pip`
    - **Freeze deps**: `pip freeze > requirements.txt`

[Back to Python](python.md){ .md-button }

## Getting Started

### Installation

=== "Linux"
    ```bash title="Install pip on Linux"
    # Ubuntu/Debian
    sudo apt update && sudo apt install python3-pip

    # Fedora/RHEL
    sudo dnf install python3-pip

    # Arch Linux
    sudo pacman -S python-pip

    # Verify installation
    pip3 --version
    ```

=== "macOS"
    ```bash title="Install pip on macOS"
    # Using Homebrew (recommended)
    brew install python3

    # Or download directly
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py --user

    # Verify installation
    pip3 --version
    ```

=== "Windows"
    ```powershell title="Install pip on Windows"
    # Python 3.4+ includes pip by default
    # If missing, use ensurepip
    python -m ensurepip --upgrade

    # Or download get-pip.py
    # Visit: https://bootstrap.pypa.io/get-pip.py
    python get-pip.py

    # Verify installation
    pip --version
    ```

### Upgrading Pip

!!! tip "Always use python -m pip"
    Using `python -m pip` instead of `pip` directly ensures you're using the correct pip for your Python version.

```bash title="Upgrade pip to latest version"
# Recommended method
python3 -m pip install --upgrade pip

# Alternative
pip3 install --upgrade pip
```

## Package Management

### Installing Packages

```bash title="Install packages"
# Install latest version
pip install requests

# Install specific version
pip install django==5.0.1

# Install with version constraints
pip install 'flask>=3.0.0,<4.0.0'

# Install multiple packages
pip install requests beautifulsoup4 pandas

# Install from requirements file
pip install -r requirements.txt

# Install in user directory (no sudo needed)
pip install --user package-name
```

!!! example "Real-world example"
    ```bash
    # Install web development stack
    pip install django djangorestframework psycopg2-binary celery redis
    ```

### Upgrading Packages

```bash title="Upgrade packages"
# Upgrade single package
pip install --upgrade requests

# Upgrade with force reinstall (fixes corrupted packages)
pip install --upgrade --force-reinstall requests

# Upgrade pip itself
python3 -m pip install --upgrade pip
```

### Uninstalling Packages

```bash title="Uninstall packages"
# Uninstall single package
pip uninstall requests

# Uninstall without confirmation prompt
pip uninstall -y requests

# Uninstall multiple packages
pip uninstall -y requests beautifulsoup4 pandas

# Uninstall everything from requirements file
pip uninstall -r requirements.txt -y
```

!!! warning "Be careful with uninstall -y"
    The `-y` flag skips confirmation. Double-check before using it with multiple packages.

## Dependency Management

### Requirements Files

Requirements files track your project's dependencies, ensuring consistent environments across development, testing, and production.

=== "Generate"
    ```bash title="Create requirements.txt"
    # Freeze all installed packages (exact versions)
    pip freeze > requirements.txt

    # List only direct dependencies (cleaner)
    pip list --not-required --format=freeze > requirements.txt

    # Install from requirements
    pip install -r requirements.txt
    ```

=== "Production (Pinned)"
    ```txt title="requirements.txt"
    # Exact versions for reproducibility
    Django==5.0.1
    djangorestframework==3.14.0
    psycopg2-binary==2.9.9
    celery==5.3.4
    redis==5.0.1
    gunicorn==21.2.0
    ```

=== "Development (Flexible)"
    ```txt title="requirements.txt"
    # Flexible version ranges for libraries
    Django>=5.0.0,<6.0.0
    djangorestframework>=3.14.0,<4.0.0
    requests>=2.31.0,<3.0.0

    # Development tools
    pytest>=7.4.0
    black>=23.0.0
    flake8>=6.0.0
    ```

=== "Structured"
    ```txt title="requirements.txt"
    # ============================================
    # Core Dependencies
    # ============================================
    Django>=5.0.0,<6.0.0
    djangorestframework>=3.14.0,<4.0.0

    # ============================================
    # Database
    # ============================================
    psycopg2-binary>=2.9.0,<3.0.0
    SQLAlchemy>=2.0.0,<3.0.0

    # ============================================
    # Async & Background Tasks
    # ============================================
    celery>=5.3.0,<6.0.0
    redis>=5.0.0,<6.0.0

    # ============================================
    # Production Server
    # ============================================
    gunicorn>=21.0.0,<22.0.0
    ```

### Multiple Requirements Files

For larger projects, split requirements into multiple files:

```txt title="requirements/base.txt"
# Base dependencies for all environments
Django>=5.0.0,<6.0.0
djangorestframework>=3.14.0,<4.0.0
psycopg2-binary>=2.9.0,<3.0.0
```

```txt title="requirements/dev.txt"
# Development dependencies
-r base.txt

pytest>=7.4.0
pytest-django>=4.5.0
black>=23.0.0
flake8>=6.0.0
ipython>=8.0.0
```

```txt title="requirements/prod.txt"
# Production dependencies
-r base.txt

gunicorn>=21.0.0,<22.0.0
sentry-sdk>=1.40.0
```

```bash title="Install environment-specific requirements"
# Development
pip install -r requirements/dev.txt

# Production
pip install -r requirements/prod.txt
```

## Virtual Environments

!!! info "Why Virtual Environments?"
    Virtual environments isolate project dependencies, preventing conflicts between projects and protecting your system Python installation.

### Quick Start with venv

=== "Linux/macOS"
    ```bash title="Create and use virtual environment"
    # Create virtual environment
    python3 -m venv venv

    # Activate
    source venv/bin/activate

    # Install dependencies
    pip install -r requirements.txt

    # Work on your project...

    # Deactivate when done
    deactivate
    ```

=== "Windows"
    ```powershell title="Create and use virtual environment"
    # Create virtual environment
    python -m venv venv

    # Activate
    venv\Scripts\activate

    # Install dependencies
    pip install -r requirements.txt

    # Work on your project...

    # Deactivate when done
    deactivate
    ```

### Workflow Example

```bash title="Typical project workflow"
# 1. Create project directory
mkdir my-project && cd my-project

# 2. Create virtual environment
python3 -m venv venv

# 3. Activate it
source venv/bin/activate

# 4. Upgrade pip
pip install --upgrade pip

# 5. Install dependencies
pip install django pytest black

# 6. Freeze dependencies
pip freeze > requirements.txt

# 7. Add venv/ to .gitignore
echo "venv/" >> .gitignore

# 8. Work on your project
# ...

# 9. Deactivate when done
deactivate
```

!!! tip "Pro tip: Add to .gitignore"
    Always add your virtual environment directory to `.gitignore`:
    ```gitignore
    # Virtual environments
    venv/
    env/
    .venv/
    ENV/
    ```

## Advanced Usage

### Package Information

```bash title="Inspect packages"
# List all installed packages
pip list

# Show outdated packages
pip list --outdated

# Show package details
pip show django

# Check for dependency conflicts
pip check

# Export in requirements format
pip freeze
```

!!! example "Useful queries"
    ```bash
    # Find package version
    pip show requests | grep Version

    # Check if package is installed
    pip show requests > /dev/null 2>&1 && echo "Installed" || echo "Not installed"

    # List packages by size
    pip list --format=json | python3 -c "import json, sys; pkgs = json.load(sys.stdin); print('\n'.join(p['name'] for p in pkgs))"
    ```

### Install from Alternative Sources

=== "Git Repository"
    ```bash title="Install from Git"
    # Latest from default branch
    pip install git+<https://github.com/django/django.git>

    # Specific branch
    pip install git+https://github.com/django/django.git@stable/5.0.x

    # Specific tag or commit
    pip install git+https://github.com/django/django.git@5.0.1

    # With SSH
    pip install git+ssh://git@github.com/user/repo.git
    ```

=== "Local Package"
    ```bash title="Install local package"
    # Editable install (for development)
    pip install -e /path/to/package
    pip install -e .  # From current directory

    # Regular install
    pip install /path/to/package

    # From wheel
    pip install ./dist/package-1.0.0-py3-none-any.whl
    ```

=== "Private Index"
    ```bash title="Install from private repository"
    # Use alternative index
    pip install --index-url <https://pypi.company.com/simple> package-name

    # Use additional index (fallback to PyPI)
    pip install --extra-index-url https://pypi.company.com/simple package-name

    # With authentication
    pip install --index-url https://user:password@pypi.company.com/simple package-name
    ```

## Configuration & Optimization

### Configuration File

Configure pip globally to customize behavior across all projects.

=== "Linux/macOS"
    ```ini title="~/.config/pip/pip.conf"
    [global]
    timeout = 60
    retries = 3

    [install]
    user = false

    [list]
    format = columns
    ```

=== "Windows"
    ```ini title="%APPDATA%\pip\pip.ini"
    [global]
    timeout = 60
    retries = 3

    [install]
    user = false

    [list]
    format = columns
    ```

### Performance Options

```bash title="Optimize pip operations"
# Skip cache (useful for CI/CD)
pip install --no-cache-dir package-name

# Increase timeout for slow connections
pip install --timeout 300 package-name

# Parallel downloads (pip 20.3+)
pip install --use-feature=fast-deps package-name

# Verbose output for debugging
pip install -vvv package-name
```

### Cache Management

```bash title="Manage pip cache"
# Show cache location and size
pip cache info

# List cached files
pip cache list

# Remove specific package from cache
pip cache remove requests

# Clear entire cache
pip cache purge
```

## Best Practices

### Version Pinning Strategy

!!! success "Applications vs Libraries"
    - **Applications**: Pin exact versions (`==`) for reproducibility
    - **Libraries**: Use flexible ranges (`>=,<`) for compatibility

=== "Application (Pinned)"
    ```txt title="requirements.txt"
    # Production app - exact versions
    Django==5.0.1
    requests==2.31.0
    celery==5.3.4
    ```

=== "Library (Flexible)"
    ```txt title="requirements.txt"
    # Python library - compatible ranges
    Django>=5.0.0,<6.0.0
    requests>=2.31.0,<3.0.0
    celery>=5.3.0,<6.0.0
    ```

### Security Audits

Regularly audit your dependencies for known vulnerabilities.

```bash title="Security scanning"
# Using pip-audit (official PyPA tool)
pip install pip-audit
pip-audit

# Scan requirements file
pip-audit -r requirements.txt

# Using safety (community tool)
pip install safety
safety check
safety check --json  # JSON output
```

### Development Workflow

!!! tip "Recommended Workflow"
    1. **Always** use virtual environments
    2. **Pin** dependencies in `requirements.txt`
    3. **Audit** dependencies regularly
    4. **Update** dependencies incrementally, not all at once
    5. **Test** after each update
    6. **Commit** updated `requirements.txt` to version control

## Troubleshooting

### Permission Errors

!!! failure "PermissionError: [Errno 13]"
    **Problem**: Installing packages without proper permissions.

    **Solutions**:

    === "Recommended"
        ```bash
        # Use virtual environment (best practice)
        python3 -m venv venv
        source venv/bin/activate
        pip install package-name
        ```

    === "Alternative"
        ```bash
        # Install in user directory
        pip install --user package-name
        ```

    === "Avoid"
        ```bash
        # ❌ Don't use sudo with pip (breaks system packages)
        # sudo pip install package-name  # DON'T DO THIS
        ```

### SSL Certificate Errors

!!! failure "SSL: CERTIFICATE_VERIFY_FAILED"
    **Problem**: SSL certificate verification issues.

    **Solutions**:
    ```bash
    # 1. Update certificates (recommended)
    pip install --upgrade certifi

    # 2. Update pip
    python3 -m pip install --upgrade pip

    # 3. Temporary bypass (not recommended)
    pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org package-name
    ```

### Dependency Conflicts

!!! failure "ERROR: ResolutionImpossible"
    **Problem**: Incompatible package versions.

    **Solutions**:
    ```bash
    # Check current conflicts
    pip check

    # See dependency tree
    pip install pipdeptree
    pipdeptree

    # Use pip-tools for resolution
    pip install pip-tools
    pip-compile requirements.in --resolver=backtracking
    ```

### Corrupted Packages

!!! failure "ImportError or ModuleNotFoundError"
    **Problem**: Package installed but import fails.

    **Solutions**:
    ```bash
    # Force reinstall
    pip install --force-reinstall --no-cache-dir package-name

    # Or uninstall and reinstall
    pip uninstall package-name
    pip install package-name

    # Verify installation
    pip show package-name
    python3 -c "import package_name; print(package_name.__version__)"
    ```

### Debugging Tips

```bash title="Debug pip issues"
# Verbose output (shows full traceback)
pip install -vvv package-name

# Check pip configuration
pip config list

# Verify pip is working
pip --version
python3 -m pip --version

# Show installed files
pip show -f package-name

# Check for conflicts
pip check
```

## Essential Tools

### pip-tools - Dependency Management

Lock dependencies for reproducible builds while maintaining human-readable input files.

```bash title="Using pip-tools"
# Install
pip install pip-tools

# Create requirements.in (your direct dependencies)
cat > requirements.in <<EOF
Django>=5.0
requests
celery
EOF

# Compile to locked requirements.txt
pip-compile requirements.in

# Install from locked requirements
pip-sync requirements.txt

# Update all dependencies
pip-compile --upgrade requirements.in

# Update single package
pip-compile --upgrade-package django requirements.in
```

!!! tip "Why pip-tools?"
    - Separates direct dependencies from transitive ones
    - Ensures reproducible builds
    - Easy to see and update top-level dependencies

### pipx - Isolated CLI Tools

Install Python CLI applications in isolated environments without affecting your projects.

```bash title="Using pipx"
# Install pipx
pip install pipx
pipx ensurepath

# Install CLI tools
pipx install black
pipx install flake8
pipx install pytest
pipx install mkdocs

# List installed apps
pipx list

# Upgrade app
pipx upgrade black

# Run without installing
pipx run cowsay "Hello World!"

# Uninstall
pipx uninstall black
```

!!! success "Recommended CLI tools via pipx"
    - `black` - Code formatter
    - `flake8` - Linter
    - `mypy` - Type checker
    - `pytest` - Testing framework
    - `poetry` - Dependency management
    - `tox` - Testing automation

### pipdeptree - Dependency Visualization

Visualize package dependencies to understand and debug conflicts.

```bash title="Using pipdeptree"
# Install
pip install pipdeptree

# Show dependency tree
pipdeptree

# Show dependencies for specific package
pipdeptree -p django

# Show reverse dependencies (what depends on this package)
pipdeptree -r -p requests

# Export as JSON
pipdeptree --json > deps.json

# Find circular dependencies
pipdeptree --warn silence
```

## Quick Command Reference

| Task | Command |
|------|---------|
| Install package | `pip install package-name` |
| Install specific version | `pip install package-name==1.2.3` |
| Install with version range | `pip install 'package-name>=1.0,<2.0'` |
| Upgrade package | `pip install --upgrade package-name` |
| Uninstall package | `pip uninstall package-name` |
| List packages | `pip list` |
| List outdated | `pip list --outdated` |
| Show package info | `pip show package-name` |
| Generate requirements | `pip freeze > requirements.txt` |
| Install from requirements | `pip install -r requirements.txt` |
| Check for conflicts | `pip check` |
| Upgrade pip | `python3 -m pip install --upgrade pip` |

## Additional Resources

### Official Documentation

- [Pip Documentation](https://pip.pypa.io/) - Official pip documentation
- [Python Packaging Guide](https://packaging.python.org/) - Comprehensive packaging guide
- [PyPI](https://pypi.org/) - Python Package Index

### Tools & Extensions

- [pip-tools](https://github.com/jazzband/pip-tools) - Dependency locking and management
- [pipx](https://github.com/pypa/pipx) - Install CLI tools in isolated environments
- [pip-audit](https://github.com/pypa/pip-audit) - Security vulnerability scanner
- [pipdeptree](https://github.com/tox-dev/pipdeptree) - Dependency tree visualization

### Standards & Specifications

- [PEP 440](https://peps.python.org/pep-0440/) - Version identification and dependency specification
- [PEP 508](https://peps.python.org/pep-0508/) - Dependency specification for Python packages
- [PEP 621](https://peps.python.org/pep-0621/) - Storing project metadata in pyproject.toml

---

[Back to Python](python.md){ .md-button } [Shell Scripts](shell.md){ .md-button .md-button--primary }
