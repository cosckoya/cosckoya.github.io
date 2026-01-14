# ARCHITECTURE VISUAL: 5-BLOCK STRUCTURE

**Date**: 2026-01-08
**Supporting Document**: SITE_ARCHITECTURE_PROPOSAL.md

---

## 1. CURRENT STATE (6-BLOCK) VS PROPOSED (5-BLOCK)

### Current Architecture (6 Blocks)

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃              cosckoya.github.io                       ┃
┃          "It's dangerous to go alone!"                ┃
┗━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                     │
    ┌────────────────┼────────────────┬────────────────┐
    │                │                │                │
    ▼                ▼                ▼                ▼
┌─────────┐   ┌──────────┐   ┌────────────┐   ┌─────────────┐
│SysAdmin │   │  Cloud   │   │   DevOps   │   │Cybersecurity│
│    80%  │   │   40%    │   │     95%    │   │     60%     │
└─────────┘   └──────────┘   └────────────┘   └─────────────┘
    │                │                │                │
    └────────────────┼────────────────┼────────────────┘
                     │                │
                     ▼                ▼
         ┌────────────────┐   ┌──────────────┐
         │Containerization│   │ Artificial   │
         │      60%       │   │Intelligence  │
         └────────────────┘   │   10% ⚠️     │
                              └──────────────┘

Legend: Percentage = Content maturity
        ⚠️ = Problematic (nearly empty)
```

**Issues:**

- AI section is 90% empty (13 placeholder directories, 2 files)
- 6 items approaches cognitive load limit
- AI content conceptually belongs in DevOps (MLOps)

---

### Proposed Architecture (5 Blocks)

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃              cosckoya.github.io                       ┃
┃          "It's dangerous to go alone!"                ┃
┗━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                     │
    ┌────────────────┼────────────────┬────────────────┐
    │                │                │                │
    ▼                ▼                ▼                ▼
┌──────────┐   ┌──────────┐   ┌────────────┐   ┌─────────────┐
│Infrastruc│   │  Cloud   │   │  DevOps &  │   │Containerizat│
│ -ture &  │   │Platforms │   │ Automation │   │ion & Orches │
│ SysAdmin │   │          │   │            │   │   tration   │
│   80%    │   │   40%    │   │  95% + AI  │   │     60%     │
└──────────┘   └──────────┘   └────────────┘   └─────────────┘
                                     │
                                     ├─ CI/CD
                                     ├─ IaC
                                     ├─ Monitoring
                                     └─ AI/ML Ops ⭐
    │                │                │                │
    └────────────────┼────────────────┼────────────────┘
                     │                │
                     ▼                ▼
                              ┌──────────┐
                              │ Security │
                              │    60%   │
                              └──────────┘

Improvements:
✅ All 5 sections have meaningful content
✅ AI integrated into DevOps (MLOps)
✅ Optimal navigation count (5 items)
✅ Clear domain boundaries
```

---

## 2. DETAILED CATEGORY BREAKDOWN

### 2.1 Infrastructure & SysAdmin (Foundation Layer)

```
┌────────────────────────────────────────────────────┐
│          INFRASTRUCTURE & SYSADMIN                 │
├────────────────────────────────────────────────────┤
│                                                    │
│  ┌─────────────────┐      ┌──────────────────┐  │
│  │ Operating Systems│      │   Networking     │  │
│  │ • Linux          │      │ • TCP/IP         │  │
│  │ • Windows Server │      │ • DNS/DHCP       │  │
│  │ • User Management│      │ • Firewalls      │  │
│  │ • Permissions    │      │ • VPN            │  │
│  └─────────────────┘      └──────────────────┘  │
│                                                    │
│  ┌─────────────────┐      ┌──────────────────┐  │
│  │Storage & Backups│      │  Virtualization  │  │
│  │ • RAID           │      │ • VMware ESXi    │  │
│  │ • NAS/SAN        │      │ • Hyper-V        │  │
│  │ • Backup (3-2-1) │      │ • KVM/Proxmox    │  │
│  │ • Disaster Recov │      │ • VirtualBox     │  │
│  └─────────────────┘      └──────────────────┘  │
│                                                    │
│  ┌─────────────────┐      ┌──────────────────┐  │
│  │    Scripting     │      │  Databases Basic│  │
│  │ • Bash           │      │ • MySQL/MariaDB  │  │
│  │ • PowerShell     │      │ • PostgreSQL     │  │
│  │ • Python         │      │ • SQL Server     │  │
│  │ • Automation     │      │ • Backup/Restore │  │
│  └─────────────────┘      └──────────────────┘  │
│                                                    │
│         Target: SysAdmins, Infra Engineers        │
└────────────────────────────────────────────────────┘
```

