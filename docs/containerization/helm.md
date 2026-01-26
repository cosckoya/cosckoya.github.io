# Helm: The Chartkeeper's Covenant

*Before the age of packaged manifests, there was chaos—endless YAML sprawl, version drift, and the despair of copy-paste infrastructure. Then came Helm, the self-proclaimed "package manager for Kubernetes," wielding charts like ancient scrolls. It promised order. It delivered... complexity. Yet here we stand, 29.3k GitHub stars later, because sometimes the devil you know beats hand-crafting 47 YAML files.*

Helm packages Kubernetes manifests into versioned, reusable "charts" with templating. Install apps with one command, upgrade declaratively, rollback when shit breaks. Graduated CNCF project. Current: v4.0.0 (stable: v3). No Tiller since v3 (thank the gods).

______________________________________________________________________

## Quick Hits

=== "🎯 Essential Commands"

    ```bash
    # Repository management
    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm repo update                           # Refresh local cache
    helm search repo nginx                     # Search added repos
    helm search hub wordpress                  # Search Artifact Hub

    # Installation & lifecycle
    helm install myrelease bitnami/nginx       # Install chart
    helm install myapp ./mychart -f values.yaml
    helm upgrade myrelease bitnami/nginx --version 15.0.0
    helm upgrade --install myapp ./mychart     # Upsert pattern
    helm rollback myrelease 1                  # Revert to revision 1
    helm uninstall myrelease                   # Nuke it

    # Inspection & debugging
    helm list -A                               # Show all releases
    helm status myrelease                      # Release info
    helm get values myrelease                  # Deployed values
    helm get manifest myrelease                # Rendered YAML
    helm history myrelease                     # Revision history

    # Local development
    helm template myapp ./mychart              # Render locally (no cluster)
    helm template myapp ./mychart --debug      # Show computed values
    helm lint ./mychart                        # Validate chart structure
    helm test myrelease                        # Run chart tests

    # Chart management
    helm create mychart                        # Scaffold new chart
    helm package ./mychart                     # Create .tgz archive
    helm dependency update ./mychart           # Fetch subchart deps
    ```

    **Real talk:**

    - Use `helm upgrade --install` instead of separate install/upgrade logic
    - Always `--dry-run` production upgrades first
    - `helm template` is your best friend for debugging WTF is being rendered
    - `helm list -A` shows releases across all namespaces (releases are namespaced since v3)
    - Install `helm-diff` plugin to preview changes before upgrading

=== "⚡ Common Patterns"

    ```yaml
    # values.yaml - Structure your config sanely
    replicaCount: 3

    image:
      repository: nginx
      tag: "1.21.6"
      pullPolicy: IfNotPresent

    service:
      type: ClusterIP
      port: 80

    ingress:
      enabled: false
      className: "nginx"
      annotations: {}
      hosts:
        - host: chart-example.local
          paths:
            - path: /
              pathType: ImplementationSpecific

    resources:
      limits:
        cpu: 100m
        memory: 128Mi
      requests:
        cpu: 100m
        memory: 128Mi

    autoscaling:
      enabled: false
      minReplicas: 1
      maxReplicas: 10
      targetCPUUtilizationPercentage: 80
    ```

    ```yaml
    # templates/deployment.yaml - Real templating example
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: {{ include "mychart.fullname" . }}
      labels:
        {{- include "mychart.labels" . | nindent 4 }}
      annotations:
        # Force rolling update when ConfigMap changes
        checksum/config: {{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
    spec:
      {{- if not .Values.autoscaling.enabled }}
      replicas: {{ .Values.replicaCount }}
      {{- end }}
      selector:
        matchLabels:
          {{- include "mychart.selectorLabels" . | nindent 6 }}
      template:
        metadata:
          labels:
            {{- include "mychart.selectorLabels" . | nindent 8 }}
        spec:
          containers:
          - name: {{ .Chart.Name }}
            image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
            imagePullPolicy: {{ .Values.image.pullPolicy }}
            ports:
            - name: http
              containerPort: 80
              protocol: TCP
            {{- with .Values.resources }}
            resources:
              {{- toYaml . | nindent 12 }}
            {{- end }}
            env:
            - name: POD_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            # Always quote env var values
            - name: ENVIRONMENT
              value: {{ .Values.environment | quote }}
    ```

    ```yaml
    # templates/_helpers.tpl - Reusable template snippets
    {{/*
    Expand the name of the chart.
    */}}
    {{- define "mychart.name" -}}
    {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
    {{- end }}

    {{/*
    Create a default fully qualified app name.
    */}}
    {{- define "mychart.fullname" -}}
    {{- if .Values.fullnameOverride }}
    {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
    {{- else }}
    {{- $name := default .Chart.Name .Values.nameOverride }}
    {{- if contains $name .Release.Name }}
    {{- .Release.Name | trunc 63 | trimSuffix "-" }}
    {{- else }}
    {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
    {{- end }}
    {{- end }}
    {{- end }}

    {{/*
    Common labels
    */}}
    {{- define "mychart.labels" -}}
    helm.sh/chart: {{ include "mychart.chart" . }}
    {{ include "mychart.selectorLabels" . }}
    {{- if .Chart.AppVersion }}
    app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
    {{- end }}
    app.kubernetes.io/managed-by: {{ .Release.Service }}
    {{- end }}

    {{/*
    Selector labels
    */}}
    {{- define "mychart.selectorLabels" -}}
    app.kubernetes.io/name: {{ include "mychart.name" . }}
    app.kubernetes.io/instance: {{ .Release.Name }}
    {{- end }}
    ```

