---
title: Infrastructure & Cloud Security
description: Network security, cloud platform security (AWS/Azure/GCP), container security, IAM, endpoint protection
---

# :fontawesome-solid-server: Infrastructure & Cloud Security

Securing the foundation. Network segmentation, firewalls, IAM, cloud configurations, container hardening. Cloud security is shared responsibility—providers secure infrastructure, you secure configuration. Misconfigured S3 buckets still leak data in 2026. Defense in depth prevents lateral movement.

!!! tip "2026 Update"
    Cloud-native security tools mandatory (CSPM, CWPP, CNAPP). Zero Trust Architecture standard. Container security critical (90% workloads containerized). Identity is perimeter (IAM everywhere). eBPF-based security (Cilium, Falco). Kubernetes security complex but essential.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Core Disciplines"

    **Network Security:**
    ```bash
    # Network segmentation (VLANs, subnets)
    # DMZ: Public-facing web servers
    # Internal: Application servers
    # Database: Data tier (no internet access)
    # Management: Jump boxes, bastion hosts

    # Firewall rules (iptables example)
    # Default deny all traffic
    iptables -P INPUT DROP
    iptables -P FORWARD DROP
    iptables -P OUTPUT ACCEPT  # (1)!

    # Allow SSH from management network only
    iptables -A INPUT -p tcp --dport 22 -s 10.0.1.0/24 -j ACCEPT

    # Allow HTTPS from anywhere
    iptables -A INPUT -p tcp --dport 443 -j ACCEPT

    # AWS Security Groups (stateful firewall)
    # Inbound rules (whitelist)
    aws ec2 authorize-security-group-ingress \
      --group-id sg-123456 \
      --protocol tcp \
      --port 443 \
      --cidr 0.0.0.0/0  # (2)!

    # Network Access Control Lists (NACLs - stateless)
    aws ec2 create-network-acl-entry \
      --network-acl-id acl-123456 \
      --ingress \
      --rule-number 100 \
      --protocol tcp \
      --port-range From=443,To=443 \
      --cidr-block 0.0.0.0/0 \
      --rule-action allow
    ```

    1. Default deny principle (explicit allow rules only)
    2. Security Groups are stateful (return traffic auto-allowed)

    **Cloud Platform Security (AWS):**
    ```bash
    # IAM Best Practices
    # 1. No root account usage (use IAM users/roles)
    # 2. MFA on all accounts
    # 3. Least privilege (minimal permissions)
    # 4. Use roles for EC2/Lambda (no hardcoded keys)

    # IAM policy example (S3 read-only)
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "s3:GetObject",
            "s3:ListBucket"
          ],
          "Resource": [
            "arn:aws:s3:::my-bucket/*",
            "arn:aws:s3:::my-bucket"
          ]
        }
      ]
    }  # (1)!

    # S3 bucket security
    # Block public access (default)
    aws s3api put-public-access-block \
      --bucket my-bucket \
      --public-access-block-configuration \
      "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"  # (2)!

    # Enable bucket encryption
    aws s3api put-bucket-encryption \
      --bucket my-bucket \
      --server-side-encryption-configuration \
      '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

    # CloudTrail (audit logging)
    aws cloudtrail create-trail \
      --name my-trail \
      --s3-bucket-name my-cloudtrail-bucket  # (3)!
    aws cloudtrail start-logging --name my-trail

    # GuardDuty (threat detection)
    aws guardduty create-detector --enable  # (4)!
    ```

    1. IAM policies use least privilege (only required actions)
    2. S3 public access block prevents accidental exposure
    3. CloudTrail logs all API calls (audit trail)
    4. GuardDuty uses ML for threat detection (automated)

    **Container Security:**
    ```bash
    # Docker image scanning (Trivy)
    trivy image nginx:latest  # (1)!
    trivy image --severity HIGH,CRITICAL myapp:v1.0

    # Dockerfile security best practices
    FROM python:3.12-slim  # (2)!

    # Create non-root user
    RUN useradd -m -u 1000 appuser
    USER appuser  # (3)!

    # Copy only necessary files
    WORKDIR /app
    COPY requirements.txt .
    RUN pip install --no-cache-dir -r requirements.txt
    COPY --chown=appuser:appuser . .

    # No secrets in image
    # Use environment variables or secret managers

    EXPOSE 8080
    CMD ["python", "app.py"]

    # Kubernetes Pod Security Standards
    apiVersion: v1
    kind: Pod
    metadata:
      name: secure-pod
    spec:
      securityContext:
        runAsNonRoot: true  # (4)!
        runAsUser: 1000
        fsGroup: 1000
      containers:
      - name: app
        image: myapp:v1.0
        securityContext:
          allowPrivilegeEscalation: false
          readOnlyRootFilesystem: true  # (5)!
          capabilities:
            drop:
            - ALL
        resources:
          limits:
            memory: "512Mi"
            cpu: "500m"
    ```

    1. Trivy scans for CVEs in container images
    2. Use minimal base images (slim, alpine, distroless)
    3. Run containers as non-root (security best practice)
    4. Kubernetes security contexts enforce constraints
    5. Read-only root filesystem prevents tampering

    **Identity & Access Management:**
    ```python
    # Zero Trust Access (BeyondCorp model)
    # 1. Verify explicitly (never trust, always verify)
    # 2. Least privilege access
    # 3. Assume breach (limit blast radius)

    # AWS IAM role assumption (no hardcoded credentials)
    import boto3

    # EC2/Lambda automatically uses instance profile
    s3 = boto3.client('s3')  # No keys needed!  # (1)!
    s3.list_buckets()

    # Azure Managed Identity
    from azure.identity import DefaultAzureCredential
    from azure.storage.blob import BlobServiceClient

    credential = DefaultAzureCredential()  # (2)!
    blob_client = BlobServiceClient(
        account_url="https://myaccount.blob.core.windows.net",
        credential=credential
    )

    # GCP Workload Identity
    # Kubernetes service account -> GCP service account mapping
    # No JSON key files needed

    # Multi-factor authentication enforcement
    # AWS IAM policy requiring MFA
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Deny",
          "Action": "*",
          "Resource": "*",
          "Condition": {
            "BoolIfExists": {
              "aws:MultiFactorAuthPresent": "false"
            }
          }
        }
      ]
    }  # (3)!
    ```

    1. AWS instance profiles eliminate hardcoded credentials
    2. Azure Managed Identity auto-rotates credentials
    3. IAM policy denies all actions without MFA

    **Real talk:**

    - Cloud misconfigurations #1 cause of breaches (Gartner: 99% through 2025)
    - IAM complexity grows exponentially (AWS 10,000+ actions)
    - Container escape vulnerabilities exist (runC CVE-2019-5736)
    - Network security insufficient (lateral movement still possible)
    - Least privilege hard to implement (easier to grant admin)
    - CSPM tools expensive but necessary (Wiz, Orca, Prisma Cloud)

