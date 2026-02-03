---
title: Docker Compose
description: Multi-container orchestration - YAML-based container definitions, networks, volumes, development environments
---

# :fontawesome-brands-docker: Docker Compose

Multi-container Docker orchestration tool. Define entire application stacks in YAML. Manages containers, networks, volumes together. Development environments made easy. Simpler than Kubernetes for local/small deployments.

!!! tip "2026 Update"
    Compose V2 is now `docker compose` (not `docker-compose`). Better integration with Docker CLI. Watch mode for live reloading. Profiles for environment-specific services. GPU support for ML workloads.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # New syntax (Compose V2, recommended)
    docker compose up                      # Start all services  # (1)!
    docker compose up -d                   # Start in background (detached)
    docker compose down                    # Stop and remove containers
    docker compose down -v                 # Also remove volumes

    # Build and start
    docker compose up --build              # Rebuild images before starting
    docker compose build                   # Build images only (no start)
    docker compose build --no-cache        # Force rebuild from scratch

    # Service management
    docker compose start                   # Start existing containers
    docker compose stop                    # Stop containers (don't remove)
    docker compose restart                 # Restart all services
    docker compose restart web             # Restart specific service

    # Logs and monitoring
    docker compose logs                    # View all logs
    docker compose logs -f web             # Follow logs for specific service  # (2)!
    docker compose ps                      # List running services
    docker compose top                     # Display running processes

    # Execute commands
    docker compose exec web bash           # Shell into running service  # (3)!
    docker compose run web npm test        # Run one-off command
    docker compose run --rm web npm test   # Run and remove after

    # Scaling services
    docker compose up -d --scale web=3     # Run 3 instances of web service  # (4)!

    # Profiles (environment-specific)
    docker compose --profile dev up        # Start dev-profile services only
    docker compose --profile prod up

    # Watch mode (live reload, V2.22+)
    docker compose watch                   # Auto-rebuild on file changes  # (5)!
    ```

    1. Compose V2 syntax: `docker compose` (space), not `docker-compose` (hyphen)
    2. `-f` follows logs in real-time (like `tail -f`)
    3. Most common command for debugging running containers
    4. Load balancing requires service config without host port mapping
    5. Watch mode rebuilds containers when source files change

    **Real talk:**

    - Compose V2 is faster and better integrated with Docker
    - Perfect for local development, not for production at scale
    - `docker-compose.yml` defines entire application stack
    - Networks created automatically (services can reference by name)
    - Volumes persist data across container restarts

=== ":fontawesome-solid-bolt: Common Patterns"

    ```yaml
    # docker-compose.yml (basic web app)
    version: '3.8'  # (1)!

    services:
      web:
        build:
          context: ./app
          dockerfile: Dockerfile
        ports:
          - "3000:3000"  # (2)!
        environment:
          NODE_ENV: development
          DATABASE_URL: postgres://db:5432/myapp  # (3)!
        depends_on:
          - db
          - redis
        volumes:
          - ./app:/app  # (4)!
          - /app/node_modules  # (5)!
        networks:
          - backend

      db:
        image: postgres:15-alpine
        environment:
          POSTGRES_DB: myapp
          POSTGRES_USER: user
          POSTGRES_PASSWORD: password
        volumes:
          - postgres_data:/var/lib/postgresql/data  # (6)!
        networks:
          - backend

      redis:
        image: redis:7-alpine
        networks:
          - backend

    volumes:
      postgres_data:  # (7)!

    networks:
      backend:  # (8)!
    ```

    1. Version 3.8 supports most features, 3.9+ for newer syntax
    2. `host:container` port mapping, expose container port 3000 to host 3000
    3. Services reference each other by service name (DNS built-in)
    4. Bind mount for live code reloading (changes reflect immediately)
    5. Anonymous volume prevents overwriting node_modules from host
    6. Named volume for persistent database storage
    7. Named volumes defined at top level, persist across `down`
    8. Custom network isolates services, auto DNS resolution

    ```yaml
    # docker-compose.override.yml (development overrides)
    # Automatically merged with docker-compose.yml
    version: '3.8'

    services:
      web:
        build:
          target: development  # (1)!
        environment:
          DEBUG: "true"
        volumes:
          - ./app:/app:cached  # (2)!
        command: npm run dev  # (3)!

      db:
        ports:
          - "5432:5432"  # (4)!
    ```

    1. Multi-stage Dockerfile target for development build
    2. `:cached` improves macOS volume performance
    3. Override default command with dev server (hot reload)
    4. Expose DB port for local database clients

    ```yaml
    # docker-compose.prod.yml (production config)
    # Use with: docker compose -f docker-compose.yml -f docker-compose.prod.yml up
    version: '3.8'

    services:
      web:
        build:
          target: production
        restart: unless-stopped  # (1)!
        environment:
          NODE_ENV: production
        deploy:
          replicas: 3  # (2)!
          resources:
            limits:
              cpus: '0.5'
              memory: 512M
        logging:
          driver: "json-file"
          options:
            max-size: "10m"
            max-file: "3"  # (3)!
    ```

    1. Auto-restart on failure, but not if manually stopped
    2. Deploy section for Swarm mode (not used in standalone Compose)
    3. Log rotation prevents disk fill-up

    ```yaml
    # Profiles for conditional services
    version: '3.8'

    services:
      web:
        image: myapp:latest
        # Always starts (no profile)

      debug:
        image: myapp:latest
        profiles: ["dev"]  # (1)!
        command: npm run debug
        ports:
          - "9229:9229"  # Node.js debugger

      monitoring:
        image: prom/prometheus
        profiles: ["monitoring"]  # (2)!
        ports:
          - "9090:9090"
    ```

    1. Start with: `docker compose --profile dev up`
    2. Multiple profiles can be active: `--profile dev --profile monitoring`

    **Why this works:**

    - Single YAML file defines entire stack (reproducible environments)
    - Override files customize for different environments (dev/prod)
    - Networks provide automatic DNS between services
    - Volumes persist data, bind mounts enable live reloading
    - `depends_on` ensures startup order (DB before app)

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Compose V2 syntax** - Use `docker compose` not `docker-compose`
        - **Environment files** - Store secrets in `.env` (add to .gitignore)
        - **Named volumes** - Persist data across container recreation
        - **Health checks** - Add health checks for reliable startup order
        - **Override files** - Use `docker-compose.override.yml` for local dev
        - **Profiles** - Group services by environment (dev, test, prod)
        - **Resource limits** - Set memory/CPU limits in production

    !!! warning "Security"
        - **Secrets in .env** - Never commit `.env` files with credentials
        - **Use secrets** - Docker secrets for sensitive data (Swarm mode)
        - **Read-only filesystems** - Add `read_only: true` where possible
        - **Drop capabilities** - Use `cap_drop` to reduce attack surface
        - **Non-root users** - Run containers as non-root (USER in Dockerfile)

    !!! tip "Performance"
        - **Build cache** - Layer Dockerfile properly for faster rebuilds
        - **Volume caching** - Use `:cached` flag on macOS for better I/O
        - **Prune regularly** - `docker system prune` removes unused resources
        - **Multi-stage builds** - Smaller production images
        - **Parallel builds** - Compose builds multiple services in parallel

    !!! danger "Gotchas"
        - **Volume ownership** - Container user must match host user for writes
        - **Port conflicts** - Check if host ports already in use (change mapping)
        - **depends_on** - Only waits for start, not readiness (use health checks)
        - **Named volumes location** - Find with `docker volume inspect <volume>`
        - **Network isolation** - Services on different networks can't communicate
        - **Anonymous volumes** - Not cleaned by `down -v` (use `docker volume prune`)
        - **macOS performance** - Bind mounts slower than Linux (use `:cached`)

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning Resources

### :fontawesome-solid-book-open: Official Docs

- **[Docker Compose Documentation](https://docs.docker.com/compose/)** - Complete reference
- **[Compose File Reference](https://docs.docker.com/compose/compose-file/)** - YAML syntax
- **[Compose CLI Reference](https://docs.docker.com/compose/reference/)** - All commands

### :fontawesome-solid-rocket: Key Features

- **Multi-container apps** - Define entire stack in single YAML file
- **Service dependencies** - Control startup order with `depends_on`
- **Networks** - Automatic DNS between services
- **Volumes** - Persistent data storage
- **Environment variables** - `.env` file support
- **Profiles** - Conditional service activation
- **Watch mode** - Auto-rebuild on file changes

______________________________________________________________________

## :fontawesome-solid-star: Related Tools

- **[Docker Swarm](https://docs.docker.com/engine/swarm/)** - Native clustering (Compose compatible)
- **[Kubernetes](../kubernetes.tool.md)** - Production-grade orchestration
- **[Portainer](https://www.portainer.io/)** - Web UI for Docker/Compose
- **[Kompose](https://kompose.io/)** - Convert Compose to Kubernetes

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-diagram-project: **Local Dev Essential** - Perfect for development environments. Simple, fast, reproducible. Not for production at scale (use Kubernetes). Compose V2 is much better than V1.

**Tags:** docker-compose, containers, orchestration, development, docker