=== "🔥 Pro Tips & Gotchas"

    **Do This:**

    - Install `helm-diff` plugin (3.3k stars) to preview changes: `helm plugin install https://github.com/databus23/helm-diff`
    - Use `helm upgrade --install` for idempotent deployments
    - Use `helm.sh/resource-policy: keep` annotation to prevent deletion on uninstall
    - Validate with `helm lint --strict` to catch warnings
    - Quote string values, don't quote integers: `port: 80` not `port: "80"`
    - Always quote environment variable values: `{{ .Values.env | quote }}`
    - Use `default` function for optional values: `{{ .Values.replicas | default 3 }}`
    - Use `required` function for mandatory values: `{{ required "A valid email is required!" .Values.email }}`
    - Test locally with `helm template` before deploying
    - Use `--dry-run --debug` to see computed values
    - Use checksums to trigger rolling updates: `checksum/config: {{ include "configmap.yaml" . | sha256sum }}`

    **Gotchas:**

    - **Indentation hell**: Use `nindent` not `indent` to avoid leading newlines
    - **Quotes**: String values need quotes, but quoting ints breaks Kubernetes parsing
    - **Env vars**: ALWAYS quote them or suffer mysterious failures
    - **YAML is evil**: One wrong space kills your entire chart
    - **Values precedence**: Rightmost wins: `--set` > `-f values.yaml` > chart defaults
    - **Release names**: Namespaced since Helm 3 (can reuse names across namespaces)
    - **No Tiller**: Helm 3 removed it, permissions now via kubeconfig (blessing and curse)
    - **Three-way merge**: Helm 3 compares old manifest + live state + new manifest (prevents accidental deletions)
    - **CRDs are special**: They go in `crds/` directory, NO templating allowed
    - **Hooks fire unpredictably**: Test them carefully, especially pre-delete hooks
    - **Secrets in values**: Don't commit secrets to Git, use external secret management
    - **Large values**: If release metadata exceeds 1MB, you're doing it wrong (or use SQL backend)

    **When NOT to use Helm:**

    - Single-environment deployments (overkill, use kubectl)
    - When you hate Go templates (use Kustomize or plain YAML)
    - When chart complexity exceeds your app complexity
    - When you need true GitOps (use FluxCD/ArgoCD with Helm, not Helm alone)
    - When your team doesn't understand templating (training cost > benefit)
    - When every chart becomes a snowflake (defeats the purpose)

______________________________________________________________________

## Chart Anatomy: The Sacred Structure