---

### 2.2 Cloud Platforms (Multi-Cloud Layer)

```
┌────────────────────────────────────────────────────┐
│              CLOUD PLATFORMS                       │
├────────────────────────────────────────────────────┤
│                                                    │
│  ╔═══════════╗    ╔═══════════╗    ╔═══════════╗ │
│  ║    AWS    ║    ║   Azure   ║    ║    GCP    ║ │
│  ╚═══════════╝    ╚═══════════╝    ╚═══════════╝ │
│       │                 │                 │        │
│       ├─ EC2/Lambda     ├─ VMs/Functions  ├─ Compute │
│       ├─ S3/EBS         ├─ Blob/Disks     ├─ Storage │
│       ├─ VPC            ├─ VNet           ├─ VPC    │
│       ├─ RDS/DynamoDB   ├─ SQL/CosmosDB   ├─ Cloud SQL │
│       ├─ IAM/KMS        ├─ AAD/Key Vault  ├─ IAM    │
│       └─ CloudWatch     └─ Monitor        └─ Ops    │
│                                                    │
│  ┌──────────────────────────────────────────────┐ │
│  │        Cross-Cloud Topics                    │ │
│  │  • Cloud-Native Architecture                 │ │
│  │  • Serverless Computing                      │ │
│  │  • FinOps & Cost Optimization                │ │
│  │  • Multi-Cloud Strategy                      │ │
│  │  • Cloud Security Best Practices             │ │
│  └──────────────────────────────────────────────┘ │
│                                                    │
│      Target: Cloud Architects, Solutions Arch     │
└────────────────────────────────────────────────────┘
```

---

### 2.3 DevOps & Automation (Workflow Layer)

```
┌────────────────────────────────────────────────────┐
│           DEVOPS & AUTOMATION                      │
├────────────────────────────────────────────────────┤
│                                                    │
│  ┌─────────────────┐      ┌──────────────────┐  │
│  │ Version Control │      │     CI/CD        │  │
│  │ • Git            │      │ • Jenkins        │  │
│  │ • GitHub/GitLab  │      │ • GitHub Actions │  │
│  │ • Branching      │      │ • GitLab CI      │  │
│  │ • Code Review    │      │ • Azure DevOps   │  │
│  └─────────────────┘      └──────────────────┘  │
│                                                    │
│  ┌─────────────────┐      ┌──────────────────┐  │
│  │  Infrastructure │      │  Configuration   │  │
│  │    as Code      │      │   Management     │  │
│  │ • Terraform     │      │ • Ansible        │  │
│  │ • CloudFormation│      │ • Puppet         │  │
│  │ • Pulumi        │      │ • Chef           │  │
│  │ • CDK           │      │ • SaltStack      │  │
│  └─────────────────┘      └──────────────────┘  │
│                                                    │
│  ┌─────────────────┐      ┌──────────────────┐  │
│  │  Monitoring &   │      │  AI/ML Ops ⭐    │  │
│  │  Observability  │      │                  │  │
│  │ • Prometheus    │      │ • MLOps Pipelines│  │
│  │ • Grafana       │      │ • Model Deploy   │  │
│  │ • ELK Stack     │      │ • AIOps          │  │
│  │ • Jaeger/Zipkin │      │ • Feature Stores │  │
│  └─────────────────┘      │ • ML Monitoring  │  │
│                            └──────────────────┘  │
│  ┌─────────────────┐      ┌──────────────────┐  │
│  │   DevSecOps     │      │ Secrets Mgmt     │  │
│  │ • SAST/DAST     │      │ • HashiCorp Vault│  │
│  │ • Security Scan │      │ • AWS Secrets    │  │
│  │ • Compliance    │      │ • Azure Key Vault│  │
│  └─────────────────┘      └──────────────────┘  │
│                                                    │
│     Target: DevOps Engineers, SREs, ML Eng       │
└────────────────────────────────────────────────────┘
```

