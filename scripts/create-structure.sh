#!/bin/bash
# create-structure.sh
# Creates the complete 6-block directory structure

set -e

BASE_DIR="docs"

echo "================================================"
echo "Creating 6-block architecture structure..."
echo "================================================"

# BLOQUE 1: SYSADMIN
echo "📁 Creating SYSADMIN structure..."
mkdir -p "${BASE_DIR}/sysadmin"/{sistemas-operativos/{linux,windows-server},redes,almacenamiento,virtualizacion,scripting,seguridad-basica,bases-datos-basicas}

# BLOQUE 2: CLOUD
echo "📁 Creating CLOUD structure..."
mkdir -p "${BASE_DIR}/cloud"/{aws,azure,gcp,multi-cloud,cloud-native,finops}

# BLOQUE 3: DEVOPS
echo "📁 Creating DEVOPS structure..."
mkdir -p "${BASE_DIR}/devops"/{ci-cd,iac/terraform,configuration-management/{ansible,puppet,chef},version-control,monitoring-observability/{prometheus-grafana,logging,apm-tracing,alerting},secrets-management,artifact-management,testing,devsecops}

# BLOQUE 4: CIBERSEGURIDAD
echo "📁 Creating CIBERSEGURIDAD structure..."
mkdir -p "${BASE_DIR}/ciberseguridad"/{fundamentos,pentesting/kali-linux,web-security,network-security,exploitation,osint,defensive-security/siem,compliance,hardening,incident-response,container-security,cloud-security}

# BLOQUE 5: CONTAINERIZACIÓN
echo "📁 Creating CONTAINERIZACIÓN structure..."
mkdir -p "${BASE_DIR}/containerizacion"/{docker,kubernetes,helm,operators,service-mesh,cloud-kubernetes,seguridad,monitoring,local-dev,alternative-runtimes,best-practices}

# BLOQUE 6: INTELIGENCIA ARTIFICIAL
echo "📁 Creating INTELIGENCIA ARTIFICIAL structure..."
mkdir -p "${BASE_DIR}/inteligencia-artificial"/{fundamentos,frameworks,llms,mlops,data-engineering,model-training,model-deployment,monitoring-ml,python-ml,ai-security,cloud-ai,use-cases}

echo ""
echo "📝 Creating index.md templates..."

# Create index.md templates for main sections
for section in sysadmin cloud devops ciberseguridad containerizacion inteligencia-artificial; do
    # Skip if index.md already exists (don't overwrite existing content)
    if [ -f "${BASE_DIR}/${section}/index.md" ]; then
        echo "⏭️  Skipping ${section}/index.md (already exists)"
        continue
    fi

    # Convert section name to title case
    TITLE=$(echo ${section} | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')

    cat > "${BASE_DIR}/${section}/index.md" <<EOF
---
title: ${TITLE}
description: TODO - Add description
tags:
  - ${section}
---

# ${TITLE}

TODO: Add introduction content

!!! abstract "Quick Reference"
    - **Topic 1**: TODO
    - **Topic 2**: TODO
    - **Topic 3**: TODO

---

## Overview

TODO: Add overview content explaining what this section covers and why it matters.

---

## Main Topics

TODO: Add main topics with subsections

---

## Related Topics

- [Home](../index.md)

---

[Back to Home](../index.md){ .md-button .md-button--primary }
EOF
    echo "✅ Created ${section}/index.md"
done

echo ""
echo "📝 Creating SUMMARY.md templates..."

# Create SUMMARY.md templates
for section in sysadmin cloud devops ciberseguridad containerizacion inteligencia-artificial; do
    # Skip if SUMMARY.md already exists
    if [ -f "${BASE_DIR}/${section}/SUMMARY.md" ]; then
        echo "⏭️  Skipping ${section}/SUMMARY.md (already exists)"
        continue
    fi

    TITLE=$(echo ${section} | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')

    cat > "${BASE_DIR}/${section}/SUMMARY.md" <<EOF
* [${TITLE} Overview](index.md)
EOF
    echo "✅ Created ${section}/SUMMARY.md"
done

echo ""
echo "================================================"
echo "✅ Structure created successfully!"
echo "================================================"
echo ""
echo "Directory structure:"
tree -L 2 "${BASE_DIR}" -d --charset ascii

echo ""
echo "Next steps:"
echo "1. Review created structure"
echo "2. Run migration scripts for existing content"
echo "3. Start populating new sections"
