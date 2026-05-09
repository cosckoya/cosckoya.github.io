---
title: Popeye
description: Kubernetes cluster sanitizer - scan resources for misconfigurations, security issues, and best practices violations
---

# :fontawesome-solid-shield-halved: Popeye

Kubernetes cluster sanitizer. Scans your cluster for misconfigurations, security issues, resource waste, and best practice violations. Color-coded report shows what's wrong and why. No cluster changes, just brutal honesty about your K8s setup.

!!! tip "Why Popeye"
    Automated cluster health checks, security scanning, resource optimization, best practice enforcement, CI/CD integration, zero cluster modifications.

---

## :fontawesome-solid-bolt: Quick Start

=== "Installation"

    **macOS:**
    ```bash
    brew install derailed/popeye/popeye
    ```

    **Linux:**
    ```bash
    # Download latest release
    curl -sL https://github.com/derailed/popeye/releases/download/v0.20.1/popeye_Linux_x86_64.tar.gz | tar xz
    sudo mv popeye /usr/local/bin/

    # Make executable
    chmod +x /usr/local/bin/popeye
    ```

    **From source:**
    ```bash
    go install github.com/derailed/popeye@latest
    ```

    **Docker:**
    ```bash
    docker run --rm -it \
      -v ~/.kube/config:/root/.kube/config \
      derailed/popeye
    ```

    **Verify:**
    ```bash
    popeye version
    # Popeye 0.20.1
    ```

=== "Basic Usage"

    **Scan current context:**
    ```bash
    # Full cluster scan
    popeye

    # Specific namespace
    popeye -n production

    # All namespaces
    popeye -A

    # Save report
    popeye -o json > report.json
    popeye -o yaml > report.yaml
    popeye -o html > report.html
    ```

    **Scan specific resources:**
    ```bash
    # Only pods
    popeye --sections po

    # Multiple resource types
    popeye --sections po,svc,dp

    # Available sections:
    # po (pods), svc (services), dp (deployments),
    # sts (statefulsets), ds (daemonsets), pv, pvc,
    # hpa, ns (namespaces), sa (service accounts),
    # cm (configmaps), sec (secrets), ing (ingresses)
    ```

    **Filter by severity:**
    ```bash
    # Only errors and warnings
    popeye --min-severity 2

    # Severity levels:
    # 0: OK
    # 1: Info
    # 2: Warning
    # 3: Error
    ```

=== "Configuration"

    **Config file:** `spinach.yaml` (in current dir or `~/.config/popeye/`)

    ```yaml
    # ============================================
    # POPEYE CONFIGURATION (spinach.yaml)
    # ============================================

    popeye:
      # Exclude namespaces
      excludes:
        namespaces:
          - kube-system
          - kube-public
          - kube-node-lease

      # Resource-specific config
      node:
        limits:
          # Alert if CPU > 80%
          cpu: 80
          # Alert if memory > 80%
          memory: 80

      pod:
        # Check container restart count
        restarts: 5
        # Check for liveness/readiness probes
        checkProbes: true

      # Resource limits
      container:
        # CPU threshold (cores)
        cpuLimit: 0.5
        # Memory threshold (MB)
        memLimit: 100

      # Custom exclusions
      excludes:
        pods:
          # Exclude by name pattern
          - rx: "^some-legacy-.*"
        services:
          - name: "legacy-service"
            namespace: "production"

      # Codes to skip (see output for codes)
      codes:
        # Skip specific check codes
        - 100  # Image pull policy
        - 101  # Latest image tag
    ```

---

## :fontawesome-solid-shield-halved: Check Categories

### Security Issues

```
- Containers running as root
- Privileged containers
- Host network/PID/IPC usage
- Unnecessary capabilities
- No security context
- Latest image tags (unpinned versions)
- Missing resource limits (CPU/memory)
- Secrets in environment variables
- Service accounts with excessive permissions
```

### Resource Management

