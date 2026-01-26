# Container Security

Securing black boxes you don't fully understand running code you didn't write on infrastructure you don't control. Welcome to 2026, where "it works on my machine" now means "the exploit works on every machine." Container security is what happens when you realize that shipping your dependencies doesn't make them any less vulnerable.

______________________________________________________________________

## Quick Hits

=== "🎯 Scanner Arsenal"

    ```bash
    # Trivy - The workhorse (scan everything)
    trivy image nginx:latest
    trivy fs --security-checks vuln,config .
    trivy sbom nginx:latest

    # Grype - Fast vulnerability scanning
    grype nginx:latest
    grype dir:.

    # Snyk - Commercial with better prioritization
    snyk container test nginx:latest
    snyk monitor --docker nginx:latest

    # Docker Bench - CIS hardening checks
    docker run -it --net host --pid host --userns host \
      --cap-add audit_control -v /:/host \
      docker/docker-bench-security

    # Cosign - Image signing/verification
    cosign sign --key cosign.key image:tag
    cosign verify --key cosign.pub image:tag
    ```

    **Real talk:**

    - Trivy is free, fast, and good enough for 90% of use cases
    - Grype has better accuracy on some CVEs, worse on others (check CVE-2024-\*)
    - Snyk costs money but prioritizes what actually matters
    - None of them catch zero-days (obviously), but that's not the point
    - Image signing is security theater unless you enforce it at admission

=== "⚡ Runtime Security Patterns"

    ```yaml
    # Falco - Runtime threat detection
    # Install via Helm
    helm repo add falcosecurity https://falcosecurity.github.io/charts
    helm install falco falcosecurity/falco \
      --set falco.grpc.enabled=true \
      --set falcoctl.artifact.install.enabled=true

    # Custom Falco rule for crypto mining detection
    - rule: Detect Crypto Mining
      desc: Detect processes like xmrig, minerd
      condition: >
        spawned_process and proc.name in (xmrig, minerd, cryptonight)
      output: "Crypto mining detected (proc=%proc.name user=%user.name)"
      priority: CRITICAL
    ```

    ```yaml
    # Pod Security Standards - Restricted profile
    apiVersion: v1
    kind: Namespace
    metadata:
      name: production
      labels:
        pod-security.kubernetes.io/enforce: restricted
        pod-security.kubernetes.io/audit: restricted
        pod-security.kubernetes.io/warn: restricted
    ```

    ```yaml
    # Actually secure container spec
    apiVersion: v1
    kind: Pod
    metadata:
      name: secure-pod
    spec:
      securityContext:
        runAsNonRoot: true
        runAsUser: 10000
        fsGroup: 10000
        seccompProfile:
          type: RuntimeDefault
      containers:
      - name: app
        image: myapp:signed-v1.2.3
        securityContext:
          allowPrivilegeEscalation: false
          readOnlyRootFilesystem: true
          capabilities:
            drop:
              - ALL
        resources:
          limits:
            memory: "512Mi"
            cpu: "500m"
          requests:
            memory: "256Mi"
            cpu: "250m"
    ```

=== "🔥 Threat Landscape & Defense"

    **Current Threats (2024-2026):**

    - Container escape via kernel exploits (CVE-2024-\* dropping monthly)
    - Supply chain poisoning (typosquatting, backdoored base images)
    - Cryptominers in public registries (50% of malicious images)
    - Exposed Docker APIs (still, somehow, in 2026)
    - Privileged pods breaking out to nodes
    - Secrets leaked in image layers (git history is forever)
    - CI/CD compromise → registry poisoning → everyone's pwned

    **Defense in depth (the only kind that works):**

    - Scan early, scan often (CI + registry + runtime)
    - Enforce Pod Security Standards (Restricted everywhere you can)
    - Network policies by default (deny-all, then whitelist)
    - Runtime monitoring (Falco or similar, actually configured)
    - Don't run as root (seriously, stop it)
    - Read-only filesystems where possible
    - Drop ALL capabilities, add back only what's needed
    - External secrets (Vault, ESO, anything but etcd)
    - SBOM generation (for when shit hits the fan)
    - Admission controllers that say "no" (Kyverno, Gatekeeper)

    **When NOT to bother:**

    - Dev/test environments where "working" > "secure"
    - If you're running public internet-facing workloads without monitoring anyway
    - When your entire security strategy is "hope nobody notices"

______________________________________________________________________

## Learning Paths

### 🎓 Free Resources