---

### 2.4 Containerization & Orchestration (Runtime Layer)

```
┌────────────────────────────────────────────────────┐
│      CONTAINERIZATION & ORCHESTRATION              │
├────────────────────────────────────────────────────┤
│                                                    │
│  ╔═══════════════════════════════════════════╗   │
│  ║              DOCKER                       ║   │
│  ╚═══════════════════════════════════════════╝   │
│  │ • Images & Dockerfiles                         │
│  │ • Container Lifecycle                          │
│  │ • Docker Compose                               │
│  │ • Networking & Volumes                         │
│  │ • Registries (Hub, GHCR, ECR)                  │
│  └────────────────────────────────────────────    │
│                                                    │
│  ╔═══════════════════════════════════════════╗   │
│  ║            KUBERNETES                     ║   │
│  ╚═══════════════════════════════════════════╝   │
│  │ • Architecture & Components                    │
│  │ • Pods, Deployments, Services                  │
│  │ • Networking (CNI, Ingress)                    │
│  │ • Storage (PV, PVC, StorageClasses)            │
│  │ • ConfigMaps & Secrets                         │
│  │ • Helm Charts                                  │
│  │ • Service Mesh (Istio, Linkerd)                │
│  └────────────────────────────────────────────    │
│                                                    │
│  ┌─────────────────┐      ┌──────────────────┐  │
│  │Container Security│      │ Alternative Runtimes│
│  │ • Image Scanning │      │ • Podman         │  │
│  │ • Admission Ctrl │      │ • containerd     │  │
│  │ • Runtime Protect│      │ • CRI-O          │  │
│  │ • RBAC          │      │ • Docker Swarm   │  │
│  └─────────────────┘      └──────────────────┘  │
│                                                    │
│   Target: Platform Eng, K8s Admins, DevOps       │
└────────────────────────────────────────────────────┘
```

---

### 2.5 Security (Protection Layer)

```
┌────────────────────────────────────────────────────┐
│                 SECURITY                           │
├────────────────────────────────────────────────────┤
│                                                    │
│  ┌─────────────────┐      ┌──────────────────┐  │
│  │Defensive Security│      │Offensive Security│  │
│  │ • Firewalls      │      │ • Penetration    │  │
│  │ • IDS/IPS        │      │   Testing        │  │
│  │ • Hardening      │      │ • Ethical Hacking│  │
│  │ • Monitoring     │      │ • Bug Bounties   │  │
│  └─────────────────┘      └──────────────────┘  │
│                                                    │
│  ┌─────────────────┐      ┌──────────────────┐  │
│  │Application Sec  │      │ Network Security │  │
│  │ • SAST/DAST      │      │ • VPN            │  │
│  │ • WAF            │      │ • Segmentation   │  │
│  │ • Secure SDLC    │      │ • Zero Trust     │  │
│  │ • API Security   │      │ • Threat Hunting │  │
│  └─────────────────┘      └──────────────────┘  │
│                                                    │
│  ┌─────────────────┐      ┌──────────────────┐  │
│  │   Compliance     │      │ Security Tools   │  │
│  │ • GDPR           │      │ • Kali Linux     │  │
│  │ • HIPAA          │      │ • Burp Suite     │  │
│  │ • PCI-DSS        │      │ • OWASP ZAP      │  │
│  │ • CIS Benchmarks │      │ • Nmap/Metasploit│  │
│  └─────────────────┘      └──────────────────┘  │
│                                                    │
│    Target: Security Engineers, Pentesters         │
└────────────────────────────────────────────────────┘
```

