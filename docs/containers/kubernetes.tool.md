---
title: Kubernetes
description: Container orchestration platform - auto-scaling, self-healing, rolling updates, complexity at scale
---

# :octicons-cpu-16: Kubernetes (K8s)

Container orchestration platform that manages Docker/containerd containers at scale. Auto-scaling, self-healing, rolling updates, service discovery. Overkill for small projects, essential for large deployments. Steep learning curve but industry standard. YAML hell is real.

!!! tip "2026 Update"
    Kubernetes 1.31+ is stable and feature-complete. Gateway API replaces Ingress (finally). Sidecars are native (no more init container hacks). kubectl plugins ecosystem is mature. Managed K8s (EKS, GKE, AKS) handles complexity - use them unless you enjoy pain.

______________________________________________________________________

## :octicons-zap-16: Quick Hits

=== ":octicons-checklist-16: Essential Commands"

    ```bash
    # Cluster info
    kubectl cluster-info                # Show cluster endpoints
    kubectl version                     # Client and server version
    kubectl get nodes                   # List cluster nodes

    # Resource management (pods, deployments, services)
    kubectl get pods                    # List pods in current namespace
    kubectl get pods -A                 # List pods in all namespaces
    kubectl get deployments             # List deployments
    kubectl get services                # List services
    kubectl get all                     # Everything in namespace

    # Detailed resource info
    kubectl describe pod pod-name       # Detailed pod information
    kubectl describe node node-name     # Node details (capacity, conditions)
    kubectl logs pod-name               # Pod logs
    kubectl logs -f pod-name            # Follow logs (like tail -f)
    kubectl logs pod-name -c container  # Logs from specific container (multi-container pods)

    # Execution and debugging
    kubectl exec -it pod-name -- bash   # Interactive shell in pod
    kubectl exec pod-name -- ls /app    # Run command in pod
    kubectl port-forward pod-name 8080:80  # Forward local port to pod

    # Apply and manage resources
    kubectl apply -f deployment.yaml    # Create/update resources
    kubectl delete -f deployment.yaml   # Delete resources
    kubectl delete pod pod-name         # Delete specific pod
    kubectl scale deployment app --replicas=3  # Scale deployment

    # Rollouts (deployments)
    kubectl rollout status deployment/app   # Check rollout status
    kubectl rollout history deployment/app  # View rollout history
    kubectl rollout undo deployment/app     # Rollback to previous version
    kubectl rollout restart deployment/app  # Restart all pods

    # Namespace management
    kubectl get namespaces              # List namespaces
    kubectl config set-context --current --namespace=dev  # Switch namespace
    kubectl create namespace staging    # Create namespace

    # Context management (multiple clusters)
    kubectl config get-contexts         # List available contexts
    kubectl config use-context prod     # Switch to prod cluster
    kubectl config current-context      # Show current context
    ```

    **Real talk:**

    - Alias `kubectl` to `k` - you'll type it 1000 times a day
    - Use `kubectl explain pod.spec` to understand any field
    - `kubectl get pods -o wide` shows node placement and IPs
    - `-n namespace` flag works with all commands
    - Learn `kubectl diff -f file.yaml` before applying changes

