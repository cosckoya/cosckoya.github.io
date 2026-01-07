# Análisis Arquitectónico Completo del Sitio de Documentación

**Fecha**: 2026-01-06
**Autor**: Claude (The Shadow Architect)
**Objetivo**: Reestructurar el sitio en 6 bloques principales de contenido

---

## 1. ANÁLISIS DEL ESTADO ACTUAL

### 1.1 Inventario de Contenido Existente

**Estructura Actual:**

```text
docs/
├── index.md                    # Landing page principal
├── SUMMARY.md                  # Navegación principal
├── bookmarks.md                # Enlaces útiles
├── sysadmin/                   # 940 líneas - EXHAUSTIVO
│   ├── index.md
│   └── SUMMARY.md
├── cloud/                      # 16 líneas - MÍNIMO
│   ├── index.md
│   └── SUMMARY.md
├── containers/                 # 50 líneas - BÁSICO (Docker/K8s)
│   ├── index.md
│   └── SUMMARY.md
├── code/                       # Snippets programación
│   ├── SUMMARY.md
│   ├── shell.md
│   ├── python.md
│   └── pip.md
├── monitoring/                 # 455 líneas - EXHAUSTIVO
│   ├── index.md
│   └── SUMMARY.md
├── security/                   # 79 líneas - BÁSICO
│   ├── index.md
│   └── SUMMARY.md
└── tools/                      # Herramientas desarrollo
    ├── index.md
    ├── SUMMARY.md
    ├── shell/ (zsh, tmux)
    ├── editors/ (neovim, obsidian)
    ├── git/ (hooks, index)
    └── version-managers/ (asdf)
```

**Total**: 26 archivos markdown

### 1.2 Problemas Arquitectónicos Identificados

#### PROBLEMA 1: Solapamiento Conceptual Masivo

**SysAdmin contiene temas que pertenecen a otras secciones:**

- ✗ **Cloud Computing** (líneas 579-644 en sysadmin/index.md)
  - AWS, Azure, GCP con detalle
  - Debería estar en `cloud/`
- ✗ **Gestión de Configuración** (líneas 706-857)
  - Ansible, Puppet, Chef, Terraform
  - Es puro DevOps, NO SysAdmin tradicional
- ✗ **Virtualización y Contenedores** (líneas 159-214)
  - Docker, Kubernetes, orquestación
  - Duplica `containers/` existente
- ✗ **Monitorización y Logging** (líneas 493-576)
  - Prometheus, Grafana, ELK
  - Duplica `monitoring/` que ya está exhaustivo

**Resultado**: SysAdmin es un "catch-all" que diluye la arquitectura

#### PROBLEMA 2: Secciones Huérfanas Sin Identidad Clara

**¿Qué es "Code"?**

- Actualmente: snippets de Shell, Python, Pip
- ¿Es diferente de "Tools"? No está claro
- ¿Debería existir como sección independiente?

**¿Qué es "Tools"?**

- ZSH, Tmux, NeoVim, Git, ASDF
- ¿Es parte del workflow DevOps?
- ¿O es transversal a todas las secciones?

#### PROBLEMA 3: Falta Completa de DevOps como Concepto

Actualmente NO existe una sección "DevOps", pero el contenido SÍ existe disperso:

- CI/CD: **NO DOCUMENTADO** (crítico)
- IaC: En SysAdmin (Terraform, Ansible)
- Containers: Sección separada
- Monitoring: Sección separada
- Git/Automation: En Tools

#### PROBLEMA 4: Contenido Mínimo en Secciones Críticas

| Sección | Líneas | Estado | Problema |
|---------|--------|--------|----------|
| Cloud | 16 | Básico AWS | Sin Azure, GCP; todo está en SysAdmin |
| Containers | 50 | Solo refs | Sin contenido real, solo bookmarks |
| Security | 79 | Básico | Sin estructura, solo tools y links |
| Code | ~100 | Snippets | Sin propósito claro |

#### PROBLEMA 5: Nueva Sección "IA" Sin Contenido Base

La sección de Inteligencia Artificial es completamente nueva:

- No hay contenido previo
- Necesita estructura desde cero
- Debe integrarse coherentemente con DevOps (MLOps)

### 1.3 Diagnóstico Técnico: Root Cause Analysis

#### Root Cause 1: SysAdmin como "Default Bucket"

- WHY: Cuando no está claro dónde va algo, va a SysAdmin
- IMPACT: SysAdmin es inmantenible (940 líneas), duplica otras secciones
- CONSEQUENCE: Usuario no sabe dónde buscar (¿Cloud está en Cloud o SysAdmin?)

#### Root Cause 2: Ausencia de Definición de "DevOps"

- WHY: No existe una separación clara entre SysAdmin tradicional y DevOps moderno
- IMPACT: IaC, CI/CD, automatización están mal categorizados
- CONSEQUENCE: Confusión entre "administración manual" y "automatización programática"

#### Root Cause 3: Taxonomía Plana (No Jerárquica)

- WHY: Todas las secciones están al mismo nivel conceptual
- IMPACT: No hay relaciones claras (¿Monitoring es parte de DevOps o SysAdmin?)
- CONSEQUENCE: Cross-referencing es ad-hoc, no sistemático

---

## 2. PROPUESTA DE NUEVA ARQUITECTURA

### 2.1 Los 6 Bloques Principales: Definiciones y Alcance

#### BLOQUE 1: SysAdmin (Redefinido)

**Tagline**: "Administración tradicional de sistemas operativos, redes y hardware"

**Scope ESTRICTO**:

- Sistemas Operativos (Linux, Windows Server)
- Redes (TCP/IP, DNS, DHCP, switching, routing)
- Almacenamiento (RAID, SAN, NAS, backups físicos)
- Seguridad básica (hardening, permisos, firewalls locales)
- Scripting para administración (Bash, PowerShell para tareas manuales)
- Bases de datos básicas (instalación, backup, no DBA profundo)

**Scope OUT (va a otras secciones)**:

- ❌ Cloud (AWS/Azure/GCP) → va a `cloud/`
- ❌ IaC (Terraform, Ansible) → va a `devops/`
- ❌ Containers (Docker, K8s) → va a `containerizacion/`
- ❌ Monitoring moderno (Prometheus) → va a `devops/monitoring/`
- ❌ CI/CD → va a `devops/`

**WHY**: SysAdmin debe representar el fundamento clásico antes de la nube y DevOps

---

#### BLOQUE 2: Cloud

**Tagline**: "Plataformas cloud públicas, arquitecturas multi-cloud y servicios gestionados"

**Scope**:

- AWS (EC2, S3, VPC, RDS, Lambda, IAM, CloudWatch)
- Azure (VMs, Storage, VNet, SQL, Functions, AD, Monitor)
- GCP (Compute, Storage, VPC, SQL, Functions, IAM, Monitoring)
- Multi-cloud strategies
- Cloud-native patterns
- FinOps (optimización de costos)
- Arquitecturas serverless
- Cloud security (IAM, compliance)

**Integración con otros bloques**:

- Containers → EKS, AKS, GKE (cross-reference)
- DevOps → CloudFormation, ARM, Deployment Manager
- Seguridad → Cloud security posture, compliance

**WHY**: Cloud es una capa de infraestructura, NO es DevOps (DevOps usa cloud)

---

#### BLOQUE 3: DevOps (NUEVO)

**Tagline**: "Automatización, CI/CD, IaC, y cultura DevOps"

**Scope**:

- **CI/CD**: Jenkins, GitLab CI, GitHub Actions, CircleCI, ArgoCD
- **IaC**: Terraform, Pulumi, CloudFormation, ARM templates
- **Configuration Management**: Ansible, Puppet, Chef, SaltStack
- **Pipelines**: Build, test, deploy workflows
- **GitOps**: Flux, ArgoCD, versioning infrastructure
- **Artifact Management**: Nexus, Artifactory, registry management
- **Monitoring & Observability**: (mantener referencia, profundizar aquí)
  - Prometheus + Grafana (stacks completos)
  - ELK, Loki (logging centralizado)
  - APM, tracing, alerting
- **DevSecOps**: Security scanning en pipelines (Trivy, Snyk)
- **Testing**: Unit, integration, smoke tests en CI
- **Secrets Management**: Vault, AWS Secrets Manager, external secrets

**Cross-references**:

- Monitoring → puede ser subsección o cross-ref fuerte
- Containers → deployment patterns, Helm, operators
- Cloud → cloud-native CI/CD

**WHY**: DevOps es la metodología que une desarrollo + operaciones mediante automatización

---

#### BLOQUE 4: CiberSeguridad (Renombrado)

**Tagline**: "Seguridad ofensiva, defensiva, pentesting y hardening"

**Scope**:

