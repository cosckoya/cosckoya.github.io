---
title: Git Hooks & Pre-Commit
description: Automate quality checks and enforce standards with Git hooks
tags:
  - git
  - hooks
  - pre-commit
  - automation
---

# Git Hooks & Pre-Commit

Git hooks are scripts that run automatically at specific points in the Git workflow. Pre-commit is a framework for managing and maintaining multi-language pre-commit hooks, helping teams enforce code quality standards before commits are made.

## Pre-Commit

Pre-commit hooks help catch issues before they reach your repository by running automated checks on staged changes.

??? example "Install Pre-Commit with Pip"
    Install pre-commit
    ```bash
    $> pip install pre-commit
    ```

    Create a file .pre-commit-config.yaml with the content
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

    Install pre-commit hook
    ```sh
    $> pre-commit install
    $> pre-commit install-hooks
    ```

    Run pre-commit hook
    ```sh
    $> pre-commit run -a

    check for merge conflicts................................................Passed
    trim trailing whitespace.................................................Passed
    fix end of files.........................................................Passed
    check for added large files..............................................Passed
    detect private key.......................................................Passed
    mkdocs-buid..............................................................Passed
    ```

## Resources

=== "Documentation"
    - [Pre-Commit Official](https://pre-commit.com)
    - [Pre-Commit Git Repo](https://github.com/pre-commit)
    - [Awesome Git Hooks](https://github.com/aitemr/awesome-git-hooks)

---

[Back to Git](index.md){ .md-button }
[Back to Tools](../index.md){ .md-button }
[ZSH](../shell/zsh.md){ .md-button .md-button--primary }
