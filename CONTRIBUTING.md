# Contributing to cosckoya.github.io

Thank you for considering contributing to this documentation site! This guide will help you get started.

## Getting Started

### Prerequisites

- Python 3.12 or higher
- pip
- Git
- Make (optional, for using Makefile commands)

### Setup

1. Fork and clone the repository:

```bash
git clone https://github.com/cosckoya/cosckoya.github.io.git
cd cosckoya.github.io
```

1. Create and activate a virtual environment (recommended):

```bash
python3 -m venv venv
source venv/bin/activate  # On Linux/Mac
# or
venv\Scripts\activate  # On Windows
```

1. Install dependencies:

```bash
pip install --upgrade pip
pip install -r requirements.txt
```

**Quick Setup with Makefile:**

```bash
make dev  # Creates venv, installs dependencies, and sets up pre-commit
```

1. Install pre-commit hooks (if not using make dev):

```bash
pip install pre-commit
pre-commit install
```

## Development Workflow

### Local Development

Start the development server with live reload:

```bash
mkdocs serve
```

The site will be available at `http://127.0.0.1:8000/`

### Building the Site

Build the site locally to test:

```bash
mkdocs build --strict
```

The `--strict` flag ensures warnings are treated as errors.

## Content Guidelines

### Adding New Content

1. Create your markdown file in the appropriate directory under `docs/`:
   - `docs/sysadmin/` - System administration topics
   - `docs/cloud/` - Cloud platform guides
   - `docs/containers/` - Container technology
   - `docs/code/` - Programming snippets
   - `docs/monitoring/` - Monitoring and observability
   - `docs/security/` - Cybersecurity topics

2. Update the relevant `SUMMARY.md` file to include your new page in the navigation

3. Add images and assets to `docs/resources/`

### Markdown Formatting

This site uses Material for MkDocs with various extensions:

- **Admonitions**: Use `!!! note`, `!!! warning`, `!!! tip`, etc.
- **Code blocks**: Use triple backticks with language specification
- **Tabs**: Use `=== "Tab Name"` syntax
- **Tables**: Use standard markdown tables

### Image Guidelines

- Keep images under 500KB (enforced by pre-commit)
- Use descriptive filenames
- Add alt text for accessibility
- Place images in `docs/resources/img/`

## Quality Checks

### Pre-commit Hooks

Pre-commit hooks will automatically run before each commit:

- Check for merge conflicts
- Remove trailing whitespace
- Fix end of file issues
- Check for large files (>500KB)
- Detect private keys
- Validate YAML and JSON files
- Lint markdown files
- Build MkDocs in strict mode

Run hooks manually:

```bash
pre-commit run --all-files
```

### Manual Testing

Before submitting a PR:

1. Serve the site locally and verify your changes
2. Check for broken links
3. Test on different screen sizes if applicable
4. Ensure all images load correctly

## Submitting Changes

1. Create a new branch:

```bash
git checkout -b feature/your-feature-name
```

1. Make your changes and commit:

```bash
git add .
git commit -m "Description of your changes"
```

1. Push to your fork:

```bash
git push origin feature/your-feature-name
```

1. Create a Pull Request against the `main` branch

## Branch Strategy

- `main` - Production branch (auto-deploys to GitHub Pages)
- `develop` - Development branch
- Feature branches - Use descriptive names prefixed with `feature/`, `fix/`, or `docs/`

## Code of Conduct

- Be respectful and constructive
- Follow the existing style and conventions
- Keep content accurate and up-to-date
- Provide clear commit messages

## Questions?

If you have questions or need help, feel free to:

- Open an issue on GitHub
- Check the [README.md](README.md) for more information
- Review the [CLAUDE.md](CLAUDE.md) for technical details

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.
