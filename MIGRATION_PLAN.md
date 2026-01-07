# Plan de Migración: Reestructuración a 6 Bloques

**Versión**: 1.0
**Fecha**: 2026-01-06
**Estado**: Listo para ejecución

---

## Visión Rápida: Antes vs Después

### ANTES (Estado Actual)

```text
8 secciones con solapamiento masivo:

┌─────────────────────────────────────────────────────┐
│ SYSADMIN (940 líneas) ← PROBLEMA: catch-all        │
│   ├── OS, Redes, Storage ✓                         │
│   ├── Cloud (AWS, Azure, GCP) ✗ duplica cloud/     │
│   ├── IaC (Terraform, Ansible) ✗ es DevOps         │
│   ├── Containers ✗ duplica containers/              │
│   └── Monitoring ✗ duplica monitoring/              │
├─────────────────────────────────────────────────────┤
│ CLOUD (16 líneas) ← Solo AWS básico                │
├─────────────────────────────────────────────────────┤
│ CONTAINERS (50 líneas) ← Solo referencias           │
├─────────────────────────────────────────────────────┤
│ CODE (snippets) ← Sin contexto claro                │
├─────────────────────────────────────────────────────┤
│ MONITORING (455 líneas) ← ¿DevOps o SysAdmin?      │
├─────────────────────────────────────────────────────┤
│ SECURITY (79 líneas) ← Básico                       │
├─────────────────────────────────────────────────────┤
│ TOOLS (dev tools) ← ¿Qué es "tool"?                │
├─────────────────────────────────────────────────────┤
│ BOOKMARKS ✓                                         │
└─────────────────────────────────────────────────────┘

PROBLEMAS:
❌ DevOps NO EXISTE como concepto
❌ Contenido duplicado entre secciones
❌ IA NO EXISTE
❌ Categorización confusa
```

### DESPUÉS (Estado Futuro)

```text
6 bloques principales bien definidos:

┌──────────────────────────────────────────────────────┐
│ 1. SYSADMIN (fundamentos tradicionales)             │
│    ├── OS: Linux, Windows                           │
│    ├── Redes: TCP/IP, DNS, routing                  │
│    ├── Almacenamiento: RAID, SAN, backup            │
│    ├── Scripting: Bash, PowerShell (admin)          │
│    └── Seguridad Básica: hardening, firewalls       │
├──────────────────────────────────────────────────────┤
│ 2. CLOUD (plataformas cloud completas)              │
│    ├── AWS: EC2, S3, VPC, RDS, Lambda, IAM          │
│    ├── Azure: VMs, Storage, VNet, SQL, Functions    │
│    ├── GCP: Compute, Storage, VPC, IAM              │
│    ├── Multi-cloud strategies                        │
│    └── FinOps: optimización costos                  │
├──────────────────────────────────────────────────────┤
│ 3. DEVOPS (automatización y cultura)                │
│    ├── CI/CD: Jenkins, GitLab, GitHub Actions       │
│    ├── IaC: Terraform, Pulumi, CloudFormation       │
│    ├── Config Mgmt: Ansible, Puppet, Chef           │
│    ├── Version Control: Git workflows               │
│    ├── Monitoring: Prometheus, Grafana, ELK         │
│    ├── Secrets: Vault, AWS Secrets Manager          │
│    └── DevSecOps: SAST, DAST, security gates        │
├──────────────────────────────────────────────────────┤
│ 4. CIBERSEGURIDAD (offensive + defensive)           │
│    ├── Pentesting: Kali, Metasploit, OWASP          │
│    ├── Web Security: ZAP, Burp Suite                │
│    ├── OSINT: reconnaissance, Maltego               │
│    ├── Defensive: IDS/IPS, SIEM, Wazuh              │
│    ├── Compliance: CIS, STIG, PCI-DSS               │
│    └── Incident Response: IR playbooks, forensics   │
├──────────────────────────────────────────────────────┤
│ 5. CONTAINERIZACIÓN (Docker + K8s ecosystem)        │
│    ├── Docker: Dockerfile, compose, networking      │
│    ├── Kubernetes: pods, services, storage          │
│    ├── Helm: charts, templating                     │
│    ├── Operators: custom controllers, CRDs          │
│    ├── Service Mesh: Istio, Linkerd                 │
│    └── Security: Trivy, Falco, policies             │
├──────────────────────────────────────────────────────┤
│ 6. INTELIGENCIA ARTIFICIAL (ML + MLOps)             │
│    ├── Frameworks: TensorFlow, PyTorch, Hugging     │
│    ├── LLMs: GPT, Claude, Llama, fine-tuning        │
│    ├── MLOps: pipelines, MLflow, Kubeflow           │
│    ├── Model Deployment: serving, inference         │
│    ├── Cloud AI: SageMaker, Azure ML, Vertex AI     │
│    └── AI Security: model poisoning, adversarial    │
└──────────────────────────────────────────────────────┘

TRANSVERSALES:
├── setup-guia.md (ZSH, NeoVim, Git inicial)
├── snippets.md (índice de code examples)
└── bookmarks.md (recursos externos)

BENEFICIOS:
✅ Clear separation of concerns
✅ DevOps como entidad propia
✅ Sin duplicación de contenido
✅ IA integrada desde el inicio
✅ Navegación intuitiva
```