- **Security Fundamentals**: OWASP Top 10, threat modeling
- **Pentesting**: Kali, Parrot, herramientas de explotación
- **Web Security**: OWASP ZAP, Burp Suite, vulnerabilidades web
- **Network Security**: Nmap, Nessus, escaneo de vulnerabilidades
- **Exploitation**: Metasploit, exploits, post-exploitation
- **OSINT**: Reconnaissance, Maltego, información pública
- **Defensive Security**: IDS/IPS (Snort, Suricata), SIEM (Splunk, Wazuh)
- **Compliance**: PCI-DSS, HIPAA, GDPR, auditing
- **Hardening**: CIS Benchmarks, STIG, system hardening
- **Incident Response**: Forensics, IR playbooks

**Integración con otros bloques**:

- Containers → Container security (Trivy, Falco, admission controllers)
- Cloud → Cloud security (IAM, CloudTrail, GuardDuty)
- DevOps → DevSecOps (SAST, DAST en pipelines)

**WHY**: Seguridad es transversal, pero necesita identidad propia como disciplina

---

#### BLOQUE 5: Containerización (Renombrado)

**Tagline**: "Docker, Kubernetes, orquestación y plataformas cloud-native"

**Scope**:

- **Docker**: Dockerfile, images, registry, compose, networking, volumes
- **Kubernetes**: Pods, Services, Deployments, StatefulSets, ConfigMaps
- **Orchestration**: K8s architecture, control plane, scheduling
- **Helm**: Charts, releases, templating
- **Operators**: Custom controllers, CRDs
- **Service Mesh**: Istio, Linkerd, traffic management
- **Cloud Kubernetes**: EKS, AKS, GKE (deployment patterns)
- **Container Security**: Trivy, Falco, admission controllers, policies
- **Monitoring**: Prometheus Operator, metrics collection
- **Local Dev**: Minikube, Kind, Tilt, Skaffold
- **Alternative Runtimes**: Podman, containerd, CRI-O

**Cross-references**:

- DevOps → CI/CD para containers, GitOps con ArgoCD
- Cloud → Managed K8s services
- Seguridad → Container security best practices

**WHY**: Containers son una tecnología específica con ecosistema propio

---

#### BLOQUE 6: Inteligencia Artificial (NUEVO)

**Tagline**: "Machine Learning, LLMs, MLOps y aplicaciones IA"

**Scope** (a construir):

- **ML Fundamentals**: Supervised, unsupervised, reinforcement learning
- **Frameworks**: TensorFlow, PyTorch, scikit-learn, Hugging Face
- **LLMs**: GPT, Claude, Llama, fine-tuning, RAG patterns
- **MLOps**: ML pipelines, model versioning, deployment
- **Data Engineering**: Data preparation, feature engineering, ETL
- **Model Training**: Notebooks, experiments, hyperparameter tuning
- **Model Deployment**: Serving (TorchServe, TFServing), APIs (FastAPI)
- **Monitoring ML**: Model drift, performance tracking, A/B testing
- **Tools**: MLflow, Kubeflow, Weights & Biases, DVC
- **AI Security**: Model poisoning, adversarial attacks, privacy
- **Cloud AI**: AWS SageMaker, Azure ML, GCP Vertex AI

**Integración con otros bloques**:

- DevOps → MLOps pipelines (CI/CD para modelos)
- Containers → Containerized models, K8s operators (Kubeflow)
- Cloud → Cloud AI services, GPU instances
- Code → Python para ML, notebooks

**WHY**: IA es el futuro y requiere su propia categoría con enfoque MLOps

---

### 2.2 Decisiones Arquitectónicas Críticas

#### DECISIÓN 1: ¿Dónde va "Monitoring"?

##### Opción A: Subsección de DevOps

- PRO: Monitoring es parte del ciclo DevOps (observability)
- PRO: Reduce secciones top-level (más simple)
- CON: Puede perderse visibilidad como tema

##### Opción B: Sección independiente (status quo)

- PRO: Monitoring es suficientemente grande (455 líneas)
- PRO: Relevante para múltiples roles (SRE, DevOps, SysAdmin)
- CON: Añade complejidad a navegación top-level

##### Opción C: Subsección CRUZADA (aparece en múltiples lugares)

- PRO: Contexto específico (monitoring para K8s en Containers, cloud en Cloud)
- CON: Duplicación de contenido
- CON: Mantenimiento pesadillesco

**RECOMENDACIÓN**: **Opción A (subsección de DevOps) + cross-references fuertes**

**WHY**:

- Monitoring moderno (Prometheus, Grafana, OpenTelemetry) es parte del toolkit DevOps
- SysAdmin tradicional usa herramientas más simples (Nagios, Zabbix)
- El contenido actual de monitoring/ es 100% DevOps-oriented
- Cross-references desde SysAdmin, Cloud, Containers aseguran visibilidad

**Implementación**:

```text
devops/
  ├── monitoring-observability/
  │   ├── index.md (contenido actual de monitoring/index.md)
  │   ├── prometheus-grafana.md
  │   ├── logging-elk-loki.md
  │   ├── apm-tracing.md
  │   └── alerting.md
```

---

#### DECISIÓN 2: ¿Qué hacer con "Tools"?

**Análisis del contenido actual**:

- ZSH, Tmux → Workflow transversal (todos los roles)
- NeoVim, Obsidian → Editors (todos los roles)
- Git, Hooks → Control de versiones (DevOps core)
- ASDF → Version management (DevOps/Code)

##### Opción A: Eliminar "Tools", distribuir contenido

- Git → `devops/version-control/`
- ZSH/Tmux → `sysadmin/scripting/` o crear `workflow/`
- Editors → Standalone o en `workflow/`

##### Opción B: Mantener "Tools" como sección transversal

- PRO: Herramientas útiles para todos
- CON: Indefinición (¿qué es "tool" vs "no tool"?)

##### Opción C: Renombrar a "Workflow & Productivity"

- PRO: Identidad clara (optimización de flujo de trabajo)
- PRO: Justifica la existencia como sección
- CON: Puede seguir siendo catch-all

**RECOMENDACIÓN**: **Opción A (distribuir) + Mantener "Recursos" transversales**

**WHY**:

- Git es CORE de DevOps, debe estar ahí (no en "tools")
- ZSH/Tmux son parte del "SysAdmin toolkit" pero también DevOps
- Mejor: crear página de "Quick Start" o "Setup" que referencie setup inicial

**Implementación**:

```text
# Git → devops/version-control/
devops/
  ├── version-control/
  │   ├── git-fundamentals.md
  │   ├── git-hooks.md
  │   └── git-workflows.md

# Shell/Editors → Página "Tooling Setup" en index principal
docs/
  ├── setup-guia.md  # Getting Started: ZSH, NeoVim, Tmux
  └── bookmarks.md   # Mantener para recursos externos
```

---

#### DECISIÓN 3: ¿Qué hacer con "Code"?

**Análisis**:

- Actual: Shell, Python, Pip (snippets)
- Sin estructura clara
- Overlaps con "Tools" y "DevOps"

##### Opción A: Eliminar "Code", mover snippets

- Shell → `sysadmin/scripting-examples/`
- Python → `devops/automation-python/` o `ia/python-ml/`

##### Opción B: Expandir "Code" a "Programming & Scripts"

- Colección de snippets útiles, patterns
- PRO: Útil como quick reference
- CON: Puede crecer descontroladamente

##### Opción C: Integrar snippets en cada sección relevante

- Bash examples → dentro de cada sección donde se usan
- Python → en IA, DevOps según contexto

**RECOMENDACIÓN**: **Opción C (integrar) + Crear página "Code Snippets" como índice**

**WHY**:

- Code without context es poco útil
- Mejor: ejemplos prácticos dentro de cada guía
- Crear `docs/snippets.md` como índice cross-referenciado

**Implementación**:

```text
# Eliminar code/ como sección
# Crear snippets en contexto:

sysadmin/
  ├── scripting/
  │   ├── bash-basics.md
  │   └── powershell-examples.md

devops/
  ├── automation/
  │   ├── python-automation.md
  │   └── ansible-playbooks.md

ia/
  ├── python-ml/
  │   └── data-processing.md

# Crear índice:
docs/snippets.md → links a todas las páginas con code examples
```

---

### 2.3 Taxonomía Final: Jerarquía y Relaciones

