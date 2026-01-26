# Kubernetes

Container orchestration at scale. Runs most of the internet. YAML as far as the eye can see. The learning curve is brutal, the operational complexity is real, but when you need to run 10,000 containers across 500 nodes, there's nothing else that comes close.

______________________________________________________________________

## Quick Hits

=== "🎯 Essential Commands"

    ```bash
    # Cluster info
    kubectl cluster-info
    kubectl get nodes
    kubectl version

    # Pods - the basic unit
    kubectl get pods
    kubectl get pods -A                    # All namespaces
    kubectl describe pod <pod-name>
    kubectl logs <pod-name>
    kubectl logs <pod-name> -f             # Follow
    kubectl exec -it <pod-name> -- /bin/sh # Shell into pod

    # Deployments - the workhorse
    kubectl get deployments
    kubectl create deployment nginx --image=nginx
    kubectl scale deployment nginx --replicas=3
    kubectl rollout status deployment/nginx
    kubectl rollout undo deployment/nginx

    # Services - networking
    kubectl get services
    kubectl expose deployment nginx --port=80 --type=LoadBalancer

    # Apply YAML (the K8s way)
    kubectl apply -f deployment.yaml
    kubectl apply -f https://url.com/manifest.yaml
    kubectl delete -f deployment.yaml

    # Debug
    kubectl get events --sort-by=.metadata.creationTimestamp
    kubectl top nodes          # Requires metrics-server
    kubectl top pods
    ```

    **Real talk:**

    - Use `-A` (all namespaces) when hunting for pods
    - `kubectl describe` is your debugging friend
    - `kubectl get pods -o wide` shows node placement
    - Set up aliases: `alias k=kubectl` (everyone does this)

=== "⚡ Common Patterns"

    ```yaml
    # Deployment pattern - use this 90% of the time
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: myapp
      labels:
        app: myapp
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: myapp
      template:
        metadata:
          labels:
            app: myapp
        spec:
          containers:
          - name: myapp
            image: myapp:v1.2.3
            ports:
            - containerPort: 8080
            resources:
              requests:
                memory: "128Mi"
                cpu: "100m"
              limits:
                memory: "512Mi"
                cpu: "500m"
            livenessProbe:
              httpGet:
                path: /health
                port: 8080
              initialDelaySeconds: 30
              periodSeconds: 10
            readinessProbe:
              httpGet:
                path: /ready
                port: 8080
              initialDelaySeconds: 5
              periodSeconds: 5
            env:
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: app-secrets
                  key: db-url
    ```

    ```yaml
    # Service pattern - expose your deployment
    apiVersion: v1
    kind: Service
    metadata:
      name: myapp-service
    spec:
      selector:
        app: myapp
      ports:
      - protocol: TCP
        port: 80
        targetPort: 8080
      type: LoadBalancer  # ClusterIP (internal), NodePort, LoadBalancer
    ```

    ```yaml
    # ConfigMap pattern - configuration
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: app-config
    data:
      app.properties: |
        database.host=postgres
        database.port=5432
        log.level=INFO
    ```

=== "🔥 Pro Tips & Gotchas"

    - **Resource requests/limits:** ALWAYS set both. Requests for scheduling, limits prevent noisy neighbors
    - **Readiness vs liveness:** Readiness = "ready for traffic", Liveness = "restart me if I'm broken"
    - **ImagePullPolicy:** Use `IfNotPresent` in dev, `Always` in prod with specific tags
    - **Labels matter:** Use consistent labels, they're how everything connects
    - **Namespaces:** Use them to isolate environments (dev, staging, prod)
    - **YAML debugging:** Pipe to `--dry-run=client -o yaml` to validate before applying
    - **Security:** Never run as root (use `securityContext`), scan images, use network policies
    - **Persistent storage:** StatefulSets for databases, ReadWriteMany is rare and slow
    - **DNS works:** Pods can reach `<service-name>.<namespace>.svc.cluster.local`
    - **Gotcha:** Pods are ephemeral - state goes away unless you use volumes
    - **Gotcha:** Each container in a pod shares network namespace (localhost works)
    - **Gotcha:** CrashLoopBackOff usually means startup failure, check logs
    - **When NOT to use:** Single app, simple workload, no scaling needed (use Docker Compose)

______________________________________________________________________

## Learning Paths

### 🎓 Free Resources

