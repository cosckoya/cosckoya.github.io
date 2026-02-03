---
title: Docker
description: Container platform - package apps with dependencies, ship anywhere, dev/prod parity
---

# :octicons-container-16: Docker

Container platform that packages applications with their dependencies into isolated, portable units. Lighter than VMs, faster startup, consistent environments from dev to prod. Industry standard for containerization. Kubernetes runs Docker containers (well, technically any OCI-compliant runtime).

!!! tip "2026 Update"
    Docker Desktop is mature and feature-rich. BuildKit is default (faster builds, better caching). Docker Compose v2 is rewritten in Go (much faster). Multi-platform builds are standard. Kubernetes dropped dockershim but Docker containers still work (containerd).

______________________________________________________________________

## :octicons-zap-16: Quick Hits

=== ":octicons-checklist-16: Essential Commands"

    ```bash
    # Container lifecycle
    docker run -it ubuntu bash          # Run interactive container
    docker run -d -p 80:80 nginx        # Run detached with port mapping
    docker ps                           # List running containers
    docker ps -a                        # List all containers (including stopped)
    docker stop container_id            # Graceful stop (SIGTERM)
    docker kill container_id            # Force stop (SIGKILL)
    docker rm container_id              # Remove stopped container
    docker logs -f container_id         # Follow container logs

    # Image management
    docker images                       # List local images
    docker pull nginx:latest            # Download image
    docker build -t myapp:1.0 .         # Build from Dockerfile
    docker tag myapp:1.0 user/myapp:1.0 # Tag image
    docker push user/myapp:1.0          # Push to registry
    docker rmi image_id                 # Remove image
    docker image prune                  # Remove unused images

    # Inspection and debugging
    docker exec -it container_id bash   # Execute command in running container
    docker inspect container_id         # JSON details about container
    docker logs container_id            # View container logs
    docker stats                        # Real-time resource usage
    docker top container_id             # Running processes in container

    # Cleanup
    docker system prune                 # Remove unused data (images, containers, networks)
    docker system prune -a              # Remove ALL unused images (not just dangling)
    docker volume prune                 # Remove unused volumes (careful!)

    # Docker Compose (multi-container apps)
    docker compose up -d                # Start services in background
    docker compose down                 # Stop and remove containers
    docker compose logs -f              # Follow logs from all services
    docker compose ps                   # List running services
    docker compose restart service_name # Restart specific service
    ```

    **Real talk:**

    - Use `docker compose` (v2), not `docker-compose` (v1 deprecated)
    - Always name your containers (`--name`) for easier management
    - Map volumes for persistent data (`-v host:container`)
    - Don't run containers as root - use `USER` directive in Dockerfile
    - `docker system prune -a` is your friend when disk fills up