```
- No resource requests/limits
- Over-allocated resources
- Under-utilized resources
- PVC not bound
- Unused ConfigMaps/Secrets
- Orphaned resources
- Node resource exhaustion
```

### Best Practices

```
- Missing liveness/readiness probes
- Image pull policy not set
- Multiple containers per pod (anti-pattern)
- Deprecated API versions
- Missing labels
- Empty namespaces
- Service selector mismatches
```

### Reliability

```
- Single replica deployments
- No pod disruption budgets
- No horizontal pod autoscaling
- Restart loops
- Pending pods
- Failed jobs
- Unhealthy endpoints
```

---

## :fontawesome-solid-diagram-project: Common Workflows

### Daily Cluster Health Check

```bash
# Run full scan
popeye -A -o html > reports/cluster-$(date +%Y%m%d).html

# Check specific production namespace
popeye -n production --min-severity 2

# Get summary counts
popeye -n production -o json | jq '.popeye.score'
```

### Pre-Deployment Validation

```bash
# Scan staging before promoting to prod
popeye -n staging --sections dp,po,svc

# Look for:
# - Resource limits set
# - Probes configured
# - No latest tags
# - Proper labels
```

### Security Audit

```bash
# Focus on security issues
popeye --sections po,sa,sec \
       -o yaml \
       | grep -A5 "security\|privilege\|root"

# Check for:
# - Root containers
# - Privileged mode
# - Host namespaces
# - Service account permissions
```

### CI/CD Integration

```bash
# GitLab CI example
k8s-scan:
  stage: validate
  image: derailed/popeye
  script:
    - popeye -n ${CI_ENVIRONMENT_SLUG} -o json > popeye.json
    # Fail if score < 80
    - score=$(cat popeye.json | jq '.popeye.score')
    - if [ $score -lt 80 ]; then exit 1; fi
  artifacts:
    paths:
      - popeye.json
    expire_in: 30 days

# GitHub Actions example
- name: Popeye Scan
  uses: azure/k8s-deploy@v1
  with:
    manifests: |
      deployment.yaml

- name: Run Popeye
  run: |
    popeye -o json > popeye-report.json
    # Parse and fail if issues found
```

---

## :fontawesome-solid-terminal: Output Format

**Terminal output (default):**
```
 ___     ___ _____   _____                       ___
| _ \___| _ \ __\ \ / / __|   Biffs`em and Buffs`em!
|  _/ _ \  _/ _| \ V /| _|    Cluster sanitizer
|_| \___/_| |___| |_| |___|   0.20.1

CLUSTER SCORE: 78/100

NAMESPACES (1 SCANNED)                          💥 0  😱 2  🔊 5  ✅ 120  💯 100
 · production                                   💥 0  😱 2  🔊 5  ✅ 120

PODS (25 SCANNED)                               💥 1  😱 4  🔊 8  ✅ 50   💯 75
 · production/api-d7b8f9c-x4j2k
   💥 [POP-106] No liveness probe specified
   😱 [POP-300] Unmanaged pod. ResourceQuota found but no requests/limits
   🔊 [POP-101] Image tagged "latest"

DEPLOYMENTS (10 SCANNED)                        💥 0  😱 2  🔊 3  ✅ 15   💯 80
 · production/api
   😱 [POP-403] At current load, memory is over allocated. Current:400Mi vs Requested:200Mi
   🔊 [POP-501] No resource limits specified

Legend:
💥 Critical  😱 Error  🔊 Warning  ✅ OK  💯 Score
```

**JSON output:**
```json
{
  "popeye": {
    "score": 78,
    "grade": "C",
    "sanitizers": {
      "pods": {
        "production/api-d7b8f9c-x4j2k": {
          "issues": [
            {
              "group": "general",
              "level": 3,
              "message": "[POP-106] No liveness probe",
              "code": 106
            }
          ]
        }
      }
    }
  }
}
```

---

## :fontawesome-solid-gear: Configuration Examples

### Production Configuration

