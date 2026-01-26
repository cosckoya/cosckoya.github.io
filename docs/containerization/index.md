---
title: Container
description: Containers - Docker, Kubernetes, Helm, and the YAML industrial complex. Package once, debug everywhere.
tags:
  - containers
  - docker
  - kubernetes
  - helm
  - container-security
---

# Container

"It works on my machine" is not a deployment strategy. So we invented containers: portable, isolated, reproducible. Then we needed to orchestrate them, so we got Kubernetes. Then we needed to package K8s manifests, so we got Helm. Now we have layers of abstraction on top of abstractions, and somehow it's still better than what we had before.

!!! abstract "What You'll Find Here"
    - Docker fundamentals and best practices
    - Kubernetes orchestration and the YAML mountain
    - Helm for packaging (Go template hell)
    - Container security (because everything is vulnerable)
    - Real-world patterns from production
    - When NOT to use containers

---

## Quick Navigation

<div class="grid cards" markdown>

- 🐳 **[Docker](docker.md)**

    ---

    Build images, run containers, curse at layer caching. The tool that made "works on my machine" mostly obsolete.

- ☸️ **[Kubernetes](kubernetes.md)**

    ---

    Container orchestration at scale. Pods, services, deployments, and 8000 lines of YAML between you and production.

- ⚓ **[Helm](helm.md)**

    ---

    Kubernetes package manager. Charts, templates, values overrides. Go template syntax will make you question your career choices.

- 🔐 **[Container Security](container-security.md)**

    ---

    Image scanning, runtime security, pod policies. Because 60% of images have HIGH/CRITICAL CVEs and that's just Tuesday.

</div>

---

## The Container Stack

```
┌─────────────────────────────────────┐
│  Security (Scanning, Policies)      │
├─────────────────────────────────────┤
│  Helm (Package Management)          │
├─────────────────────────────────────┤
│  Kubernetes (Orchestration)         │
├─────────────────────────────────────┤
│  Container Runtime (containerd)     │
├─────────────────────────────────────┤
│  Docker (Image Building)            │
├─────────────────────────────────────┤
│  Container Images (Layers)          │
├─────────────────────────────────────┤
│  Linux Kernel (Namespaces, cgroups) │
└─────────────────────────────────────┘
```

---

## Learning Path

### Foundation (0-6 months)
1. **Docker basics** - Build images, understand layers, run containers locally
2. **Dockerfile mastery** - Multi-stage builds, optimization, security basics
3. **Docker Compose** - Multi-container apps, networks, volumes
4. **Container concepts** - Namespaces, cgroups, what's actually happening
5. **Registry basics** - Docker Hub, GitHub Container Registry, image tagging

### Intermediate (6-18 months)
1. **Kubernetes fundamentals** - Pods, services, deployments, the core abstractions
2. **kubectl proficiency** - Command-line management, YAML debugging
3. **Helm basics** - Using charts, values overrides, repository management
4. **Persistent storage** - Volumes, StatefulSets, when stateful meets stateless
5. **Security scanning** - Trivy, Grype, fixing CVEs before they bite you

### Advanced (18+ months)
1. **Kubernetes architecture** - Control plane, etcd, scheduler, the guts
2. **Custom resources** - CRDs, operators, extending Kubernetes
3. **Multi-cluster** - Federation, service mesh, the real complexity
4. **Advanced Helm** - Chart development, templating mastery, CI/CD integration
5. **Runtime security** - Falco, admission controllers, zero-trust networking

---

## Container vs VM Comparison

| Aspect | Containers | Virtual Machines | Reality |
|--------|-----------|------------------|---------|
| **Size** | MB | GB | Containers win on disk space |
| **Startup** | Seconds | Minutes | Containers win on speed |
| **Isolation** | Process-level | Hardware-level | VMs win on security |
| **Overhead** | Low (~1-2% CPU) | High (~5-15% CPU) | Containers win on efficiency |
| **Portability** | High | Medium | Containers win, mostly |
| **Density** | 100s per host | 10s per host | Containers win on utilization |
| **Debugging** | Pain | More pain | Both lose on simplicity |
| **State** | Ephemeral | Persistent | Depends on your storage strategy |

---

## Tool Ecosystem

