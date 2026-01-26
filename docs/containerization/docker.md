# Docker

Containerization platform that packages your app and its dependencies into isolated, reproducible environments. Runs anywhere without "works on my machine" BS. Industry standard for dev-prod parity. Learning curve is gentle, debugging is not.

______________________________________________________________________

## Quick Hits

=== "🎯 Essential Commands"

    ```bash
    # Container lifecycle
    docker run -d -p 8080:80 --name web nginx:alpine
    docker ps                          # Running containers
    docker ps -a                       # All containers (including stopped)
    docker stop web                    # Graceful shutdown
    docker rm web                      # Remove container
    docker logs -f web                 # Stream logs

    # Image management
    docker images                      # List local images
    docker pull redis:7-alpine         # Pull from registry
    docker build -t myapp:v1 .         # Build from Dockerfile
    docker rmi myapp:v1                # Remove image
    docker image prune -a              # Clean up dangling images

    # Debugging & inspection
    docker exec -it web /bin/sh        # Shell into running container
    docker inspect web                 # Full JSON config
    docker stats                       # Real-time resource usage
    docker system df                   # Disk usage by images/containers/volumes

    # Networks & volumes
    docker network create mynet        # Custom bridge network
    docker volume create mydata        # Named volume
    docker volume ls                   # List volumes
    docker network ls                  # List networks
    ```

    **Real talk:**

    - `-d` runs detached (background), `-it` runs interactive (foreground)
    - `--rm` auto-removes container on exit (great for one-offs)
    - Always use specific image tags (`nginx:1.25-alpine`), never `:latest` in prod
    - `docker exec` needs container running, `docker run` creates new container

=== "⚡ Dockerfile Patterns"

    ```dockerfile
    # Multi-stage build (production-ready Node.js app)
    FROM node:20-alpine AS builder
    WORKDIR /app
    COPY package*.json ./
    RUN npm ci --only=production
    COPY . .
    RUN npm run build

    FROM node:20-alpine
    WORKDIR /app
    # Copy only built artifacts, not source
    COPY --from=builder /app/dist ./dist
    COPY --from=builder /app/node_modules ./node_modules
    COPY package.json ./

    # Security: non-root user
    RUN addgroup -g 1001 -S nodejs && \
        adduser -S nodejs -u 1001 && \
        chown -R nodejs:nodejs /app
    USER nodejs

    EXPOSE 3000
    HEALTHCHECK --interval=30s --timeout=3s \
      CMD node healthcheck.js
    CMD ["node", "dist/server.js"]
    ```

    ```dockerfile
    # Python Flask app with layer caching optimization
    FROM python:3.12-slim
    WORKDIR /app

    # Install system dependencies (rarely change)
    RUN apt-get update && apt-get install -y \
        gcc \
        && rm -rf /var/lib/apt/lists/*

    # Install Python deps (change less often than code)
    COPY requirements.txt .
    RUN pip install --no-cache-dir -r requirements.txt

    # Copy application code last (changes most often)
    COPY . .

    # Security
    RUN useradd -m -u 1001 appuser && \
        chown -R appuser:appuser /app
    USER appuser

    EXPOSE 5000
    CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
    ```

    ```yaml
    # docker-compose.yml (realistic multi-service app)
    version: '3.8'

    services:
      web:
        build: ./web
        ports:
          - "8080:3000"
        environment:
          - NODE_ENV=production
          - REDIS_URL=redis://cache:6379
          - POSTGRES_URL=postgres://db:5432/myapp
        depends_on:
          - db
          - cache
        networks:
          - frontend
          - backend
        restart: unless-stopped
        healthcheck:
          test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
          interval: 30s
          timeout: 5s
          retries: 3

      db:
        image: postgres:16-alpine
        environment:
          POSTGRES_PASSWORD: ${DB_PASSWORD}
          POSTGRES_DB: myapp
        volumes:
          - db-data:/var/lib/postgresql/data
          - ./init.sql:/docker-entrypoint-initdb.d/init.sql:ro
        networks:
          - backend
        restart: unless-stopped

      cache:
        image: redis:7-alpine
        volumes:
          - cache-data:/data
        networks:
          - backend
        restart: unless-stopped
        command: redis-server --appendonly yes

      nginx:
        image: nginx:1.25-alpine
        ports:
          - "80:80"
          - "443:443"
        volumes:
          - ./nginx.conf:/etc/nginx/nginx.conf:ro
          - ./certs:/etc/nginx/certs:ro
        depends_on:
          - web
        networks:
          - frontend
        restart: unless-stopped

    volumes:
      db-data:
      cache-data:

    networks:
      frontend:
      backend:
    ```

