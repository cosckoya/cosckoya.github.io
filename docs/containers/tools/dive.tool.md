---
title: Dive
description: Docker image layer analyzer - explore image contents, find wasted space, optimize layer efficiency
---

# :fontawesome-solid-magnifying-glass: Dive

Docker image layer explorer. See every layer, every file change, wasted space from deletions. Interactive TUI shows what bloats your images. Build smaller images by understanding what's actually inside.

!!! tip "Why Dive"
    Visual layer breakdown, wasted space analysis, efficiency score, file tree navigation, CI/CD integration for image size enforcement.

---

## :fontawesome-solid-bolt: Quick Start

=== "Installation"

    **macOS:**
    ```bash
    brew install dive
    ```

    **Ubuntu/Debian:**
    ```bash
    wget https://github.com/wagoodman/dive/releases/download/v0.11.0/dive_0.11.0_linux_amd64.deb
    sudo dpkg -i dive_0.11.0_linux_amd64.deb
    ```

    **Arch Linux:**
    ```bash
    yay -S dive
    ```

    **Docker (no install):**
    ```bash
    docker run --rm -it \
      -v /var/run/docker.sock:/var/run/docker.sock \
      wagoodman/dive:latest <image>
    ```

    **Go install:**
    ```bash
    go install github.com/wagoodman/dive@latest
    ```

    **Verify:**
    ```bash
    dive --version
    # dive 0.11.0
    ```

=== "Basic Usage"

    **Analyze local image:**
    ```bash
    # Analyze image by name
    dive nginx:latest

    # Analyze by image ID
    dive a24bb4013296

    # Analyze with custom config
    dive --config ~/.dive.yaml nginx:latest
    ```

    **Build and analyze:**
    ```bash
    # Build Dockerfile and analyze result
    dive build -t myapp:latest .

    # Analyze specific build stage
    dive build --target production -t myapp:prod .
    ```

    **CI/CD mode (non-interactive):**
    ```bash
    # Exit with error if efficiency < 90%
    CI=true dive nginx:latest

    # Custom threshold
    CI=true dive --highestUserWastedPercent 0.05 nginx:latest
    ```

    **Export analysis:**
    ```bash
    # JSON output
    dive nginx:latest --json output.json

    # Source options
    dive docker://nginx:latest     # Docker daemon (default)
    dive podman://nginx:latest     # Podman
    dive docker-archive://image.tar # Tar archive
    ```

=== "TUI Navigation"

    **Interface sections:**
    - **Left pane:** Layer list with sizes
    - **Right top:** File tree of current layer
    - **Right bottom:** Layer details and commands

    **Keyboard shortcuts:**
    - `Tab` - Switch between panes
    - `Ctrl+C` - Exit
    - `Ctrl+Space` - Toggle collapse/expand
    - `Space` - Collapse/expand directory
    - `Ctrl+A` - Show aggregate changes
    - `Ctrl+L` - Show layer changes only
    - `PageUp/PageDown` - Scroll layers
    - `Ctrl+F` - Filter files
    - `Ctrl+/` - Toggle view (added/removed/modified)

    **Layer view modes:**
    - **Aggregate:** Show cumulative file tree
    - **Layer:** Show changes in current layer only

    **File indicators:**
    - `+` - Added file
    - `-` - Removed file (wasted space!)
    - `M` - Modified file
    - No indicator - Unchanged

---

## :fontawesome-solid-gear: Configuration

**Config file:** `~/.dive.yaml` or `.dive-ci`

```yaml
# ============================================
# DIVE CONFIGURATION
# ============================================

# Keybindings
keybinding:
  # Layer navigation
  toggle-collapse-dir: Ctrl+Space
  toggle-aggregate-layer: Ctrl+A
  toggle-added-files: Ctrl+A
  toggle-removed-files: Ctrl+R
  toggle-modified-files: Ctrl+M
  toggle-unmodified-files: Ctrl+U

  # Pane navigation
  page-up: PageUp
  page-down: PageDown
  filter-files: Ctrl+F

# Display
diff:
  # Show diffs in tree
  hide: []

# Performance
layer:
  # Show layer command
  show-aggregated-changes: false

# CI/CD thresholds
rules:
  - name: "Efficiency check"
    trigger: "image-efficiency"
    message: "Image efficiency below threshold"
    # Fail if efficiency < 95%
    threshold: 0.95

  - name: "Wasted space check"
    trigger: "user-wasted-percent"
    message: "Too much wasted space"
    # Fail if wasted space > 5%
    threshold: 0.05
```

**Environment variables:**
```bash
# CI mode (non-interactive)
export CI=true

# Custom config path
export DIVE_CONFIG_PATH=~/.config/dive.yaml

# Source
export DIVE_SOURCE=docker  # docker, podman, docker-archive
```

---

## :fontawesome-solid-diagram-project: Common Workflows

### Optimize Dockerfile

```bash
# 1. Analyze current image
dive myapp:latest

# Look for:
# - Large layers (inefficient COPY commands)
# - Removed files (wasted space - files added then deleted)
# - Duplicate files across layers

# 2. Common issues and fixes:

# BAD: Multiple RUN commands create layers
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get clean

# GOOD: Chain commands, clean in same layer
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# BAD: COPY then modify creates wasted space
COPY . /app
RUN rm -rf /app/tests /app/.git

# GOOD: Use .dockerignore or COPY selectively
COPY src/ /app/src/
COPY package.json /app/

# BAD: Install dev dependencies
RUN npm install

# GOOD: Production only
RUN npm ci --only=production
```