```bash
mychart/
├── Chart.yaml              # Chart metadata (required)
├── values.yaml             # Default configuration values
├── values.schema.json      # JSON Schema validation (optional)
├── charts/                 # Dependency charts (subcharts)
├── crds/                   # CustomResourceDefinitions (plain YAML, no templating)
├── templates/              # Kubernetes manifest templates
│   ├── NOTES.txt          # Post-install instructions (optional)
│   ├── _helpers.tpl       # Named template definitions (underscore = not rendered)
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   └── tests/
│       └── test-connection.yaml
├── README.md              # Human-readable docs
└── LICENSE                # Chart license
```

### Chart.yaml - The Covenant Document

```yaml
apiVersion: v2              # v2 for Helm 3+
name: mychart
version: 0.1.0             # Chart version (SemVer)
appVersion: "1.16.0"       # App version (informational)
description: A Helm chart for Kubernetes
type: application          # 'application' or 'library'
keywords:
  - web
  - nginx
home: https://example.com
sources:
  - https://github.com/example/mychart
maintainers:
  - name: Your Name
    email: you@example.com
dependencies:
  - name: postgresql
    version: 12.1.2
    repository: https://charts.bitnami.com/bitnami
    condition: postgresql.enabled  # Optional: enable/disable via values
    tags:
      - database
```

**Required fields:** `apiVersion`, `name`, `version`

______________________________________________________________________

## Templating: The Go Incantations

### Built-in Objects

Helm provides these objects in every template:

| Object          | Purpose                                 | Example                                           |
| :-------------- | :-------------------------------------- | :------------------------------------------------ |
| `.Values`       | Values from `values.yaml` and overrides | `{{ .Values.replicaCount }}`                      |
| `.Release`      | Release metadata                        | `{{ .Release.Name }}`, `{{ .Release.Namespace }}` |
| `.Chart`        | Chart.yaml contents                     | `{{ .Chart.Name }}-{{ .Chart.Version }}`          |
| `.Files`        | Access non-template files               | `{{ .Files.Get "config.ini" }}`                   |
| `.Capabilities` | Cluster capabilities                    | `{{ .Capabilities.KubeVersion.Major }}`           |
| `.Template`     | Current template info                   | `{{ .Template.Name }}`                            |

### Essential Functions

```yaml
# Strings & quotes
{{ .Values.name | quote }}              # Add quotes
{{ .Values.name | upper }}              # Uppercase
{{ .Values.name | lower }}              # Lowercase
{{ .Values.name | trunc 63 }}           # Truncate
{{ .Values.name | trimSuffix "-" }}     # Remove suffix

# Defaults & required
{{ .Values.replicas | default 3 }}      # Use 3 if not set
{{ required "Email required!" .Values.email }}  # Fail if missing

# Lists & dicts
{{ .Values.labels | toYaml | nindent 2 }}      # Convert to YAML
{{ .Values.data | toJson }}                     # Convert to JSON
{{ .Values.secret | b64enc }}                   # Base64 encode

# Control flow
{{- if .Values.ingress.enabled }}
# ... ingress config
{{- end }}

{{- with .Values.resources }}
resources:
  {{- toYaml . | nindent 2 }}
{{- end }}

{{- range .Values.environments }}
- name: {{ . }}
{{- end }}

# Named templates (from _helpers.tpl)
{{ include "mychart.fullname" . }}
{{ include "mychart.labels" . | nindent 4 }}

# Lookup (query live cluster)
{{ $secret := lookup "v1" "Secret" .Release.Namespace "mysecret" }}
{{- if $secret }}
  # Secret exists, use it
{{- end }}
```

### The Pipeline Pattern

Helm templates use Unix-style pipes to chain operations:

```yaml
# Right-to-left evaluation
{{ .Values.name | default "nginx" | quote | upper }}

# Expands to: UPPER(QUOTE(DEFAULT(.Values.name, "nginx")))
# Result: "NGINX"
```

**Pro tip:** Use `-` to strip whitespace:

```yaml
{{- if .Values.enabled }}   # Remove preceding whitespace
enabled: true
{{- end }}                  # Remove trailing whitespace
```

______________________________________________________________________

## Values Overrides: The Hierarchy of Truth

Helm merges values from multiple sources with this precedence (rightmost wins):

1. Chart's `values.yaml` (defaults)
1. Parent chart's `values.yaml` (if subchart)
1. User-supplied `-f values.yaml` files (multiple allowed, rightmost wins)
1. Individual `--set` flags (highest precedence)

