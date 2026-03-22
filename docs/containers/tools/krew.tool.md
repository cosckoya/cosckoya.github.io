---
title: Krew
description: kubectl plugin manager - extend kubectl with 200+ community plugins for better cluster management
---

# :fontawesome-solid-plug: Krew

kubectl plugin manager. 200+ community plugins extend kubectl with features the official binary doesn't have. Debug pods, view resources visually, manage contexts, scan security issues, and more. One plugin manager, endless possibilities.

!!! tip "Why Krew"
    Extend kubectl without rebuilding, community-maintained tools, easy install/update, fill gaps in official kubectl functionality, plugin ecosystem with 200+ tools.

---

## :fontawesome-solid-bolt: Quick Start

=== "Install Krew"

    **macOS/Linux:**
    ```bash
    (
      set -x; cd "$(mktemp -d)" &&
      OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
      ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
      KREW="krew-${OS}_${ARCH}" &&
      curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
      tar zxvf "${KREW}.tar.gz" &&
      ./"${KREW}" install krew
    )
    ```

    **Add to PATH (add to .zshrc or .bashrc):**
    ```bash
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
    ```

    **Verify:**
    ```bash
    kubectl krew version
    # GitTag:    v0.4.4
    # GitCommit: d8c4221
    ```

=== "Basic Usage"

    **Plugin management:**
    ```bash
    # List available plugins
    kubectl krew search

    # Search for specific plugin
    kubectl krew search logs

    # Install plugin
    kubectl krew install ctx      # Context switcher
    kubectl krew install ns       # Namespace switcher
    kubectl krew install tree     # Resource hierarchy viewer

    # List installed plugins
    kubectl krew list

    # Update all plugins
    kubectl krew update
    kubectl krew upgrade

    # Uninstall plugin
    kubectl krew uninstall tree

    # Get plugin info
    kubectl krew info ctx
    ```

    **Use plugins:**
    ```bash
    # After installing, use like native kubectl commands
    kubectl ctx                   # Switch context
    kubectl ns production         # Switch namespace
    kubectl tree deploy/api       # Show resource tree
    ```

=== "Essential Plugins"

    **Install recommended set:**
    ```bash
    # Context/namespace management
    kubectl krew install ctx ns

    # Resource viewing
    kubectl krew install tree get-all resource-capacity

    # Debugging
    kubectl krew install debug stern tail

    # Node management
    kubectl krew install node-shell sick-pods

    # Security
    kubectl krew install rbac-tool who-can access-matrix

    # Utilities
    kubectl krew install neat view-secret images
    ```

---

## :fontawesome-solid-box: Essential Plugins

### Context & Namespace Management

```bash
# ctx - Context switcher (like kubectx)
kubectl krew install ctx
kubectl ctx                      # List contexts
kubectl ctx staging              # Switch context
kubectl ctx -                    # Previous context

# ns - Namespace switcher (like kubens)
kubectl krew install ns
kubectl ns                       # List namespaces
kubectl ns production            # Switch namespace
kubectl ns -                     # Previous namespace
```

### Resource Viewing

```bash
# tree - Show resource hierarchy
kubectl krew install tree
kubectl tree deployment/nginx    # Show all related resources
kubectl tree pod/api-x7k9s       # Pod with owner chain

# get-all - Get ALL resources (including CRDs)
kubectl krew install get-all
kubectl get-all -n production    # Everything in namespace

# resource-capacity - Node resource usage
kubectl krew install resource-capacity
kubectl resource-capacity        # CPU/Memory per node
kubectl resource-capacity --pods # Per-pod breakdown

# images - List container images
kubectl krew install images
kubectl images                   # All images in cluster
kubectl images -n production     # Images in namespace
```

### Debugging & Logs

```bash
# debug - Debug running pods
kubectl krew install debug
kubectl debug pod/api-x7k9s      # Ephemeral debug container
kubectl debug node/worker-01     # Debug node

# stern - Multi-pod log tailing
kubectl krew install stern
stern api                        # Tail all pods matching "api"
stern api --since 5m             # Last 5 minutes
stern api -n production          # Specific namespace

# tail - Enhanced log viewer
kubectl krew install tail
kubectl tail -l app=api          # Follow by label
kubectl tail -p api-x7k9s        # Follow specific pod
```

### Node Management