```text
NIVEL 0: LANDING
├── index.md (home page con cards a 6 bloques)
├── setup-guia.md (getting started: install ZSH, NeoVim, Git)
├── snippets.md (índice de code examples cross-referenciado)
└── bookmarks.md (recursos externos)

NIVEL 1: BLOQUES PRINCIPALES (6)
│
├── 1. SYSADMIN/
│   ├── sistemas-operativos/
│   │   ├── linux/
│   │   └── windows-server/
│   ├── redes/
│   │   ├── protocolos-tcp-ip.md
│   │   ├── dns-dhcp.md
│   │   └── troubleshooting.md
│   ├── almacenamiento/
│   │   ├── raid-lvm.md
│   │   ├── san-nas.md
│   │   └── backup-estrategias.md
│   ├── scripting/
│   │   ├── bash-basics.md
│   │   └── powershell-admin.md
│   ├── seguridad-basica/
│   │   ├── hardening.md
│   │   └── firewalls.md
│   └── bases-datos-basicas/
│       ├── mysql-admin.md
│       └── postgresql-admin.md
│
├── 2. CLOUD/
│   ├── aws/
│   │   ├── ec2-compute.md
│   │   ├── s3-storage.md
│   │   ├── vpc-networking.md
│   │   ├── rds-databases.md
│   │   ├── lambda-serverless.md
│   │   └── iam-security.md
│   ├── azure/
│   │   ├── vms.md
│   │   ├── storage.md
│   │   ├── networking.md
│   │   └── ad-iam.md
│   ├── gcp/
│   │   ├── compute-engine.md
│   │   ├── cloud-storage.md
│   │   └── iam.md
│   ├── multi-cloud/
│   │   ├── estrategias.md
│   │   └── vendor-lock-in.md
│   ├── cloud-native/
│   │   ├── serverless-patterns.md
│   │   └── arquitecturas.md
│   └── finops/
│       └── optimizacion-costos.md
│
├── 3. DEVOPS/
│   ├── introduccion-devops.md
│   ├── ci-cd/
│   │   ├── jenkins.md
│   │   ├── gitlab-ci.md
│   │   ├── github-actions.md
│   │   └── argocd-gitops.md
│   ├── iac/
│   │   ├── terraform/
│   │   │   ├── basics.md
│   │   │   ├── modules.md
│   │   │   └── best-practices.md
│   │   ├── pulumi.md
│   │   └── cloudformation.md
│   ├── configuration-management/
│   │   ├── ansible/
│   │   │   ├── playbooks.md
│   │   │   ├── roles.md
│   │   │   └── best-practices.md
│   │   ├── puppet.md
│   │   └── chef.md
│   ├── version-control/
│   │   ├── git-fundamentals.md
│   │   ├── git-hooks.md
│   │   ├── git-workflows.md (gitflow, trunk-based)
│   │   └── monorepos.md
│   ├── monitoring-observability/
│   │   ├── index.md (contenido actual monitoring/index.md)
│   │   ├── prometheus-grafana/
│   │   │   ├── setup.md
│   │   │   ├── queries.md
│   │   │   └── dashboards.md
│   │   ├── logging/
│   │   │   ├── elk-stack.md
│   │   │   ├── loki.md
│   │   │   └── log-management.md
│   │   ├── apm-tracing/
│   │   │   ├── opentelemetry.md
│   │   │   ├── jaeger.md
│   │   │   └── distributed-tracing.md
│   │   └── alerting/
│   │       ├── alertmanager.md
│   │       └── oncall-management.md
│   ├── secrets-management/
│   │   ├── hashicorp-vault.md
│   │   ├── aws-secrets-manager.md
│   │   └── external-secrets-operator.md
│   ├── testing/
│   │   ├── unit-tests.md
│   │   ├── integration-tests.md
│   │   └── smoke-tests.md
│   └── devsecops/
│       ├── sast-dast.md
│       ├── dependency-scanning.md
│       └── security-gates.md
│
├── 4. CIBERSEGURIDAD/
│   ├── fundamentos/
│   │   ├── owasp-top10.md
│   │   ├── threat-modeling.md
│   │   └── security-frameworks.md
│   ├── pentesting/
│   │   ├── kali-linux/
│   │   │   ├── setup.md
│   │   │   └── tools.md
│   │   ├── metodologia.md
│   │   └── reporting.md
│   ├── web-security/
│   │   ├── owasp-zap.md
│   │   ├── burp-suite.md
│   │   └── vulnerabilidades-web.md
│   ├── network-security/
│   │   ├── nmap-scanning.md
│   │   ├── nessus-vulnerability.md
│   │   └── network-monitoring.md
│   ├── exploitation/
│   │   ├── metasploit.md
│   │   ├── exploits.md
│   │   └── post-exploitation.md
│   ├── osint/
│   │   ├── reconnaissance.md
│   │   ├── maltego.md
│   │   └── passive-recon.md
│   ├── defensive-security/
│   │   ├── ids-ips.md
│   │   ├── siem.md
│   │   └── wazuh.md
│   ├── compliance/
│   │   ├── cis-benchmarks.md
│   │   ├── stig.md
│   │   └── pci-dss.md
│   ├── hardening/
│   │   ├── linux-hardening.md
│   │   ├── windows-hardening.md
│   │   └── application-hardening.md
│   ├── incident-response/
│   │   ├── ir-playbooks.md
│   │   ├── forensics.md
│   │   └── malware-analysis.md
│   ├── container-security/
│   │   ├── docker-security.md
│   │   ├── kubernetes-security.md
│   │   └── image-scanning.md
│   └── cloud-security/
│       ├── aws-security.md
│       ├── azure-security.md
│       └── gcp-security.md
│
├── 5. CONTAINERIZACION/
│   ├── docker/
│   │   ├── dockerfile-best-practices.md
│   │   ├── images-registry.md
│   │   ├── docker-compose.md
│   │   ├── networking.md
│   │   └── volumes-storage.md
│   ├── kubernetes/
│   │   ├── arquitectura.md
│   │   ├── pods-deployments.md
│   │   ├── services-networking.md
│   │   ├── configmaps-secrets.md
│   │   ├── statefulsets.md
│   │   └── storage.md
│   ├── helm/
│   │   ├── charts.md
│   │   ├── templating.md
│   │   └── best-practices.md
│   ├── operators/
│   │   ├── custom-controllers.md
│   │   ├── crds.md
│   │   └── operator-sdk.md
│   ├── service-mesh/
│   │   ├── istio.md
│   │   ├── linkerd.md
│   │   └── traffic-management.md
│   ├── cloud-kubernetes/
│   │   ├── eks-aws.md
│   │   ├── aks-azure.md
│   │   └── gke-gcp.md
│   ├── seguridad/
│   │   ├── trivy-scanning.md
│   │   ├── falco-runtime-security.md
│   │   └── admission-controllers.md
│   ├── monitoring/
│   │   ├── prometheus-operator.md
│   │   └── metrics-collection.md
│   ├── local-dev/
│   │   ├── minikube.md
│   │   ├── kind.md
│   │   └── tilt-skaffold.md
│   └── alternative-runtimes/
│       ├── podman.md
│       └── containerd.md
│
└── 6. INTELIGENCIA-ARTIFICIAL/
    ├── fundamentos/
    │   ├── ml-basics.md
    │   ├── supervised-learning.md
    │   ├── unsupervised-learning.md
    │   └── deep-learning.md
    ├── frameworks/
    │   ├── tensorflow.md
    │   ├── pytorch.md
    │   ├── scikit-learn.md
    │   └── huggingface.md
    ├── llms/
    │   ├── gpt-modelos.md
    │   ├── claude.md
    │   ├── llama-opensource.md
    │   ├── fine-tuning.md
    │   └── rag-patterns.md
    ├── mlops/
    │   ├── ml-pipelines.md
    │   ├── model-versioning.md
    │   ├── mlflow.md
    │   ├── kubeflow.md
    │   └── dvc.md
    ├── data-engineering/
    │   ├── data-preparation.md
    │   ├── feature-engineering.md
    │   └── etl-pipelines.md
    ├── model-training/
    │   ├── jupyter-notebooks.md
    │   ├── experiments.md
    │   └── hyperparameter-tuning.md
    ├── model-deployment/
    │   ├── torchserve.md
    │   ├── tfserving.md
    │   ├── fastapi-ml.md
    │   └── inference-optimization.md
    ├── monitoring-ml/
    │   ├── model-drift.md
    │   ├── performance-tracking.md
    │   └── ab-testing.md
    ├── python-ml/
    │   ├── numpy-pandas.md
    │   ├── data-visualization.md
    │   └── ml-libraries.md
    ├── ai-security/
    │   ├── model-poisoning.md
    │   ├── adversarial-attacks.md
    │   └── privacy-ml.md
    └── cloud-ai/
        ├── sagemaker-aws.md
        ├── azure-ml.md
        └── vertex-ai-gcp.md
```

---

## 3. MATRIZ DE MIGRACIÓN: ¿QUÉ VA DÓNDE?

### 3.1 Migración desde SysAdmin