---

## Matriz de Migración: ¿Qué se Mueve?

### Desde SysAdmin (940 líneas → 400-500 líneas)

| Contenido | Líneas | Acción | Destino |
|-----------|--------|--------|---------|
| Sistemas Operativos | 26-100 | ✅ MANTENER | sysadmin/sistemas-operativos/ |
| Redes | 103-157 | ✅ MANTENER | sysadmin/redes/ |
| Virtualización (VMs) | 159-196 | ✅ MANTENER | sysadmin/virtualizacion/ |
| Contenedores (Docker, K8s) | 197-214 | ⚠️ MOVER | containerizacion/ |
| Scripting | 217-314 | ✅ MANTENER | sysadmin/scripting/ |
| Almacenamiento | 316-420 | ✅ MANTENER | sysadmin/almacenamiento/ |
| Seguridad básica | 422-491 | ✅ MANTENER | sysadmin/seguridad-basica/ |
| Monitoring | 493-576 | ⚠️ MOVER | devops/monitoring-observability/ |
| Cloud (AWS, Azure, GCP) | 579-644 | ⚠️ MOVER | cloud/ |
| Bases de datos | 646-703 | ✅ MANTENER | sysadmin/bases-datos-basicas/ |
| Config Mgmt (Ansible, Puppet) | 709-804 | ⚠️ MOVER | devops/configuration-management/ |
| IaC (Terraform, Pulumi) | 806-857 | ⚠️ MOVER | devops/iac/ |

### Desde Monitoring (455 líneas → mover completo)

| Contenido | Acción | Destino |
|-----------|--------|---------|
| TODO el contenido | ⚠️ MOVER | devops/monitoring-observability/ |
| Prometheus + Grafana | ⚠️ MOVER | devops/monitoring-observability/prometheus-grafana/ |
| ELK, Loki | ⚠️ MOVER | devops/monitoring-observability/logging/ |
| APM, Tracing | ⚠️ MOVER | devops/monitoring-observability/apm-tracing/ |
| Alerting | ⚠️ MOVER | devops/monitoring-observability/alerting/ |

### Desde Tools (eliminar sección)

| Contenido | Acción | Destino |
|-----------|--------|---------|
| ZSH | ⚠️ INTEGRAR | setup-guia.md |
| Tmux | ⚠️ INTEGRAR | setup-guia.md |
| NeoVim | ⚠️ INTEGRAR | setup-guia.md |
| Obsidian | ⚠️ INTEGRAR | setup-guia.md |
| Git fundamentals | ⚠️ MOVER | devops/version-control/git-fundamentals.md |
| Git Hooks | ⚠️ MOVER | devops/version-control/git-hooks.md |
| ASDF | ⚠️ INTEGRAR | setup-guia.md |

### Desde Code (eliminar sección)

| Contenido | Acción | Destino |
|-----------|--------|---------|
| Shell snippets | ⚠️ INTEGRAR | sysadmin/scripting/bash-examples.md |
| Python snippets | ⚠️ INTEGRAR | devops/automation/python-automation.md |
| Pip | ⚠️ INTEGRAR | inteligencia-artificial/python-ml/entornos.md |

### Expansiones (contenido nuevo)