```bash
# Override priority demonstration
helm install myapp ./mychart \
  -f values-base.yaml \          # Base values
  -f values-prod.yaml \           # Environment-specific (overrides base)
  --set replicas=5 \              # Override specific value
  --set-string longNumber=1234567890  # Force string type
```

### Real-World Values Override

```yaml
# values.yaml (chart defaults)
replicaCount: 1
image:
  repository: nginx
  tag: "1.21"

# values-prod.yaml (environment override)
replicaCount: 3
image:
  tag: "1.23"
  pullPolicy: Always

ingress:
  enabled: true
  host: app.example.com
```

```bash
# Deploy to production
helm upgrade --install myapp ./mychart -f values-prod.yaml
```

______________________________________________________________________

## Chart Dependencies: Subcharts & Library Charts

### Application Dependencies

Define dependencies in `Chart.yaml`:

```yaml
dependencies:
  - name: postgresql
    version: 12.1.2
    repository: https://charts.bitnami.com/bitnami
    condition: postgresql.enabled     # Optional
    tags:
      - database

  - name: redis
    version: 17.3.0
    repository: https://charts.bitnami.com/bitnami
    condition: redis.enabled
```

```bash
# Fetch dependencies
helm dependency update ./mychart

# Disable specific dependencies via values
helm install myapp ./mychart --set postgresql.enabled=false
```

### Library Charts: Reusable Templates

Library charts (`type: library` in Chart.yaml) provide shared templates but can't be installed directly. Use them to standardize resource definitions across multiple charts.

```yaml
# Chart.yaml for library chart
apiVersion: v2
name: common-lib
type: library         # Key difference
version: 1.0.0
```

Consuming charts include the library and reference its named templates:

```yaml
# Consumer's Chart.yaml
dependencies:
  - name: common-lib
    version: 1.0.0
    repository: https://charts.example.com/
```

```yaml
# Consumer's template using library
{{ include "common-lib.deployment" . }}
```

______________________________________________________________________

## Helm vs Kustomize vs Plain YAML: The Eternal Debate

| Approach       | Strengths                                                                                   | Weaknesses                                                                  | Use When                                                                |
| :------------- | :------------------------------------------------------------------------------------------ | :-------------------------------------------------------------------------- | :---------------------------------------------------------------------- |
| **Helm**       | Versioned packages, templating, rollback, reusable charts, massive ecosystem (Artifact Hub) | Steep learning curve, Go template hell, over-engineering simple deployments | Multi-environment, reusable packages, complex apps, need rollback       |
| **Kustomize**  | No templating (pure YAML), overlay model, built into kubectl, simple, GitOps-friendly       | No versioning, no rollback, less reusable, manual duplication               | GitOps workflows, simple env variants, template-phobic teams            |
| **Plain YAML** | Maximum simplicity, full control, no abstractions, transparent                              | Copy-paste hell, version drift, no lifecycle management, no reusability     | Single environment, tiny apps, learning Kubernetes, when you hate tools |

**Cynical truth:** Helm is overkill for simple apps but becomes essential at scale. Kustomize is elegant until you need rollback. Plain YAML is pure until you're managing 47 files across 5 environments. Pick your poison.

**Real world:** Many teams use both—Helm for third-party apps (postgres, redis, nginx), Kustomize for internal apps. Or Helm + ArgoCD/FluxCD for GitOps. Or just raw YAML and cron jobs. We're all making it up as we go.

______________________________________________________________________

## Repository Management: Chart Distribution

### Adding Public Repositories

```bash
# Artifact Hub - The centralized discovery hub
helm search hub redis

# Add specific repos
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add stable https://charts.helm.sh/stable
helm repo add jetstack https://charts.jetstack.io

# Update local cache
helm repo update

# Search added repos
helm search repo nginx
helm search repo postgres --versions  # Show all versions
```

### Hosting Your Own Repository

A Helm repo is just an HTTP server with an `index.yaml` file:

```bash
# Package charts
helm package ./mychart
helm package ./anotherchart

# Generate index
helm repo index . --url https://charts.example.com

# Upload .tgz files + index.yaml to web server
```