| Contenido Actual | Líneas | Destino | Acción |
|------------------|--------|---------|--------|
| Sistemas Operativos (Linux, Windows) | 26-100 | `sysadmin/sistemas-operativos/` | **MANTENER** |
| Redes (TCP/IP, DNS, DHCP) | 103-157 | `sysadmin/redes/` | **MANTENER** |
| Virtualización (VMware, Hyper-V, KVM) | 159-214 | `sysadmin/virtualizacion/` | **MANTENER** (solo VMs, no containers) |
| Contenedores (Docker, K8s overview) | 197-214 | `containerizacion/` | **MOVER** (todo contenido containers) |
| Scripting (Bash, PowerShell, Python) | 217-314 | `sysadmin/scripting/` | **MANTENER** (contexto admin, no automation) |
| Almacenamiento (RAID, SAN, NAS, Backup) | 316-420 | `sysadmin/almacenamiento/` | **MANTENER** |
| Seguridad (Hardening, Patch) | 422-491 | `sysadmin/seguridad-basica/` | **MANTENER** (básico) |
| Hardening avanzado | | `ciberseguridad/hardening/` | **DUPLICAR** (profundizar) |
| Monitorización (Prometheus, ELK) | 493-576 | `devops/monitoring-observability/` | **MOVER** |
| Cloud Computing (AWS, Azure, GCP) | 579-644 | `cloud/` | **MOVER** (expandir) |
| Bases de Datos básicas | 646-703 | `sysadmin/bases-datos-basicas/` | **MANTENER** (admin básico) |
| Gestión Configuración (Ansible, Puppet, Chef) | 709-804 | `devops/configuration-management/` | **MOVER** |
| IaC (Terraform, CloudFormation, Pulumi) | 806-857 | `devops/iac/` | **MOVER** |

**RESULTADO**: SysAdmin pasa de 940 líneas a ~400-500 líneas (reducción 50%)

---

### 3.2 Migración desde Monitoring

| Contenido Actual | Destino | Acción |
|------------------|---------|--------|
| Monitoring & Observability (TODO) | `devops/monitoring-observability/` | **MOVER COMPLETO** |
| - Prometheus + Grafana | `devops/monitoring-observability/prometheus-grafana/` | MOVER |
| - Logging (ELK, Loki) | `devops/monitoring-observability/logging/` | MOVER |
| - APM & Tracing | `devops/monitoring-observability/apm-tracing/` | MOVER |
| - Alerting | `devops/monitoring-observability/alerting/` | MOVER |

**Cross-references desde**:

- `sysadmin/` → link a monitoring básico (Nagios, Zabbix mencionados allí)
- `containerizacion/monitoring/` → Prometheus Operator, K8s-specific
- `cloud/aws/cloudwatch.md` → Cloud-specific monitoring

---

### 3.3 Migración desde Tools

| Contenido Actual | Destino | Acción |
|------------------|---------|--------|
| ZSH | `setup-guia.md` (getting started) | **INTEGRAR** |
| Tmux | `setup-guia.md` | **INTEGRAR** |
| NeoVim | `setup-guia.md` | **INTEGRAR** |
| Obsidian | `setup-guia.md` | **INTEGRAR** |
| Git fundamentals | `devops/version-control/git-fundamentals.md` | **MOVER** |
| Git Hooks | `devops/version-control/git-hooks.md` | **MOVER** |
| ASDF | `setup-guia.md` (version managers) | **INTEGRAR** |

**RESULTADO**: Eliminar `tools/` como sección, crear `setup-guia.md` transversal

---

### 3.4 Migración desde Code

| Contenido Actual | Destino | Acción |
|------------------|---------|--------|
| Shell snippets | `sysadmin/scripting/bash-basics.md` | **INTEGRAR** |
| Python snippets | `devops/automation/python-automation.md` | **INTEGRAR** |
| Pip management | `ia/python-ml/entornos-virtuales.md` | **INTEGRAR** |

**RESULTADO**: Eliminar `code/` como sección, crear `snippets.md` como índice

---

### 3.5 Expansión de Cloud

| Contenido Nuevo | Fuente | Acción |
|-----------------|--------|--------|
| AWS detallado | SysAdmin (líneas 579-644) | **MOVER + EXPANDIR** |
| Azure completo | Actualmente NO EXISTE | **CREAR** |
| GCP completo | Actualmente NO EXISTE | **CREAR** |
| Multi-cloud | Actualmente NO EXISTE | **CREAR** |
| Serverless patterns | Actualmente NO EXISTE | **CREAR** |
| FinOps | Actualmente NO EXISTE | **CREAR** |

---

### 3.6 Expansión de Containers

| Contenido Nuevo | Fuente | Acción |
|-----------------|--------|--------|
| Docker profundo | SysAdmin + containers/index.md | **CONSOLIDAR + EXPANDIR** |
| Kubernetes | containers/index.md (solo refs) | **EXPANDIR** |
| Helm | Actualmente NO EXISTE | **CREAR** |
| Operators | Actualmente NO EXISTE | **CREAR** |
| Service Mesh | Actualmente NO EXISTE | **CREAR** |
| Container Security | security/index.md (mínimo) | **EXPANDIR** |

---

### 3.7 Expansión de CiberSeguridad

| Contenido Nuevo | Fuente | Acción |
|-----------------|--------|--------|
| OWASP Top 10 | security/index.md (básico) | **EXPANDIR** |
| Pentesting | security/index.md (tools) | **EXPANDIR** |
| Defensive Security | Actualmente NO EXISTE | **CREAR** |
| Compliance | SysAdmin (mínimo) | **EXPANDIR** |
| Incident Response | Actualmente NO EXISTE | **CREAR** |
| Container Security | Overlap con containers | **CREAR + CROSS-REF** |
| Cloud Security | Overlap con cloud | **CREAR + CROSS-REF** |

---

### 3.8 Creación de DevOps (desde cero)

| Contenido Nuevo | Fuente | Acción |
|-----------------|--------|--------|
| Introducción DevOps | Actualmente NO EXISTE | **CREAR** |
| CI/CD (Jenkins, GitLab, GitHub Actions) | Actualmente NO EXISTE | **CREAR** |
| GitOps (ArgoCD, Flux) | Actualmente NO EXISTE | **CREAR** |
| IaC (Terraform) | SysAdmin (líneas 806-857) | **MOVER + EXPANDIR** |
| Config Mgmt (Ansible, Puppet, Chef) | SysAdmin (líneas 709-804) | **MOVER + EXPANDIR** |
| Version Control (Git) | tools/git/ | **MOVER + EXPANDIR** |
| Monitoring | monitoring/ completo | **MOVER** |
| Secrets Management | Actualmente NO EXISTE | **CREAR** |
| Testing in CI | Actualmente NO EXISTE | **CREAR** |
| DevSecOps | Actualmente NO EXISTE | **CREAR** |

---

### 3.9 Creación de Inteligencia Artificial (desde cero)

| Contenido Nuevo | Fuente | Acción |
|-----------------|--------|--------|
| ML Fundamentals | NO EXISTE | **CREAR** |
| Frameworks (TensorFlow, PyTorch) | NO EXISTE | **CREAR** |
| LLMs | NO EXISTE | **CREAR** |
| MLOps | NO EXISTE | **CREAR** |
| Model Training | NO EXISTE | **CREAR** |
| Model Deployment | NO EXISTE | **CREAR** |
| Python for ML | code/python.md (básico) | **EXPANDIR** |
| Cloud AI | cloud/ (no existe) | **CREAR** |

---

## 4. ESTRUCTURA DE DIRECTORIOS FINAL