| Sección | Estado Actual | Acción |
|---------|---------------|--------|
| Cloud/Azure | NO EXISTE | 🆕 CREAR |
| Cloud/GCP | NO EXISTE | 🆕 CREAR |
| DevOps/CI-CD | NO EXISTE | 🆕 CREAR |
| DevOps/Secrets | NO EXISTE | 🆕 CREAR |
| Containers/Helm | Referencias | 🔄 EXPANDIR |
| Containers/Operators | Referencias | 🔄 EXPANDIR |
| Security/IR | NO EXISTE | 🆕 CREAR |
| Security/Defensive | NO EXISTE | 🆕 CREAR |
| IA/* | NO EXISTE | 🆕 CREAR TODO |

---

## Fases de Implementación

### FASE 1: Fundamentos (1-2 semanas)

**Objetivo**: Crear estructura base y mover contenido existente

**Tareas**:

```bash
1. Crear directorios vacíos para 6 bloques
2. Crear setup-guia.md (consolidar tools/)
3. Crear snippets.md (índice de code)
4. Descomponer sysadmin/index.md en subcarpetas
5. Actualizar SUMMARY.md principal
```

**Entregables**:

- ✅ Estructura de directorios completa
- ✅ setup-guia.md funcional
- ✅ sysadmin/ reorganizado (sin cloud, IaC, monitoring)
- ✅ Navegación actualizada

**Testing**:

```bash
mkdocs serve --strict
# Verificar que sysadmin/ funciona correctamente
```

---

### FASE 2: Migración de Contenido (1 semana)

**Objetivo**: Mover contenido de secciones a eliminar

**Tareas**:

```bash
1. monitoring/ → devops/monitoring-observability/
2. cloud content de sysadmin/ → cloud/
3. IaC de sysadmin/ → devops/iac/
4. Config mgmt de sysadmin/ → devops/configuration-management/
5. tools/git/ → devops/version-control/
6. Eliminar tools/ y code/
```

**Entregables**:

- ✅ devops/monitoring-observability/ completo
- ✅ cloud/ con contenido de sysadmin
- ✅ devops/iac/ funcional
- ✅ devops/configuration-management/ funcional
- ✅ tools/ y code/ eliminados

**Testing**:

```bash
mkdocs serve --strict
# Verificar links no rotos
grep -r "](tools/" docs/
grep -r "](code/" docs/
```

---

### FASE 3: Crear DevOps (2-3 semanas)

**Objetivo**: Construir sección DevOps completa

**Tareas**:

```bash
1. devops/index.md (introducción DevOps)
2. devops/ci-cd/ (Jenkins, GitLab, GitHub Actions, ArgoCD)
3. devops/secrets-management/
4. devops/testing/
5. devops/devsecops/
6. devops/SUMMARY.md completo
```

**Entregables**:

- ✅ devops/index.md (overview completo)
- ✅ devops/ci-cd/ con 4-5 guías
- ✅ devops/secrets-management/ con 3 guías
- ✅ devops/testing/ con ejemplos
- ✅ devops/devsecops/ con security scanning

**Testing**:

```bash
mkdocs serve
# Navegar devops/ completo
# Verificar cross-references
```

---

### FASE 4: Expandir Bloques Existentes (2 semanas)

**Objetivo**: Completar cloud, containers, security

**Tareas**:

```bash
# CLOUD
1. cloud/azure/ (7-8 páginas)
2. cloud/gcp/ (5-6 páginas)
3. cloud/multi-cloud/
4. cloud/cloud-native/
5. cloud/finops/

# CONTAINERS
6. containerizacion/helm/
7. containerizacion/operators/
8. containerizacion/service-mesh/
9. containerizacion/seguridad/ (expandir)

# SECURITY
10. ciberseguridad/pentesting/ (expandir)
11. ciberseguridad/defensive-security/
12. ciberseguridad/incident-response/
13. ciberseguridad/compliance/
```

**Entregables**:

- ✅ cloud/ completo con 3 providers
- ✅ containerizacion/ con Helm, Operators, Service Mesh
- ✅ ciberseguridad/ con defensive + IR

---

### FASE 5: Crear Inteligencia Artificial (3-4 semanas)

**Objetivo**: Construir sección IA desde cero

**Tareas**:

```bash
1. inteligencia-artificial/index.md
2. fundamentos/ (ML basics, supervised, unsupervised, DL)
3. frameworks/ (TensorFlow, PyTorch, Hugging Face)
4. llms/ (GPT, Claude, Llama, fine-tuning, RAG)
5. mlops/ (pipelines, MLflow, Kubeflow)
6. model-training/ (notebooks, experiments)
7. model-deployment/ (TorchServe, FastAPI)
8. monitoring-ml/ (drift, performance)
9. python-ml/ (numpy, pandas, viz)
10. cloud-ai/ (SageMaker, Azure ML, Vertex AI)
```

**Entregables**:

- ✅ inteligencia-artificial/index.md (overview)
- ✅ fundamentos/ completo
- ✅ frameworks/ con 4 guías
- ✅ llms/ con 6-7 guías
- ✅ mlops/ funcional
- ✅ deployment + monitoring + cloud-ai

---

### FASE 6: Refinamiento (1 semana)

**Objetivo**: Polish, testing, deployment

**Tareas**:

```bash
1. Revisar todos los cross-references
2. Actualizar index.md principal
3. Crear "Related Topics" en cada página
4. Testing exhaustivo de navegación
5. Fix links rotos
6. Verificar builds
7. Deploy a producción
```

**Entregables**:

- ✅ Cross-references bidireccionales
- ✅ index.md con 6 cards principales
- ✅ Zero broken links
- ✅ Build exitoso en strict mode
- ✅ Deployed a main branch

---

## Scripts de Automatización

### Script 1: Crear Estructura de Directorios

```bash
#!/bin/bash
# create-structure.sh

set -e

BASE_DIR="docs"

echo "Creating 6-block structure..."

# SYSADMIN
mkdir -p "${BASE_DIR}/sysadmin"/{sistemas-operativos/{linux,windows-server},redes,almacenamiento,virtualizacion,scripting,seguridad-basica,bases-datos-basicas}

# CLOUD
mkdir -p "${BASE_DIR}/cloud"/{aws,azure,gcp,multi-cloud,cloud-native,finops}

# DEVOPS
mkdir -p "${BASE_DIR}/devops"/{ci-cd,iac/terraform,configuration-management/{ansible,puppet,chef},version-control,monitoring-observability/{prometheus-grafana,logging,apm-tracing,alerting},secrets-management,artifact-management,testing,devsecops}

# CIBERSEGURIDAD
mkdir -p "${BASE_DIR}/ciberseguridad"/{fundamentos,pentesting/kali-linux,web-security,network-security,exploitation,osint,defensive-security/siem,compliance,hardening,incident-response,container-security,cloud-security}

# CONTAINERIZACIÓN
mkdir -p "${BASE_DIR}/containerizacion"/{docker,kubernetes,helm,operators,service-mesh,cloud-kubernetes,seguridad,monitoring,local-dev,alternative-runtimes,best-practices}

# INTELIGENCIA ARTIFICIAL
mkdir -p "${BASE_DIR}/inteligencia-artificial"/{fundamentos,frameworks,llms,mlops,data-engineering,model-training,model-deployment,monitoring-ml,python-ml,ai-security,cloud-ai,use-cases}

# Create index.md and SUMMARY.md templates for each main section
for section in sysadmin cloud devops ciberseguridad containerizacion inteligencia-artificial; do
    cat > "${BASE_DIR}/${section}/index.md" <<EOF
---
title: ${section^}
description: TODO
tags:
  - ${section}
---

# ${section^}

TODO: Add content

---

## Overview

TODO

---

## Related Topics

- [Home](../index.md)

---

[Back to Home](../index.md){ .md-button .md-button--primary }
EOF

    cat > "${BASE_DIR}/${section}/SUMMARY.md" <<EOF
* [${section^} Overview](index.md)
EOF
done

echo "✅ Structure created successfully!"
echo "Next: Run migration scripts"
```

### Script 2: Migrar Monitoring a DevOps

```bash
#!/bin/bash
# migrate-monitoring.sh

set -e

SOURCE="docs/monitoring"
DEST="docs/devops/monitoring-observability"

echo "Migrating monitoring/ to devops/monitoring-observability/..."

# Create destination
mkdir -p "${DEST}"

# Move index.md
cp "${SOURCE}/index.md" "${DEST}/index.md"

# Update SUMMARY
cp "${SOURCE}/SUMMARY.md" "${DEST}/SUMMARY.md"
sed -i 's|Monitoring & Observability|Monitoring & Observability|g' "${DEST}/SUMMARY.md"

echo "✅ Monitoring migrated!"
echo "⚠️  Manual: Update cross-references in sysadmin/, containerizacion/"
echo "⚠️  Manual: Delete old monitoring/ after verification"
```

### Script 3: Validar Links

```bash
#!/bin/bash
# validate-links.sh

set -e

echo "Checking for broken internal links..."

# Find all .md files and check for links to deleted sections
BROKEN_LINKS=0

# Check for links to old tools/
if grep -r "](tools/" docs/ --include="*.md" | grep -v "docs/tools/"; then
    echo "❌ Found links to deleted tools/ directory"
    BROKEN_LINKS=$((BROKEN_LINKS + 1))
fi

# Check for links to old code/
if grep -r "](code/" docs/ --include="*.md" | grep -v "docs/code/"; then
    echo "❌ Found links to deleted code/ directory"
    BROKEN_LINKS=$((BROKEN_LINKS + 1))
fi

# Check for links to old monitoring/
if grep -r "](monitoring/" docs/ --include="*.md" | grep -v "docs/devops/monitoring-observability/"; then
    echo "❌ Found links to old monitoring/ directory"
    BROKEN_LINKS=$((BROKEN_LINKS + 1))
fi

if [ ${BROKEN_LINKS} -eq 0 ]; then
    echo "✅ No broken links found!"
    exit 0
else
    echo "❌ Found ${BROKEN_LINKS} types of broken links"
    exit 1
fi
```

### Script 4: Testing Build

```bash
#!/bin/bash
# test-build.sh

set -e

echo "Testing MkDocs build..."

# Test with strict mode
mkdocs build --strict --clean

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo "Testing serve..."
    timeout 10s mkdocs serve &
    sleep 5
    curl -s http://127.0.0.1:8000/ > /dev/null
    if [ $? -eq 0 ]; then
        echo "✅ Serve working!"
    else
        echo "❌ Serve failed"
        exit 1
    fi
else
    echo "❌ Build failed!"
    exit 1
fi
```

---

## Checklist de Ejecución

### Pre-Migration Checklist

- [ ] Backup completo del repo actual
- [ ] Crear branch `refactor/architecture-6-blocks`
- [ ] Leer ARCHITECTURE_ANALYSIS.md completo
- [ ] Entender matriz de migración
- [ ] Revisar scripts de automatización
- [ ] Preparar entorno de testing local

### FASE 1 Checklist

- [ ] Ejecutar `create-structure.sh`
- [ ] Crear `setup-guia.md`
- [ ] Crear `snippets.md`
- [ ] Descomponer `sysadmin/index.md` en subcarpetas
- [ ] Actualizar `SUMMARY.md` principal
- [ ] Test: `mkdocs serve --strict`
- [ ] Commit: "FASE 1: Estructura base y reorganización sysadmin"

### FASE 2 Checklist

- [ ] Ejecutar `migrate-monitoring.sh`
- [ ] Mover cloud content de sysadmin a cloud/
- [ ] Mover IaC de sysadmin a devops/iac/
- [ ] Mover config mgmt de sysadmin a devops/
- [ ] Mover git de tools/ a devops/version-control/
- [ ] Eliminar `tools/` (después de mover todo)
- [ ] Eliminar `code/` (después de integrar)
- [ ] Ejecutar `validate-links.sh`
- [ ] Test: `mkdocs serve --strict`
- [ ] Commit: "FASE 2: Migración de contenido existente"

### FASE 3 Checklist

- [ ] Crear `devops/index.md`
- [ ] Crear `devops/ci-cd/` con Jenkins, GitLab CI, GitHub Actions
- [ ] Crear `devops/secrets-management/`
- [ ] Crear `devops/testing/`
- [ ] Crear `devops/devsecops/`
- [ ] Crear `devops/SUMMARY.md`
- [ ] Cross-references desde otras secciones
- [ ] Test: `mkdocs serve`
- [ ] Commit: "FASE 3: Creación de sección DevOps"

### FASE 4 Checklist

- [ ] Expandir `cloud/aws/`
- [ ] Crear `cloud/azure/`
- [ ] Crear `cloud/gcp/`
- [ ] Crear `cloud/multi-cloud/`
- [ ] Expandir `containerizacion/helm/`
- [ ] Expandir `containerizacion/operators/`
- [ ] Crear `containerizacion/service-mesh/`
- [ ] Expandir `ciberseguridad/pentesting/`
- [ ] Crear `ciberseguridad/defensive-security/`
- [ ] Crear `ciberseguridad/incident-response/`
- [ ] Test: `mkdocs serve`
- [ ] Commit: "FASE 4: Expansión de bloques existentes"

### FASE 5 Checklist

- [ ] Crear `inteligencia-artificial/index.md`
- [ ] Crear `fundamentos/`
- [ ] Crear `frameworks/`
- [ ] Crear `llms/`
- [ ] Crear `mlops/`
- [ ] Crear `model-training/`
- [ ] Crear `model-deployment/`
- [ ] Crear `monitoring-ml/`
- [ ] Crear `python-ml/`
- [ ] Crear `cloud-ai/`
- [ ] Crear `inteligencia-artificial/SUMMARY.md`
- [ ] Test: `mkdocs serve`
- [ ] Commit: "FASE 5: Creación de sección Inteligencia Artificial"

### FASE 6 Checklist

- [ ] Revisar todos los cross-references (bidireccionales)
- [ ] Actualizar `index.md` principal con 6 cards
- [ ] Añadir "Related Topics" en cada página relevante
- [ ] Ejecutar `validate-links.sh`
- [ ] Ejecutar `test-build.sh`
- [ ] Fix todos los warnings de `mkdocs build --strict`
- [ ] Testing navegación completa manual
- [ ] Actualizar CLAUDE.md con nueva estructura
- [ ] Commit: "FASE 6: Refinamiento y finalización"
- [ ] Merge a `develop`
- [ ] Testing en develop
- [ ] Merge a `main` → auto-deploy

---

## Comandos Útiles Durante Migración

```bash
# Ver archivos modificados
git status

# Ver estructura de directorios
tree -L 3 docs/

# Contar archivos .md por sección
find docs/sysadmin -name "*.md" | wc -l

# Buscar referencias a sección antigua
grep -r "](tools/" docs/ --include="*.md"

# Buscar links rotos (después de mover archivos)
grep -r "](../" docs/ --include="*.md" | grep "\.md:" | sort | uniq

# Testing local con live reload
mkdocs serve

# Testing con strict mode (falla en warnings)
mkdocs build --strict --clean

# Ver warnings de MkDocs
mkdocs build 2>&1 | grep -i warning

# Buscar TODOs en archivos
grep -r "TODO" docs/ --include="*.md"

# Estadísticas de contenido
find docs/ -name "*.md" -exec wc -l {} \; | awk '{sum+=$1} END {print sum " total lines"}'
```

---

## Criterios de Éxito

### Técnicos

- ✅ `mkdocs build --strict` pasa sin errores ni warnings
- ✅ `mkdocs serve` funciona correctamente
- ✅ Zero broken links internos
- ✅ Todos los SUMMARY.md correctos
- ✅ Pre-commit hooks pasan
- ✅ Build en GitHub Actions exitoso

### Estructurales

- ✅ 6 bloques principales claramente definidos
- ✅ Sin duplicación de contenido entre secciones
- ✅ Cross-references bidireccionales funcionando
- ✅ setup-guia.md consolidando tools
- ✅ snippets.md como índice de code examples
- ✅ Cada sección tiene index.md y SUMMARY.md

### De Contenido

- ✅ SysAdmin reducido de 940 a ~400-500 líneas
- ✅ Cloud expandido con AWS, Azure, GCP
- ✅ DevOps creado con CI/CD, IaC, Monitoring
- ✅ Containers expandido con Helm, Operators
- ✅ Security expandido con IR, Defensive
- ✅ IA creado con estructura completa

---

## Rollback Plan

Si algo sale mal durante la migración:

```bash
# 1. Volver al branch de backup
git checkout backup-YYYYMMDD

# 2. Crear nuevo branch de trabajo
git checkout -b refactor/architecture-6-blocks-v2

# 3. Cherry-pick commits buenos (si los hay)
git cherry-pick <commit-hash>

# 4. Continuar desde punto seguro
```

**Puntos de checkpoint**:

- Después de FASE 1: branch `checkpoint/fase-1`
- Después de FASE 2: branch `checkpoint/fase-2`
- Etc.

```bash
# Crear checkpoint
git checkout -b checkpoint/fase-1
git push origin checkpoint/fase-1
git checkout refactor/architecture-6-blocks
```

---

## Contacto y Soporte

**Para preguntas sobre**:

- Decisiones arquitectónicas → Ver ARCHITECTURE_ANALYSIS.md sección 6
- Migración de contenido específico → Ver matriz de migración
- Scripts fallando → Revisar logs de mkdocs build
- Dudas conceptuales → Consultar sección "Tradeoffs y Decisiones"

---

## FIN DEL PLAN DE MIGRACIÓN

**Siguiente paso**: Ejecutar FASE 1
