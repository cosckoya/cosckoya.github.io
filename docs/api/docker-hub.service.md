---
title: Docker Hub API
description: Container registry API - pull, push, search, and manage container images programmatically
tags:
  - docker
  - container-registry
  - api
  - ci-cd
---

# :simple-docker: Docker Hub API

Container registry API from Docker Inc. Pull and push images, search repositories, manage webhooks, and automate registry operations. Used by virtually every CI/CD pipeline. Rate-limited (anonymous: 100 pulls/6h, authenticated: 200 pulls/6h). Docker Hub is the default registry — `docker.io` is implied when no registry is specified.

!!! tip "2026 Update"
    Docker Hub now enforces rate limits strictly. Authenticated pulls give higher limits. Organization accounts with team features require paid plans. Artifact Registry (cloud-specific) is replacing Docker Hub for enterprise production use. GHCR (GitHub Container Registry) is a popular alternative.

---

## Quick Hits

=== ":lucide-list-check: Essential Commands"

    ```bash
    # Authentication
    docker login                    # Interactive login
    docker login -u $USER -p $TOKEN  # CI/CD login (use access token, not password)

    # Search images
    curl -s "https://hub.docker.com/v2/repositories/library/nginx/tags" | jq '.results[].name'
    curl -s "https://hub.docker.com/v2/repositories/library/nginx/" | jq '.pull_count'

    # Pull and push
    docker pull nginx:latest
    docker tag myapp:latest myuser/myapp:v1.0
    docker push myuser/myapp:v1.0

    # Registry API directly
    TOKEN=$(curl -s "https://auth.docker.io/token?service=registry.docker.io&scope=repository:library/nginx:pull" | jq -r '.token')
    curl -s -H "Authorization: Bearer $TOKEN" "https://registry-1.docker.io/v2/library/nginx/tags/list"
    ```

    **Real talk:**

    - Use access tokens (not passwords) for automation — generate at hub.docker.com/settings/security
    - Rate limits apply per IP for anonymous pulls — authenticate in CI
    - Tag immutability requires paid plan — use unique tags (commit SHA), not `latest`
    - `jq` is essential for working with the API from CLI

=== ":lucide-bolt: Common Patterns"

    ```bash
    # CI/CD: Build and push with commit SHA tagging
    IMAGE="myuser/myapp"
    SHA=$(git rev-parse --short HEAD)
    docker build -t $IMAGE:$SHA .
    docker tag $IMAGE:$SHA $IMAGE:latest
    docker push $IMAGE:$SHA
    docker push $IMAGE:latest

    # Multi-platform builds
    docker buildx create --use
    docker buildx build \
      --platform linux/amd64,linux/arm64 \
      -t $IMAGE:$SHA \
      --push .

    # List all tags for an image (API pagination)
    list_tags() {
        local repo=$1
        local url="https://hub.docker.com/v2/repositories/$repo/tags/?page_size=100"
        while [ -n "$url" ]; do
            response=$(curl -s "$url")
            echo "$response" | jq -r '.results[].name'
            url=$(echo "$response" | jq -r '.next // empty')
        done
    }
    list_tags library/nginx

    # Delete old tags (requires token with delete scope)
    delete_tag() {
        local repo=$1 tag=$2 token=$3
        curl -X DELETE \
          -H "Authorization: JWT $token" \
          "https://hub.docker.com/v2/repositories/$repo/tags/$tag/"
    }
    ```

    **Why this works:**

    - Commit SHA tagging ensures traceability — you always know which code produced which image
    - `buildx` with `--push` builds and pushes in one step, saving CI time
    - Pagination handling is essential — Docker Hub returns 100 results per page max
    - Tag cleanup prevents registry bloat — automate deletion of old dev/feature tags

=== ":lucide-flame: Pro Tips & Gotchas"

    **Tips:**

    - Set up webhooks in Docker Hub to trigger deployments on push
    - Use `docker login` with `--password-stdin` for secure CI: `echo $TOKEN | docker login -u $USER --password-stdin`
    - Multi-stage builds reduce final image size by 10x — leverage them
    - Docker Hub shows pull counts — use this to gauge image popularity before adopting
    - Organization accounts let you manage teams and permissions centrally
    - GitHub Actions has built-in `docker/login-action` for authentication

    **Gotchas:**

    - Anonymous pulls limited to 100 per 6 hours per IP — this hits fast in shared CI environments
    - Tag deletion via API requires authentication with `delete` scope — not available on free plans
    - `latest` tag is meaningless — it points to whatever was pushed last without `latest` tag
    - Docker Hub downtime happens (rare but real) — always have a fallback registry
    - Image layers are cached, but manifest changes force re-pull — `--cache-from` helps in CI

---

## Reference

**Documentation:**

- :lucide-book: [Docker Hub API Reference](https://docs.docker.com/docker-hub/api/latest/)
- :lucide-book: [Docker Registry API Spec](https://docs.docker.com/registry/spec/api/)
- :simple-github: [Docker Hub GitHub](https://github.com/docker/hub-feedback)

**Related:**

- :lucide-flame: **Docker** — Container runtime that uses Docker Hub by default
- :lucide-wrench: **GitHub Container Registry (GHCR)** — Alternative registry integrated with GitHub

---

**Last Updated:** 2026-06-01 | **Vibe Check:** :lucide-box: **Registry Standard** - The default container registry for a reason. Rate limits are annoying but manageable. Free tier sufficient for personal projects. For teams, consider GHCR or cloud-native registries. The API is simple, well-documented, and works.

**Tags:** docker, container-registry, api, ci-cd