```text
docs/
├── index.md                                  # Landing con 6 cards principales
├── SUMMARY.md                                # Nav: 6 bloques + setup + bookmarks
├── setup-guia.md                             # Getting Started (ZSH, NeoVim, Git)
├── snippets.md                               # Índice de code examples
├── bookmarks.md                              # Recursos externos
│
├── sysadmin/                                 # BLOQUE 1
│   ├── index.md
│   ├── SUMMARY.md
│   ├── sistemas-operativos/
│   │   ├── linux/
│   │   │   ├── index.md
│   │   │   ├── distributions.md
│   │   │   ├── package-management.md
│   │   │   ├── systemd.md
│   │   │   └── permissions.md
│   │   └── windows-server/
│   │       ├── index.md
│   │       ├── active-directory.md
│   │       ├── powershell.md
│   │       └── group-policy.md
│   ├── redes/
│   │   ├── index.md
│   │   ├── tcp-ip.md
│   │   ├── dns-dhcp.md
│   │   ├── routing-switching.md
│   │   └── troubleshooting.md
│   ├── almacenamiento/
│   │   ├── index.md
│   │   ├── raid-lvm.md
│   │   ├── san-nas.md
│   │   └── backup-disaster-recovery.md
│   ├── virtualizacion/
│   │   ├── index.md
│   │   ├── vmware.md
│   │   ├── hyper-v.md
│   │   └── kvm.md
│   ├── scripting/
│   │   ├── index.md
│   │   ├── bash-basics.md
│   │   ├── bash-examples.md
│   │   ├── powershell-admin.md
│   │   └── python-sysadmin.md
│   ├── seguridad-basica/
│   │   ├── index.md
│   │   ├── hardening-basico.md
│   │   ├── firewalls.md
│   │   └── patch-management.md
│   └── bases-datos-basicas/
│       ├── index.md
│       ├── mysql-admin.md
│       ├── postgresql-admin.md
│       └── sql-server-admin.md
│
├── cloud/                                    # BLOQUE 2
│   ├── index.md
│   ├── SUMMARY.md
│   ├── aws/
│   │   ├── index.md
│   │   ├── ec2-compute.md
│   │   ├── s3-storage.md
│   │   ├── vpc-networking.md
│   │   ├── rds-databases.md
│   │   ├── lambda-serverless.md
│   │   ├── iam-security.md
│   │   ├── cloudwatch-monitoring.md
│   │   └── cli-tools.md
│   ├── azure/
│   │   ├── index.md
│   │   ├── virtual-machines.md
│   │   ├── storage.md
│   │   ├── virtual-network.md
│   │   ├── sql-database.md
│   │   ├── functions.md
│   │   ├── active-directory.md
│   │   └── monitor.md
│   ├── gcp/
│   │   ├── index.md
│   │   ├── compute-engine.md
│   │   ├── cloud-storage.md
│   │   ├── vpc-network.md
│   │   ├── cloud-sql.md
│   │   └── iam.md
│   ├── multi-cloud/
│   │   ├── index.md
│   │   ├── estrategias.md
│   │   └── vendor-lock-in.md
│   ├── cloud-native/
│   │   ├── index.md
│   │   ├── serverless-patterns.md
│   │   ├── arquitecturas-escalables.md
│   │   └── cloud-design-patterns.md
│   └── finops/
│       ├── index.md
│       ├── optimizacion-costos.md
│       └── cost-monitoring.md
│
├── devops/                                   # BLOQUE 3 (NUEVO)
│   ├── index.md
│   ├── SUMMARY.md
│   ├── introduccion-devops.md
│   ├── cultura-devops.md
│   ├── ci-cd/
│   │   ├── index.md
│   │   ├── jenkins.md
│   │   ├── gitlab-ci.md
│   │   ├── github-actions.md
│   │   ├── circleci.md
│   │   ├── argocd-gitops.md
│   │   └── flux-gitops.md
│   ├── iac/
│   │   ├── index.md
│   │   ├── terraform/
│   │   │   ├── index.md
│   │   │   ├── getting-started.md
│   │   │   ├── modules.md
│   │   │   ├── state-management.md
│   │   │   └── best-practices.md
│   │   ├── pulumi.md
│   │   ├── cloudformation.md
│   │   └── arm-templates.md
│   ├── configuration-management/
│   │   ├── index.md
│   │   ├── ansible/
│   │   │   ├── index.md
│   │   │   ├── playbooks.md
│   │   │   ├── roles.md
│   │   │   ├── inventory.md
│   │   │   └── best-practices.md
│   │   ├── puppet/
│   │   │   ├── index.md
│   │   │   └── manifests.md
│   │   ├── chef/
│   │   │   ├── index.md
│   │   │   └── cookbooks.md
│   │   └── saltstack.md
│   ├── version-control/
│   │   ├── index.md
│   │   ├── git-fundamentals.md
│   │   ├── git-hooks.md
│   │   ├── git-workflows.md
│   │   ├── gitflow.md
│   │   ├── trunk-based-development.md
│   │   └── monorepos.md
│   ├── monitoring-observability/
│   │   ├── index.md (contenido de monitoring/index.md)
│   │   ├── introduccion.md
│   │   ├── golden-signals.md
│   │   ├── prometheus-grafana/
│   │   │   ├── index.md
│   │   │   ├── prometheus-setup.md
│   │   │   ├── prometheus-queries.md
│   │   │   ├── grafana-dashboards.md
│   │   │   └── alertmanager.md
│   │   ├── logging/
│   │   │   ├── index.md
│   │   │   ├── elk-stack.md
│   │   │   ├── elasticsearch.md
│   │   │   ├── logstash.md
│   │   │   ├── kibana.md
│   │   │   ├── loki.md
│   │   │   └── fluentd.md
│   │   ├── apm-tracing/
│   │   │   ├── index.md
│   │   │   ├── opentelemetry.md
│   │   │   ├── jaeger.md
│   │   │   ├── zipkin.md
│   │   │   └── distributed-tracing.md
│   │   ├── alerting/
│   │   │   ├── index.md
│   │   │   ├── alertmanager.md
│   │   │   ├── pagerduty.md
│   │   │   ├── opsgenie.md
│   │   │   └── oncall-management.md
│   │   └── best-practices.md
│   ├── secrets-management/
│   │   ├── index.md
│   │   ├── hashicorp-vault.md
│   │   ├── aws-secrets-manager.md
│   │   ├── azure-key-vault.md
│   │   └── external-secrets-operator.md
│   ├── artifact-management/
│   │   ├── index.md
│   │   ├── nexus.md
│   │   ├── artifactory.md
│   │   └── container-registries.md
│   ├── testing/
│   │   ├── index.md
│   │   ├── unit-tests.md
│   │   ├── integration-tests.md
│   │   ├── smoke-tests.md
│   │   └── test-automation.md
│   └── devsecops/
│       ├── index.md
│       ├── sast-dast.md
│       ├── dependency-scanning.md
│       ├── container-scanning.md
│       └── security-gates.md
│
├── ciberseguridad/                           # BLOQUE 4
│   ├── index.md
│   ├── SUMMARY.md
│   ├── fundamentos/
│   │   ├── index.md
│   │   ├── owasp-top10.md
│   │   ├── threat-modeling.md
│   │   ├── security-frameworks.md
│   │   └── cia-triad.md
│   ├── pentesting/
│   │   ├── index.md
│   │   ├── kali-linux/
│   │   │   ├── index.md
│   │   │   ├── setup.md
│   │   │   └── tools-overview.md
│   │   ├── metodologia-pentesting.md
│   │   ├── reporting.md
│   │   └── legal-ethical.md
│   ├── web-security/
│   │   ├── index.md
│   │   ├── owasp-zap.md
│   │   ├── burp-suite.md
│   │   ├── sql-injection.md
│   │   ├── xss.md
│   │   ├── csrf.md
│   │   └── vulnerabilities.md
│   ├── network-security/
│   │   ├── index.md
│   │   ├── nmap-scanning.md
│   │   ├── nessus-vulnerability.md
│   │   ├── network-monitoring.md
│   │   └── vpn-security.md
│   ├── exploitation/
│   │   ├── index.md
│   │   ├── metasploit.md
│   │   ├── exploits.md
│   │   └── post-exploitation.md
│   ├── osint/
│   │   ├── index.md
│   │   ├── reconnaissance.md
│   │   ├── maltego.md
│   │   ├── passive-recon.md
│   │   └── google-dorking.md
│   ├── defensive-security/
│   │   ├── index.md
│   │   ├── ids-ips.md
│   │   ├── snort.md
│   │   ├── suricata.md
│   │   ├── siem/
│   │   │   ├── index.md
│   │   │   ├── splunk.md
│   │   │   └── wazuh.md
│   │   └── threat-hunting.md
│   ├── compliance/
│   │   ├── index.md
│   │   ├── cis-benchmarks.md
│   │   ├── stig.md
│   │   ├── pci-dss.md
│   │   ├── hipaa.md
│   │   └── gdpr.md
│   ├── hardening/
│   │   ├── index.md
│   │   ├── linux-hardening.md
│   │   ├── windows-hardening.md
│   │   ├── application-hardening.md
│   │   └── network-hardening.md
│   ├── incident-response/
│   │   ├── index.md
│   │   ├── ir-playbooks.md
│   │   ├── forensics.md
│   │   ├── malware-analysis.md
│   │   └── evidence-handling.md
│   ├── container-security/
│   │   ├── index.md
│   │   ├── docker-security.md
│   │   ├── kubernetes-security.md
│   │   ├── image-scanning.md
│   │   └── runtime-security.md
│   └── cloud-security/
│       ├── index.md
│       ├── aws-security.md
│       ├── azure-security.md
│       ├── gcp-security.md
│       └── cloud-compliance.md
│
├── containerizacion/                         # BLOQUE 5
│   ├── index.md
│   ├── SUMMARY.md
│   ├── introduccion.md
│   ├── docker/
│   │   ├── index.md
│   │   ├── getting-started.md
│   │   ├── dockerfile-best-practices.md
│   │   ├── images-registry.md
│   │   ├── docker-compose.md
│   │   ├── networking.md
│   │   ├── volumes-storage.md
│   │   └── multi-stage-builds.md
│   ├── kubernetes/
│   │   ├── index.md
│   │   ├── arquitectura.md
│   │   ├── pods.md
│   │   ├── deployments.md
│   │   ├── services-networking.md
│   │   ├── ingress.md
│   │   ├── configmaps-secrets.md
│   │   ├── statefulsets.md
│   │   ├── daemonsets.md
│   │   ├── jobs-cronjobs.md
│   │   ├── storage.md
│   │   ├── rbac.md
│   │   └── namespaces.md
│   ├── helm/
│   │   ├── index.md
│   │   ├── charts.md
│   │   ├── templating.md
│   │   ├── values-management.md
│   │   └── best-practices.md
│   ├── operators/
│   │   ├── index.md
│   │   ├── custom-controllers.md
│   │   ├── crds.md
│   │   ├── operator-sdk.md
│   │   └── operator-lifecycle.md
│   ├── service-mesh/
│   │   ├── index.md
│   │   ├── istio.md
│   │   ├── linkerd.md
│   │   ├── traffic-management.md
│   │   └── observability.md
│   ├── cloud-kubernetes/
│   │   ├── index.md
│   │   ├── eks-aws.md
│   │   ├── aks-azure.md
│   │   └── gke-gcp.md
│   ├── seguridad/
│   │   ├── index.md
│   │   ├── trivy-scanning.md
│   │   ├── falco-runtime-security.md
│   │   ├── admission-controllers.md
│   │   ├── policies.md
│   │   └── network-policies.md
│   ├── monitoring/
│   │   ├── index.md
│   │   ├── prometheus-operator.md
│   │   ├── metrics-collection.md
│   │   └── logging-k8s.md
│   ├── local-dev/
│   │   ├── index.md
│   │   ├── minikube.md
│   │   ├── kind.md
│   │   ├── k3s.md
│   │   ├── tilt.md
│   │   └── skaffold.md
│   ├── alternative-runtimes/
│   │   ├── index.md
│   │   ├── podman.md
│   │   ├── containerd.md
│   │   └── cri-o.md
│   └── best-practices/
│       ├── index.md
│       ├── production-readiness.md
│       └── troubleshooting.md
│
└── inteligencia-artificial/                  # BLOQUE 6 (NUEVO)
    ├── index.md
    ├── SUMMARY.md
    ├── introduccion.md
    ├── fundamentos/
    │   ├── index.md
    │   ├── ml-basics.md
    │   ├── supervised-learning.md
    │   ├── unsupervised-learning.md
    │   ├── reinforcement-learning.md
    │   └── deep-learning.md
    ├── frameworks/
    │   ├── index.md
    │   ├── tensorflow.md
    │   ├── pytorch.md
    │   ├── scikit-learn.md
    │   ├── huggingface.md
    │   └── keras.md
    ├── llms/
    │   ├── index.md
    │   ├── introduccion-llms.md
    │   ├── gpt-modelos.md
    │   ├── claude.md
    │   ├── llama-opensource.md
    │   ├── fine-tuning.md
    │   ├── prompt-engineering.md
    │   └── rag-patterns.md
    ├── mlops/
    │   ├── index.md
    │   ├── ml-pipelines.md
    │   ├── model-versioning.md
    │   ├── mlflow.md
    │   ├── kubeflow.md
    │   ├── dvc.md
    │   └── ci-cd-ml.md
    ├── data-engineering/
    │   ├── index.md
    │   ├── data-preparation.md
    │   ├── feature-engineering.md
    │   ├── etl-pipelines.md
    │   └── data-quality.md
    ├── model-training/
    │   ├── index.md
    │   ├── jupyter-notebooks.md
    │   ├── experiments.md
    │   ├── hyperparameter-tuning.md
    │   └── distributed-training.md
    ├── model-deployment/
    │   ├── index.md
    │   ├── torchserve.md
    │   ├── tfserving.md
    │   ├── fastapi-ml.md
    │   ├── inference-optimization.md
    │   └── model-serving-patterns.md
    ├── monitoring-ml/
    │   ├── index.md
    │   ├── model-drift.md
    │   ├── performance-tracking.md
    │   ├── ab-testing.md
    │   └── ml-observability.md
    ├── python-ml/
    │   ├── index.md
    │   ├── numpy-pandas.md
    │   ├── data-visualization.md
    │   ├── ml-libraries.md
    │   └── entornos-virtuales.md
    ├── ai-security/
    │   ├── index.md
    │   ├── model-poisoning.md
    │   ├── adversarial-attacks.md
    │   ├── privacy-ml.md
    │   └── responsible-ai.md
    ├── cloud-ai/
    │   ├── index.md
    │   ├── sagemaker-aws.md
    │   ├── azure-ml.md
    │   ├── vertex-ai-gcp.md
    │   └── gpu-instances.md
    └── use-cases/
        ├── index.md
        ├── computer-vision.md
        ├── nlp.md
        ├── recommendation-systems.md
        └── time-series.md
```

