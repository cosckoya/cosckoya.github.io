---
hide:
  - tags

tags:
  - git
  - pre-commit
  - git-hooks
  - DevSecOps
---
# Git
!!! info "Reference"
    === "Learning"
    - [Gitlab Learn](https://about.gitlab.com/learn/)
    - [Gitignore Templates](https://github.com/github/gitignore)
    - [Git Branching](https://learngitbranching.js.org)
    === "Badges and Shields"
    - [ASCII Art](https://github.com/moul/awesome-ascii-art)
    - [Version Badge](https://badge.fury.io)
    - [Shields.io](https://shields.io)
    - [Aleen42 Badges](https://badges.aleen42.com)
    - [For The Badge](https://forthebadge.com)
    - [Badgen](https://badgen.net)

## Pre-Commit

!!! tip "Install Pre-Commit with Pip"
    === "Install pre-commit"
    ```
    $> pip install pre-commit
    ```

    === "Create a file .pre-commit-config.yaml with the content"
    ```yaml
    repos:
    - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
    - id: check-merge-conflict
    - id: trailing-whitespace
    - id: end-of-file-fixer
    - id: check-added-large-files
    - id: detect-private-key
    ```
    === "Install pre-commit hook"
    ```sh
    $> pre-commit install
    $> pre-commit install-hooks
    ```
    === "Run pre-commit hook"
    ```sh
    $> pre-commit run -a

    check for merge conflicts................................................Passed
    trim trailing whitespace.................................................Passed
    fix end of files.........................................................Passed
    check for added large files..............................................Passed
    detect private key.......................................................Passed
    mkdocs-buid..............................................................Passed
    ```

!!! info "Reference"
    - [Pre-Commit Official](https://pre-commit.com)
    - [Pre-Commit Git Repo](https://github.com/pre-commit)

## Github

!!! info "Reference"
    === "Learning"
    - [Github Docs](https://docs.github.com/)
    - [Github Skills](https://skills.github.com/)

### Github Actions

## Gitlab
!!! info "Reference"
    === "Learning"
    - [Gitlab Docs](https://docs.gitlab.com/)
    - [Gitlab Learn](https://docs.gitlab.com/ee/tutorials/)
### Gitlab Actions

## Azure DevOps
### Pipelines
### Releases