**Hosting options:**

- GitHub Pages (free, simple)
- ChartMuseum (self-hosted, S3/GCS backend)
- Artifactory / Nexus (enterprise)
- Cloud storage with public HTTPS (GCS, S3)
- OCI registries (Docker Hub, Harbor, etc.)

### OCI Registries (Modern Approach)

Helm 3.8+ supports OCI registries natively:

```bash
# Login to registry
echo $REGISTRY_TOKEN | helm registry login registry.example.com -u myuser --password-stdin

# Push chart
helm package ./mychart
helm push mychart-0.1.0.tgz oci://registry.example.com/helm-charts

# Install from OCI
helm install myapp oci://registry.example.com/helm-charts/mychart --version 0.1.0
```

______________________________________________________________________

## Chart Testing & Linting: Quality Gates

### Linting - Catch Errors Early

```bash
# Basic linting
helm lint ./mychart

# Strict mode (warnings = errors)
helm lint ./mychart --strict

# Test with specific values
helm lint ./mychart -f values-prod.yaml

# Lint with dependencies
helm lint ./mychart --with-subcharts

# Check against specific K8s version
helm lint ./mychart --kube-version 1.28.0
```

**Linting checks:**

- Chart.yaml structure
- Valid YAML syntax
- Required fields present
- Template rendering errors
- Best practice violations

### Chart Tests - Validate Deployments

Define test pods in `templates/tests/`:

```yaml
# templates/tests/test-connection.yaml
apiVersion: v1
kind: Pod
metadata:
  name: "{{ include "mychart.fullname" . }}-test-connection"
  annotations:
    "helm.sh/hook": test        # Mark as test hook
spec:
  containers:
  - name: wget
    image: busybox
    command: ['wget']
    args: ['{{ include "mychart.fullname" . }}:{{ .Values.service.port }}']
  restartPolicy: Never
```

```bash
# Run tests after install/upgrade
helm test myrelease

# View test logs
helm test myrelease --logs

# Filter specific tests
helm test myrelease --filter name=test-connection
```

### Local Rendering & Debug

```bash
# Render templates locally (no cluster needed)
helm template myapp ./mychart

# Show computed values
helm template myapp ./mychart --debug

# Render only specific templates
helm template myapp ./mychart --show-only templates/deployment.yaml

# Render with values override
helm template myapp ./mychart -f values-prod.yaml

# Save rendered manifests to files
helm template myapp ./mychart --output-dir ./rendered

# Test against specific K8s version
helm template myapp ./mychart --kube-version 1.28.0
```

______________________________________________________________________

## Best Practices: Hard-Won Wisdom

### Chart Structure

- Use `_helpers.tpl` for reusable named templates
- Prefix helper templates with chart name: `{{ define "mychart.fullname" }}`
- Keep templates focused (one resource per file)
- Use consistent naming: `<chart>-<resource>.yaml`
- Document complex templates with comments
- Use `.helmignore` to exclude unnecessary files from packages

### Values Design

- Provide sane defaults in `values.yaml`
- Use nested structure for logical grouping
- Document every value with comments
- Use `values.schema.json` for validation
- Don't expose every possible config (curate the API)
- Use `enabled` flags for optional features

```yaml
# Good values structure
ingress:
  enabled: false          # Feature flag
  className: "nginx"
  annotations: {}         # Extensibility
  hosts:                  # Structured data
    - host: example.local
      paths:
        - path: /
          pathType: Prefix
```

### Templating

- Quote string values: `{{ .Values.name | quote }}`
- Don't quote integers: `port: 80` not `port: "80"`
- Always quote env var values
- Use `default` for optional values
- Use `required` for mandatory values
- Use `nindent` instead of `indent` (avoids leading newlines)
- Test templates with `helm template` before deploying
- Use `lookup` sparingly (requires live cluster)

### Security

- Never commit secrets in `values.yaml` (use external secrets: Sealed Secrets, External Secrets Operator)
- Use `values.schema.json` to validate sensitive fields
- Apply RBAC resources with minimal permissions
- Use `helm.sh/resource-policy: keep` for sensitive resources
- Scan charts for vulnerabilities (Trivy, Snyk)
- Sign charts with GPG for provenance verification