---

## 5. PLAN DE IMPLEMENTACIÓN

### 5.1 Orden de Ejecución (Priorizado)

**FASE 1: Fundamentos y Reorganización** (1-2 semanas)

1. Crear estructura de directorios vacía
2. Crear `setup-guia.md` consolidando tools/
3. Crear `snippets.md` como índice
4. Migrar contenido de SysAdmin a nuevas ubicaciones
5. Actualizar SUMMARY.md principal

**FASE 2: Mover Contenido Existente** (1 semana)
6. Mover monitoring/ completo a devops/monitoring-observability/
7. Mover contenido cloud de SysAdmin a cloud/
8. Mover IaC y Config Mgmt de SysAdmin a devops/
9. Mover Git de tools/ a devops/version-control/
10. Eliminar secciones vacías (tools/, code/)

**FASE 3: Crear Bloques Nuevos - DevOps** (2-3 semanas)
11. Crear devops/index.md (introducción y overview)
12. Crear devops/ci-cd/ con Jenkins, GitLab CI, GitHub Actions
13. Crear devops/secrets-management/
14. Crear devops/testing/
15. Crear devops/devsecops/
16. Crear devops/SUMMARY.md

**FASE 4: Expandir Bloques Existentes** (2 semanas)
17. Expandir cloud/ (Azure, GCP, multi-cloud)
18. Expandir containerizacion/ (Helm, Operators, Service Mesh)
19. Expandir ciberseguridad/ (Pentesting, IR, Compliance)
20. Actualizar cross-references entre secciones

**FASE 5: Crear Bloque IA** (3-4 semanas)
21. Crear inteligencia-artificial/index.md
22. Crear fundamentos/, frameworks/, llms/
23. Crear mlops/, model-training/, model-deployment/
24. Crear monitoring-ml/, python-ml/, cloud-ai/
25. Crear inteligencia-artificial/SUMMARY.md

**FASE 6: Refinamiento y Testing** (1 semana)
26. Revisar todos los cross-references
27. Actualizar index.md principal con 6 bloques
28. Testear navegación completa
29. Verificar builds con mkdocs serve
30. Deploy y validación final

---

### 5.2 Tareas Específicas por Fase

#### FASE 1: Fundamentos

##### TAREA 1.1: Crear estructura vacía

```bash
mkdir -p docs/{sysadmin,cloud,devops,ciberseguridad,containerizacion,inteligencia-artificial}/{index.md,SUMMARY.md}
# + subcarpetas según estructura
```

##### TAREA 1.2: setup-guia.md

- Contenido: ZSH, Tmux, NeoVim, Obsidian, ASDF, Git básico
- Formato: Guía paso a paso para setup inicial
- Enlaces: a devops/version-control/ para Git avanzado

##### TAREA 1.3: snippets.md

- Índice categorizado de code examples
- Links a bash examples, python automation, etc.

##### TAREA 1.4: Migrar SysAdmin

```text
sysadmin/index.md (líneas 1-940) → descomponer:
  - Líneas 26-100 → sysadmin/sistemas-operativos/
  - Líneas 103-157 → sysadmin/redes/
  - Líneas 316-420 → sysadmin/almacenamiento/
  - Líneas 217-314 → sysadmin/scripting/
  - Líneas 422-491 → sysadmin/seguridad-basica/
  - Líneas 646-703 → sysadmin/bases-datos-basicas/

  ❌ MOVER a otras secciones:
  - Líneas 493-576 → devops/monitoring-observability/
  - Líneas 579-644 → cloud/
  - Líneas 709-857 → devops/
```

##### TAREA 1.5: SUMMARY.md principal

```markdown
* [Home](index.md)
* [Setup Guide](setup-guia.md)
* [SysAdmin](sysadmin/)
* [Cloud](cloud/)
* [DevOps](devops/)
* [CiberSeguridad](ciberseguridad/)
* [Containerización](containerizacion/)
* [Inteligencia Artificial](inteligencia-artificial/)
* [Code Snippets](snippets.md)
* [Bookmarks](bookmarks.md)
```

