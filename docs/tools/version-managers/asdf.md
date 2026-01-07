---
title: ASDF - Version Manager
description: Versatile version manager for managing multiple runtime versions
tags:
  - asdf
  - version-manager
  - runtime
---

# ASDF

ASDF is a versatile version manager for managing multiple runtime versions of different languages. It supports a wide range of programming languages and tools, enabling seamless switching between different versions for development projects. ASDF's plugin architecture allows easy extension, making it a flexible tool for developers.

## Quick Start

??? example "ASDF Command line basics"
    ASDF UPDATE
    ```bash
    $> asdf update --head
    ```

    LIST PLUGIN
    ```bash
    $> asdf plugin list all
    ```

    ADD PLUGIN
    ```bash
    $> asdf plugin add <plugin_name>
    ```

    LIST PLUGIN VERSIONS
    ```bash
    $> asdf list all <plugin_name>
    ```

    INSTALL PLUGIN
    ```bash
    # Install latest plugin version
    $> asdf install <plugin_name>

    # Install a selected plugin version
    $> asdf install <plugin_name> <plugin_version>
    ```

    SETUP A PLUGIN VERSION
    ```bash
    $> asdf global <plugin_name> <plugin_version> # Set the package global version
    $> asdf local <plugin_name> <plugin_version>  # Set the package local version
    $> asdf shell <plugin_name> <plugin_version>  # Set the package in the current shell
    ```

## Resources

=== "Documentation"
    - [ASDF](https://asdf-vm.com)

---

[Back to Tools](../index.md){ .md-button }
[Git](../git/index.md){ .md-button }
[NeoVim](../editors/neovim.md){ .md-button .md-button--primary }