- **[Kubernetes Goat](https://github.com/madhuakula/kubernetes-goat)** - Vulnerable cluster, learn by breaking things (5.4k stars, actual hands-on)
- **[Aqua Security Blog](https://blog.aquasec.com/)** - Real-world threats, not marketing fluff (mostly)
- **[OWASP Kubernetes Top 10](https://owasp.org/www-project-kubernetes-top-ten/)** - The hits that keep on hitting
- **[CNCF Security Whitepaper](https://github.com/cncf/tag-security)** - Comprehensive, actually useful (read v2)
- **[Container Security by Liz Rice](https://www.oreilly.com/library/view/container-security/9781492056690/)** - O'Reilly book, free in various places

### 🧪 Interactive Labs

- **[Kubernetes Goat Labs](https://madhuakula.com/kubernetes-goat/)** - Break into pods, escalate privileges, the fun stuff
- **[Katacoda Kubernetes Security](https://www.katacoda.com/courses/kubernetes/security-introduction)** - Step-by-step security scenarios
- **[Sysdig Secure Playground](https://sysdig.com/learn/falco/)** - Falco rules testing

### 📜 Certifications Worth It

- **[Certified Kubernetes Security Specialist (CKS)](https://www.cncf.io/certification/cks/)** - $395, hands-on, actually proves you know shit
- **[GIAC Security Essentials (GSEC)](https://www.giac.org/certification/security-essentials-gsec)** - $2,499, overkill unless employer pays
- **Skip:** Cloud vendor security certs (AWS/Azure/GCP) unless you're deep in that ecosystem

### 🚀 Projects to Build

- **Beginner:** Deploy app with Trivy scanning in CI/CD, fix all HIGH/CRITICAL CVEs
- **Intermediate:** Implement Pod Security Standards, Network Policies, and Falco rules for production workload
- **Advanced:** Build admission controller that enforces image signing, blocks privilege escalation, and integrates with Vault for secrets

______________________________________________________________________

## Community Pulse

### 🐦 Who to Follow

**Twitter/X:**

- [@lizrice](https://twitter.com/lizrice) - Isovalent CTO, eBPF/security expert, writes actual books
- [@IanColdwater](https://twitter.com/IanColdwater) - Kubernetes security researcher, breaks things professionally
- [@raesene](https://twitter.com/raesene) - rory mccune, container security author, CNCF TAG Security
- [@jessfraz](https://twitter.com/jessfraz) - Containers OG, built Docker security, no-bullshit takes
- [@bgeesaman](https://twitter.com/bgeesaman) - Co-creator CKS exam, Kubernetes security deep knowledge

**YouTube/Streamers:**

- [rawkode](https://www.youtube.com/c/rawkode) - Cloud Native security, deep dives
- [That DevOps Guy](https://www.youtube.com/@MarcelDempers) - Practical security implementations
- [CNCF Talks](https://www.youtube.com/c/cloudnativefdn) - KubeCon security sessions worth watching

### 💬 Active Communities

- **[r/kubernetes](https://reddit.com/r/kubernetes)** - 200k+ members, security questions answered daily, mix of noobs + experts
- **[Kubernetes Slack #security](https://kubernetes.slack.com/)** - Where actual security folks hang, good signal-to-noise
- **[Falco Community](https://falco.org/community/)** - Active runtime security discussions
- **[CNCF Slack #tag-security](https://cloud-native.slack.com/)** - Security TAG, whitepapers discussed here
- **[Dev.to #containersecurity](https://dev.to/t/containersecurity)** - Decent tutorials, not just marketing

### 🎙️ Podcasts & Newsletters

- **[Cloud Security Podcast](https://cloudsecuritypodcast.tv/)** - Google folks, containers + cloud security
- **[Screaming in the Cloud](https://www.lastweekinaws.com/podcast/screaming-in-the-cloud/)** - Corey Quinn, container security guests occasionally
- **[Container Security Newsletter](https://container-security.site/)** - Weekly, curated threats/vulns
- **[tl;dr sec](https://tldrsec.com/)** - Weekly security newsletter, container stuff regular

### 🎪 Events & Conferences

- **[KubeCon Security Track](https://events.linuxfoundation.org/kubecon-cloudnativecon-north-america/)** - $1000+, best container security talks yearly
- **[OWASP Global AppSec](https://owasp.org/events/)** - Container/cloud security always featured
- **[BSides Events](http://www.securitybsides.com/)** - Free local security cons, container topics common
- **[Cloud Native SecurityCon](https://events.linuxfoundation.org/cloudnativesecuritycon-north-america/)** - CNCF security-focused, worth attending

______________________________________________________________________

## Scanner Comparison

| Scanner          | Accuracy | Speed   | SBOM | Secrets | IaC | Cost     | Best For                       |
| ---------------- | -------- | ------- | ---- | ------- | --- | -------- | ------------------------------ |
| **Trivy**        | High     | Fast    | ✅   | ✅      | ✅  | Free     | Everything, CI/CD, start here  |
| **Grype**        | High     | Fastest | ✅   | ❌      | ❌  | Free     | Pure vulnerability scanning    |
| **Snyk**         | Highest  | Medium  | ✅   | ✅      | ✅  | $$$      | Prioritization, dev-focused    |
| **Clair**        | Medium   | Slow    | ❌   | ❌      | ❌  | Free     | Registry integration (legacy)  |
| **Anchore**      | High     | Slow    | ✅   | ✅      | ❌  | Free/$$$ | Policy enforcement, compliance |
| **Docker Scout** | Medium   | Fast    | ✅   | ❌      | ❌  | Free/$$$ | Docker Hub users               |

**Verdict:** Start with Trivy (free, comprehensive, fast). Upgrade to Snyk if you have budget and need better prioritization. Skip the rest unless you have specific needs.

______________________________________________________________________

## Pod Security Standards Deep Dive

Kubernetes replaced PodSecurityPolicy with Pod Security Standards in v1.25. Three profiles, progressively restrictive.

### Privileged (Don't Use This)

- Allows everything, including privilege escalation
- Use case: System workloads, CNI plugins, storage drivers
- Real talk: If your app needs this, rethink your app

### Baseline (Minimum Bar)

```yaml
# Apply to namespace
apiVersion: v1
kind: Namespace
metadata:
  name: baseline-ns
  labels:
    pod-security.kubernetes.io/enforce: baseline
    pod-security.kubernetes.io/audit: baseline
    pod-security.kubernetes.io/warn: baseline
```

**What it blocks:**

- Privileged containers
- Host namespaces (hostNetwork, hostPID, hostIPC)
- Host ports
- Dangerous capabilities (beyond default safe set)
- HostPath volumes
- Privilege escalation
- Root user in specific cases

**What it allows:**

- Running as root (bad, but allowed)
- Most volumes types
- Basic capabilities

### Restricted (Production Standard)

```yaml
# Apply to namespace - this is what you want
apiVersion: v1
kind: Namespace
metadata:
  name: production
  labels:
    pod-security.kubernetes.io/enforce: restricted
    pod-security.kubernetes.io/audit: restricted
    pod-security.kubernetes.io/warn: restricted
```

**Enforces:**

- Non-root user execution (`runAsNonRoot: true`)
- No privilege escalation (`allowPrivilegeEscalation: false`)
- Drop ALL capabilities
- Seccomp profile required
- Limited volume types (no hostPath, etc.)
- Read-only root filesystem recommended

**Example restricted pod:**

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: restricted-example
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 10001
    fsGroup: 10001
    seccompProfile:
      type: RuntimeDefault
  containers:
  - name: app
    image: myapp:v1
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop:
          - ALL
    volumeMounts:
    - name: tmp
      mountPath: /tmp
  volumes:
  - name: tmp
    emptyDir: {}
```

______________________________________________________________________

## Network Policies (Actually Secure Your Shit)

Default Kubernetes networking: Every pod can talk to every pod. This is insane.

### Default Deny All (Start Here)

```yaml
# Block all ingress to all pods in namespace
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
  namespace: production
spec:
  podSelector: {}
  policyTypes:
  - Ingress
```

```yaml
# Block all egress from all pods in namespace
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-egress
  namespace: production
spec:
  podSelector: {}
  policyTypes:
  - Egress
```

### Allow Only What's Needed

```yaml
# Frontend can talk to backend, nothing else
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: frontend-to-backend
  namespace: production
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: frontend
    ports:
    - protocol: TCP
      port: 8080
```

```yaml
# Backend can talk to database only
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: backend-to-db
  namespace: production
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: postgres
    ports:
    - protocol: TCP
      port: 5432
  # Allow DNS (otherwise nothing works)
  - to:
    - namespaceSelector:
        matchLabels:
          name: kube-system
    ports:
    - protocol: UDP
      port: 53
```

### Common Gotcha: DNS

If you block all egress, DNS breaks. Always allow UDP 53 to kube-system:

```yaml
egress:
- to:
  - namespaceSelector:
      matchLabels:
        kubernetes.io/metadata.name: kube-system
  ports:
  - protocol: UDP
    port: 53
```

______________________________________________________________________

## Secrets Management (Stop Using Kubernetes Secrets)

Kubernetes Secrets are base64-encoded data stored in etcd. They're not encrypted by default. Anyone with API access can read them. This is not a secret.

### Native Secrets (If You Must)

```yaml
# At minimum, enable encryption at rest
# /etc/kubernetes/enc/enc.yaml
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: <base64-encoded-32-byte-key>
      - identity: {}
```

```yaml
# Use secrets as volume mounts, not env vars (env vars leak in logs)
apiVersion: v1
kind: Pod
metadata:
  name: secret-pod
spec:
  containers:
  - name: app
    image: myapp
    volumeMounts:
    - name: secret-volume
      mountPath: /etc/secrets
      readOnly: true
  volumes:
  - name: secret-volume
    secret:
      secretName: my-secret
```

### External Secrets Operator (Better)

```yaml
# Install ESO
helm repo add external-secrets https://charts.external-secrets.io
helm install external-secrets external-secrets/external-secrets -n external-secrets-system --create-namespace

# Configure backend (Vault example)
apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: vault-backend
  namespace: production
spec:
  provider:
    vault:
      server: "https://vault.example.com"
      path: "secret"
      version: "v2"
      auth:
        kubernetes:
          mountPath: "kubernetes"
          role: "my-app-role"

# Pull secret from Vault
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: app-secret
  namespace: production
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: vault-backend
    kind: SecretStore
  target:
    name: app-secret-k8s
  data:
  - secretKey: db-password
    remoteRef:
      key: myapp/database
      property: password
```

### Sealed Secrets (Simple Alternative)

```bash
# Install controller
kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.24.0/controller.yaml

# Seal a secret (safe to commit to git)
kubeseal --format yaml < secret.yaml > sealed-secret.yaml

# Controller decrypts in-cluster only
kubectl apply -f sealed-secret.yaml
```

**Options ranked:**

1. **Vault + ESO** - Enterprise-grade, centralized, audited (if you have ops team)
1. **Cloud provider secrets** - AWS Secrets Manager + ESO, Azure Key Vault, GCP Secret Manager (if cloud-native)
1. **Sealed Secrets** - Simple, GitOps-friendly, good enough for most
1. **Native Secrets** - With encryption at rest, RBAC locked down, rotation automated (minimum acceptable)
1. **Hardcoded in code** - You're fired

______________________________________________________________________

## Supply Chain Security

Your container is only as secure as its most vulnerable dependency. Spoiler: It's very vulnerable.

### SBOM (Software Bill of Materials)

Know what's in your images. SBOM = ingredient list for containers.

```bash
# Generate SBOM with Syft
syft packages nginx:latest -o spdx-json > nginx-sbom.json

# Generate with Trivy
trivy image --format spdx-json --output nginx-sbom.json nginx:latest

# Scan SBOM for vulnerabilities (faster than rescanning image)
grype sbom:./nginx-sbom.json
```

**Standards:**

- **SPDX** - Linux Foundation standard, more detailed
- **CycloneDX** - OWASP standard, security-focused

Use SPDX if compliance matters, CycloneDX if security scanning is priority.

### Image Signing with Cosign

```bash
# Generate keypair
cosign generate-key-pair

# Sign image
cosign sign --key cosign.key myregistry.com/myapp:v1.2.3

# Verify image
cosign verify --key cosign.pub myregistry.com/myapp:v1.2.3

# Keyless signing (uses Sigstore, OIDC auth)
cosign sign myregistry.com/myapp:v1.2.3

# Verify keyless signature
cosign verify \
  --certificate-identity user@example.com \
  --certificate-oidc-issuer https://accounts.google.com \
  myregistry.com/myapp:v1.2.3
```

### Enforce Signing with Admission Controller

```yaml
# Kyverno policy - block unsigned images
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: verify-image-signature
spec:
  validationFailureAction: Enforce
  rules:
  - name: verify-signature
    match:
      any:
      - resources:
          kinds:
          - Pod
    verifyImages:
    - imageReferences:
      - "myregistry.com/*"
      attestors:
      - count: 1
        entries:
        - keys:
            publicKeys: |-
              -----BEGIN PUBLIC KEY-----
              <your-cosign-public-key>
              -----END PUBLIC KEY-----
```

### Supply Chain Attack Vectors

**2024-2026 reality check:**

- 60% of container images have HIGH/CRITICAL CVEs
- 50% of malicious images are cryptominers
- Base images are vulnerable within 6 months (Debian, Alpine, Ubuntu - all of them)
- npm/pypi/maven dependencies are attack surface (SolarWinds wasn't the last)
- CI/CD compromise → registry poisoning → game over

**Defense:**

1. Scan images in CI (Trivy, Grype, Snyk - pick one, use it)
1. Scan registries continuously (vulnerabilities discovered daily)
1. Sign images (Cosign + admission enforcement)
1. Generate SBOMs (for incident response, compliance)
1. Use minimal base images (distroless, scratch, alpine)
1. Pin dependencies to SHAs, not tags (tags are mutable)
1. Private registries only (Docker Hub is not your friend)
1. Scan before pull (admission webhooks)

______________________________________________________________________

## Container Escape Techniques (Defensive Knowledge)

Understanding how containers break helps you prevent it. Don't try this in production.

### Common Escape Vectors

**1. Privileged Containers**

```yaml
# This is basically running on the host
containers:
- name: evil
  securityContext:
    privileged: true
```

Privileged = full device access + all capabilities. Can mount host filesystem, load kernel modules, own the node.

**Defense:** Never use `privileged: true` unless system workload. Enforce with Pod Security Standards.

**2. hostPath Volumes**

```yaml
# Mount host filesystem into container
volumes:
- name: host-root
  hostPath:
    path: /
    type: Directory
```

Access to host filesystem = escape complete. Modify systemd units, SSH keys, kernel.

**Defense:** Block hostPath in production. Use PersistentVolumes instead.

**3. hostNetwork/hostPID**

```yaml
spec:
  hostNetwork: true  # Container uses host networking
  hostPID: true      # Can see/kill host processes
```

Host namespace access = no isolation. See all processes, network traffic, attack other containers.

**Defense:** Block via Pod Security Standards. Required for CNI plugins only.

**4. Exposed Docker Socket**

```yaml
# Never, ever, ever do this
volumes:
- name: docker-sock
  hostPath:
    path: /var/run/docker.sock
```

Docker socket = root on host. Spawn privileged container, escape, profit.

**Defense:** Don't mount Docker socket. If you must (CI/CD), use rootless Docker, separate node pools.

**5. Kernel Exploits**

CVE-2024-\* (there's always a new one). Exploit kernel vulnerability from container → escape.

**Defense:** Keep nodes patched, use hardened kernels (SELinux, AppArmor), runtime security (Falco).

### MITRE ATT&CK for Containers

**Common techniques:**

- **T1611** - Escape to Host (via exploits, misconfigurations)
- **T1610** - Deploy Container (malicious image deployment)
- **T1552** - Unsecured Credentials (Docker API, service tokens)
- **T1612** - Build Image on Host (inject malicious layers)
- **T1053.007** - Scheduled Task/Job (CronJobs for persistence)

**Attack chain:**

1. Initial access (exposed service, stolen credentials)
1. Execution (deploy malicious container)
1. Privilege escalation (privileged pod, kernel exploit)
1. Persistence (malicious CronJob, backdoored image)
1. Defense evasion (disable Falco, clear logs)
1. Credential access (steal secrets from etcd)
1. Discovery (scan cluster for targets)
1. Lateral movement (access other pods/nodes)
1. Impact (cryptomining, data exfiltration, DoS)

______________________________________________________________________

## Admission Controllers (The Bouncer)

Admission controllers validate/mutate resources before they hit etcd. Last line of defense against stupid.

### Kyverno (Kubernetes-Native)

```yaml
# Install
helm repo add kyverno https://kyverno.github.io/kyverno/
helm install kyverno kyverno/kyverno -n kyverno --create-namespace

# Policy: Require image signature
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: require-image-signature
spec:
  validationFailureAction: Enforce
  background: false
  rules:
  - name: check-signature
    match:
      any:
      - resources:
          kinds:
          - Pod
    verifyImages:
    - imageReferences:
      - "*"
      attestors:
      - count: 1
        entries:
        - keys:
            publicKeys: |-
              -----BEGIN PUBLIC KEY-----
              <your-public-key>
              -----END PUBLIC KEY-----

# Policy: Block latest tag
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: disallow-latest-tag
spec:
  validationFailureAction: Enforce
  rules:
  - name: require-version-tag
    match:
      any:
      - resources:
          kinds:
          - Pod
    validate:
      message: "Using 'latest' tag is not allowed"
      pattern:
        spec:
          containers:
          - image: "!*:latest"

# Policy: Enforce resource limits
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: require-limits
spec:
  validationFailureAction: Enforce
  rules:
  - name: check-limits
    match:
      any:
      - resources:
          kinds:
          - Pod
    validate:
      message: "Resource limits are required"
      pattern:
        spec:
          containers:
          - resources:
              limits:
                memory: "?*"
                cpu: "?*"
```

### OPA Gatekeeper (Rego-Based)

```yaml
# Install
kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/master/deploy/gatekeeper.yaml

# Constraint Template (policy definition)
apiVersion: templates.gatekeeper.sh/v1
kind: ConstraintTemplate
metadata:
  name: k8srequiredlabels
spec:
  crd:
    spec:
      names:
        kind: K8sRequiredLabels
      validation:
        openAPIV3Schema:
          type: object
          properties:
            labels:
              type: array
              items:
                type: string
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8srequiredlabels
        violation[{"msg": msg, "details": {"missing_labels": missing}}] {
          provided := {label | input.review.object.metadata.labels[label]}
          required := {label | label := input.parameters.labels[_]}
          missing := required - provided
          count(missing) > 0
          msg := sprintf("Missing required labels: %v", [missing])
        }

# Constraint (policy instance)
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sRequiredLabels
metadata:
  name: require-app-labels
spec:
  match:
    kinds:
      - apiGroups: [""]
        kinds: ["Pod"]
  parameters:
    labels: ["app", "env", "owner"]
```

**Kyverno vs OPA Gatekeeper:**

| Feature            | Kyverno              | OPA Gatekeeper       |
| ------------------ | -------------------- | -------------------- |
| Language           | YAML                 | Rego                 |
| Learning curve     | Easy                 | Steep                |
| Policy library     | 300+ ready-made      | Smaller library      |
| Mutation           | Native               | Supported            |
| Generation         | Native               | Limited              |
| Image verification | Native               | Via external tool    |
| Best for           | Teams that hate Rego | Teams that love Rego |

**Verdict:** Kyverno for most teams (YAML-native, easier). Gatekeeper if you need complex logic or already use OPA.

______________________________________________________________________

## Runtime Security with Falco

eBPF-based threat detection. Watches syscalls, network, file access in real-time.

### Installation

```bash
# Helm install
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
helm install falco falcosecurity/falco \
  --namespace falco --create-namespace \
  --set falco.grpc.enabled=true \
  --set falco.grpcOutput.enabled=true
```

### Custom Rules

```yaml
# /etc/falco/rules.d/custom-rules.yaml

# Detect reverse shell
- rule: Reverse Shell Detected
  desc: Detect reverse shell connections
  condition: >
    spawned_process and (
      (proc.name in (bash, sh, zsh) and
       proc.args contains "-i" and
       (proc.args contains "/dev/tcp" or proc.args contains "/dev/udp"))
      or
      (proc.name = nc and proc.args contains "-e")
      or
      (proc.name in (python, python3) and proc.args contains "socket")
    )
  output: >
    Reverse shell detected
    (user=%user.name container=%container.name image=%container.image.repository
    proc=%proc.cmdline)
  priority: CRITICAL
  tags: [shell, reverse_shell, mitre_execution]

# Detect crypto mining
- rule: Crypto Mining Detected
  desc: Detect crypto mining processes
  condition: >
    spawned_process and (
      proc.name in (xmrig, minerd, ccminer, ethminer, cryptonight) or
      proc.args contains "stratum+tcp" or
      proc.args contains "cryptonight"
    )
  output: >
    Crypto mining process detected
    (user=%user.name container=%container.name proc=%proc.cmdline)
  priority: CRITICAL
  tags: [mining, malware]

# Detect /etc/shadow access
- rule: Read sensitive file
  desc: Attempt to read sensitive files
  condition: >
    open_read and
    fd.name in (/etc/shadow, /etc/sudoers, /etc/pam.conf, /etc/security/pwquality.conf)
  output: >
    Sensitive file read
    (user=%user.name file=%fd.name container=%container.name proc=%proc.cmdline)
  priority: WARNING
  tags: [filesystem, mitre_credential_access]

# Detect container escape attempt
- rule: Launch Privileged Container
  desc: Detect attempt to launch privileged container
  condition: >
    container and
    container.privileged=true
  output: >
    Privileged container launched
    (user=%user.name container=%container.name image=%container.image.repository)
  priority: CRITICAL
  tags: [container, escape]

# Detect service account token access
- rule: ServiceAccount Token Access
  desc: Detect access to Kubernetes service account token
  condition: >
    open_read and
    fd.name startswith /var/run/secrets/kubernetes.io/serviceaccount/
  output: >
    Service account token accessed
    (user=%user.name file=%fd.name container=%container.name proc=%proc.cmdline)
  priority: WARNING
  tags: [kubernetes, credential_access]
```

### Integration with SIEM

```yaml
# Ship to Elasticsearch
helm install falco falcosecurity/falco \
  --set falco.jsonOutput=true \
  --set falco.httpOutput.enabled=true \
  --set falco.httpOutput.url=http://elasticsearch:9200/_bulk

# Ship to Slack
falco:
  programOutput:
    enabled: true
    program: jq -r .output | falcosidekick
```

______________________________________________________________________

## Hardening Checklist

### Image Hardening

- [ ] Use minimal base images (distroless, scratch, alpine)
- [ ] Don't run as root (USER directive in Dockerfile)
- [ ] Scan images in CI/CD (Trivy/Grype, fail on HIGH/CRITICAL)
- [ ] Sign images (Cosign, enforce in admission)
- [ ] Pin versions (no `latest`, use SHA256 digests)
- [ ] Multi-stage builds (don't ship build tools)
- [ ] No secrets in layers (check with dive, trivy)
- [ ] Generate SBOM (syft/trivy)
- [ ] Scan dependencies (npm audit, pip-audit, etc)
- [ ] Remove unnecessary packages (minimize attack surface)

### Pod Hardening

- [ ] Non-root user (`runAsNonRoot: true`)
- [ ] Read-only filesystem (`readOnlyRootFilesystem: true`)
- [ ] Drop all capabilities (`capabilities.drop: [ALL]`)
- [ ] No privilege escalation (`allowPrivilegeEscalation: false`)
- [ ] Seccomp profile (`seccompProfile.type: RuntimeDefault`)
- [ ] Resource limits set (CPU/memory limits + requests)
- [ ] No host namespaces (hostNetwork/hostPID/hostIPC: false)
- [ ] No hostPath volumes (use PVCs)
- [ ] Service account with minimal RBAC
- [ ] Pod Security Standard: Restricted

### Cluster Hardening

- [ ] RBAC enabled and locked down (principle of least privilege)
- [ ] Pod Security Standards enforced (Restricted by default)
- [ ] Network Policies (default deny, explicit allow)
- [ ] Admission controllers (Kyverno/Gatekeeper blocking bad configs)
- [ ] Image signing enforcement (Cosign + admission)
- [ ] Secrets encrypted at rest (KMS or EncryptionConfiguration)
- [ ] Audit logging enabled (catch-all for forensics)
- [ ] Runtime security (Falco monitoring syscalls)
- [ ] Node OS hardening (CIS benchmarks, SELinux/AppArmor)
- [ ] Private registry only (no public Docker Hub pulls)
- [ ] mTLS between services (service mesh if you hate yourself)
- [ ] Regular updates (nodes, Kubernetes, dependencies)

### CI/CD Hardening

- [ ] Scan code (SAST - Semgrep, SonarQube)
- [ ] Scan dependencies (SCA - Snyk, Dependabot)
- [ ] Scan images before push (Trivy in pipeline)
- [ ] Sign images after build (Cosign in pipeline)
- [ ] Generate SBOM (Syft/Trivy, store in registry)
- [ ] Scan IaC configs (Checkov, tfsec)
- [ ] Separate build and runtime credentials (don't ship AWS keys)
- [ ] Immutable tags (v1.2.3, not latest)
- [ ] Registry scanning (continuous, detect new CVEs)
- [ ] Fail builds on HIGH/CRITICAL (don't ship vulnerable code)

______________________________________________________________________

## OWASP Kubernetes Top 10 (2024)

The hits that keep on hitting. Learn these, fix these.

1. **K01: Insecure Workload Configurations** - Privileged pods, host namespaces, no resource limits
1. **K02: Supply Chain Vulnerabilities** - Vulnerable images, unsigned artifacts, compromised registries
1. **K03: Overly Permissive RBAC** - Cluster-admin everywhere, no principle of least privilege
1. **K04: Lack of Centralized Policy Enforcement** - No admission controllers, anything goes
1. **K05: Inadequate Logging & Monitoring** - Blind to attacks, no audit logs, no runtime detection
1. **K06: Broken Authentication** - Weak service account tokens, exposed credentials, no mTLS
1. **K07: Missing Network Segmentation** - No Network Policies, flat network, lateral movement easy
1. **K08: Secrets Management Failures** - Secrets in etcd unencrypted, hardcoded, in env vars
1. **K09: Misconfigured Cluster Components** - Insecure API server, etcd exposed, kubelet misconfigured
1. **K10: Outdated & Vulnerable Components** - Old Kubernetes, unpatched nodes, CVE-laden images

**Fix all 10 or don't complain when you get pwned.**

______________________________________________________________________

## Worth Checking

<div class="grid cards" markdown>

- 📚 __Official Resources__

    ______________________________________________________________________

    [Kubernetes Security Docs](https://kubernetes.io/docs/concepts/security/)

    [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)

    [CNCF TAG Security](https://github.com/cncf/tag-security)

    [OWASP Kubernetes Top 10](https://owasp.org/www-project-kubernetes-top-ten/)

- 🧪 __Hands-On Labs__

    ______________________________________________________________________

    [Kubernetes Goat](https://github.com/madhuakula/kubernetes-goat)

    [Katacoda Security Labs](https://www.katacoda.com/courses/kubernetes/security-introduction)

    [Attack Defense Kubernetes](https://www.attackdefense.com/)

- 💻 __Tools & Scanners__

    ______________________________________________________________________

    [Trivy Scanner](https://github.com/aquasecurity/trivy)

    [Grype Scanner](https://github.com/anchore/grype)

    [Falco Runtime Security](https://falco.org/)

    [Kyverno Policies](https://kyverno.io/)

    [OPA Gatekeeper](https://open-policy-agent.github.io/gatekeeper/)

    [Cosign Image Signing](https://github.com/sigstore/cosign)

- 🔥 __Real-World Threats__

    ______________________________________________________________________

    [Aqua Security Blog](https://blog.aquasec.com/)

    [Sysdig Threat Research](https://sysdig.com/blog/tag/threat-research/)

    [MITRE ATT&CK Containers](https://attack.mitre.org/matrices/enterprise/containers/)

    [CVE Details - Docker](https://www.cvedetails.com/product/28125/Docker-Docker.html)

- 🛡️ __Defense Tools__

    ______________________________________________________________________

    [External Secrets Operator](https://github.com/external-secrets/external-secrets)

    [Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets)

    [Docker Bench Security](https://github.com/docker/docker-bench-security)

    [Kubernetes Hardening Guide (NSA)](https://media.defense.gov/2022/Aug/29/2003066362/-1/-1/0/CTR_KUBERNETES_HARDENING_GUIDANCE_1.2_20220829.PDF)

- 📰 __Community & News__

    ______________________________________________________________________

    [r/kubernetes](https://reddit.com/r/kubernetes)

    [Container Security Newsletter](https://container-security.site/)

    [tl;dr sec](https://tldrsec.com/)

    [Kubernetes Slack #security](https://kubernetes.slack.com/)

</div>

______________________________________________________________________

## Common CVEs & Exploits (2024-2026)

**Container Escapes:**

- **CVE-2024-21626** - Leaky Vessels, runc container escape via file descriptor leak
- **CVE-2024-3094** - XZ Utils backdoor (supply chain, not container-specific but affected many images)
- **CVE-2023-2878** - Kubernetes secret-edit escalation
- **CVE-2022-0492** - Cgroups container escape (old but still exploited)

**Registry/Supply Chain:**

- **CVE-2024-5321** - Docker BuildKit privilege escalation
- Malicious images in Docker Hub (ongoing, cryptominers mostly)
- Typosquatting attacks (fake tensorflow, pytorch packages)

**Runtime:**

- **CVE-2024-1394** - Golang SSH vulnerability (affected many container images)
- Crypto mining malware in public images (50% of malicious containers)
- Log4Shell still found in legacy containers (CVE-2021-44228, won't die)

**Defense:** Scan continuously (new CVEs daily), update base images monthly, don't trust public registries.

______________________________________________________________________

## See Also

- [Kubernetes](kubernetes.md) - Core Kubernetes concepts and operations
- [Docker](docker.md) - Container runtime basics
- [Helm](helm.md) - Package management for Kubernetes
- Network Security - Service mesh, mTLS, zero trust
- Cloud Security - AWS/Azure/GCP-specific container security

______________________________________________________________________

**Last Updated:** 2026-01-14 **Vibe Check:** 🔥 Critical - Container security is no longer optional. Supply chain attacks are real, runtime threats are constant, and every CVE matters. The tooling is mature, the knowledge is available, but most teams still ship vulnerable containers. Don't be most teams.