---

#### FASE 2: Mover Contenido Existente

##### TAREA 2.1: Monitoring

```bash
mv docs/monitoring/index.md docs/devops/monitoring-observability/index.md
# Crear subsecciones: prometheus-grafana/, logging/, apm-tracing/, alerting/
```

##### TAREA 2.2: Cloud

- Extraer líneas 579-644 de sysadmin/index.md
- Crear cloud/aws/ con estructura detallada
- Crear cloud/azure/ (nuevo contenido)
- Crear cloud/gcp/ (nuevo contenido)

##### TAREA 2.3: IaC y Config Mgmt

- Extraer líneas 709-857 de sysadmin/index.md
- Crear devops/iac/terraform/ con múltiples archivos
- Crear devops/configuration-management/ansible/

##### TAREA 2.4: Git

```bash
mv docs/tools/git/index.md docs/devops/version-control/git-fundamentals.md
mv docs/tools/git/hooks.md docs/devops/version-control/git-hooks.md
```

##### TAREA 2.5: Limpiar

```bash
rm -rf docs/tools/
rm -rf docs/code/
# Contenido integrado en setup-guia.md y devops/
```

---

#### FASE 3: Crear DevOps

##### TAREA 3.1: devops/index.md

- Qué es DevOps (cultura, prácticas, herramientas)
- Los 3 pilares: CI/CD, IaC, Monitoring
- Relación con otras secciones
- Roadmap de aprendizaje

##### TAREA 3.2: CI/CD

- devops/ci-cd/jenkins.md
- devops/ci-cd/gitlab-ci.md
- devops/ci-cd/github-actions.md
- devops/ci-cd/argocd-gitops.md
- Ejemplos de pipelines completos

##### TAREA 3.3: Secrets Management

- devops/secrets-management/hashicorp-vault.md
- devops/secrets-management/aws-secrets-manager.md
- devops/secrets-management/external-secrets-operator.md

##### TAREA 3.4: DevSecOps

- devops/devsecops/sast-dast.md
- devops/devsecops/dependency-scanning.md
- devops/devsecops/container-scanning.md
- devops/devsecops/security-gates.md

---

#### FASE 4: Expandir Bloques

##### TAREA 4.1: Cloud

- cloud/aws/ → expandir cada servicio (EC2, S3, VPC, RDS, Lambda, IAM)
- cloud/azure/ → VMs, Storage, VNet, SQL, Functions, AD
- cloud/gcp/ → Compute, Storage, VPC, SQL, IAM
- cloud/multi-cloud/ → estrategias, tradeoffs
- cloud/cloud-native/ → serverless, arquitecturas
- cloud/finops/ → optimización costos

##### TAREA 4.2: Containerización

- containerizacion/docker/ → Dockerfile, images, compose, networking
- containerizacion/kubernetes/ → architecture, pods, services, storage
- containerizacion/helm/ → charts, templating, best practices
- containerizacion/operators/ → custom controllers, CRDs
- containerizacion/service-mesh/ → Istio, Linkerd
- containerizacion/seguridad/ → Trivy, Falco, policies

##### TAREA 4.3: CiberSeguridad

- ciberseguridad/fundamentos/ → OWASP Top 10, threat modeling
- ciberseguridad/pentesting/ → Kali, metodología, reporting
- ciberseguridad/defensive-security/ → IDS/IPS, SIEM
- ciberseguridad/incident-response/ → IR playbooks, forensics
- ciberseguridad/compliance/ → CIS, STIG, PCI-DSS

---

#### FASE 5: Crear IA

##### TAREA 5.1: Estructura base

- inteligencia-artificial/index.md (overview, por qué IA, aplicaciones)
- inteligencia-artificial/introduccion.md (ML vs DL vs IA)

##### TAREA 5.2: Fundamentos

- fundamentos/ml-basics.md
- fundamentos/supervised-learning.md
- fundamentos/unsupervised-learning.md
- fundamentos/deep-learning.md

##### TAREA 5.3: Frameworks

- frameworks/tensorflow.md
- frameworks/pytorch.md
- frameworks/scikit-learn.md
- frameworks/huggingface.md

##### TAREA 5.4: LLMs

- llms/introduccion-llms.md
- llms/gpt-modelos.md
- llms/claude.md
- llms/llama-opensource.md
- llms/fine-tuning.md
- llms/rag-patterns.md

##### TAREA 5.5: MLOps

- mlops/ml-pipelines.md
- mlops/model-versioning.md
- mlops/mlflow.md
- mlops/kubeflow.md
- mlops/ci-cd-ml.md

##### TAREA 5.6: Deployment

- model-deployment/torchserve.md
- model-deployment/tfserving.md
- model-deployment/fastapi-ml.md
- model-deployment/inference-optimization.md

##### TAREA 5.7: Cloud AI

- cloud-ai/sagemaker-aws.md
- cloud-ai/azure-ml.md
- cloud-ai/vertex-ai-gcp.md

---

#### FASE 6: Refinamiento

##### TAREA 6.1: Cross-references

- Revisar todos los links entre secciones
- Asegurar bidireccionalidad (A → B y B → A)
- Crear "Related Topics" al final de cada página

##### TAREA 6.2: index.md principal

- Rediseñar con 6 cards principales
- Eliminar referencia a "Tools" y "Code"
- Añadir "Setup Guide" prominente
- Actualizar "Quick Paths by Role" con nueva estructura

##### TAREA 6.3: Testing

```bash
mkdocs serve
# Verificar:
# - Navegación completa
# - Links rotos
# - SUMMARY.md correctos
# - Rendering correcto
```

##### TAREA 6.4: Deploy

```bash
mkdocs build --strict
# Fix warnings
git add .
git commit -m "Reestructuración arquitectónica: 6 bloques principales"
git push origin develop
# Merge to main → auto-deploy
```

---

## 6. TRADEOFFS Y DECISIONES ARQUITECTÓNICAS

### 6.1 Tradeoff: Monitoring como subsección vs independiente

**DECISIÓN**: Monitoring → devops/monitoring-observability/

**Tradeoffs**:

| Aspecto | Independiente | Subsección DevOps |
|---------|---------------|-------------------|
| Visibilidad | ✅ Top-level nav | ⚠️ Requiere 2 clicks |
| Cohesión | ❌ Aislado de CI/CD | ✅ Parte del ciclo DevOps |
| Complejidad nav | ❌ Más secciones (8 vs 6) | ✅ Menos secciones |
| Relevancia SysAdmin | ⚠️ SysAdmin también monitorea | ✅ Cross-ref desde SysAdmin |
| Tamaño contenido | ✅ Grande (455 líneas) | ✅ Suficientemente grande |

**Justificación**:

- Monitoring moderno (Prometheus, Grafana, OpenTelemetry) ES DevOps
- SysAdmin tradicional usa Nagios/Zabbix (mencionado en sysadmin/index.md)
- Cross-references fuertes aseguran que SysAdmin lo encuentre
- Reduce complejidad top-level (6 bloques vs 8)

**Mitigación**:

- Cross-reference prominente desde sysadmin/index.md
- Sección "Monitoring" en setup-guia.md para quick start
- Tags/search aseguran discovery

---

### 6.2 Tradeoff: Contenido duplicado vs distribución

**PROBLEMA**: Algunos temas aparecen en múltiples contextos

- Container Security → ¿containers/ o ciberseguridad/?
- Cloud Security → ¿cloud/ o ciberseguridad/?
- Monitoring K8s → ¿devops/monitoring/ o containerizacion/?

**DECISIÓN**: Single Source of Truth + Cross-references

**Implementación**:

| Tema | SSOT (fuente única) | Cross-references |
|------|---------------------|------------------|
| Container Security | ciberseguridad/container-security/ | containerizacion/seguridad/ → link |
| Cloud Security | ciberseguridad/cloud-security/ | cloud/aws/iam-security.md → link |
| K8s Monitoring | containerizacion/monitoring/ | devops/monitoring/ → link |

**WHY**:

- Evita duplicación y desincronización
- Cada tema tiene un "home" claro
- Cross-references mantienen contexto

**Ejemplo**:

```markdown
# containerizacion/index.md

## Seguridad en Containers

Los containers introducen nuevos vectores de ataque. Para una guía completa de
seguridad, consulta [Container Security](../ciberseguridad/container-security/).

**Quick tips**:
- Escanea imágenes con Trivy
- Usa runtime security con Falco
- Implementa admission controllers

→ [Ver guía completa de Container Security](../ciberseguridad/container-security/)
```

---

### 6.3 Tradeoff: Profundidad vs amplitud en IA