### Operations

- Use `helm upgrade --install` for idempotent deployments
- Always `--dry-run` production changes
- Install `helm-diff` plugin to preview changes
- Use `--wait` for critical deployments (blocks until ready)
- Use `--timeout` to prevent hanging deployments
- Tag releases with Git SHA or build numbers
- Document upgrade procedures in NOTES.txt
- Test rollback procedures before you need them

______________________________________________________________________

## Anti-Patterns: The Path to Madness

### Template Complexity

**Bad:** Logic-heavy templates that replicate application code

```yaml
# DON'T: Business logic in templates
{{- if and (eq .Values.env "prod") (gt .Values.replicas 3) (not .Values.debug) }}
  # Complex conditional hell
{{- end }}
```

**Good:** Simple templates, complex logic in application

### Values Explosion

**Bad:** Exposing every possible configuration option

```yaml
# DON'T: 500-line values.yaml with every flag
deployment:
  annotations:
    annotation1: value1
    annotation2: value2
    # ... 100 more annotations
```

**Good:** Curated API surface, escape hatches for power users

### Mega Charts

**Bad:** Single chart deploying 20+ microservices

**Good:** Separate charts per service, umbrella chart for coordination

### Copy-Paste Inheritance

**Bad:** Duplicating templates across charts

**Good:** Library charts for shared components

### Secret Committing

**Bad:** Secrets in `values.yaml` committed to Git

```yaml
# DON'T EVER DO THIS
database:
  password: "supersecret123"  # NEVER
```

**Good:** External secret management (Sealed Secrets, SOPS, Vault)

### Version Pinning Neglect

**Bad:** `version: "*"` or unpinned dependencies

**Good:** Exact versions with controlled upgrade cadence

______________________________________________________________________

## Common Gotchas: Field Notes from the Battlefield

### The Indentation Catastrophe

```yaml
# WRONG - Creates leading newline
labels:
  {{ toYaml .Values.labels | indent 2 }}

# RIGHT - Use nindent
labels:
  {{- toYaml .Values.labels | nindent 2 }}
```

### The Integer Quote Trap

```yaml
# WRONG - Kubernetes rejects "80" as invalid integer
containerPort: {{ .Values.port | quote }}

# RIGHT - No quotes for numbers
containerPort: {{ .Values.port }}
```

### The Environment Variable Gotcha

```yaml
# WRONG - Will break on special characters
env:
  - name: MY_VAR
    value: {{ .Values.myVar }}

# RIGHT - Always quote env values
env:
  - name: MY_VAR
    value: {{ .Values.myVar | quote }}
```

### The Checksum Oversight

Without checksums, config changes don't trigger pod restarts:

```yaml
# Add this to deployment spec.template.metadata.annotations
annotations:
  checksum/config: {{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
```

### The CRD Templating Error

```yaml
# WRONG - CRDs in crds/ directory cannot use templates
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: {{ .Values.crdName }}  # FAILS

# RIGHT - CRDs must be plain YAML, no templating
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: mycrd.example.com
```

### The Release Namespace Confusion

Since Helm 3, releases are namespaced:

```bash
# Install same release name in different namespaces
helm install myapp ./chart -n dev
helm install myapp ./chart -n prod  # This works in Helm 3!

# List requires namespace or --all-namespaces
helm list                # Shows only current namespace
helm list -A             # Shows all namespaces
```

______________________________________________________________________

## Learning Paths

### 🎓 Free Resources