```bash
# node-shell - SSH into nodes
kubectl krew install node-shell
kubectl node-shell worker-01     # Get shell on node

# sick-pods - Find unhealthy pods
kubectl krew install sick-pods
kubectl sick-pods                # Show failing/pending pods
kubectl sick-pods -n production

# ssh-jump - SSH via jump pod
kubectl krew install ssh-jump
kubectl ssh-jump worker-01       # SSH through bastion pod
```

### Security & RBAC

```bash
# rbac-tool - RBAC visualization
kubectl krew install rbac-tool
kubectl rbac-tool lookup         # Who can do what
kubectl rbac-tool viz            # Generate RBAC diagram

# who-can - Check permissions
kubectl krew install who-can
kubectl who-can get pods         # Who can get pods
kubectl who-can delete deploy    # Who can delete deployments

# access-matrix - Permission matrix
kubectl krew install access-matrix
kubectl access-matrix            # Show all permissions
kubectl access-matrix -n prod    # Namespace-specific

# cert-manager - Certificate info
kubectl krew install cert-manager
kubectl cert-manager status      # Certificate status
kubectl cert-manager renew       # Renew certificates
```

### Cleanup & Maintenance

```bash
# neat - Clean output (remove clutter)
kubectl krew install neat
kubectl get pod api-x7k9s -o yaml | kubectl neat
# Removes: managedFields, status, etc.

# prune-unused - Remove unused resources
kubectl krew install prune-unused
kubectl prune-unused configmaps  # Find unused ConfigMaps
kubectl prune-unused secrets     # Find unused Secrets

# outdated - Find outdated images
kubectl krew install outdated
kubectl outdated                 # Show images with updates

# deprecations - Check API deprecations
kubectl krew install deprecations
kubectl deprecations             # Find deprecated APIs
```

### Utilities

```bash
# view-secret - Decode secrets
kubectl krew install view-secret
kubectl view-secret db-password  # Decode secret values
kubectl view-secret db-password -a  # All keys

# modify-secret - Edit secrets
kubectl krew install modify-secret
kubectl modify-secret db-password  # Edit decoded values

# sniff - Packet capture
kubectl krew install sniff
kubectl sniff api-x7k9s          # tcpdump pod traffic

# graph - Visualize dependencies
kubectl krew install graph
kubectl graph deployments        # Generate dependency graph
```

---

## :fontawesome-solid-diagram-project: Common Workflows

### Daily Operations

```bash
# Quick context/namespace switch
kubectl ctx production
kubectl ns api-team

# View all resources in namespace
kubectl get-all

# Check resource capacity
kubectl resource-capacity --pods

# Tail logs from multiple pods
stern api --since 15m

# Find unhealthy pods
kubectl sick-pods
```

### Debugging Issues

```bash
# 1. Check pod status
kubectl sick-pods

# 2. View resource tree
kubectl tree deployment/api

# 3. Check logs from all replicas
stern api -t --since 10m

# 4. Debug running pod
kubectl debug pod/api-x7k9s --image=busybox

# 5. Check node if needed
kubectl node-shell worker-01
```

### Security Audit

```bash
# Check who can do dangerous operations
kubectl who-can delete pods
kubectl who-can delete deployments
kubectl who-can create secrets

# View complete access matrix
kubectl access-matrix -n production

# Visualize RBAC
kubectl rbac-tool viz > rbac-diagram.html

# Check for security issues
kubectl rbac-tool lookup
```

### Resource Cleanup

```bash
# Find unused ConfigMaps
kubectl prune-unused configmaps

# Find unused Secrets
kubectl prune-unused secrets

# Check for outdated images
kubectl outdated

# Find deprecated API usage
kubectl deprecations
```

---

## :fontawesome-solid-terminal: Advanced Plugins

### Development & Testing

```bash
# konfig - Merge kubeconfig files
kubectl krew install konfig
kubectl konfig merge config1 config2

# ktop - Top alternative
kubectl krew install ktop
kubectl ktop                     # Interactive top

# lineage - Resource relationships
kubectl krew install lineage
kubectl lineage pod api-x7k9s    # Show all related resources

# relay - Port forward manager
kubectl krew install relay
kubectl relay list               # Active forwards
kubectl relay start api 8080:80  # Create forward
```

### GitOps & Helm

```bash
# helm-diff - Preview Helm changes
kubectl krew install helm
kubectl helm diff upgrade myapp ./chart

# kustomize - Kustomize support
kubectl krew install kustomize
kubectl kustomize build overlays/prod
```

### Cluster Operations