=== "🔥 Pro Tips & Gotchas"

    **Image Optimization:**

    - Use Alpine Linux images (`node:20-alpine` vs `node:20` saves 900MB)
    - Multi-stage builds reduce final image by 60-90%
    - Order Dockerfile layers from least to most frequently changed
    - `.dockerignore` prevents copying `node_modules`, `.git`, etc. - saves time + space

    **Security:**

    - NEVER run containers as root in production (`USER 1001`)
    - Scan images with `docker scan` or Trivy before deployment
    - Pin base image versions with SHA256: `FROM node:20-alpine@sha256:abc123...`
    - Use `--read-only` filesystem when possible, mount `/tmp` as tmpfs
    - Secrets via Docker secrets or env vars, NEVER baked into images

    **Networking:**

    - Default bridge network has no DNS, use custom networks (`docker network create`)
    - Containers on same network communicate via service name (no IPs needed)
    - `--network host` bypasses isolation (fast but insecure)
    - Publish ports sparingly - internal services don't need `-p`

    **Volumes & Data:**

    - Named volumes persist data (`docker volume create`)
    - Bind mounts map host paths (dev only, breaks portability)
    - Volumes survive container deletion, containers don't
    - Never store data in container filesystem (ephemeral by design)

    **Performance:**

    - Build cache speeds up rebuilds - structure Dockerfiles carefully
    - Use `COPY --link` in multi-stage builds (BuildKit feature)
    - Enable BuildKit: `export DOCKER_BUILDKIT=1`
    - Layer caching breaks if ANY parent layer changes

    **Common Footguns:**

    - Forgetting `EXPOSE` doesn't publish ports (just documentation)
    - Using `:latest` tag in prod (non-deterministic, breaks rollbacks)
    - Not cleaning up: `docker system prune` saves gigabytes
    - Running `apt-get update` without `rm -rf /var/lib/apt/lists/*` bloats images
    - Debugging inside containers without shell (use `FROM scratch` images sparingly)

    **When NOT to Use Docker:**

    - GUI desktop apps (technically possible, practically painful)
    - Kernel modules or low-level hardware access required
    - Single static binary with no dependencies (overhead outweighs benefits)
    - Windows-native apps (.NET Framework, not Core)
    - Real-time systems with strict latency requirements (virtualization adds overhead)
    - Development on resource-constrained machines (Docker Desktop eats RAM)

______________________________________________________________________

## Learning Paths

### 🎓 Free Resources