=== ":octicons-zap-16: Common Patterns"

    ```yaml
    # deployment.yaml - The bread and butter of K8s
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: web-app
      namespace: production
      labels:
        app: web
        tier: frontend
    spec:
      replicas: 3  # (1)!
      selector:
        matchLabels:
          app: web
      strategy:
        type: RollingUpdate  # (2)!
        rollingUpdate:
          maxUnavailable: 1
          maxSurge: 1
      template:
        metadata:
          labels:
            app: web
            tier: frontend
        spec:
          containers:
          - name: web
            image: myregistry/web-app:1.2.3  # (3)!
            imagePullPolicy: IfNotPresent
            ports:
            - containerPort: 8080
              name: http
            env:
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:  # (4)!
                  name: db-credentials
                  key: url
            - name: LOG_LEVEL
              valueFrom:
                configMapKeyRef:  # (5)!
                  name: app-config
                  key: log_level
            resources:  # (6)!
              requests:
                memory: "256Mi"
                cpu: "250m"
              limits:
                memory: "512Mi"
                cpu: "500m"
            livenessProbe:  # (7)!
              httpGet:
                path: /health
                port: 8080
              initialDelaySeconds: 30
              periodSeconds: 10
            readinessProbe:  # (8)!
              httpGet:
                path: /ready
                port: 8080
              initialDelaySeconds: 5
              periodSeconds: 5
          imagePullSecrets:  # (9)!
          - name: registry-credentials
    ```

    1. Number of pod replicas - K8s maintains this count
    2. Rolling update strategy - zero-downtime deployments
    3. Always use specific image tags, never `:latest` in production
    4. Secrets for sensitive data (base64 encoded, not encrypted!)
    5. ConfigMaps for non-sensitive configuration
    6. Resource requests/limits - critical for scheduling and stability
    7. Liveness probe - K8s restarts pod if this fails
    8. Readiness probe - K8s removes pod from service if not ready
    9. Pull images from private registries

    ```yaml
    # service.yaml - Expose deployment with stable IP/DNS
    apiVersion: v1
    kind: Service
    metadata:
      name: web-service
      namespace: production
    spec:
      type: ClusterIP  # (1)!
      selector:
        app: web  # Matches pods with this label
      ports:
      - port: 80        # Service port
        targetPort: 8080  # Container port
        protocol: TCP
        name: http
      sessionAffinity: ClientIP  # (2)!
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: web-external
      namespace: production
    spec:
      type: LoadBalancer  # (3)!
      selector:
        app: web
      ports:
      - port: 80
        targetPort: 8080
    ```

    1. ClusterIP (default) - internal access only, most common
    2. Session affinity - sticky sessions (rarely needed with stateless apps)
    3. LoadBalancer - external access, cloud provider creates LB automatically

    ```yaml
    # ingress.yaml - HTTP routing with SSL/TLS
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: web-ingress
      namespace: production
      annotations:
        cert-manager.io/cluster-issuer: letsencrypt-prod  # (1)!
        nginx.ingress.kubernetes.io/ssl-redirect: "true"
        nginx.ingress.kubernetes.io/rate-limit: "100"  # (2)!
    spec:
      ingressClassName: nginx  # (3)!
      tls:
      - hosts:
        - myapp.example.com
        secretName: myapp-tls  # (4)!
      rules:
      - host: myapp.example.com
        http:
          paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: web-service
                port:
                  number: 80
          - path: /api
            pathType: Prefix
            backend:
              service:
                name: api-service
                port:
                  number: 8080
    ```

    1. Cert-manager auto-provisions Let's Encrypt SSL certificates
    2. Rate limiting via ingress controller annotations
    3. Ingress class selects which controller handles this ingress
    4. TLS secret created by cert-manager automatically

    **Why this works:**

    - Deployments manage ReplicaSets (you rarely touch ReplicaSets directly)
    - Services provide stable networking (pods are ephemeral, IPs change)
    - Resource limits prevent one pod from starving others
    - Health probes enable self-healing
    - Ingress provides HTTP routing + SSL termination at the edge
    - Secrets/ConfigMaps separate config from code