```yaml
# spinach.yaml for production
popeye:
  # Strict limits for prod
  node:
    limits:
      cpu: 70
      memory: 70

  pod:
    restarts: 3
    checkProbes: true

  container:
    cpuLimit: 2
    memLimit: 2048

  # Don't scan system namespaces
  excludes:
    namespaces:
      - kube-system
      - kube-public
      - kube-node-lease
      - monitoring
      - logging

  # Allow some violations for legacy apps
  codes:
    - 101  # Latest tag (for specific legacy apps)
```

### Development Configuration

```yaml
# spinach-dev.yaml for development
popeye:
  # Relaxed limits for dev
  node:
    limits:
      cpu: 90
      memory: 90

  # Skip some checks in dev
  codes:
    - 100  # Image pull policy
    - 101  # Latest tags (common in dev)
    - 300  # Resource limits (not critical in dev)

  # Only scan dev namespaces
  excludes:
    namespaces:
      - kube-system
      - production
      - staging
```

---

## :fontawesome-solid-lightbulb: Pro Tips

- **Run regularly** - Schedule daily scans in CI/CD
- **Track scores over time** - Monitor cluster health trends
- **Fix high-severity first** - Critical > Error > Warning
- **Use custom config** - Exclude known false positives
- **Generate HTML reports** - Share with team/stakeholders
- **Set score thresholds** - Fail CI if score drops below 80
- **Scan before deploy** - Catch issues in staging
- **Check deprecations** - API version warnings before upgrades
- **Resource right-sizing** - Use utilization data to set limits
- **Security focus** - Fix root containers and privileged mode first

---

## :fontawesome-solid-triangle-exclamation: Common Issues & Fixes

**No liveness probe (POP-106):**
```yaml
# Add to deployment
spec:
  template:
    spec:
      containers:
      - name: app
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
```

**Latest image tag (POP-101):**
```yaml
# Use specific version
spec:
  template:
    spec:
      containers:
      - name: app
        image: myapp:1.2.3  # Not :latest
```

**No resource limits (POP-300):**
```yaml
# Set requests and limits
spec:
  template:
    spec:
      containers:
      - name: app
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "256Mi"
            cpu: "200m"
```

**Running as root (POP-500):**
```yaml
# Add security context
spec:
  template:
    spec:
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
      containers:
      - name: app
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
              - ALL
```

---

## :fontawesome-solid-list-check: Pre-Production Checklist

```bash
# Run comprehensive check
popeye -n production -o yaml > audit.yaml

# Verify:
□ No critical (💥) issues
□ < 5 errors (😱)
□ Resource limits set on all containers
□ Liveness/readiness probes configured
□ No containers running as root
□ No privileged containers
□ Image tags pinned (no :latest)
□ Service selectors match deployments
□ PVCs bound
□ No deprecated APIs
□ Cluster score > 80
```

---

## :fontawesome-solid-link: Resources

**Official:**
- **[GitHub](https://github.com/derailed/popeye)** - Source code
- **[Documentation](https://popeyecli.io/)** - Official docs
- **[Releases](https://github.com/derailed/popeye/releases)** - Download

**Kubernetes Best Practices:**
- **[K8s Security](https://kubernetes.io/docs/concepts/security/)** - Security documentation
- **[Resource Management](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)** - Resource guide
- **[Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)** - Security standards

**Alternatives:**
- **[kube-score](https://github.com/zegl/kube-score)** - Static analysis
- **[polaris](https://github.com/FairwindsOps/polaris)** - Policy enforcement
- **[kubesec](https://github.com/controlplaneio/kubesec)** - Security scanner
- **[kube-bench](https://github.com/aquasecurity/kube-bench)** - CIS benchmark

**Communities:**
- **[K8s Slack](https://kubernetes.slack.com/)** - #popeye channel
- **[GitHub Discussions](https://github.com/derailed/popeye/discussions)** - Q&A

---

**Last Updated:** 2026-02-03

**Tags:** popeye, kubernetes, k8s, cluster-scanner, security, best-practices, ci-cd, devops