### CI/CD Integration

```bash
# In CI pipeline (GitLab CI example)
image-scan:
  stage: test
  image: wagoodman/dive:latest
  script:
    - dive --ci ${CI_REGISTRY_IMAGE}:${CI_COMMIT_SHA}
  only:
    - merge_requests

# GitHub Actions example
- name: Dive image scan
  uses: yuichielectric/dive-action@0.0.4
  with:
    image: 'myapp:${{ github.sha }}'
    config-file: '.dive-ci'
```

**`.dive-ci` for CI:**
```yaml
rules:
  - name: "Efficiency > 95%"
    trigger: "image-efficiency"
    threshold: 0.95

  - name: "Wasted space < 100MB"
    trigger: "user-wasted-bytes"
    threshold: 104857600  # 100MB in bytes
```

### Compare Images

```bash
# Build two versions
docker build -t myapp:v1 .
# (make optimizations)
docker build -t myapp:v2 .

# Compare sizes
dive myapp:v1 --json v1.json
dive myapp:v2 --json v2.json

# Manual comparison or use jq
jq '.layer | length' v1.json  # Number of layers
jq '.layer | length' v2.json
```

---

## :fontawesome-solid-lightbulb: Pro Tips

- **Use multi-stage builds** - Final image only gets artifacts, not build tools
- **Order matters** - Put frequently changing files (code) after stable deps
- **Combine RUN commands** - Each RUN creates a layer
- **Clean in same layer** - Delete files in same RUN that created them
- **Use .dockerignore** - Don't COPY unnecessary files
- **Leverage build cache** - Order Dockerfile commands by change frequency
- **Check base image** - `alpine` vs `debian` size difference
- **Use specific tags** - `python:3.11-slim` vs `python:latest`
- **Run in CI** - Enforce image size standards automatically
- **Analyze prod images** - Not just dev builds

---

## :fontawesome-solid-triangle-exclamation: Common Gotchas

- **Deleted files waste space** - Removing in later layer doesn't free space
- **apt-get cache** - Always `rm -rf /var/lib/apt/lists/*` in same RUN
- **Large COPY commands** - Use .dockerignore or selective COPY
- **Package manager caches** - `npm cache clean`, `pip cache purge`
- **Log files** - Don't include logs in image
- **Source control** - Exclude .git directory
- **Development dependencies** - Use `--only=production` or similar
- **Temporary files** - Clean `/tmp` in same layer
- **Multiple FROM** - Only last stage ends up in final image (multi-stage)
- **Base image size** - Alpine 5MB vs Ubuntu 77MB

---

## :octicons-telescope-16: Efficiency Metrics

**Image efficiency score:**
```
Efficiency = (Total Image Size - Wasted Space) / Total Image Size × 100%
```

**Wasted space sources:**
- Files added then removed in later layers
- Package manager caches not cleaned
- Build artifacts not cleaned
- Duplicate files across layers

**Good efficiency targets:**
- **> 95%** - Excellent (well-optimized)
- **90-95%** - Good (minor waste)
- **80-90%** - Acceptable (some optimization possible)
- **< 80%** - Poor (significant waste)

**Example output:**
```
Image efficiency: 93.5%
  Total image size: 152 MB
  Potential waste: 10 MB

Layer count: 8
  Largest layer: 45 MB (apt packages)

Wasted space by layer:
  Layer 3: 8 MB (removed .git directory)
  Layer 6: 2 MB (apt cache)
```

---

## :fontawesome-solid-book: Dockerfile Best Practices

```dockerfile
# ============================================
# OPTIMIZED DOCKERFILE
# ============================================

# Use specific, slim base image
FROM python:3.11-slim as builder

# Install build dependencies in one layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        g++ \
        make && \
    rm -rf /var/lib/apt/lists/*

# Copy only dependency files first (better caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir --user -r requirements.txt

# ============================================
# FINAL STAGE
# ============================================

FROM python:3.11-slim

# Copy only installed packages from builder
COPY --from=builder /root/.local /root/.local

# Copy application code
COPY src/ /app/src/
COPY config/ /app/config/

# Make sure scripts are in PATH
ENV PATH=/root/.local/bin:$PATH

WORKDIR /app

CMD ["python", "src/main.py"]

# Result: ~150MB instead of 500MB
# Efficiency: 98%
```

---

## :fontawesome-solid-link: Resources

**Official:**
- **[GitHub](https://github.com/wagoodman/dive)** - Source code
- **[Releases](https://github.com/wagoodman/dive/releases)** - Download

**Docker Image Optimization:**
- **[Docker Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)** - Official guide
- **[Multi-stage Builds](https://docs.docker.com/build/building/multi-stage/)** - Multi-stage documentation

**CI/CD Integration:**
- **[GitHub Action](https://github.com/yuichielectric/dive-action)** - Dive action
- **[GitLab CI Example](https://gitlab.com/gitlab-org/gitlab/-/blob/master/.gitlab-ci.yml)** - Integration example

**Alternatives:**
- **[docker-slim](https://github.com/docker-slim/docker-slim)** - Automated image minification
- **[container-diff](https://github.com/GoogleContainerTools/container-diff)** - Compare container images

---

**Last Updated:** 2026-02-03

**Tags:** dive, docker, containers, image-optimization, dockerfile, ci-cd, development-tools