---

## 3. CROSS-CUTTING CONCERNS MAP

```
┌─────────────────────────────────────────────────────────┐
│         CROSS-CUTTING TOPICS & RELATIONSHIPS            │
└─────────────────────────────────────────────────────────┘

                    MONITORING
                        │
        ┌───────────────┼───────────────┐
        │               │               │
   Infrastructure    DevOps      Containerization
        │               │               │
        │               ▼               │
        │         ┌─────────┐          │
        └────────►│SECURITY │◄─────────┘
                  └────┬────┘
                       │
                  All sections
                  reference
                  security


    INFRASTRUCTURE ─────┬────► Provides: OS, Network, Storage
            │            │
            │            └────► Uses: Virtualization
            │
            ├────────────────► Scripting & Automation
            │
            └────────────────► System Hardening


    CLOUD ──────────────┬────► Provides: Cloud VMs, Services
            │            │
            │            └────► Uses: IaC (from DevOps)
            │
            └────────────────► Cloud-Native Patterns


    DEVOPS ─────────────┬────► Provides: CI/CD, IaC, Monitoring
            │            │
            │            ├────► Uses: Containers (from Containerization)
            │            │
            │            ├────► Uses: Cloud (from Cloud)
            │            │
            │            └────► Integrates: AI/ML Ops ⭐
            │
            └────────────────► DevSecOps (bridges to Security)


    CONTAINERIZATION ───┬────► Provides: Docker, K8s
            │            │
            │            ├────► Uses: Cloud platforms for hosting
            │            │
            │            └────► Integrates: Security practices
            │
            └────────────────► Container Orchestration


    SECURITY ───────────┬────► Applies to: All layers
            │            │
            │            ├────► Hardening (Infrastructure)
            │            ├────► Cloud Security (Cloud)
            │            ├────► DevSecOps (DevOps)
            │            ├────► Container Security (Containerization)
            │            │
            └────────────────► Compliance & Auditing
```

---

## 4. USER JOURNEY FLOWS

### 4.1 Journey: System Administrator → DevOps Engineer

```
START: Infrastructure & SysAdmin
   │
   ├─ Learn Linux/Windows fundamentals
   ├─ Master networking & storage
   ├─ Scripting (Bash/PowerShell/Python)
   │
   ▼
NEXT: DevOps & Automation
   │
   ├─ Version control (Git)
   ├─ CI/CD pipelines
   ├─ Infrastructure as Code (Terraform)
   ├─ Configuration management (Ansible)
   │
   ▼
THEN: Containerization & Orchestration
   │
   ├─ Docker fundamentals
   ├─ Kubernetes basics
   ├─ Container orchestration
   │
   ▼
FINALLY: Cloud Platforms
   │
   ├─ AWS/Azure/GCP services
   ├─ Cloud-native architectures
   └─ FinOps & cost optimization
```

---

### 4.2 Journey: Developer → ML Engineer (MLOps)

```
START: DevOps & Automation
   │
   ├─ CI/CD fundamentals
   ├─ Version control best practices
   │
   ▼
FOCUS: AI/ML Operations (within DevOps)
   │
   ├─ MLOps pipelines
   ├─ Model versioning & deployment
   ├─ Feature stores & registries
   ├─ ML monitoring & drift detection
   │
   ▼
INTEGRATE: Containerization
   │
   ├─ Containerize ML models
   ├─ Kubernetes for model serving
   ├─ Scalable inference
   │
   ▼
DEPLOY: Cloud Platforms
   │
   ├─ AWS SageMaker / Azure ML / Vertex AI
   ├─ Serverless ML inference
   └─ Cost optimization for ML workloads
```