=== ":fontawesome-solid-bolt: Common Patterns"

    **Cloud Security Posture Management (CSPM):**
    ```bash
    # AWS Config (compliance monitoring)
    aws configservice put-config-rule \
      --config-rule '{
        "ConfigRuleName": "s3-bucket-public-read-prohibited",
        "Source": {
          "Owner": "AWS",
          "SourceIdentifier": "S3_BUCKET_PUBLIC_READ_PROHIBITED"
        }
      }'  # (1)!

    # Azure Policy (governance)
    az policy definition create \
      --name 'require-encryption' \
      --rules '{
        "if": {
          "field": "type",
          "equals": "Microsoft.Storage/storageAccounts"
        },
        "then": {
          "effect": "audit",
          "details": {
            "type": "Microsoft.Storage/storageAccounts/encryptionSettings"
          }
        }
      }'

    # GCP Security Command Center
    gcloud scc assets list ORGANIZATION_ID \
      --filter="securityCenterProperties.resourceType=\"google.compute.Instance\""  # (2)!

    # Open source CSPM (CloudSploit)
    npm install -g cloudsploit
    cloudsploit scan --cloud aws --config config.js  # (3)!
    ```

    1. AWS Config monitors compliance with rules
    2. GCP SCC centralizes security findings
    3. CloudSploit open-source alternative to commercial CSPM

    **Kubernetes Security:**
    ```yaml
    # Network Policies (Calico, Cilium)
    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: deny-all-ingress
      namespace: production
    spec:
      podSelector: {}
      policyTypes:
      - Ingress  # (1)!

    ---
    # Allow only from specific namespace
    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: allow-from-frontend
      namespace: backend
    spec:
      podSelector:
        matchLabels:
          app: api
      ingress:
      - from:
        - namespaceSelector:
            matchLabels:
              name: frontend  # (2)!
        ports:
        - protocol: TCP
          port: 8080

    # RBAC (Role-Based Access Control)
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      namespace: production
      name: pod-reader
    rules:
    - apiGroups: [""]
      resources: ["pods"]
      verbs: ["get", "list"]  # (3)!

    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      name: read-pods
      namespace: production
    subjects:
    - kind: ServiceAccount
      name: my-app
      namespace: production
    roleRef:
      kind: Role
      name: pod-reader
      apiGroup: rbac.authorization.k8s.io

    # Admission Controllers (OPA Gatekeeper)
    apiVersion: constraints.gatekeeper.sh/v1beta1
    kind: K8sRequiredLabels
    metadata:
      name: require-owner-label
    spec:
      match:
        kinds:
        - apiGroups: [""]
          kinds: ["Namespace"]
      parameters:
        labels:
        - key: "owner"  # (4)!
    ```

    1. Default deny all ingress (explicit allow required)
    2. Namespace-based segmentation (micro-segmentation)
    3. RBAC least privilege (only read pods, no create/delete)
    4. OPA Gatekeeper enforces policies (required labels, resource limits)

    **Secrets Management:**
    ```bash
    # AWS Secrets Manager
    aws secretsmanager create-secret \
      --name prod/db/password \
      --secret-string "MySecurePassword123!"  # (1)!

    # Retrieve secret (application)
    aws secretsmanager get-secret-value \
      --secret-id prod/db/password \
      --query SecretString \
      --output text

    # HashiCorp Vault
    # Start Vault dev server
    vault server -dev

    # Store secret
    vault kv put secret/myapp/config \
      db_password="MySecurePassword123!" \
      api_key="abc123"  # (2)!

    # Retrieve secret (application)
    vault kv get -field=db_password secret/myapp/config

    # Kubernetes Secrets (encrypted at rest)
    kubectl create secret generic db-secret \
      --from-literal=password='MySecurePassword123!'  # (3)!

    # External Secrets Operator (sync from Vault/AWS Secrets Manager)
    apiVersion: external-secrets.io/v1beta1
    kind: ExternalSecret
    metadata:
      name: db-secret
    spec:
      refreshInterval: 1h
      secretStoreRef:
        name: aws-secrets-manager
        kind: SecretStore
      target:
        name: db-secret
      data:
      - secretKey: password
        remoteRef:
          key: prod/db/password  # (4)!
    ```

    1. AWS Secrets Manager auto-rotates secrets
    2. Vault dynamic secrets (short-lived, auto-revoked)
    3. Kubernetes secrets base64-encoded (NOT encrypted by default)
    4. External Secrets Operator syncs from external secret stores

    **Zero Trust Network Architecture:**
    ```markdown
    ## Zero Trust Principles

    ### 1. Verify Explicitly
    - Multi-factor authentication (MFA) everywhere
    - Device compliance checks (EDR agent installed, patched)
    - Continuous authentication (re-verify periodically)

    ### 2. Least Privilege Access
    - Just-in-time (JIT) access (time-limited permissions)
    - Just-enough-access (JEA) (minimal permissions)
    - Privileged Access Management (PAM) for admin

    ### 3. Assume Breach
    - Micro-segmentation (limit lateral movement)
    - Network traffic encryption (mTLS between services)
    - Logging and monitoring (detect anomalies)

    ## Implementation (BeyondCorp/Zero Trust Access)

    **Identity Provider (IdP):**
    - Okta, Azure AD, Google Workspace  # (1)!
    - SAML/OIDC for SSO

    **Device Trust:**
    - MDM (Mobile Device Management)
    - Endpoint detection (CrowdStrike, SentinelOne)

    **Access Proxy:**
    - Google BeyondCorp, Cloudflare Access, Zscaler
    - No VPN (direct access via proxy)  # (2)!

    **Enforcement:**
    - Context-aware policies (user + device + location)
    - Continuous monitoring (anomaly detection)
    ```

    1. Centralized identity management (single source of truth)
    2. Zero Trust eliminates VPN (context-based access instead)

    **Why this works:**

    - Defense in depth (network, host, application layers)
    - Least privilege reduces blast radius
    - Encryption protects data in transit and at rest
    - Automation catches misconfigurations (CSPM)
    - Zero Trust assumes breach (limits lateral movement)

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Immutable infrastructure** - Rebuild, don't patch (containers, IaC)
        - **Encryption everywhere** - At rest (AES-256), in transit (TLS 1.3+)
        - **Least privilege** - IAM policies minimal permissions
        - **Network segmentation** - Micro-segmentation prevents lateral movement
        - **Secrets rotation** - Auto-rotate credentials (AWS Secrets Manager)
        - **Audit logging** - CloudTrail, Azure Monitor, GCP Cloud Logging
        - **Vulnerability scanning** - Continuous (Trivy, Qualys, Tenable)

    !!! warning "Cloud Security Reality"
        - **Shared responsibility** - Provider secures infra, you secure config
        - **IAM complexity** - AWS 10,000+ permissions (hard to manage)
        - **Visibility gaps** - Multi-cloud increases blind spots
        - **Compliance drift** - Manual configs break compliance
        - **Cost explosion** - CSPM tools $50k-500k/year
        - **Alert fatigue** - CSPM generates thousands of alerts
        - **Multi-cloud chaos** - Different security models per provider

    !!! tip "Essential Tools"
        - **CSPM** - Wiz ($$$), Orca ($$$), Prisma Cloud ($$$), CloudSploit (free)
        - **Container** - Trivy (free), Snyk ($), Aqua ($), Sysdig ($)
        - **Secrets** - HashiCorp Vault (free/$$), AWS Secrets Manager ($)
        - **Network** - Calico (free), Cilium (free), Istio service mesh (free)
        - **CNAPP** - Wiz, Orca, Palo Alto Prisma Cloud (comprehensive platforms)
        - **Kubernetes** - Falco (free), kube-bench (free), OPA Gatekeeper (free)

    !!! danger "Gotchas"
        - **S3 buckets** - Still public by default (in old accounts)
        - **IMDSv1** - EC2 metadata v1 vulnerable (use IMDSv2)
        - **Over-permissive IAM** - Admin everywhere (audit regularly)
        - **No CloudTrail** - Blind to API calls (attackers disable first)
        - **Container escape** - Privileged containers dangerous
        - **Kubernetes RBAC** - Default service account has permissions
        - **Secrets in env vars** - Visible in process list (use secret managers)

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning & Certifications