=== ":octicons-zap-16: Common Patterns"

    ```dockerfile
    # Dockerfile best practices (multi-stage build)
    # Stage 1: Build
    FROM node:20-alpine AS builder
    WORKDIR /app
    COPY package*.json ./
    RUN npm ci --only=production  # (1)!
    COPY . .
    RUN npm run build

    # Stage 2: Production
    FROM node:20-alpine
    WORKDIR /app

    # Create non-root user
    RUN addgroup -g 1001 -S nodejs && \
        adduser -S nodejs -u 1001  # (2)!

    # Copy artifacts from builder
    COPY --from=builder --chown=nodejs:nodejs /app/dist ./dist
    COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules
    COPY --from=builder --chown=nodejs:nodejs /app/package.json ./

    # Switch to non-root user
    USER nodejs  # (3)!

    # Health check
    HEALTHCHECK --interval=30s --timeout=3s \
      CMD node healthcheck.js || exit 1  # (4)!

    EXPOSE 3000
    CMD ["node", "dist/server.js"]
    ```

    1. `npm ci` is faster and more reliable than `npm install` for CI/CD
    2. Never run containers as root - creates user with UID 1001
    3. Switches to non-root user - security best practice
    4. Health checks allow Docker/K8s to detect unhealthy containers

    ```yaml
    # docker-compose.yml (realistic production-ish setup)
    version: '3.8'

    services:
      web:
        build: .
        ports:
          - "3000:3000"
        environment:
          NODE_ENV: production
          DATABASE_URL: postgres://postgres:password@db:5432/myapp  # (1)!
        depends_on:
          db:
            condition: service_healthy  # (2)!
        restart: unless-stopped  # (3)!
        volumes:
          - ./logs:/app/logs  # Persist logs
        networks:
          - app-network
        healthcheck:
          test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
          interval: 30s
          timeout: 10s
          retries: 3

      db:
        image: postgres:16-alpine
        environment:
          POSTGRES_DB: myapp
          POSTGRES_PASSWORD: password  # (4)!
        volumes:
          - postgres-data:/var/lib/postgresql/data  # (5)!
        networks:
          - app-network
        healthcheck:
          test: ["CMD-SHELL", "pg_isready -U postgres"]
          interval: 10s
          timeout: 5s
          retries: 5

      redis:
        image: redis:7-alpine
        command: redis-server --appendonly yes  # (6)!
        volumes:
          - redis-data:/data
        networks:
          - app-network

    volumes:
      postgres-data:  # Named volume (persists data)
      redis-data:

    networks:
      app-network:
        driver: bridge
    ```

    1. Service names resolve to container IPs automatically
    2. Wait for db health check before starting web service
    3. Auto-restart unless explicitly stopped
    4. Use `.env` file or secrets in production, not hardcoded passwords
    5. Named volumes persist data across container recreations
    6. Enable AOF persistence for Redis

    **Why this works:**

    - Multi-stage builds reduce image size (only production dependencies)
    - Non-root user improves security posture
    - Health checks enable automatic recovery
    - Named volumes prevent data loss
    - Service dependencies ensure startup order
    - Networks isolate containers from host