---

### 4.3 Journey: Security Professional

```
START: Security
   │
   ├─ Defensive security basics
   ├─ Penetration testing fundamentals
   │
   ▼
BRANCH 1: Infrastructure Security
   │
   ├─ System hardening (Infrastructure)
   ├─ Network security
   └─ Compliance (CIS benchmarks)

BRANCH 2: Application Security
   │
   ├─ DevSecOps practices (DevOps)
   ├─ SAST/DAST integration in CI/CD
   └─ Secrets management

BRANCH 3: Cloud Security
   │
   ├─ Cloud IAM (Cloud Platforms)
   ├─ Cloud network security
   └─ Cloud compliance

BRANCH 4: Container Security
   │
   ├─ Image scanning (Containerization)
   ├─ Kubernetes RBAC
   └─ Runtime protection
```

---

## 5. MIGRATION VISUAL FLOW

### Phase 1: Move AI Content

```
BEFORE:
docs/
├── artificial-intelligence/
│   ├── index.md
│   ├── SUMMARY.md
│   └── [13 empty subdirs]
└── devops/
    ├── ci-cd/
    ├── iac/
    └── ... (9 other subdirs)

        ⬇ MIGRATION ⬇

AFTER:
docs/
└── devops/
    ├── ci-cd/
    ├── iac/
    ├── aiml-operations/     ⭐ NEW
    │   ├── index.md         (moved)
    │   ├── SUMMARY.md       (moved)
    │   └── [subdirs]        (moved)
    └── ... (other subdirs)
```

---

### Phase 2: Update Navigation

```
BEFORE (docs/SUMMARY.md):
* [Klaatu Barada Nikto!](index.md)
* [SysAdmin](sysadmin/)
* [Cloud](cloud/)
* [DevOps](devops/)
* [Cybersecurity](cybersecurity/)
* [Containerization](containerization/)
* [Artificial Intelligence](artificial-intelligence/)  ← REMOVE
* [Bookmarks](bookmarks.md)

        ⬇ UPDATE ⬇

AFTER (docs/SUMMARY.md):
* [Klaatu Barada Nikto!](index.md)
* [Infrastructure & SysAdmin](infrastructure/)  ← OPTIONAL RENAME
* [Cloud Platforms](cloud/)
* [DevOps & Automation](devops/)               ← UPDATE LABEL
* [Containerization & Orchestration](containerization/)
* [Security](security/)                        ← OPTIONAL RENAME
* [Bookmarks](bookmarks.md)
```

---

## 6. CONTENT MATURITY ROADMAP

```
                   CONTENT MATURITY
                   (Current → Target)

Infrastructure     ████████████████░░   80% → 90%
                   Focus: Expand networking, add monitoring section

Cloud Platforms    ████████░░░░░░░░░░   40% → 70%
                   Focus: Complete Azure/GCP, add architecture patterns

DevOps            ███████████████████  95% → 98%
                   Focus: Expand AI/ML Ops, add more examples

Containerization   ████████████░░░░░░   60% → 85%
                   Focus: Advanced K8s, service mesh, security

Security          ████████████░░░░░░   60% → 80%
                   Focus: Expand pentesting, compliance, tools


Priority Order:
1. DevOps (AI/ML Ops integration)    ← IMMEDIATE
2. Cloud (Complete AWS, add Azure)   ← HIGH
3. Containerization (K8s depth)      ← HIGH
4. Security (Tools & practices)      ← MEDIUM
5. Infrastructure (Refinement)       ← LOW
```

---

## 7. DECISION TREE