- **[Docker Official Docs](https://docs.docker.com/)** - Comprehensive, well-structured, start here
- **[Play with Docker](https://labs.play-with-docker.com/)** - Browser-based playground, no install needed
- **[The Docker Handbook](https://www.freecodecamp.org/news/the-docker-handbook/)** - Free 400-page book on freeCodeCamp
- **[Docker Curriculum](https://docker-curriculum.com/)** - Gentle intro with hands-on examples
- **[Docker for Beginners (freeCodeCamp)](https://www.freecodecamp.org/news/tag/docker/)** - 169+ articles, beginner to advanced

### 🧪 Interactive Labs

- **[Play with Docker Classroom](https://training.play-with-docker.com/)** - Free labs from beginner to Swarm clustering
- **[Docker Desktop Tutorial](https://www.docker.com/101-tutorial/)** - Built-in getting started guide
- **[Killer.sh Docker Practice](https://killer.sh/docker)** - Hands-on exercises for certification prep

### 📜 Certifications Worth It

- **[Docker Certified Associate (DCA)](https://training.mirantis.com/dca-certification-exam/)** - $195, covers Docker fundamentals + orchestration, valuable for resume
- **Certified Kubernetes Administrator (CKA)** - $395, more valuable than DCA if you're going container orchestration route
- **Skip:** Docker Desktop certifications (niche, limited industry recognition)

### 🚀 Projects to Build

- **Beginner:** Containerize a Flask/Express app with database - learn Dockerfile + Compose basics
- **Intermediate:** Multi-service app with Nginx reverse proxy, Redis caching, Postgres - real-world architecture
- **Advanced:** CI/CD pipeline building images, scanning vulnerabilities, deploying to prod with health checks + rollbacks

______________________________________________________________________

## Community Pulse

### 🐦 Who to Follow

**Twitter/X:**

- [@docker](https://twitter.com/docker) - Official updates, feature announcements
- [@jpetazzo](https://twitter.com/jpetazzo) - Jérôme Petazzoni, Docker early engineer, deep container insights
- [@IanMLewis](https://twitter.com/IanMLewis) - Google container expert, Kubernetes contributor
- [@kelseyhightower](https://twitter.com/kelseyhightower) - Kubernetes creator, container advocacy
- [@BretFisher](https://twitter.com/BretFisher) - Docker Captain, great tutorials and courses

**YouTube:**

- [TechWorld with Nana](https://www.youtube.com/@TechWorldwithNana) - DevOps tutorials, Docker + Kubernetes
- [NetworkChuck](https://www.youtube.com/@NetworkChuck) - Beginner-friendly container content
- [Bret Fisher Docker and DevOps](https://www.youtube.com/@BretFisher) - Docker Captain, in-depth courses

### 💬 Active Communities

- **[r/docker](https://reddit.com/r/docker)** - 170k+ members, daily activity, helpful community, mix of beginner + advanced
- **[Dev.to #docker](https://dev.to/t/docker)** - Active tag with quality tutorials, updated daily, practical content
- **[Docker Community Slack](https://dockr.ly/slack)** - Official, multiple channels, Docker employees present
- **[Docker Community Forums](https://forums.docker.com/)** - Official, searchable, thorough answers
- **[Stack Overflow [docker]](https://stackoverflow.com/questions/tagged/docker)** - 200k+ questions, excellent for debugging

### 🎙️ Podcasts & Newsletters

- **[Docker Blog](https://www.docker.com/blog/)** - Official, weekly updates, feature releases, security advisories
- **[Last Week in AWS](https://www.lastweekinaws.com/)** - Covers container news in cloud context
- **[Kubernetes Podcast](https://kubernetespodcast.com/)** - Weekly, often covers Docker ecosystem
- **[DevOps Paradox](https://www.devopsparadox.com/)** - Biweekly, containers + cloud native topics

### 🎪 Events & Conferences

- **[DockerCon](https://www.docker.com/events/)** - Annual (virtual + in-person), free virtual tier, Docker roadmap reveals
- **[KubeCon + CloudNativeCon](https://www.cncf.io/kubecon-cloudnativecon-events/)** - Largest container conference, $1000+, worth it for serious practitioners
- **[Docker Community Meetups](https://www.docker.com/community/)** - Local meetups worldwide, free, networking opportunities
- **[Cloud Native Rejekts](https://cloud-native.rejekts.io/)** - Free community conference before KubeCon

______________________________________________________________________

## Worth Checking

<div class="grid cards" markdown>

- 📚 __Official Stuff__

    ______________________________________________________________________

    [Docker Docs](https://docs.docker.com/)

    [Docker Hub](https://hub.docker.com/)

    [GitHub: Moby Project](https://github.com/moby/moby)

    [Docker Blog](https://www.docker.com/blog/)

- 🧪 __Hands-on__

    ______________________________________________________________________

    [Play with Docker](https://labs.play-with-docker.com/)

    [Docker 101 Tutorial](https://www.docker.com/101-tutorial/)

    [Docker Samples](https://github.com/dockersamples)

- 💻 __Real Code__

    ______________________________________________________________________

    [Awesome Docker](https://github.com/veggiemonk/awesome-docker)

    [Docker Official Images](https://github.com/docker-library/official-images)

    [Hadolint (Dockerfile Linter)](https://github.com/hadolint/hadolint)

    [Dive (Image Layer Explorer)](https://github.com/wagoodman/dive)

- 🔥 __Deep Dives__

    ______________________________________________________________________

    [Docker Security Best Practices](https://snyk.io/learn/docker-security/)

    [Docker ARG vs ENV](https://vsupalov.com/docker-arg-vs-env/)

    [Multi-stage Builds Guide](https://docs.docker.com/build/building/multi-stage/)

    [Layer Caching Deep Dive](https://docs.docker.com/build/cache/)

- 🛠️ __Tools & Extensions__

    ______________________________________________________________________

    [Lazydocker (Terminal UI)](https://github.com/jesseduffield/lazydocker)

    [Portainer (Web UI)](https://www.portainer.io/)

    [Trivy (Vulnerability Scanner)](https://github.com/aquasecurity/trivy)

    [Docker Bench Security](https://github.com/docker/docker-bench-security)

    [cAdvisor (Monitoring)](https://github.com/google/cadvisor)

- 📰 __News & Updates__

    ______________________________________________________________________

    [Docker Release Notes](https://docs.docker.com/engine/release-notes/)

    [r/docker](https://reddit.com/r/docker)

    [Hacker News: Docker](https://hn.algolia.com/?q=docker)

    [Dev.to #docker](https://dev.to/t/docker)

</div>

______________________________________________________________________

**Last Updated:** 2026-01-14 **Vibe Check:** 🌍 Mainstream - Docker is the container standard. Kubernetes gets the hype, but Docker still runs most dev environments and countless production workloads. Not the shiny new toy, but the reliable workhorse everyone knows.