=== ":octicons-flame-16: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Namespaces** - Isolate environments (dev, staging, prod)
        - **Resource limits** - ALWAYS set requests/limits (prevents node overload)
        - **Health probes** - Liveness + readiness on all pods
        - **Rolling updates** - Set maxUnavailable/maxSurge for zero-downtime
        - **Labels** - Use consistent labeling (app, tier, version)
        - **RBAC** - Principle of least privilege for service accounts
        - **Network policies** - Restrict pod-to-pod communication
        - **Pod disruption budgets** - Ensure availability during node drains

    !!! warning "Security Essentials"
        - **Don't run as root** - Set `securityContext.runAsNonRoot: true`
        - **Read-only filesystem** - `securityContext.readOnlyRootFilesystem: true`
        - **Drop capabilities** - Remove unnecessary Linux capabilities
        - **Pod Security Standards** - Enforce restricted profile
        - **Secrets encryption at rest** - Enable in etcd
        - **Image scanning** - Trivy, Snyk, or cloud provider tools
        - **Network policies** - Default deny, explicit allow
        - **RBAC audit** - Regular reviews of who can access what

    !!! tip "Operational Excellence"
        - **Managed K8s** - Use EKS/GKE/AKS (seriously, don't self-host for production)
        - **GitOps** - ArgoCD or Flux for declarative deployments
        - **Monitoring** - Prometheus + Grafana stack (kube-prometheus-stack Helm chart)
        - **Logging** - ELK, Loki, or cloud provider solutions
        - **Autoscaling** - HPA for pods, Cluster Autoscaler for nodes
        - **Cost optimization** - Use spot/preemptible nodes, rightsize resources
        - **Disaster recovery** - Velero for backups, multi-region for HA

    !!! danger "Common Gotchas"
        - **YAML indentation** - Two spaces, not tabs (will haunt you)
        - **Resource limits too low** - OOMKilled pods (check logs with `kubectl describe pod`)
        - **Missing readiness probe** - Pods receive traffic before ready (5xx errors)
        - **No resource requests** - Pods scheduled on overloaded nodes
        - **Secrets in Git** - NEVER commit secrets, use sealed-secrets or external secrets
        - **`:latest` tag** - Image pull behavior is unpredictable, always use specific versions
        - **PersistentVolumes** - Understand storage classes, don't use hostPath in prod
        - **Namespace deletion** - Deletes EVERYTHING in namespace (careful!)
        - **Service selector typos** - Service has no endpoints (check with `kubectl get endpoints`)

    !!! info "Learning Path"
        - **Start with** - Minikube or Docker Desktop K8s (local cluster)
        - **Learn** - Pods, Deployments, Services, Ingress (core concepts)
        - **Then** - ConfigMaps, Secrets, PersistentVolumes
        - **Advanced** - StatefulSets, DaemonSets, Jobs, CronJobs
        - **Production** - RBAC, Network Policies, Pod Security, Monitoring
        - **Optional** - Custom Resource Definitions (CRDs), Operators

______________________________________________________________________

## :octicons-shield-check-16: Tools Ecosystem

Essential tools for working with Kubernetes.

### :octicons-tools-16: CLI Tools

```bash
# kubectl plugins via krew (package manager)
curl -fsSLO https://github.com/kubernetes-sigs/krew/releases/latest/download/krew-linux_amd64.tar.gz
tar zxvf krew-linux_amd64.tar.gz
./krew-linux_amd64 install krew
export PATH="${PATH}:${HOME}/.krew/bin"

# Essential plugins
kubectl krew install ctx        # Switch contexts easily
kubectl krew install ns         # Switch namespaces
kubectl krew install tail       # Tail logs from multiple pods
kubectl krew install tree       # Show resource hierarchy
kubectl krew install neat       # Clean up kubectl output

# Other critical tools
brew install k9s                # Terminal UI for K8s (amazing)
brew install helm               # Package manager for K8s
brew install kubectx            # Context/namespace switcher
brew install stern              # Multi-pod log tailing
brew install dive               # Analyze container images
```

### :octicons-package-16: Popular Tools

| Tool | Purpose | Why Use It |
|------|---------|------------|
| **Helm** | Package manager | Deploy complex apps with one command |
| **k9s** | Terminal UI | Navigate clusters faster than kubectl |
| **Lens** | Desktop GUI | Visual cluster management, beginner-friendly |
| **ArgoCD** | GitOps | Automated deployments from Git |
| **Istio** | Service mesh | Advanced traffic management, observability |
| **cert-manager** | Certificate management | Auto-provision SSL certs (Let's Encrypt) |
| **KEDA** | Event-driven autoscaling | Scale based on events (queue length, etc.) |
| **Velero** | Backup/restore | Disaster recovery and migrations |

______________________________________________________________________

## :octicons-book-16: Learning Resources

### :octicons-mortar-board-16: Free Resources

- **[Kubernetes Documentation](https://kubernetes.io/docs/)** - Official docs, comprehensive
- **[Kubernetes the Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way)** - Build K8s from scratch (deep understanding)
- **[Play with Kubernetes](https://labs.play-with-k8s.com/)** - Browser-based playground
- **[KillerCoda K8s Labs](https://killercoda.com/kubernetes)** - Interactive scenarios
- **[Kubernetes by Example](https://kubernetesbyexample.com/)** - Quick examples

### :octicons-certificate-16: Certifications

!!! success "Worth Getting"
    - **CKA (Certified Kubernetes Administrator)** - $395, hands-on exam, industry standard
    - **CKAD (Certified Kubernetes Application Developer)** - $395, for developers deploying to K8s
    - **CKS (Certified Kubernetes Security Specialist)** - $395, requires CKA first

**Reality check:**

- CKA/CKAD are performance-based (actual kubectl commands, not multiple choice)
- Practice with killer.sh (included with exam registration)
- Study 2-3 months if new to K8s
- Certifications expire after 3 years

### :octicons-code-16: Practice Projects

!!! example "Beginner"
    - **Deploy static site** - Nginx deployment + service + ingress
    - **WordPress** - MySQL + WordPress with persistent volumes
    - **Multi-tier app** - Frontend + backend + database

!!! example "Intermediate"
    - **GitOps setup** - ArgoCD managing deployments
    - **Observability stack** - Prometheus, Grafana, Loki
    - **Autoscaling** - HPA based on CPU/memory
    - **Blue-green deployment** - Zero-downtime releases

!!! example "Advanced"
    - **Service mesh** - Istio for traffic management
    - **Multi-cluster** - Federated clusters across regions
    - **Custom operator** - Build CRD with Operator SDK
    - **Security hardening** - Pod Security Standards, Network Policies, OPA

______________________________________________________________________

## :octicons-star-16: Worth Checking

<div class="grid cards" markdown>

- :octicons-book-16: __Official Docs__

    ______________________________________________________________________

    [Kubernetes Documentation](https://kubernetes.io/docs/)

    [kubectl Reference](https://kubernetes.io/docs/reference/kubectl/)

    [API Reference](https://kubernetes.io/docs/reference/kubernetes-api/)

    [Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/)

- :octicons-tools-16: __Essential Tools__

    ______________________________________________________________________

    [kubectl](https://kubernetes.io/docs/tasks/tools/)

    [Helm](https://helm.sh/)

    [k9s](https://k9scli.io/)

    [Lens](https://k8slens.dev/)

    [krew (kubectl plugins)](https://krew.sigs.k8s.io/)

- :octicons-code-16: __Learning & Practice__

    ______________________________________________________________________

    [Kubernetes the Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way)

    [KillerCoda Labs](https://killercoda.com/kubernetes)

    [Kubernetes by Example](https://kubernetesbyexample.com/)

    [CNCF Landscape](https://landscape.cncf.io/)

- :octicons-people-16: __Community__

    ______________________________________________________________________

    [Kubernetes Slack](https://kubernetes.slack.com/)

    [r/kubernetes](https://reddit.com/r/kubernetes)

    [CNCF Community](https://community.cncf.io/)

    [KubeCon + CloudNativeCon](https://www.cncf.io/kubecon-cloudnativecon-events/)

</div>

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :octicons-cpu-16: **Complex but Essential** - Kubernetes is overkill for small projects but mandatory at scale. Steep learning curve, but managed services (EKS/GKE/AKS) hide most complexity. If you're doing containers seriously, you're learning K8s.
**Tags:** kubernetes, k8s, containers, orchestration, devops
