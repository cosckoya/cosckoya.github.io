---
title: kubectx & kubens
description: Fast Kubernetes context and namespace switching - saves typing, improves workflow, essential productivity tool
---

# :fontawesome-solid-rotate: kubectx & kubens

Fast switching between Kubernetes contexts and namespaces. Two tools in one: kubectx switches clusters, kubens switches namespaces. Saves massive amounts of typing. Interactive mode with fzf. Essential for multi-cluster workflows.

!!! tip "2026 Update"
    Both tools now support JSON output for scripting. Tab completion improved for all shells. Supports kubeconfig with multiple contexts. Integration with Starship prompt. Maintained by Ahmet Alp Balkan (Google).

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # Installation
    brew install kubectx                   # macOS (includes kubens)
    # Or: sudo apt install kubectx kubens  # Debian/Ubuntu
    # Manual: https://github.com/ahmetb/kubectx

    # kubectx - Switch clusters
    kubectx                                # List all contexts  # (1)!
    kubectx dev-cluster                    # Switch to dev-cluster
    kubectx -                              # Switch to previous context  # (2)!
    kubectx -c                             # Show current context
    kubectx new-name=old-name              # Rename context  # (3)!
    kubectx -d dev-cluster                 # Delete context

    # kubectx with fzf (interactive)
    kubectx                                # Opens fuzzy finder  # (4)!
    # Use arrow keys, type to filter, Enter to select

    # kubens - Switch namespaces
    kubens                                 # List all namespaces  # (5)!
    kubens production                      # Switch to production namespace
    kubens -                               # Switch to previous namespace
    kubens -c                              # Show current namespace
    kubens default                         # Switch back to default

    # kubens with fzf (interactive)
    kubens                                 # Opens fuzzy finder
    # Type to search, Enter to switch

    # Combined workflow examples
    kubectx prod-cluster && kubens production  # (6)!
    kubectx staging && kubens default

    # Shell aliases (add to .bashrc/.zshrc)
    alias kctx='kubectx'                   # (7)!
    alias kns='kubens'
    alias k='kubectl'
    ```

    1. Shows list with current context highlighted
    2. `-` switches to previous (like `cd -` in bash)
    3. Rename context for easier reference (saves editing kubeconfig)
    4. If fzf installed, provides interactive fuzzy search
    5. Only shows namespaces in current context
    6. Chain with `&&` to switch cluster and namespace together
    7. Common aliases to save even more typing

    **Real talk:**

    - Saves hours of typing `kubectl config use-context`
    - Interactive mode with fzf is game-changing
    - Previous context (`-`) is underrated lifesaver
    - Renaming contexts makes multi-cluster work sane
    - Works with any kubectl-compatible tool (k9s, lens, etc.)

=== ":fontawesome-solid-bolt: Common Patterns"

    ```bash
    # Multi-cluster workflow
    # Check production
    kubectx production
    kubens monitoring
    kubectl get pods
    kubectl logs -f prometheus-0

    # Quick check dev
    kubectx dev
    kubectl get deployments

    # Back to production
    kubectx -  # Returns to production

    # Dev workflow with namespace switching
    kubectx minikube
    kubens development
    kubectl apply -f app.yaml

    kubens testing
    kubectl apply -f app.yaml

    kubens -  # Back to development

    # Scripting with kubectx/kubens
    #!/bin/bash
    # Save current context
    ORIGINAL_CTX=$(kubectx -c)
    ORIGINAL_NS=$(kubens -c)

    # Do work in different cluster/namespace
    kubectx prod-cluster
    kubens production
    kubectl apply -f deployment.yaml

    # Restore original context
    kubectx "$ORIGINAL_CTX"
    kubens "$ORIGINAL_NS"
    ```

    ```bash
    # Shell prompt integration
    # Add to .bashrc or .zshrc
    parse_kube_context() {
      kubectx -c 2>/dev/null || echo "none"
    }

    parse_kube_namespace() {
      kubens -c 2>/dev/null || echo "none"
    }

    # Bash PS1
    export PS1='[\u@\h \W $(parse_kube_context):$(parse_kube_namespace)]\$ '

    # Or use Starship prompt (better):
    # https://starship.rs/config/#kubernetes
    # Shows context and namespace automatically
    ```

    ```bash
    # fzf integration for advanced filtering
    # Requires fzf: brew install fzf

    # kubectx automatically uses fzf if installed
    kubectx  # Interactive fuzzy search

    # Filter contexts by pattern
    kubectx | grep prod  # Show only prod contexts

    # Switch to context matching pattern (no fzf)
    kubectx $(kubectx | grep -i prod | head -1)

    # Custom fzf options
    export FZF_DEFAULT_OPTS="--height 40% --reverse"
    kubectx  # Uses custom fzf layout
    ```

    ```yaml
    # Kubeconfig organization for kubectx
    # ~/.kube/config (multi-cluster setup)
    apiVersion: v1
    kind: Config
    current-context: dev-cluster  # (1)!

    clusters:
      - name: dev-cluster
        cluster:
          server: https://dev.example.com:6443

      - name: staging-cluster
        cluster:
          server: https://staging.example.com:6443

      - name: prod-cluster
        cluster:
          server: https://prod.example.com:6443

    contexts:
      - name: dev-cluster  # (2)!
        context:
          cluster: dev-cluster
          user: dev-user
          namespace: default  # (3)!

      - name: staging  # (4)!
        context:
          cluster: staging-cluster
          user: staging-user
          namespace: default

      - name: prod
        context:
          cluster: prod-cluster
          user: prod-user
          namespace: production  # (5)!

    users:
      - name: dev-user
        user:
          token: <token>

      - name: staging-user
        user:
          client-certificate-data: <cert>
          client-key-data: <key>

      - name: prod-user
        user:
          exec:  # (6)!
            apiVersion: client.authentication.k8s.io/v1beta1
            command: aws
            args:
              - eks
              - get-token
              - --cluster-name
              - prod-cluster
    ```

    1. Current context used by kubectl
    2. Context name shown in `kubectx` list
    3. Default namespace for this context
    4. Short, memorable context names (rename with `kubectx`)
    5. Can set default namespace per context
    6. Dynamic token via exec (AWS EKS example)

    **Why this works:**

    - Context switching takes <1 second (vs 5+ seconds typing)
    - Previous context (`-`) enables rapid toggling
    - Interactive mode prevents typos
    - Shell integration shows current context/namespace
    - Works with any number of clusters/namespaces

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Install fzf** - Makes kubectx/kubens interactive (essential)
        - **Rename contexts** - Use `kubectx short=long-cluster-name-production`
        - **Aliases** - `kctx` and `kns` save typing
        - **Prompt integration** - Show current context/namespace in shell
        - **Starship prompt** - Better than manual PS1 configuration
        - **Previous context** - Use `-` frequently (faster than typing name)
        - **Namespace defaults** - Set default namespace per context in kubeconfig

    !!! warning "Security"
        - **Production contexts** - Rename with `prod-` prefix for visibility
        - **Namespace matters** - Always verify namespace before applying
        - **Prompt indicators** - Visual cues prevent production accidents
        - **Separate kubeconfigs** - Use `KUBECONFIG` env var for isolation
        - **Context validation** - Add pre-flight checks in scripts

    !!! tip "Productivity"
        - **Muscle memory** - `kubectx -` and `kubens -` become instinctive
        - **Tab completion** - Works in bash, zsh, fish
        - **k9s integration** - k9s respects kubectx/kubens changes
        - **Lens integration** - Context switching syncs with Lens IDE
        - **IDE plugins** - VS Code Kubernetes extension shows current context

    !!! danger "Gotchas"
        - **No kubectl** - kubectx/kubens are wrappers, need kubectl installed
        - **Context != namespace** - Switching context doesn't change namespace
        - **Default namespace** - Defined in kubeconfig, not always `default`
        - **Multiple kubeconfigs** - KUBECONFIG env var with `:` separator
        - **Prompt lag** - Parsing context/ns in prompt can slow shell (use cache)
        - **Renamed contexts** - Renames only local, not in cluster
        - **fzf required** - Interactive mode needs fzf installed separately

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning Resources

### :fontawesome-solid-book-open: Official Docs

- **[kubectx GitHub](https://github.com/ahmetb/kubectx)** - Source and documentation
- **[fzf GitHub](https://github.com/junegunn/fzf)** - Fuzzy finder (recommended)
- **[Starship Prompt](https://starship.rs/config/#kubernetes)** - Modern prompt with k8s support

### :fontawesome-solid-rocket: Key Features

- **Fast context switching** - Sub-second cluster changes
- **Fast namespace switching** - Sub-second namespace changes
- **Previous context/namespace** - Toggle with `-`
- **Interactive mode** - Fuzzy search with fzf
- **Context renaming** - Simplify long context names
- **Shell completion** - Tab completion for bash/zsh/fish

______________________________________________________________________

## :fontawesome-solid-star: Alternatives & Related Tools

- **[kubie](https://github.com/sbstp/kubie)** - Context switching with shell isolation
- **[k9s](https://k9scli.io/)** - Terminal UI with built-in context/namespace switching
- **[Lens](https://k8slens.dev/)** - Desktop IDE with visual context switching
- **[kubectl ctx/ns plugins](https://github.com/kubernetes-sigs/krew)** - Native kubectl plugins

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-bolt: **Essential Tool** - Must-have for anyone managing multiple clusters. Saves hours every week. Interactive mode with fzf is perfect. Zero learning curve. Install immediately.

**Tags:** kubectx, kubernetes, productivity, cli, kubectl