- **[Official Kubernetes Docs](https://kubernetes.io/docs/)** - Comprehensive, well-written, start here
- **[Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way)** - Build K8s from scratch, understand internals
- **[Introduction to Kubernetes (CNCF/edX)](https://www.edx.org/learn/kubernetes/the-linux-foundation-introduction-to-kubernetes)** - Free course from Linux Foundation
- **[Interactive Tutorial](https://kubernetes.io/docs/tutorials/kubernetes-basics/)** - Official interactive browser tutorial
- **[Kubernetes By Example](https://kubernetesbyexample.com/)** - Short, practical examples

### 🧪 Interactive Labs

- **[Katacoda Kubernetes](https://www.katacoda.com/courses/kubernetes)** - Browser-based scenarios (free)
- **[Play with Kubernetes](https://labs.play-with-k8s.com/)** - Free 4-hour K8s playground
- **[Kubernetes Goat](https://madhuakula.com/kubernetes-goat)** - Security training (22 vulnerable scenarios)

### 📜 Certifications Worth It

- **[CKA - Certified Kubernetes Administrator](https://www.cncf.io/certification/cka/)** - $395, hands-on exam, highly respected, worth it
- **[CKAD - Certified Kubernetes Application Developer](https://www.cncf.io/certification/ckad/)** - $395, developer-focused, also worth it
- **[CKS - Certified Kubernetes Security Specialist](https://www.cncf.io/certification/cks/)** - $395, requires CKA, worth it for security roles
- **[KCNA - Kubernetes and Cloud Native Associate](https://www.cncf.io/certification/kcna/)** - $250, entry-level, skip if you have experience
- **Skip:** Cloud provider K8s certs (AKS, EKS, GKE) unless employer pays

### 🚀 Projects to Build

- **Beginner:** Deploy a multi-tier web app (frontend + backend + database) with services
- **Intermediate:** Set up GitOps with ArgoCD, deploy via Git push, implement rollbacks
- **Advanced:** Multi-cluster setup with service mesh (Istio), observability stack (Prometheus/Grafana), and network policies

______________________________________________________________________

## Community Pulse

### 🐦 Who to Follow

**Twitter/X:**

- [@kubernetesio](https://twitter.com/kubernetesio) - Official Kubernetes account
- [@kelseyhightower](https://twitter.com/kelseyhightower) - K8s legend, creator of "Kubernetes The Hard Way"
- [@brendandburns](https://twitter.com/brendandburns) - K8s co-founder, Microsoft
- [@thockin](https://twitter.com/thockin) - Tim Hockin, K8s networking lead, Google
- [@IanMLewis](https://twitter.com/IanMLewis) - Google Dev Advocate, K8s expert

**YouTube:**

- [CNCF](https://www.youtube.com/@cncf) - Official, KubeCon talks
- [TechWorld with Nana](https://www.youtube.com/@TechWorldwithNana) - Great K8s tutorials
- [DevOps Toolkit](https://www.youtube.com/@DevOpsToolkit) - Advanced topics, real-world scenarios

### 💬 Active Communities

- **[r/kubernetes](https://reddit.com/r/kubernetes)** - 180k+ members, active daily, helpful community
- **[Kubernetes Slack](https://kubernetes.slack.com)** - Official, massive, #kubernetes-users is the place
- **[CNCF Slack](https://cloud-native.slack.com/)** - Broader cloud-native ecosystem
- **[Stack Overflow](https://stackoverflow.com/questions/tagged/kubernetes)** - 100k+ questions answered
- **[Dev.to #kubernetes](https://dev.to/t/kubernetes)** - Quality tutorials and war stories

### 🎙️ Podcasts & Newsletters

- **[Kubernetes Podcast from Google](https://kubernetespodcast.com/)** - Weekly, news and interviews
- **[KubeWeekly](https://www.cncf.io/kubeweekly/)** - Newsletter, curated K8s content every week
- **[Cloud Native News](https://www.cncf.io/newsletter/)** - CNCF monthly newsletter
- **[Last Week in AWS](https://www.lastweekinaws.com/)** - Covers EKS news (Corey Quinn's irreverent take)

### 🎪 Events & Conferences

- **[KubeCon + CloudNativeCon](https://www.cncf.io/kubecon-cloudnativecon-events/)** - The K8s conference, 3x/year (NA, EU, China)
- **[Kubernetes Community Days](https://community.cncf.io/kubernetes-community-days/)** - Local, community-run events
- **[CNCF Webinars](https://www.cncf.io/webinars/)** - Free online sessions

______________________________________________________________________

## Worth Checking

<div class="grid cards" markdown>

- 📚 __Official Stuff__

    ______________________________________________________________________

    [Kubernetes Docs](https://kubernetes.io/docs/)

    [API Reference](https://kubernetes.io/docs/reference/)

    [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/quick-reference/)

    [GitHub Repo](https://github.com/kubernetes/kubernetes)

- 🧪 __Hands-on__

    ______________________________________________________________________

    [Interactive Tutorial](https://kubernetes.io/docs/tutorials/kubernetes-basics/)

    [Play with K8s](https://labs.play-with-k8s.com/)

    [Katacoda Scenarios](https://www.katacoda.com/courses/kubernetes)

    [Kubernetes Goat](https://madhuakula.com/kubernetes-goat)

- 💻 __Real Code__

    ______________________________________________________________________

    [Awesome Kubernetes](https://github.com/ramitsurana/awesome-kubernetes)

    [Kubernetes Examples](https://github.com/kubernetes/examples)

    [Kubernetes Patterns](https://github.com/k8spatterns/examples)

- 🔥 __Deep Dives__

    ______________________________________________________________________

    [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way)

    [Production Best Practices](https://learnk8s.io/production-best-practices)

    [Kubernetes Failure Stories](https://k8s.af/)

- 🛠️ __Tools & Extensions__

    ______________________________________________________________________

    [Helm](https://helm.sh) - Package manager

    [k9s](https://k9scli.io/) - Terminal UI

    [Lens](https://k8slens.dev/) - Desktop UI

    [ArgoCD](https://argo-cd.readthedocs.io/) - GitOps

    [Istio](https://istio.io/) - Service mesh

- 📰 __News & Updates__

    ______________________________________________________________________

    [Kubernetes Blog](https://kubernetes.io/blog/)

    [Release Notes](https://kubernetes.io/releases/)

    [r/kubernetes](https://reddit.com/r/kubernetes)

    [KubeWeekly](https://www.cncf.io/kubeweekly/)

</div>

______________________________________________________________________

## Core Concepts Reference

| Concept         | What It Is                              | When You Need It                                        |
| --------------- | --------------------------------------- | ------------------------------------------------------- |
| **Pod**         | Smallest deployable unit, 1+ containers | Always - it's the basic building block                  |
| **Deployment**  | Manages ReplicaSets, rolling updates    | 90% of the time - this is your workhorse                |
| **Service**     | Stable network endpoint, load balancing | Whenever pods need to talk to each other                |
| **Namespace**   | Virtual cluster, resource isolation     | Multi-tenant, env separation (dev/staging/prod)         |
| **ConfigMap**   | Configuration data                      | App config, non-sensitive settings                      |
| **Secret**      | Sensitive data (base64, not encrypted)  | Passwords, tokens, keys (use external secrets for prod) |
| **Volume**      | Persistent storage                      | Databases, stateful apps, shared data                   |
| **Ingress**     | HTTP/HTTPS routing, load balancing      | External access, multiple services behind one IP        |
| **StatefulSet** | Ordered, stable pod identities          | Databases, clustered apps, requires stable network      |
| **DaemonSet**   | Pod on every node                       | Log collectors, monitoring agents, node-level work      |
| **Job**         | Run to completion                       | Batch processing, ETL, one-off tasks                    |
| **CronJob**     | Scheduled jobs                          | Regular backups, reports, cleanup tasks                 |

______________________________________________________________________

## Related Sections

!!! info "Expand Your Skills"

    - **[Docker](docker.md)** - Container fundamentals, build images before orchestrating them
    - **[Helm](helm.md)** - Package manager for Kubernetes, chart templating
    - **[Container Security](container-security.md)** - Scan images, runtime security, pod policies
    - **[GitOps](../devops/gitops.md)** - ArgoCD and FluxCD for K8s deployments
    - **[Cloud](../cloud/)** - EKS (AWS), AKS (Azure), GKE (GCP) managed Kubernetes

______________________________________________________________________

**Last Updated:** 2026-01-14 **Vibe Check:** 🌍 **Mainstream** - Kubernetes won. It's the default for container orchestration. Every major company runs it, cloud providers offer managed services, the ecosystem is massive. Learning curve is still brutal, YAML fatigue is real, but once you get it, you get it. Not the coolest tech anymore (that's serverless/edge), but it's the foundation everything else builds on.
