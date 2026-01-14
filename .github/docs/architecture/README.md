# Architecture Documentation

This directory contains architectural decision documents and design proposals for the cosckoya.github.io documentation site.

## Documents

### Active Architecture

- **[SITE_ARCHITECTURE_PROPOSAL.md](SITE_ARCHITECTURE_PROPOSAL.md)** - Detailed proposal for the 5-block architecture (2026-01-08)
  - Comprehensive analysis of current vs. proposed structure
  - Rationale for consolidating AI content into DevOps
  - Migration plan and implementation guidelines

- **[ARCHITECTURE_VISUAL_5BLOCK.md](ARCHITECTURE_VISUAL_5BLOCK.md)** - Visual representation of the 5-block architecture
  - ASCII diagrams and flowcharts
  - User journey maps
  - Cross-cutting concerns visualization

## Architecture Overview

The site uses a **5-block hybrid architecture**:

1. **Infrastructure & SysAdmin** - OS fundamentals, networking, storage, virtualization
2. **Cloud Platforms** - AWS, Azure, GCP, cloud-native architectures
3. **DevOps & Automation** - CI/CD, IaC, monitoring, AI/ML Operations
4. **Containerization & Orchestration** - Docker, Kubernetes, container security
5. **Security** - Offensive, defensive, compliance, security tooling

## Key Decisions

- **AI Integration**: AI/ML content integrated into DevOps as "AI/ML Operations" (MLOps naturally aligns with DevOps practices)
- **Optimal Navigation**: 5 primary categories provide optimal cognitive load (7±2 rule)
- **Content-First**: No empty placeholder directories - create subdirectories only when content exists
- **Cross-References**: Each section links to related topics for improved discoverability

## History

- **2026-01-08**: 5-block architecture proposal created
- **Branch**: `refactor/architecture-6-blocks` (migrating from 6 to 5 blocks)

---

**Status**: Active
**Last Updated**: 2026-01-13