```bash
# df-pv - PV disk usage
kubectl krew install df-pv
kubectl df-pv                    # Show PV usage

# score - Resource scoring
kubectl krew install score
kubectl score deployment/api     # Security/reliability score

# cost - Cost estimation
kubectl krew install cost
kubectl cost                     # Cluster cost breakdown
```

---

## :fontawesome-solid-lightbulb: Pro Tips

- **Install Krew first** - It's the plugin manager for all others
- **Update regularly** - `kubectl krew update && kubectl krew upgrade`
- **Combine with native kubectl** - Plugins extend, not replace
- **Use stern for logs** - Better than `kubectl logs` for multiple pods
- **tree shows dependencies** - Understand resource relationships
- **neat cleans output** - Remove clutter for better diffs
- **who-can for RBAC** - Quick permission checks
- **node-shell for debugging** - Access nodes without SSH
- **Check plugin index** - New plugins added frequently
- **Custom plugins possible** - Write your own in any language

---

## :fontawesome-solid-triangle-exclamation: Common Gotchas

- **PATH not updated** - Add `$HOME/.krew/bin` to PATH
- **Krew not in kubectl plugins** - Krew manages plugins, not a plugin itself
- **Plugin name conflicts** - Some plugins duplicate kubectl functionality
- **Version compatibility** - Check plugin supports your K8s version
- **Slow plugin install** - Downloads binaries, can take time
- **Missing dependencies** - Some plugins need other tools (git, helm)
- **Permission issues** - Ensure `~/.krew` is writable
- **Plugins not showing** - Run `kubectl plugin list` to verify
- **Update krew itself** - `kubectl krew upgrade krew`
- **Custom plugins** - Must be in PATH with `kubectl-` prefix

---

## :fontawesome-solid-code: Custom Plugin Example

**Create custom plugin (`kubectl-hello`):**

```bash
#!/bin/bash
# Save as kubectl-hello in PATH
# Make executable: chmod +x kubectl-hello

echo "Hello from custom kubectl plugin!"
echo "Context: $(kubectl config current-context)"
echo "Namespace: $(kubectl config view --minify -o jsonpath='{..namespace}')"
```

**Use it:**
```bash
kubectl hello
# Hello from custom kubectl plugin!
# Context: production
# Namespace: default
```

**Any executable with `kubectl-` prefix works as plugin!**

---

## :fontawesome-solid-book: Plugin Development

**Plugin requirements:**
- Executable file named `kubectl-<plugin-name>`
- In PATH
- Any language (bash, python, go, etc.)
- Returns 0 on success

**Example in Python:**
```python
#!/usr/bin/env python3
# kubectl-count-pods

import subprocess
import json

result = subprocess.run(
    ['kubectl', 'get', 'pods', '-o', 'json'],
    capture_output=True,
    text=True
)

data = json.loads(result.stdout)
print(f"Total pods: {len(data['items'])}")
```

**Make it available:**
```bash
chmod +x kubectl-count-pods
mv kubectl-count-pods /usr/local/bin/
kubectl count-pods
```

---

## :fontawesome-solid-link: Resources

**Official:**
- **[Krew](https://krew.sigs.k8s.io/)** - Plugin manager
- **[Plugin Index](https://krew.sigs.k8s.io/plugins/)** - All available plugins
- **[kubectl Plugin Docs](https://kubernetes.io/docs/tasks/extend-kubectl/kubectl-plugins/)** - Official guide

**Popular Plugins:**
- **[stern](https://github.com/stern/stern)** - Multi-pod log tailing
- **[ctx/ns](https://github.com/ahmetb/kubectx)** - Context/namespace switcher
- **[tree](https://github.com/ahmetb/kubectl-tree)** - Resource hierarchy
- **[debug](https://github.com/aylei/kubectl-debug)** - Enhanced debugging

**Plugin Development:**
- **[Sample Plugin](https://github.com/kubernetes/sample-cli-plugin)** - Example
- **[Plugin Guide](https://kubernetes.io/docs/tasks/extend-kubectl/kubectl-plugins/)** - How to write

**Communities:**
- **[K8s Slack](https://kubernetes.slack.com/)** - #kubectl channel
- **[GitHub Discussions](https://github.com/kubernetes-sigs/krew/discussions)** - Krew Q&A

---

**Last Updated:** 2026-02-03

**Tags:** kubectl, kubernetes, k8s, krew, plugins, cli, development-tools, devops