### :fontawesome-solid-book-open: Certifications

- **[CCSP](https://www.isc2.org/Certifications/CCSP)** - $749, Certified Cloud Security Professional
- **[CCSK](https://cloudsecurityalliance.org/education/ccsk/)** - $395, Cloud Security Knowledge
- **[CKS](https://training.linuxfoundation.org/certification/certified-kubernetes-security-specialist/)** - $395, Certified Kubernetes Security Specialist
- **[AWS Security Specialty](https://aws.amazon.com/certification/certified-security-specialty/)** - $300, AWS-specific

### :fontawesome-solid-rocket: Practice

- **[flAWS](http://flaws.cloud/)** - Free, AWS security challenges
- **[CloudGoat](https://github.com/RhinoSecurityLabs/cloudgoat)** - Free, vulnerable-by-design AWS environments

______________________________________________________________________

## :fontawesome-solid-wrench: Essential Toolkit

| Category | Tools | Purpose |
|----------|-------|---------|
| **CSPM** | Wiz, Orca, Prisma Cloud, CloudSploit | Cloud security posture |
| **Container** | Trivy, Snyk, Aqua, Falco | Image scanning, runtime protection |
| **Secrets** | Vault, AWS Secrets Manager, External Secrets | Secret management |
| **Network** | Calico, Cilium, Istio | Network policies, service mesh |
| **IAM** | AWS IAM, Azure AD, GCP IAM | Identity and access management |
| **Kubernetes** | kube-bench, OPA Gatekeeper, Falco | K8s security hardening |

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-cloud: **Misconfiguration Minefield** - Cloud breaches from misconfig (99%). IAM complexity overwhelming. CSPM tools expensive but necessary. Container security critical (90% workloads). Zero Trust replacing VPNs. Kubernetes security steep learning curve.

**Tags:** infrastructure-security, cloud-security, network-security, container-security, iam, kubernetes-security
