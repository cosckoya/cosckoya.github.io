---
title: Helm
description: Kubernetes package manager - charts for templated manifests, releases, rollbacks, plugin ecosystem
---

# :fontawesome-solid-ship: Helm

Kubernetes package manager. Install apps with a single command. Charts are templated Kubernetes manifests. Manages releases, rollbacks, upgrades. Plugin ecosystem extends functionality. De facto standard for K8s package management.

!!! tip "2026 Update"
    Helm 3.14+ includes OCI registry support by default. PostRenderer allows Kustomize integration. Chart dependencies from OCI registries. Improved diff output. Better RBAC integration.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # Installation
    brew install helm                      # macOS
    # Or: curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

    # Repository management
    helm repo add bitnami https://charts.bitnami.com/bitnami  # (1)!
    helm repo add stable https://charts.helm.sh/stable
    helm repo update                       # Update repo cache
    helm repo list                         # List configured repos

    # Search charts
    helm search repo nginx                 # Search in added repos
    helm search hub wordpress              # Search Artifact Hub  # (2)!

    # Install charts
    helm install my-release bitnami/nginx  # (3)!
    helm install my-app ./my-chart         # From local directory
    helm install my-app ./my-chart --dry-run --debug  # (4)!

    # Install with custom values
    helm install my-release bitnami/nginx --set service.type=LoadBalancer
    helm install my-release bitnami/nginx -f custom-values.yaml  # (5)!
    helm install my-release bitnami/nginx --create-namespace -n myapp

    # List releases
    helm list                              # Current namespace
    helm list -A                           # All namespaces
    helm list --all                        # Include failed releases

    # Upgrade releases
    helm upgrade my-release bitnami/nginx  # (6)!
    helm upgrade my-release bitnami/nginx --reuse-values
    helm upgrade --install my-release bitnami/nginx  # Install if not exists  # (7)!

    # Rollback
    helm rollback my-release               # Rollback to previous
    helm rollback my-release 3             # Rollback to revision 3
    helm history my-release                # View release history

    # Uninstall
    helm uninstall my-release              # Remove release
    helm uninstall my-release --keep-history  # Keep history for rollback

    # Get release info
    helm get values my-release             # Show values used
    helm get manifest my-release           # Show rendered manifests
    helm get notes my-release              # Show release notes

    # Template rendering (no install)
    helm template my-release bitnami/nginx  # (8)!
    helm template my-release ./my-chart -f values.yaml
    ```

    1. Bitnami charts are well-maintained, popular choice
    2. Artifact Hub is central registry for Helm charts
    3. Release name is user-chosen, chart name from repo
    4. `--dry-run --debug` shows rendered templates without installing
    5. `-f` flag can be repeated for multiple values files
    6. Upgrades create new revision (can rollback)
    7. Idempotent install/upgrade command (useful in CI/CD)
    8. Template command renders manifests without applying to cluster

    **Real talk:**

    - Helm 3 removed Tiller (no more server-side component)
    - Charts are just templated YAML (learning curve moderate)
    - Version management better than kubectl apply
    - Rollbacks save your ass when upgrades go wrong
    - Most popular apps have official Helm charts

=== ":fontawesome-solid-bolt: Common Patterns"

    ```yaml
    # Chart.yaml (chart metadata)
    apiVersion: v2
    name: myapp
    description: My application Helm chart
    type: application  # (1)!
    version: 1.0.0  # (2)!
    appVersion: "2.1.0"  # (3)!

    dependencies:  # (4)!
      - name: postgresql
        version: "12.x.x"
        repository: https://charts.bitnami.com/bitnami
        condition: postgresql.enabled  # (5)!

      - name: redis
        version: "17.x.x"
        repository: https://charts.bitnami.com/bitnami
        condition: redis.enabled
    ```

    1. `application` for apps, `library` for reusable templates
    2. Chart version (semantic versioning)
    3. App version (what version of the app this chart deploys)
    4. Dependencies are sub-charts (like npm dependencies)
    5. Conditional dependencies via values.yaml

    ```yaml
    # values.yaml (default configuration)
    replicaCount: 2

    image:
      repository: myapp
      pullPolicy: IfNotPresent
      tag: "latest"  # (1)!

    service:
      type: ClusterIP  # (2)!
      port: 80

    ingress:
      enabled: false  # (3)!
      className: "nginx"
      hosts:
        - host: myapp.example.com
          paths:
            - path: /
              pathType: Prefix

    resources:  # (4)!
      limits:
        cpu: 100m
        memory: 128Mi
      requests:
        cpu: 50m
        memory: 64Mi

    postgresql:
      enabled: true  # (5)!
      auth:
        username: myapp
        password: changeme
        database: myapp_db

    redis:
      enabled: true
      architecture: standalone
    ```

    1. Override with `--set image.tag=v1.2.3`
    2. ClusterIP (internal), LoadBalancer (external), NodePort (dev)
    3. Ingress disabled by default (enable with `--set ingress.enabled=true`)
    4. Resource requests/limits prevent resource starvation
    5. Enable/disable sub-charts (dependencies)

    ```yaml
    # templates/deployment.yaml (templated manifest)
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: {{ include "myapp.fullname" . }}  # (1)!
      labels:
        {{- include "myapp.labels" . | nindent 4 }}  # (2)!
    spec:
      replicas: {{ .Values.replicaCount }}  # (3)!
      selector:
        matchLabels:
          {{- include "myapp.selectorLabels" . | nindent 6 }}
      template:
        metadata:
          labels:
            {{- include "myapp.selectorLabels" . | nindent 8 }}
        spec:
          containers:
          - name: {{ .Chart.Name }}
            image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"  # (4)!
            imagePullPolicy: {{ .Values.image.pullPolicy }}
            ports:
            - name: http
              containerPort: 8080
              protocol: TCP
            {{- if .Values.resources }}  # (5)!
            resources:
              {{- toYaml .Values.resources | nindent 12 }}
            {{- end }}
    ```

    1. Helper function for consistent naming (defined in _helpers.tpl)
    2. `-` in `{{-` strips whitespace (cleaner YAML output)
    3. `.Values` accesses values.yaml, `.Chart` accesses Chart.yaml
    4. Tag defaults to appVersion if not specified
    5. Conditional blocks with `if`/`end`

    ```bash
    # Custom values for production (values-prod.yaml)
    replicaCount: 5

    image:
      tag: "v1.2.3"  # Specific version for prod

    service:
      type: LoadBalancer

    ingress:
      enabled: true
      hosts:
        - host: app.production.com
          paths:
            - path: /
              pathType: Prefix
      tls:
        - secretName: app-tls
          hosts:
            - app.production.com

    resources:
      limits:
        cpu: 1000m
        memory: 1Gi
      requests:
        cpu: 500m
        memory: 512Mi

    # Deploy with production values
    # helm install myapp ./my-chart -f values-prod.yaml
    ```

    **Why this works:**

    - Templates use Go template syntax (learning curve but powerful)
    - Values.yaml provides sensible defaults
    - Override values per environment (dev, staging, prod)
    - Dependencies managed automatically (PostgreSQL, Redis)
    - Helper functions (_helpers.tpl) reduce duplication

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Essential Plugins"
        **[helm-diff](https://github.com/databus23/helm-diff)** - Show changes before upgrade
        ```bash
        helm plugin install https://github.com/databus23/helm-diff
        helm diff upgrade my-release bitnami/nginx -f values.yaml  # (1)!
        ```

        **[helm-secrets](https://github.com/jkroepke/helm-secrets)** - Encrypt values files
        ```bash
        helm plugin install https://github.com/jkroepke/helm-secrets
        # Requires sops or vals
        helm secrets enc values-secrets.yaml  # Encrypt
        helm secrets install my-release ./chart -f values-secrets.yaml  # (2)!
        ```

        **[helm-git](https://github.com/aslafy-z/helm-git)** - Install charts from git
        ```bash
        helm plugin install https://github.com/aslafy-z/helm-git
        helm install my-release git+https://github.com/user/charts@path/to/chart  # (3)!
        ```

        1. See diff before applying changes (prevents surprises)
        2. Decrypt automatically during install/upgrade
        3. Install charts directly from git repos

    !!! warning "Security"
        - **Secrets in values** - Use helm-secrets plugin or external secrets operator
        - **RBAC** - Helm uses your kubectl permissions (least privilege)
        - **Verify charts** - Check chart provenance with `helm verify`
        - **OCI registries** - More secure than HTTP helm repos
        - **Image tags** - Never use `latest` in production

    !!! tip "Performance"
        - **Parallel installs** - Helm 3 supports parallel operations
        - **Atomic installs** - Use `--atomic` to rollback on failure
        - **Wait for readiness** - Use `--wait` to block until pods ready
        - **Timeout** - Set `--timeout` for long-running deployments

    !!! danger "Gotchas"
        - **Helm 2 vs 3** - Helm 3 removed Tiller (breaking change)
        - **Release names** - Must be unique per namespace
        - **Value precedence** - CLI `--set` overrides `-f` files
        - **Template syntax** - Go templates are picky about whitespace
        - **Dependency updates** - Run `helm dependency update` after changing Chart.yaml
        - **CRDs** - Custom Resource Definitions not upgraded (manual process)
        - **Hooks** - Pre/post install hooks can fail silently (check logs)

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning Resources

### :fontawesome-solid-book-open: Official Docs

- **[Helm Documentation](https://helm.sh/docs/)** - Complete guide
- **[Artifact Hub](https://artifacthub.io/)** - Find Helm charts
- **[Chart Best Practices](https://helm.sh/docs/chart_best_practices/)** - Official guidelines

### :fontawesome-solid-rocket: Key Features

- **Package management** - Install/upgrade/rollback apps
- **Templating** - Go templates for dynamic manifests
- **Dependencies** - Charts can depend on other charts
- **Rollbacks** - Easy rollback to previous versions
- **Hooks** - Pre/post install/upgrade actions
- **Plugin system** - Extend Helm functionality

______________________________________________________________________

## :fontawesome-solid-star: Related Tools

- **[Helmfile](https://github.com/helmfile/helmfile)** - Declarative Helm release management
- **[Helm Dashboard](https://github.com/komodorio/helm-dashboard)** - Web UI for Helm
- **[ArgoCD](https://argo-cd.readthedocs.io/)** - GitOps with Helm chart support
- **[Flux](https://fluxcd.io/)** - GitOps with HelmRelease CRD

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-crown: **K8s Standard** - De facto package manager for Kubernetes. Learning curve for templates. helm-diff plugin is essential. Rollbacks are lifesaver. Better than raw kubectl apply for complex apps.

**Tags:** helm, kubernetes, package-manager, charts, k8s