- **[Official Helm Docs](https://helm.sh/docs/)** - Comprehensive, well-structured, start here
- **[Helm Chart Template Guide](https://helm.sh/docs/chart_template_guide/)** - Deep dive into templating (17 sections)
- **[Helm Best Practices](https://helm.sh/docs/chart_best_practices/)** - Official patterns from the maintainers
- **[Artifact Hub](https://artifacthub.io/)** - Browse 10,000+ charts, learn from examples
- **[Helm GitHub](https://github.com/helm/helm)** - Source code, issues, discussions (29.3k stars)

### 📚 Recommended Charts to Study

Browse these well-maintained charts on Artifact Hub to learn patterns:

- **Bitnami charts** - Industry standard, excellent quality
- **Prometheus/Grafana** - Complex multi-component apps
- **Cert-manager** - CRD management, webhooks, operators
- **Ingress-nginx** - Configuration complexity done right

### 🧪 Hands-on Learning

- **[Helm Create Tutorial](https://helm.sh/docs/chart_template_guide/getting_started/)** - Build your first chart
- Create chart from scratch: `helm create mychart` then explore structure
- Clone popular charts from Artifact Hub and dissect them
- Install `helm-diff` and practice preview workflows

______________________________________________________________________

## Community Pulse

### 💬 Active Communities

- **[Kubernetes Slack](https://kubernetes.slack.com/)** - Channels: `#helm-users`, `#helm-dev`, `#charts`
- **[Helm GitHub Discussions](https://github.com/helm/helm/discussions)** - Q&A, feature requests
- **[Helm Community](https://github.com/helm/community)** - Governance, meetings, contribution guides
- **[CNCF Slack](https://cloud-native.slack.com/)** - Helm channels available

### 🐦 Who to Follow

- **[@HelmPack](https://twitter.com/HelmPack)** - Official Helm project account
- Helm maintainers on GitHub: Matt Butcher, Matt Farina, Taylor Thomas

### 📊 Project Health

- **GitHub:** 29.3k stars, 7.5k forks, 808 contributors
- **Releases:** 232+ releases, v4.0.0 latest
- **Status:** CNCF Graduated Project (highest maturity level)
- **Language:** 98.2% Go
- **License:** Apache 2.0

______________________________________________________________________

## Worth Checking

<div class="grid cards" markdown>

- 📚 __Official Scrolls__

    ______________________________________________________________________

    [Helm Docs](https://helm.sh/docs/) - Start here, seriously

    [GitHub Repository](https://github.com/helm/helm) - 29.3k stars, active development

    [Chart Template Guide](https://helm.sh/docs/chart_template_guide/) - Master templating

    [Best Practices](https://helm.sh/docs/chart_best_practices/) - Official patterns

- 🧪 __Chart Repositories__

    ______________________________________________________________________

    [Artifact Hub](https://artifacthub.io/) - Central chart discovery (replaced Helm Hub)

    [Bitnami Charts](https://github.com/bitnami/charts) - High-quality maintained charts

    [Prometheus Community](https://github.com/prometheus-community/helm-charts) - Monitoring stack

- 💻 __Essential Tools__

    ______________________________________________________________________

    [helm-diff Plugin](https://github.com/databus23/helm-diff) - Preview changes (3.3k stars)

    [ChartMuseum](https://github.com/helm/chartmuseum) - Self-hosted chart repository

    [Helm Secrets Plugin](https://github.com/jkroepke/helm-secrets) - Encrypted values support

    [Helmfile](https://github.com/helmfile/helmfile) - Declarative Helm deployment

- 🔥 __Real-World Patterns__

    ______________________________________________________________________

    [Helm Chart Template Examples](https://github.com/helm/examples) - Official examples

    [Common Helm Patterns](https://helm.sh/docs/howto/charts_tips_and_tricks/) - Tips from the trenches

    [Awesome Helm](https://github.com/cdwv/awesome-helm) - Curated list of resources

</div>

______________________________________________________________________

**Last Updated:** 2026-01-14

**Vibe Check:** 🔥 **Dominant** - Helm reigns as the de facto Kubernetes package manager despite vocal critics. Every platform team runs it. The CNCF graduation seal solidifies its position. Kustomize nibbles at the edges, but Helm's ecosystem (Artifact Hub, 10k+ charts, universal tooling support) creates overwhelming gravitational pull.

**Realm Status:** Mature, battle-tested, occasionally frustrating. Helm is the systemd of Kubernetes—complained about endlessly, used universally. Go template syntax is legitimately painful, but the alternative (manually managing 50 YAML files per app across 4 environments) is worse. Version 3's Tiller removal cleansed the worst sins. Now it's just... infrastructure. Not sexy, but essential. You'll curse it during template debugging, then rely on it for rollback when production breaks. Such is the chartkeeper's burden.