| Category | Standard | Alternative | When to Use |
|----------|----------|-------------|-------------|
| **Container Runtime** | containerd | CRI-O, Docker | containerd is K8s default, Docker for dev |
| **Orchestrator** | Kubernetes | Docker Swarm, Nomad | K8s for production, Swarm is dead, Nomad for simplicity |
| **Package Manager** | Helm | Kustomize | Helm for complex apps, Kustomize for simple overlays |
| **Registry** | GitHub CR | Docker Hub, Harbor | GitHub CR is free and fast, Harbor for self-hosted |
| **Scanner** | Trivy | Grype, Snyk | Trivy is fast and free, Snyk if you have budget |
| **Local Dev** | Docker Desktop | Podman, Rancher Desktop | Docker Desktop costs money now, Podman is daemonless |
| **K8s Distribution** | K3s | MicroK8s, Kind | K3s for edge, Kind for local testing |

---

## Related Sections

!!! info "Expand Your Skills"
    - **[DevOps](../devops/)** - CI/CD for containers, GitOps, building and deploying
    - **[Cloud](../cloud/)** - EKS, AKS, GKE - where your containers actually run
    - **[Security](../security/)** - Container escape techniques, security testing
    - **[Tools](../tools/)** - Container management and debugging tools

---

## Community & Resources

### 🐦 Follow These
- **r/docker** - 170k+ members, "why won't this build" support group
- **r/kubernetes** - 180k+ members, YAML therapy sessions
- **CNCF Slack** - #kubernetes, #helm, #falco channels
- **Kubernetes Forum** - Official discussions and troubleshooting

### 📚 Essential Reading
- **Docker Deep Dive** - Nigel Poulton (best Docker book, period)
- **Kubernetes Up & Running** - Kelsey Hightower (K8s bible)
- **Kubernetes Patterns** - Design patterns that actually work
- **Cloud Native DevOps with Kubernetes** - O'Reilly practical guide

### 🎙️ Podcasts & Newsletters
- **Kubernetes Podcast** - Weekly K8s news from Google
- **Cloud Native News** - CNCF updates and ecosystem
- **Docker Blog** - Official updates and best practices
- **KubeWeekly** - Newsletter, curated K8s content

### 🎓 Certifications Worth It
- **CKA (Kubernetes Administrator)** ($395) - Hands-on, highly respected, worth it
- **CKAD (Kubernetes Developer)** ($395) - Developer-focused, also worth it
- **CKS (Kubernetes Security)** ($395) - Security-focused, worth it for security roles
- **Docker Certified Associate** ($195) - Good for Docker-heavy roles
- **Skip**: Most cloud provider K8s certs unless employer pays

---

## Best Practices

!!! success "Core Principles"
    1. **Small images** - Alpine base, multi-stage builds, minimize attack surface
    2. **Non-root user** - Never run containers as root, it's 2026 for fuck's sake
    3. **Specific tags** - Pin versions, avoid 'latest', reproducibility matters
    4. **Health checks** - Liveness and readiness probes, let K8s help you
    5. **Resource limits** - Set CPU/memory limits always, prevent noisy neighbors
    6. **Secrets management** - External Secrets, Sealed Secrets, not ConfigMaps
    7. **Immutable images** - Build once, deploy everywhere, no SSH into containers
    8. **Security scanning** - Scan in CI, fix CVEs before production
    9. **Network policies** - Default deny, explicit allow, defense in depth
    10. **Monitoring** - Logs to stdout, metrics to Prometheus, traces to Jaeger

---

## Common Patterns

### Docker Multi-Stage Build
```dockerfile
# Build stage
FROM golang:1.21 AS builder
WORKDIR /app
COPY go.* ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o main

# Runtime stage
FROM gcr.io/distroless/static-debian11
COPY --from=builder /app/main /
USER nobody
ENTRYPOINT ["/main"]
```

### Kubernetes Deployment Pattern
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: app
        image: myapp:v1.2.3
        ports:
        - containerPort: 8080
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
        readinessProbe:
          httpGet:
            path: /ready
            port: 8080
```

### Helm Values Pattern
```yaml
# values.yaml
replicaCount: 3
image:
  repository: myapp
  tag: v1.2.3
  pullPolicy: IfNotPresent
resources:
  limits:
    cpu: 500m
    memory: 512Mi
  requests:
    cpu: 100m
    memory: 128Mi
ingress:
  enabled: true
  host: myapp.example.com
```

---

**Last Updated:** 2026-01-14
**Vibe Check:** 🌍 **Mainstream** - Containers are the standard. Docker for dev, Kubernetes for prod. Everyone's running containers, not everyone's doing it well. YAML fatigue is real but alternatives are worse. Security is still everyone's weakest link. The complexity is worth it, barely.
