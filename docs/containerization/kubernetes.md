# Kubernetes

Production-grade container orchestration for automating deployment, scaling, and management of containerized
applications.

______________________________________________________________________

## Overview

### What is Kubernetes?

Kubernetes (K8s) is an open-source container orchestration platform originally designed by Google and now maintained by
the Cloud Native Computing Foundation (CNCF). It automates deployment, scaling, and operations of containerized
applications across clusters.

**Current Stable Version:** v1.35 (December 2025)

### Why Use Kubernetes?

- ✅ **Automated Operations** - Self-healing, auto-scaling, rollouts/rollbacks
- ✅ **Multi-Cloud** - Run anywhere: on-premises, cloud, hybrid
- ✅ **Service Discovery** - Built-in networking and load balancing
- ✅ **Declarative** - Infrastructure as Code with YAML
- ✅ **Extensible** - CRDs, Operators, massive ecosystem

**Common Use Cases:** Microservices, CI/CD, batch processing, hybrid cloud

______________________________________________________________________

## Getting Started

### Learning Paths

**Complete Beginners:**

1. Start with [Official Getting Started Guide](https://kubernetes.io/docs/setup/)
1. Try [Interactive Tutorials](https://kubernetes.io/docs/tutorials/)
1. Take free [Introduction to Kubernetes (edX)](https://www.edx.org/)

**Hands-On Practice:**

- **[kind](https://kind.sigs.k8s.io/)** - Local Kubernetes clusters in Docker (fastest for testing)
- **[Minikube](https://minikube.sigs.k8s.io/)** - Local single-node clusters
- **[Kubernetes Goat](https://madhuakula.com/kubernetes-goat)** - Security training (22 vulnerable scenarios)

!!! warning "Security Training"
    **kube-goat** is intentionally vulnerable. ONLY use in isolated environments, NEVER in production.

**Production:**

- **[AKS](https://learn.microsoft.com/azure/aks/)** - Azure managed Kubernetes
- **[EKS](https://aws.amazon.com/eks/)** - AWS managed Kubernetes
- **[GKE](https://cloud.google.com/kubernetes-engine)** - Google Cloud managed K8s

______________________________________________________________________

## Core Concepts

Learn the fundamental building blocks:

- **[Pods](https://kubernetes.io/docs/concepts/workloads/pods/)** - Smallest deployable units
- **[Services](https://kubernetes.io/docs/concepts/services-networking/service/)** - Network endpoints and load
    balancing
- **[Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)** - Declarative updates and
    scaling
- **[Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)** - Resource isolation
- **[ConfigMaps & Secrets](https://kubernetes.io/docs/concepts/configuration/)** - Configuration management
- **[Volumes](https://kubernetes.io/docs/concepts/storage/volumes/)** - Persistent storage

**Recommended Reading:**

- [Official Concepts Guide](https://kubernetes.io/docs/concepts/) - Complete concepts documentation
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/quick-reference/) - Quick command reference

______________________________________________________________________

## Key Tools

### Essential CLI Tools

- **[kubectl](https://kubernetes.io/docs/reference/kubectl/)** - Kubernetes command-line tool
- **[Helm](https://helm.sh)** - Package manager for Kubernetes
- **[k9s](https://k9scli.io/)** - Terminal UI for cluster management
- **[Kustomize](https://kustomize.io/)** - Configuration customization

### Development & Testing

- **[kind](https://kind.sigs.k8s.io/)** - Local clusters in Docker (fastest)
- **[Minikube](https://minikube.sigs.k8s.io/)** - Local single-node clusters
- **[Kubernetes Goat](https://madhuakula.com/kubernetes-goat)** - Security training (isolated only!)

### Monitoring & Observability

- **[Prometheus](https://prometheus.io)** - Monitoring and alerting
- **[Grafana](https://grafana.com)** - Metrics visualization
- **[Istio](https://istio.io)** - Service mesh
- **[Argo CD](https://argo-cd.readthedocs.io)** - GitOps delivery

### Security

- **[Trivy](https://github.com/aquasecurity/trivy)** - Vulnerability scanner
- **[Falco](https://falco.org/)** - Runtime security
- **[kube-goat](https://github.com/madhuakula/kubernetes-goat)** - Security training scenarios

______________________________________________________________________

## Best Practices

**Learn from the experts:**

- **[Kubernetes Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/)** - Official
    recommendations
- **[Production Best Practices](https://learnk8s.io/production-best-practices)** - LearnK8s guide
- **[Security Best Practices](https://kubernetes.io/docs/concepts/security/)** - Official security guide
- **[12 Factor Apps on Kubernetes](https://12factor.net/)** - Cloud-native patterns

**Key Areas:**

- Development: Namespaces, labels, version tags, health checks
- Production: HA clusters, RBAC, network policies, monitoring
- Security: Pod Security, image scanning, secrets management, audit logging

______________________________________________________________________

## Resources & Links

### 🏠 Official

**Primary Resources:**

- **[Kubernetes Official Website](https://kubernetes.io)** - Main project website
- **[Official Documentation](https://kubernetes.io/docs/home/)** - Comprehensive documentation hub
- **[Getting Started Guide](https://kubernetes.io/docs/setup/)** - Official quick start
- **[Release Notes](https://kubernetes.io/releases/)** - Version history and changelogs
- **[Official Blog](https://kubernetes.io/blog/)** - Latest updates and announcements
- **[Enhancement Proposals (KEPs)](https://github.com/kubernetes/enhancements)** - Feature proposals

### 📚 Documentation & References

**Technical Documentation:**

- **[API Reference](https://kubernetes.io/docs/reference/)** - Complete API documentation
- **[kubectl Quick Reference](https://kubernetes.io/docs/reference/kubectl/quick-reference/)** - Command-line cheat
    sheet
- **[kubectl Reference](https://kubectl.docs.kubernetes.io)** - kubectl documentation
- **[Glossary](https://kubernetes.io/docs/reference/glossary/)** - Kubernetes terminology
- **[Concepts Guide](https://kubernetes.io/docs/concepts/)** - Core concepts explained

### 💻 Code & Repositories

**Source Code:**

- **[GitHub Organization](https://github.com/kubernetes)** - Official GitHub organization
- **[Main Repository](https://github.com/kubernetes/kubernetes)** - Primary source code (120k+ stars)
- **[Community Repository](https://github.com/kubernetes/community)** - Community documentation (1,300+ contributors)
- **[kind Repository](https://github.com/kubernetes-sigs/kind)** - Kubernetes in Docker for local development
- **[kubectl Repository](https://github.com/kubernetes/kubectl)** - kubectl source code

### ⭐ Awesome Lists & Curated Resources

**Community Curations:**

- **[Awesome Kubernetes](https://github.com/ramitsurana/awesome-kubernetes)** - Comprehensive curated list (389+
    contributors)
- **[Kubernetes Tools](https://github.com/topics/kubernetes-tools)** - Tool ecosystem
- **[CNCF Landscape](https://landscape.cncf.io)** - Cloud native technology landscape

### 👥 Community & Support

**Discussion Forums:**

- **[Kubernetes Slack](https://kubernetes.slack.com)** - Real-time community chat (multiple channels)
- **[Stack Overflow](https://stackoverflow.com/questions/tagged/kubernetes)** - Q&A for Kubernetes
- **[Reddit - r/kubernetes](https://reddit.com/r/kubernetes)** - Reddit community discussions
- **[Dev.to Kubernetes Tag](https://dev.to/t/kubernetes)** - Developer articles
- **[GitHub Discussions](https://github.com/kubernetes/kubernetes/discussions)** - Community discussions

### 🎓 Learning Platforms & Courses

**Structured Learning:**

- **[Official Training](https://kubernetes.io/training/)** - Training resources and certifications
- **[Linux Foundation Kubernetes Courses](https://training.linuxfoundation.org/training/course-catalog/?_sft_technology=kubernetes)**
    \- Official courses
- **[Introduction to Kubernetes (edX)](https://www.edx.org/)** - Free edX course
- **[Kubernetes and Cloud Native Associate (KCNA)](https://www.cncf.io/certification/kcna/)** - Entry-level
    certification
- **[Certified Kubernetes Administrator (CKA)](https://www.cncf.io/certification/cka/)** - Admin certification
- **[Certified Kubernetes Application Developer (CKAD)](https://www.cncf.io/certification/ckad/)** - Developer
    certification
- **[Certified Kubernetes Security Specialist (CKS)](https://www.cncf.io/certification/cks/)** - Security certification

### 🎥 Video Content

**Video Resources:**

- **[CNCF YouTube Channel](https://www.youtube.com/@cncf)** - Official CNCF content
- **[KubeCon Talks](https://www.youtube.com/@cncf/playlists)** - Conference presentations
- **Community Channels** - TechWorld with Nana, DevOps Toolkit, Just me and Opensource

### 📝 Blogs & Articles

**Technical Blogs:**

- **[Kubernetes Blog](https://kubernetes.io/blog/)** - Official blog
- **[CNCF Blog](https://www.cncf.io/blog/)** - Cloud Native Computing Foundation
- **[Dev.to Kubernetes](https://dev.to/t/kubernetes)** - Community tutorials

### 🛠️ Tools & Integrations

**Ecosystem Tools:**

- **[Helm](https://helm.sh)** - Kubernetes package manager (v4.0.0)
- **[k9s](https://k9scli.io/)** - Terminal UI for cluster management (32.4k stars)
- **[Minikube](https://minikube.sigs.k8s.io/)** - Local Kubernetes clusters (31.4k stars)
- **[kind](https://kind.sigs.k8s.io/)** - Kubernetes in Docker (v0.31.0)
- **[Kustomize](https://kubectl.docs.kubernetes.io/references/kustomize/)** - Configuration customization
- **[Krew](https://krew.sigs.k8s.io)** - kubectl plugin manager
- **[Istio](https://istio.io)** - Service mesh (37.8k stars, CNCF graduated)
- **[Argo CD](https://argo-cd.readthedocs.io)** - GitOps continuous delivery
- **[Prometheus](https://prometheus.io)** - Monitoring system (CNCF graduated)
- **[Trivy](https://github.com/aquasecurity/trivy)** - Security scanner (30.9k stars)

### 🔒 Security Resources

**Security Tools:**

- **[Kubernetes Goat](https://madhuakula.com/kubernetes-goat)** - Security training platform (22 scenarios)
- **[kube-goat GitHub](https://github.com/madhuakula/kubernetes-goat)** - Source repository
- **[Trivy](https://github.com/aquasecurity/trivy)** - Vulnerability scanner
- **[Falco](https://falco.org/)** - Runtime security

### ☁️ Managed Kubernetes Services

**Cloud Providers:**

- **[Azure Kubernetes Service (AKS)](https://azure.microsoft.com/products/kubernetes-service)** - Microsoft Azure
    managed K8s
- **[AKS Documentation](https://learn.microsoft.com/azure/aks/)** - Complete AKS docs
- **[Amazon EKS](https://aws.amazon.com/eks/)** - AWS managed Kubernetes
- **[Google GKE](https://cloud.google.com/kubernetes-engine)** - Google Cloud managed K8s

### 🌐 Additional Resources

**Other Valuable Resources:**

- **[kubectl Aliases](https://github.com/ahmetb/kubectl-aliases)** - Shell shortcuts
- **[Kubernetes CheatSheet A4](https://github.com/dennyzhang/cheatsheet-kubernetes-A4)** - Quick reference
- **[OperatorHub](https://operatorhub.io)** - Kubernetes Operator registry
- **[Artifact Hub](https://artifacthub.io)** - Package discovery

______________________________________________________________________

## Related Topics

- **[Containerization](../containerization/)** - Container fundamentals and Docker basics
- **[Security](../security/)** - Security best practices for containers
- **[GitHub Actions](../devops/github-actions.md)** - CI/CD for Kubernetes deployments
- **[Azure DevOps](../devops/azure-devops.md)** - Azure Pipelines for Kubernetes
- **[Cloud Platforms](../cloud/)** - AWS EKS, Azure AKS, Google GKE managed services
- **[DevOps Tools](../devops/)** - Automation and operational tools

______________________________________________________________________

## Version History

**Current Version:** v1.35 "Timbernetes" (December 17, 2025)

**Recent Changes:**

- **v1.35** (Dec 2025) - Kubeconfig credential plugin allowlist, mutable PV node affinity (alpha), CSI SA token
    improvements, in-place Pod restart
- **v1.34** (Oct 2025) - EOL February 2026
- **v1.33** (Jun 2025) - EOL October 2026

**Support Model:** ~1 year of patch support, most recent 3 minor versions maintained

______________________________________________________________________

**Last Updated:** 2026-01-13 **Status:** Active **Maintained by:** DocMaster Agent v2.0