**PROBLEMA**: IA es nuevo, ¿cuánto detalle incluir inicialmente?

**DECISIÓN**: Estructura completa, contenido inicial básico, expandir iterativamente

**Estrategia**:

| Subsección | Prioridad | Profundidad Inicial |
|------------|-----------|---------------------|
| fundamentos/ | 🔥 Alta | Básico (definiciones, conceptos) |
| frameworks/ | 🔥 Alta | Getting started guides |
| llms/ | 🔥 Alta | Intro, uso básico, RAG |
| mlops/ | 🟡 Media | Overview, herramientas clave |
| model-deployment/ | 🟡 Media | Patterns básicos |
| cloud-ai/ | 🟢 Baja | Links a docs oficiales |

**WHY**:

- IA evoluciona rápidamente → mejor estructura flexible
- Usuarios necesitan intro accesible, no deep dive
- Expandir con casos de uso reales

**Roadmap IA**:

1. Q1: Estructura + fundamentos + LLMs
2. Q2: MLOps + deployment
3. Q3: Cloud AI + casos de uso
4. Q4: Advanced topics (distributed training, etc.)

---

### 6.4 Tradeoff: SysAdmin tradicional vs cloud-first

**PROBLEMA**: ¿SysAdmin debe incluir cloud, o es "legacy"?

**DECISIÓN**: SysAdmin = fundamentos on-premise + habilidades transferibles

**Filosofía**:

- SysAdmin NO es legacy, es foundational
- Cloud abstrae infraestructura, pero necesitas entender qué abstrae
- Path: SysAdmin → Cloud → DevOps

**Contenido SysAdmin (post-refactor)**:

- ✅ Linux/Windows: Siempre relevante
- ✅ Redes: TCP/IP es universal (cloud o no)
- ✅ Almacenamiento: Conceptos RAID, backup aplicables a cloud storage
- ✅ Scripting: Bash/PowerShell siguen siendo necesarios
- ❌ Cloud: Va a cloud/ (no duplicar)
- ❌ IaC/Automation: Es DevOps, no admin manual

**WHY**:

- Clear separation of concerns
- Respeta el path de aprendizaje
- Evita confusión (¿esto es AWS o on-premise?)

---

### 6.5 Tradeoff: Mantener "Code" o eliminar

**DECISIÓN**: Eliminar "Code" como sección, integrar snippets en contexto

**Justificación**:

| Opción | PRO | CON |
|--------|-----|-----|
| Mantener "Code" | Fácil encontrar snippets | Sin contexto, crece descontrolado |
| Eliminar, integrar | Snippets con contexto | Puede dificultar discovery |
| Índice snippets.md | Best of both worlds | Requiere mantenimiento |

**Implementación elegida**: Eliminar + snippets.md

**WHY**:

- Code sin contexto tiene poco valor educativo
- Mejor: ejemplos dentro de cada guía (bash en sysadmin/scripting/, python en devops/automation/)
- snippets.md actúa como "buscar por lenguaje"

**snippets.md estructura**:

```markdown
# Code Snippets Index

## Bash
- [SysAdmin Scripting Examples](sysadmin/scripting/bash-examples.md)
- [DevOps Automation Scripts](devops/automation/bash-automation.md)

## Python
- [SysAdmin Python Tools](sysadmin/scripting/python-sysadmin.md)
- [DevOps Automation](devops/automation/python-automation.md)
- [ML Data Processing](inteligencia-artificial/python-ml/data-processing.md)

## YAML
- [Ansible Playbooks](devops/configuration-management/ansible/playbooks.md)
- [Kubernetes Manifests](containerizacion/kubernetes/index.md)
- [CI/CD Pipelines](devops/ci-cd/github-actions.md)
```

---

## 7. IMPACTO Y RIESGOS

### 7.1 Impacto en Usuarios

**Navegación**:

- ✅ Más clara (6 bloques vs 8 actuales)
- ⚠️ Cambio de ubicaciones (bookmarks rotos)
- ✅ Mejor discoverability (temas agrupados lógicamente)

**Contenido**:

- ✅ Menos duplicación
- ✅ Contexto más claro
- ⚠️ Contenido movido (reaprender estructura)

**SEO**:

- ⚠️ URLs cambiarán (redirects necesarios?)
- ✅ Mejor estructura semántica (mejora SEO long-term)

### 7.2 Riesgos Técnicos

| Riesgo | Probabilidad | Impacto | Mitigación |
|--------|--------------|---------|------------|
| Links rotos internos | Alta | Alto | Pre-commit hooks + testing exhaustivo |
| Build failures | Media | Alto | mkdocs build --strict en cada paso |
| Merge conflicts | Media | Medio | Trabajo en branch, merge frecuente |
| Contenido perdido | Baja | Crítico | Git history + backup pre-refactor |

### 7.3 Esfuerzo Estimado

| Fase | Esfuerzo | Complejidad | Blocker Potential |
|------|----------|-------------|-------------------|
| FASE 1: Fundamentos | 8-16h | Media | Baja (mecánico) |
| FASE 2: Mover contenido | 6-10h | Baja | Baja (copy-paste) |
| FASE 3: Crear DevOps | 16-24h | Alta | Media (nuevo contenido) |
| FASE 4: Expandir bloques | 16-24h | Media | Media (research) |
| FASE 5: Crear IA | 24-32h | Alta | Alta (contenido complejo) |
| FASE 6: Refinamiento | 8-12h | Baja | Baja (polish) |
| **TOTAL** | **78-118h** | | **~2-3 semanas full-time** |

---

## 8. CONCLUSIÓN Y RECOMENDACIONES

### 8.1 Resumen Ejecutivo

**Estado Actual**: Sitio con 8 secciones, solapamiento masivo, SysAdmin como "catch-all", falta de DevOps claro.

**Estado Futuro**: 6 bloques principales bien definidos, sin duplicación, clara separación de concerns, nueva sección IA.

**Beneficios**:

1. **Claridad**: Usuario sabe exactamente dónde buscar
2. **Escalabilidad**: Estructura permite crecimiento sin caos
3. **Mantenibilidad**: Sin duplicación, updates más fáciles
4. **Completeness**: Cubre toda la stack moderna (SysAdmin → Cloud → DevOps → Security → Containers → IA)

### 8.2 Recomendación Final

**PROCEDER con la reestructuración** siguiendo el plan de 6 fases.

**Prioridad de ejecución**:

1. **Inmediato**: FASE 1-2 (fundamentos + mover contenido)
2. **Short-term**: FASE 3-4 (crear DevOps + expandir)
3. **Long-term**: FASE 5 (crear IA)
4. **Continuous**: FASE 6 (refinamiento)

**Critical Success Factors**:

- Testing exhaustivo en cada fase
- Cross-references fuertes entre secciones
- Mantener landing page (index.md) actualizado
- Documentar cambios en CHANGELOG.md

### 8.3 Next Steps Inmediatos

1. **Backup**: `git checkout -b refactor-backup`
2. **Branch**: `git checkout -b refactor/architecture-6-blocks`
3. **Execute**: Comenzar FASE 1 (crear estructura)
4. **Test**: `mkdocs serve` después de cada cambio
5. **Commit**: Commits pequeños y frecuentes
6. **Review**: Validar navegación antes de merge

---

## FIN DEL ANÁLISIS ARQUITECTÓNICO

---

## APÉNDICE A: Comandos Útiles

```bash
# Crear estructura completa
./scripts/create-structure.sh

# Testing
mkdocs serve --strict

# Buscar links rotos
grep -r "](../" docs/ | grep -v ".md:"

# Contar archivos por sección
find docs/sysadmin -name "*.md" | wc -l

# Backup pre-refactor
git checkout -b backup-$(date +%Y%m%d)
git push origin backup-$(date +%Y%m%d)
```

## APÉNDICE B: Template para index.md

```markdown
---
title: [SECTION NAME]
description: [ONE LINE DESCRIPTION]
tags:
  - [tag1]
  - [tag2]
---

# [SECTION NAME]

[Brief introduction paragraph - what is this section about?]

!!! abstract "Quick Reference"
    - **Topic 1**: [Brief description]
    - **Topic 2**: [Brief description]
    - **Topic 3**: [Brief description]

---

## Overview

[Detailed overview - 2-3 paragraphs explaining scope, purpose, and why it matters]

---

## [Main Topic 1]

[Content organized with headers, tabs, admonitions, code blocks]

=== "Subtopic A"
    [Content]

=== "Subtopic B"
    [Content]

---

## Related Topics

- [Link to related section 1](../section1/)
- [Link to related section 2](../section2/)

---

[Back to Home](../index.md){ .md-button .md-button--primary }
[Related Section](../section/){ .md-button }
```

---

**Document Version**: 1.0
**Last Updated**: 2026-01-06
**Status**: Ready for Implementation