```
                   ┌──────────────────┐
                   │  Keep current    │
                   │  6-block arch?   │
                   └────────┬─────────┘
                            │
                   ┌────────┴─────────┐
                   │                  │
                  YES                NO
                   │                  │
        ┌──────────▼───────┐         │
        │  Accept empty    │         │
        │  AI section      │         │
        │  (not ideal)     │         │
        └──────────────────┘         │
                                     │
                    ┌────────────────▼──────────┐
                    │ How many blocks optimal?  │
                    └────────┬──────────────────┘
                             │
            ┌────────────────┼────────────────┐
            │                │                │
           4-5              6-7              8+
            │                │                │
    ┌───────▼───────┐        │        ┌──────▼──────┐
    │ Consolidate   │        │        │ Too complex │
    │ categories    │        │        │ (avoid)     │
    └───────┬───────┘        │        └─────────────┘
            │                │
     ┌──────▼─────┐   ┌─────▼──────┐
     │  4-Block   │   │  5-Block   │
     │  (too      │   │ OPTIMAL ✅  │
     │ aggressive)│   └────────────┘
     └────────────┘
            │
            └──────────┐
                       │
              ┌────────▼─────────┐
              │   RECOMMENDED:   │
              │   5-BLOCK HYBRID │
              │                  │
              │ 1. Infrastructure│
              │ 2. Cloud         │
              │ 3. DevOps + AI   │
              │ 4. Containers    │
              │ 5. Security      │
              └──────────────────┘
```

---

## 8. IMPLEMENTATION TIMELINE

```
Week 1: Planning & Migration
┌─────────────────────────────────────────────┐
│ Day 1-2: Review proposal, get approval      │
│ Day 3:   Execute Phase 1 (move AI content)  │
│ Day 4:   Phase 2 (optional renames)         │
│ Day 5:   Update cross-references            │
│ Day 6-7: Testing, validation, commit        │
└─────────────────────────────────────────────┘

Week 2: Content Enhancement
┌─────────────────────────────────────────────┐
│ • Expand AI/ML Ops section with content     │
│ • Add examples to aiml-operations/index.md  │
│ • Create subdirectory guides (MLOps, AIOps) │
│ • Update DevOps index to highlight AI       │
└─────────────────────────────────────────────┘

Week 3-4: Documentation Polish
┌─────────────────────────────────────────────┐
│ • Improve SUMMARY.md files across sections  │
│ • Add "Related Topics" cross-references     │
│ • Verify all internal links                 │
│ • Update README with new structure          │
└─────────────────────────────────────────────┘
```

---

## 9. RISK MITIGATION

```
┌───────────────────────────────────────────────────┐
│ RISK                 │ MITIGATION                 │
├───────────────────────────────────────────────────┤
│ Broken links         │ Pre-commit hooks catch     │
│                      │ Test with mkdocs serve     │
├───────────────────────────────────────────────────┤
│ Lost content         │ Git tracks all changes     │
│                      │ Easy rollback available    │
├───────────────────────────────────────────────────┤
│ User confusion       │ Clear redirects in index   │
│                      │ Update cross-references    │
├───────────────────────────────────────────────────┤
│ Navigation clutter   │ 5 items = optimal UX       │
│                      │ Each category has purpose  │
├───────────────────────────────────────────────────┤
│ Future scalability   │ Each section has growth    │
│                      │ room (20-50 pages each)    │
└───────────────────────────────────────────────────┘
```

---

## 10. SUCCESS CRITERIA

```
✅ All 5 sections have meaningful content (no empty placeholders)
✅ Navigation menu has 5-7 items (optimal cognitive load)
✅ AI content integrated into DevOps (natural home for MLOps)
✅ No broken links or navigation issues
✅ mkdocs build --strict passes without warnings
✅ Pre-commit hooks pass successfully
✅ Clear boundaries between categories
✅ User journeys flow naturally between sections
✅ Migration completed in < 2 hours
✅ Easy to roll back if needed
```

---

**Document**: ARCHITECTURE_VISUAL_5BLOCK.md
**Date**: 2026-01-08
**Status**: SUPPORTING VISUAL DOCUMENTATION
**Primary Document**: SITE_ARCHITECTURE_PROPOSAL.md