=== ":octicons-flame-16: Pro Tips & Gotchas"

    !!! success "Build Optimization"
        - **Layer caching** - Order Dockerfile commands by change frequency (COPY dependencies before code)
        - **BuildKit** - Enable with `DOCKER_BUILDKIT=1` for parallel builds and better caching
        - **Multi-stage builds** - Separate build and runtime stages, 10x smaller images
        - **.dockerignore** - Exclude node_modules, .git, tests from build context (faster builds)
        - **Alpine images** - Smaller base images (5MB vs 100MB+), but glibc issues possible
        - **Specific tags** - Use `node:20.11.0-alpine` not `node:latest` (reproducible builds)

    !!! warning "Security Best Practices"
        - **Never run as root** - Use `USER` directive in Dockerfile
        - **Scan images** - `docker scan image:tag` or use Trivy, Snyk
        - **Minimal base images** - `scratch`, `alpine`, or distroless
        - **No secrets in images** - Use env vars, Docker secrets, or external secret managers
        - **Read-only filesystem** - `docker run --read-only` when possible
        - **Drop capabilities** - `--cap-drop=ALL --cap-add=NET_BIND_SERVICE`
        - **Resource limits** - Set memory/CPU limits to prevent container takeover

    !!! tip "Development Workflow"
        - **Bind mounts** - Live code reload in dev (`-v $(pwd):/app`)
        - **Docker Compose** - Define entire stack (app + db + redis)
        - **Override files** - Use `docker-compose.override.yml` for local settings
        - **BuildKit cache mounts** - `RUN --mount=type=cache,target=/root/.npm` for faster builds
        - **Docker Desktop** - Kubernetes built-in (single-node cluster for testing)
        - **Dev containers** - VSCode Remote Containers for consistent dev environments

    !!! danger "Common Gotchas"
        - **Disk space** - Docker images fill disk fast, run `docker system prune` regularly
        - **Port conflicts** - Check if port already in use (`lsof -i :8080` on macOS/Linux)
        - **Volume permissions** - Host user != container user (use `chown` or named volumes)
        - **Networking** - Container-to-container use service names, not localhost
        - **Logs fill disk** - Configure log rotation (`--log-opt max-size=10m`)
        - **Layer caching gotcha** - `COPY . .` invalidates all subsequent layers
        - **Platform mismatch** - M1/M2 Macs need `--platform linux/amd64` for production images

    !!! info "Production Considerations"
        - **Orchestration** - Use Kubernetes, Docker Swarm, or ECS (don't run containers manually)
        - **Monitoring** - Prometheus + Grafana for metrics, ELK for logs
        - **Registry** - Private registry (ECR, Docker Hub private, Harbor, Artifactory)
        - **Image signing** - Docker Content Trust (DCT) or Cosign for supply chain security
        - **Resource limits** - Always set memory/CPU limits in production
        - **Health checks** - Required for orchestrators to detect failures
        - **Graceful shutdown** - Handle SIGTERM properly (Node.js often doesn't by default)

______________________________________________________________________

## :octicons-book-16: Learning Resources

### :octicons-mortar-board-16: Free Resources

- **[Docker Documentation](https://docs.docker.com/)** - Official docs, comprehensive and well-written
- **[Docker Getting Started](https://docs.docker.com/get-started/)** - Official tutorial, hands-on
- **[Play with Docker](https://labs.play-with-docker.com/)** - Browser-based Docker playground (no install needed)
- **[Docker Curriculum](https://docker-curriculum.com/)** - Beginner-friendly tutorial
- **[Awesome Docker](https://github.com/veggiemonk/awesome-docker)** - Curated list of tools and resources

### :octicons-code-16: Practice Projects

!!! example "Beginner"
    - **Static website** - Nginx serving HTML/CSS/JS
    - **Node.js API** - Express app with multi-stage build
    - **Python Flask app** - Web app with Redis for sessions

!!! example "Intermediate"
    - **Full-stack app** - React frontend + Node backend + PostgreSQL (docker-compose)
    - **Microservices** - Multiple services communicating via REST/gRPC
    - **CI/CD pipeline** - GitHub Actions building and pushing images

!!! example "Advanced"
    - **Multi-arch builds** - ARM64 + AMD64 images with buildx
    - **Private registry** - Self-hosted Harbor with scanning
    - **Security hardening** - Distroless images, rootless Docker, Falco monitoring

______________________________________________________________________

## :octicons-star-16: Worth Checking

<div class="grid cards" markdown>

- :octicons-book-16: __Official Docs__

    ______________________________________________________________________

    [Docker Documentation](https://docs.docker.com/)

    [Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

    [Docker Compose](https://docs.docker.com/compose/)

    [Docker CLI Reference](https://docs.docker.com/engine/reference/commandline/cli/)

- :octicons-tools-16: __Essential Tools__

    ______________________________________________________________________

    [Docker Desktop](https://www.docker.com/products/docker-desktop/)

    [Dive](https://github.com/wagoodman/dive) (Analyze image layers)

    [Trivy](https://github.com/aquasecurity/trivy) (Vulnerability scanner)

    [Hadolint](https://github.com/hadolint/hadolint) (Dockerfile linter)

- :octicons-code-16: __Examples & Patterns__

    ______________________________________________________________________

    [Awesome Compose](https://github.com/docker/awesome-compose)

    [Docker Samples](https://github.com/dockersamples)

    [Google Distroless Images](https://github.com/GoogleContainerTools/distroless)

- :octicons-people-16: __Community__

    ______________________________________________________________________

    [r/docker](https://reddit.com/r/docker)

    [Docker Community Slack](https://dockercommunity.slack.com/)

    [Docker Forum](https://forums.docker.com/)

    [Stack Overflow [docker]](https://stackoverflow.com/questions/tagged/docker)

</div>

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :octicons-rocket-16: **Essential** - Docker is the standard for containerization. If you're deploying modern applications, you're using Docker (or at least OCI containers). Learn it well.
**Tags:** docker, containers, devops, virtualization
