# CI/CD (Continuous Integration/Continuous Deployment)

Automate your way to production. Merge, build, test, deploy, break, repeat. It's the pipeline that never sleeps so you can pretend to sleep while your code ships itself at 3 AM. When it works, you're a genius. When it breaks, you're debugging YAML at midnight.

______________________________________________________________________

## Quick Hits

=== "🎯 Core Concepts"

    **What CI/CD Actually Means:**

    - **Continuous Integration** - Merge code constantly, catch conflicts early, automated tests prevent dumpster fires
    - **Continuous Deployment** - Ship every commit that passes tests (bold strategy)
    - **Continuous Delivery** - Ship when you want, but always be *ready* to ship (safer strategy)

    **The Real Deal:**

    - Commit → Build → Test → Deploy → Monitor → Panic → Fix → Repeat
    - Small changes frequently > big bang releases that explode
    - Automate everything, trust nothing, test constantly
    - Your pipeline is code, version it, review it, don't YOLO it

    **Martin Fowler's Timeless Rules:**

    - Single source of truth (one main branch)
    - Everyone commits to main daily (or you're doing it wrong)
    - Every commit triggers a build
    - Fix broken builds immediately (drop everything)
    - Keep builds fast (\<10 mins or people stop caring)
    - Test in production-like environments
    - Make it easy to get the latest build
    - Deployments should be boring

=== "⚡ Essential Patterns"

    ```yaml
    # GitHub Actions: The pattern you'll copy-paste 1000 times
    name: CI/CD Pipeline

    on:
      push:
        branches: [main]
      pull_request:
        branches: [main]

    jobs:
      test:
        runs-on: ubuntu-latest

        strategy:
          matrix:
            node-version: [18, 20, 22]

        steps:
          - uses: actions/checkout@v4

          - uses: actions/setup-node@v4
            with:
              node-version: ${{ matrix.node-version }}
              cache: 'npm'

          - run: npm ci
          - run: npm test
          - run: npm run build

      deploy:
        needs: test
        if: github.ref == 'refs/heads/main'
        runs-on: ubuntu-latest

        steps:
          - uses: actions/checkout@v4
          - name: Deploy to production
            run: ./deploy.sh
            env:
              API_KEY: ${{ secrets.API_KEY }}
    ```

    **GitLab CI equivalent:**

    ```yaml
    # .gitlab-ci.yml - same shit, different YAML
    stages:
      - test
      - deploy

    test:
      stage: test
      parallel:
        matrix:
          - NODE_VERSION: [18, 20, 22]
      image: node:$NODE_VERSION
      script:
        - npm ci
        - npm test
        - npm run build
      cache:
        paths:
          - node_modules/

    deploy:
      stage: deploy
      only:
        - main
      script:
        - ./deploy.sh
      environment:
        name: production
    ```

=== "🔥 Pro Tips & Gotchas"

    **Matrix Builds:**

    - Test across versions/OS combinations simultaneously
    - GitHub Actions limits: 256 jobs max per matrix (don't try)
    - Use `fail-fast: false` to see all failures, not just the first one

    **Caching Saves Your Life:**

    - Cache dependencies or wait 10 minutes per build
    - GitHub Actions cache: 10GB limit, 7-day retention
    - Cache keys matter: `${{ hashFiles('**/package-lock.json') }}` FTW
    - Cache invalidation is still the hardest problem in CS

    **Secrets Management:**

    - Never hardcode secrets (git remembers forever)
    - Use environment secrets with approval workflows
    - GitHub secrets are write-only (can't view after saving)
    - Self-hosted runners see secrets in plaintext (be careful)
    - Mask dynamic secrets: `echo "::add-mask::$SECRET_VALUE"`

    **Common Footguns:**

    - Forgetting `needs:` creates race conditions
    - `pull_request_target` + fork PRs = security nightmare
    - Self-hosted runners on public repos = crypto miner playground
    - Workflow dispatch without validation = production roulette
    - Matrix builds × large test suites = infinite CI minutes

    **When NOT to CI/CD:**

    - Compliance requires manual approvals (use CD not deployment)
    - Your tests are flakier than a croissant
    - Deployment rollback takes hours (fix that first)
    - Database migrations with no rollback plan
    - You're deploying to production on Friday (rookie mistake)

______________________________________________________________________

## Platform Wars

### GitHub Actions vs GitLab CI vs Jenkins

| Feature            | GitHub Actions            | GitLab CI                | Jenkins              | Reality Check                     |
| ------------------ | ------------------------- | ------------------------ | -------------------- | --------------------------------- |
| **Setup**          | Zero config needed        | Zero config needed       | Java + plugins hell  | GH/GL win here                    |
| **Syntax**         | YAML workflows            | YAML pipelines           | Groovy or YAML       | All equally painful               |
| **Hosted**         | ✅ 2000 min/month free    | ✅ 400 min/month free    | ❌ Self-host only    | Hosting costs add up              |
| **Speed**          | Fast cold starts          | Fast cold starts         | Slow AF              | Jenkins needs warm-up             |
| **Caching**        | Built-in, 10GB limit      | Built-in, varies by tier | Plugins required     | GH/GL easier                      |
| **Secrets**        | Native, secure            | Native, secure           | Credentials plugin   | All work, Jenkins clunky          |
| **Matrix**         | ✅ Elegant                | ✅ Elegant               | ❌ Manual loops      | Modern CI wins                    |
| **Ecosystem**      | Marketplace: 20k+ actions | Less mature              | Plugin jungle: 1800+ | GH wins quantity                  |
| **Debugging**      | `act` for local runs      | GitLab Runner locally    | Pain                 | GH has best DX                    |
| **Cost**           | $$$ self-hosted/$$$$ SaaS | $$ reasonable            | $ but time = money   | Depends on scale                  |
| **UI/UX**          | Clean, modern             | Clean, modern            | Looks like 2010      | Jenkins aged poorly               |
| **Learning Curve** | Gentle                    | Gentle                   | Steep                | Jenkins veterans exist for reason |

**The Verdict:**

- **New projects?** GitHub Actions (if already on GitHub) or GitLab CI (if not)
- **Existing Jenkins?** Migrate if you can, maintain if you can't
- **Enterprise?** GitLab CI for self-hosted control, GitHub Actions for ecosystem
- **Complex pipelines?** All suck equally at 2000+ lines of YAML

______________________________________________________________________

## GitHub Actions Deep Dive

### Why Everyone Uses It

**The Good:**

- Native to GitHub (where your code already lives)
- Marketplace has an action for literally everything
- Matrix builds that actually work
- Reusable workflows (DRY your pipelines)
- Concurrent job execution by default
- Environment protection rules with required approvals
- OIDC for keyless cloud auth (bye AWS keys)

**The Bad:**

- Free tier burns fast (2000 mins = ~33 hours)
- Self-hosted runners are security nightmares
- Workflow file gets huge (congrats, it's 500 lines now)
- Debugging is "commit, push, wait 5 mins, repeat"
- No way to view secrets after creation (hope you saved them)

**The Ugly:**

- YAML indentation will ruin your day
- Marketplace quality varies wildly
- Actions can exfiltrate secrets (supply chain risk)
- GitHub goes down, your CI goes down
- Minute multipliers: Windows (2x), macOS (10x) 🤑

### Essential Workflow Patterns

**Build → Test → Deploy:**

```yaml
name: Production Pipeline

on:
  push:
    branches: [main]
    paths-ignore:
      - '**.md'
      - 'docs/**'

env:
  NODE_VERSION: '20'

jobs:
  build:
    runs-on: ubuntu-latest
    outputs:
      version: ${{ steps.version.outputs.version }}

    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Build
        run: npm run build

      - name: Extract version
        id: version
        run: echo "version=$(node -p "require('./package.json').version")" >> $GITHUB_OUTPUT

      - uses: actions/upload-artifact@v4
        with:
          name: build-artifacts
          path: dist/
          retention-days: 7

  test:
    needs: build
    runs-on: ${{ matrix.os }}

    strategy:
      fail-fast: false
      matrix:
        os: [ubuntu-latest, windows-latest]
        node-version: [18, 20, 22]

    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: 'npm'

      - run: npm ci

      - name: Run tests
        run: npm test

      - name: Upload coverage
        uses: codecov/codecov-action@v4
        if: matrix.os == 'ubuntu-latest' && matrix.node-version == '20'

  deploy:
    needs: [build, test]
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://app.example.com

    steps:
      - uses: actions/checkout@v4

      - uses: actions/download-artifact@v4
        with:
          name: build-artifacts
          path: dist/

      - name: Deploy to production
        run: |
          echo "Deploying version ${{ needs.build.outputs.version }}"
          # Your deploy script here
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

**Security Scanning:**

```yaml
name: Security Checks

on:
  push:
    branches: [main, develop]
  pull_request:
  schedule:
    - cron: '0 6 * * 1'  # Weekly Monday 6 AM

jobs:
  scan:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      security-events: write

    steps:
      - uses: actions/checkout@v4

      - name: Run Snyk security scan
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}

      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          scan-ref: '.'
          format: 'sarif'
          output: 'trivy-results.sarif'

      - name: Upload to GitHub Security
        uses: github/codeql-action/upload-sarif@v3
        with:
          sarif_file: 'trivy-results.sarif'
```

**Monorepo with Path Filters:**

```yaml
name: Monorepo CI

on:
  push:
    branches: [main]
  pull_request:
    paths:
      - 'apps/**'
      - 'packages/**'

jobs:
  changes:
    runs-on: ubuntu-latest
    outputs:
      frontend: ${{ steps.filter.outputs.frontend }}
      backend: ${{ steps.filter.outputs.backend }}
    steps:
      - uses: actions/checkout@v4
      - uses: dorny/paths-filter@v3
        id: filter
        with:
          filters: |
            frontend:
              - 'apps/web/**'
            backend:
              - 'apps/api/**'

  frontend:
    needs: changes
    if: needs.changes.outputs.frontend == 'true'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm run test:frontend

  backend:
    needs: changes
    if: needs.changes.outputs.backend == 'true'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm run test:backend
```

______________________________________________________________________

## GitLab CI: The Underdog

### Why It's Actually Good

**Advantages over GitHub Actions:**

- Self-hosted = full control, no minute limits
- Better Docker integration (Docker-in-Docker, kaniko)
- Environments and deployments are first-class
- Dynamic child pipelines (generate pipelines with code)
- Better UI for complex pipelines (dependency graphs)
- Merge request approval rules > GitHub branch protection

**Why People Skip It:**

- Smaller ecosystem than GitHub
- Self-hosting is extra work
- SaaS tier limits stricter
- GitHub is where everyone already is

### Key GitLab CI Patterns

**.gitlab-ci.yml essentials:**

```yaml
# Stages execute in order, jobs in same stage run parallel
stages:
  - build
  - test
  - deploy

# Variables available to all jobs
variables:
  NODE_VERSION: "20"
  POSTGRES_VERSION: "15"

# Anchor for DRY
.node_template: &node_template
  image: node:${NODE_VERSION}
  cache:
    key: ${CI_COMMIT_REF_SLUG}
    paths:
      - node_modules/
  before_script:
    - npm ci

# Build job
build:
  <<: *node_template
  stage: build
  script:
    - npm run build
  artifacts:
    paths:
      - dist/
    expire_in: 1 week

# Test with services (like databases)
test:
  <<: *node_template
  stage: test
  services:
    - postgres:${POSTGRES_VERSION}
  variables:
    POSTGRES_DB: test_db
    POSTGRES_USER: test_user
    POSTGRES_PASSWORD: test_pass
  script:
    - npm run migrate
    - npm test
  coverage: '/Coverage: \d+\.\d+/'
  artifacts:
    reports:
      junit: junit.xml
      coverage_report:
        coverage_format: cobertura
        path: coverage/cobertura-coverage.xml

# Deploy only on main, manual approval required
deploy:production:
  stage: deploy
  script:
    - ./deploy-production.sh
  environment:
    name: production
    url: https://example.com
    on_stop: stop_production
  when: manual
  only:
    - main
  dependencies:
    - build

# Stop environment job
stop_production:
  stage: deploy
  script:
    - ./stop-production.sh
  environment:
    name: production
    action: stop
  when: manual
  only:
    - main
```

**Dynamic child pipelines:**

```yaml
# Generate pipeline based on changed files
generate-config:
  stage: build
  script:
    - python generate_pipeline.py > pipeline.yml
  artifacts:
    paths:
      - pipeline.yml

# Trigger generated pipeline
child-pipeline:
  stage: test
  trigger:
    include:
      - artifact: pipeline.yml
        job: generate-config
    strategy: depend
```

______________________________________________________________________

## Jenkins: The Legacy Beast

### Why It's Still Everywhere

**The Reality:**

- Been around since 2011 (formerly Hudson since 2005)
- Every enterprise has Jenkins somewhere
- Plugin for literally everything (1800+)
- Fully self-hosted, full control
- Groovy pipelines = actual code, not YAML limits
- Mature, battle-tested, boring technology

**Why People Want to Leave:**

- UI from the Bush administration
- Plugin hell (dependencies, compatibility, security)
- Slow cold starts, resource hungry
- Setup and maintenance are full-time jobs
- No cloud-native features (manual scaling, no OIDC, etc.)
- Security vulns discovered regularly

### Declarative vs Scripted Pipelines

**Declarative (recommended):**

```groovy
pipeline {
    agent {
        docker {
            image 'node:20'
            args '-v $HOME/.npm:/root/.npm'
        }
    }

    environment {
        NODE_ENV = 'production'
        API_KEY = credentials('api-key-secret')
    }

    stages {
        stage('Build') {
            steps {
                sh 'npm ci'
                sh 'npm run build'
            }
        }

        stage('Test') {
            parallel {
                stage('Unit Tests') {
                    steps {
                        sh 'npm run test:unit'
                    }
                }
                stage('Integration Tests') {
                    steps {
                        sh 'npm run test:integration'
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Deploy to production?', ok: 'Deploy'
                sh './deploy.sh'
            }
        }
    }

    post {
        always {
            junit 'test-results/**/*.xml'
            cleanWs()
        }
        failure {
            mail to: 'team@example.com',
                 subject: "Build Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                 body: "Check console output at ${env.BUILD_URL}"
        }
    }
}
```

**Scripted (full Groovy power, more footguns):**

```groovy
node('docker') {
    def app

    stage('Clone') {
        checkout scm
    }

    stage('Build') {
        app = docker.build("myapp:${env.BUILD_ID}")
    }

    stage('Test') {
        app.inside {
            sh 'npm test'
        }
    }

    stage('Push') {
        docker.withRegistry('https://registry.example.com', 'docker-creds') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }

    if (env.BRANCH_NAME == 'main') {
        stage('Deploy') {
            timeout(time: 1, unit: 'HOURS') {
                input message: 'Deploy to production?'
            }

            sh './deploy-k8s.sh'
        }
    }
}
```

**Migrating from Jenkins:**

- Document your Groovy pipelines (future you will thank you)
- Start with new projects on modern CI
- Slowly migrate Jenkins jobs as you touch them
- Use Jenkins X for Kubernetes-native Jenkins (or just switch to Tekton)

______________________________________________________________________

## Best Practices (Actually Follow These)

### Build Strategy

**Keep Builds Fast (\<10 minutes):**

- Cache aggressively (dependencies, build outputs)
- Run tests in parallel (matrix builds, job splitting)
- Use build artifacts between jobs (don't rebuild)
- Skip jobs when paths haven't changed
- Use faster runners (self-hosted, bigger machines)

**Example timing breakdown:**

```
✓ Checkout code:           10s
✓ Restore cache:           20s  <- Cache or die
✓ Install dependencies:    30s  <- Should be cached
✓ Build:                   60s
✓ Run tests:              120s  <- Parallelize this
✓ Security scan:           45s  <- Run in parallel job
✓ Deploy staging:          30s
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total:                   ~5 min (acceptable)
```

### Caching Strategies

**GitHub Actions:**

```yaml
# Dependency caching
- uses: actions/cache@v4
  with:
    path: |
      ~/.npm
      node_modules/
    key: ${{ runner.os }}-npm-${{ hashFiles('**/package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-npm-
      ${{ runner.os }}-

# Docker layer caching
- uses: docker/build-push-action@v5
  with:
    context: .
    cache-from: type=gha
    cache-to: type=gha,mode=max
```

**Cache Invalidation:**

- Change cache key when dependencies change: `${{ hashFiles('**/package-lock.json') }}`
- Use restore-keys for partial matches (faster than cold start)
- Set reasonable retention (7 days usually enough)
- Monitor cache hit rates (GitHub insights shows this)

### Secrets Management

**The Hierarchy:**

1. **Best:** OIDC keyless auth (AWS, Azure, GCP)
1. **Good:** Short-lived tokens, auto-rotated
1. **Acceptable:** Long-lived secrets in vault (GitHub Secrets, etc.)
1. **Bad:** Secrets in environment variables
1. **Fired:** Secrets in code

**OIDC Example (no AWS keys!):**

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read

    steps:
      - uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::123456789012:role/GitHubActionsRole
          aws-region: us-east-1

      - run: aws s3 sync ./dist s3://my-bucket/
```

**Dynamic Secrets (mask them!):**

```yaml
- name: Generate temporary token
  run: |
    TOKEN=$(curl -X POST https://api.example.com/token)
    echo "::add-mask::$TOKEN"
    echo "TEMP_TOKEN=$TOKEN" >> $GITHUB_ENV
```

**Never Do This:**

```yaml
# 🚨 Security nightmare
- name: Deploy
  run: |
    echo "My API key is: ${{ secrets.API_KEY }}"  # WILL BE VISIBLE IN LOGS
    curl -H "Authorization: ${{ secrets.API_KEY }}" ...  # URL logged
```

### Matrix Build Mastery

**Test Everything:**

```yaml
strategy:
  fail-fast: false  # See all failures, not just first
  matrix:
    os: [ubuntu-latest, windows-latest, macos-latest]
    node-version: [18, 20, 22]
    include:
      # Add specific combinations
      - os: ubuntu-latest
        node-version: 22
        experimental: true
    exclude:
      # Skip problematic combinations
      - os: macos-latest
        node-version: 18

# Access matrix values
steps:
  - name: Show config
    run: echo "Testing Node ${{ matrix.node-version }} on ${{ matrix.os }}"

  - name: Mark experimental
    if: matrix.experimental
    run: echo "::warning::This is an experimental build"
```

**Cost Optimization:**

```yaml
# Don't do this (10x macOS pricing)
matrix:
  os: [ubuntu-latest, macos-latest]
  node: [14, 16, 18, 20, 22]  # 10 jobs, 5 on macOS 💸

# Do this instead
matrix:
  os: [ubuntu-latest]
  node: [14, 16, 18, 20, 22]  # 5 jobs
  include:
    - os: macos-latest  # Only one macOS job
      node: 22          # Latest only
```

### Pipeline Patterns

**Feature Branch Workflow:**

```yaml
on:
  pull_request:
    branches: [main, develop]
  push:
    branches: [main, develop]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm test

  preview-deploy:
    if: github.event_name == 'pull_request'
    needs: test
    steps:
      - name: Deploy preview
        run: ./deploy-preview.sh
        env:
          PR_NUMBER: ${{ github.event.pull_request.number }}

  production-deploy:
    if: github.ref == 'refs/heads/main' && github.event_name == 'push'
    needs: test
    environment:
      name: production
      url: https://example.com
    steps:
      - run: ./deploy-production.sh
```

**Trunk-Based Development:**

```yaml
# Everyone commits to main, feature flags for WIP features
on:
  push:
    branches: [main]

jobs:
  continuous-deployment:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm ci
      - run: npm test
      - name: Deploy to production
        if: success()
        run: ./deploy.sh
      - name: Rollback on failure
        if: failure()
        run: ./rollback.sh
```

**GitOps Pattern:**

```yaml
# Update deployment repo after successful build
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Build and push image
        run: |
          docker build -t myapp:${{ github.sha }} .
          docker push myapp:${{ github.sha }}

      - name: Update GitOps repo
        run: |
          git clone https://github.com/org/k8s-config
          cd k8s-config
          sed -i "s|image: myapp:.*|image: myapp:${{ github.sha }}|" deployment.yaml
          git add deployment.yaml
          git commit -m "Update myapp to ${{ github.sha }}"
          git push
```

______________________________________________________________________

## Learning Paths

### 🎓 Free Resources

**Fundamentals:**

- **[Martin Fowler: Continuous Integration](https://martinfowler.com/articles/continuousIntegration.html)** - The canonical essay that started it all, ignore at your peril
- **[GitHub Skills: GitHub Actions](https://github.com/skills/hello-github-actions)** - Interactive course, actually hands-on
- **[GitLab CI/CD Documentation](https://docs.gitlab.com/ee/ci/)** - Comprehensive, well-written, examples for days
- **[The DevOps Handbook](https://itrevolution.com/product/the-devops-handbook-second-edition/)** - Theory behind the practice (library, $30 used)
- **[Jenkins Tutorial](https://www.jenkins.io/doc/pipeline/tour/getting-started/)** - If you're stuck with Jenkins, start here

**Video Courses:**

- **[freeCodeCamp: CI/CD Full Course](https://www.youtube.com/watch?v=42UP1fxi2SY)** - 3 hours, covers fundamentals
- **[TechWorld with Nana: GitHub Actions Tutorial](https://www.youtube.com/watch?v=R8_veQiYBjI)** - 1 hour, practical examples
- **[GitLab CI CD Tutorial for Beginners](https://www.youtube.com/watch?v=qP8kir2GUgo)** - 40 mins, crash course

### 🧪 Interactive Labs

**Try Before You Cry:**

- **[Katacoda CI/CD Scenarios](https://www.katacoda.com/courses/cicd)** - Browser-based labs (being deprecated, use while alive)
- **[Play with Docker](https://labs.play-with-docker.com/)** - Free Docker playground for pipeline testing
- **[act](https://github.com/nektos/act)** - Run GitHub Actions locally (debug without 50 commits)
- **[GitLab CI Lint](https://gitlab.com/ci/lint)** - Validate .gitlab-ci.yml before you push

### 📜 Certifications Worth It

**GitHub Actions:**

- **No official cert** - GitHub doesn't offer one (yet)
- **Prove it:** Public repos with solid workflows are your resume

**GitLab CI/CD:**

- **[GitLab Certified CI/CD Specialist](https://about.gitlab.com/services/education/gitlab-cicd-specialist/)** - $650, 3 hours, hands-on lab
- **Worth it if:** Company pays, you're all-in on GitLab, want formal recognition
- **Skip if:** Learning for general CI/CD knowledge (too vendor-specific)

**Jenkins:**

- **[Certified Jenkins Engineer (CJE)](https://www.cloudbees.com/jenkins/certification)** - $300, multiple choice + hands-on
- **Worth it if:** Career Jenkins admin, enterprise requirements
- **Skip if:** You're trying to escape Jenkins (don't anchor yourself)

**General DevOps:**

- **[AWS Certified DevOps Engineer](https://aws.amazon.com/certification/certified-devops-engineer-professional/)** - $300, covers CI/CD + AWS
- **[Azure DevOps Engineer Expert](https://learn.microsoft.com/en-us/certifications/devops-engineer/)** - $165, Azure CI/CD focused

### 🚀 Projects to Build

**Beginner: Simple Node.js CI/CD**

- GitHub repo with Express app
- GitHub Actions workflow: lint → test → build
- Deploy to Vercel/Netlify on merge to main
- *Learn:* Basic pipeline, artifacts, deployment

**Intermediate: Multi-stage Docker Pipeline**

- Multi-service app (frontend, backend, database)
- Docker Compose for local dev
- GitHub Actions: build images → push to registry → deploy to staging
- Matrix testing across Node/Python versions
- *Learn:* Containerization, multi-job workflows, secrets

**Advanced: Kubernetes GitOps**

- Microservices app
- GitHub Actions builds images, updates K8s manifests in separate repo
- ArgoCD watches manifest repo, auto-deploys to cluster
- Canary deployments with Flagger
- Rollback on failure
- *Learn:* GitOps, advanced deployment strategies, observability

______________________________________________________________________

## Community Pulse

### 🐦 Who to Follow

**Twitter/X (yeah it's still called that):**

- **[@kelseyhightower](https://x.com/kelseyhightower)** - Ex-Googler, Kubernetes OG, CI/CD wisdom
- **[@jessfraz](https://x.com/jessfraz)** - Ex-Docker/Microsoft, container security, automation expert
- **[@rakyll](https://x.com/rakyll)** - Google SRE, observability, dev tooling insights
- **[@brikis98](https://x.com/brikis98)** - Gruntwork founder, Terraform, IaC, deployment patterns
- **[@github](https://x.com/github)** - Official GitHub account, Actions updates, features
- **[@gitlab](https://x.com/gitlab)** - Official GitLab, CI/CD features, case studies

**YouTube/Streams:**

- **[TechWorld with Nana](https://www.youtube.com/@TechWorldwithNana)** - DevOps tutorials, CI/CD deep dives
- **[NetworkChuck](https://www.youtube.com/@NetworkChuck)** - DevOps basics, fun presentation style
- **[DevOps Toolkit](https://www.youtube.com/@DevOpsToolkit)** - Advanced patterns, Kubernetes, GitOps
- **[GitHub](https://www.youtube.com/@GitHub)** - Official channel, Actions demos, best practices

### 💬 Active Communities

**Reddit:**

- **[r/devops](https://reddit.com/r/devops)** - 300k+ members, active daily, war stories + advice
- **[r/github](https://reddit.com/r/github)** - 100k+ members, GitHub-specific questions, Actions help
- **[r/gitlab](https://reddit.com/r/gitlab)** - 15k+ members, smaller but helpful community

**Discord/Slack:**

- **[DevOps Chat](https://discord.gg/devops)** - General DevOps discussions, CI/CD channels
- **[GitHub Community](https://github.com/orgs/community/discussions)** - Official GitHub discussions, Actions Q&A
- **[GitLab Discord](https://discord.gg/gitlab)** - Official community, active support

**Forums:**

- **[Stack Overflow: github-actions](https://stackoverflow.com/questions/tagged/github-actions)** - 30k+ questions, active answerers
- **[Stack Overflow: gitlab-ci](https://stackoverflow.com/questions/tagged/gitlab-ci)** - 15k+ questions
- **[Stack Overflow: jenkins](https://stackoverflow.com/questions/tagged/jenkins)** - 60k+ questions (legacy searches)

**Dev.to:**

- **[#cicd tag](https://dev.to/t/cicd)** - Tutorials, case studies, modern patterns
- **[#githubactions tag](https://dev.to/t/githubactions)** - Actions-specific content, workflow examples
- **[#devops tag](https://dev.to/t/devops)** - Broader DevOps community, CI/CD included

### 🎙️ Podcasts & Newsletters

**Podcasts:**

- **[Arrested DevOps](https://www.arresteddevops.com/)** - Weekly, interviews with practitioners, 10+ years running
- **[The Changelog](https://changelog.com/podcast)** - Developer tooling, occasional CI/CD deep dives
- **[Software Engineering Daily: DevOps](https://softwareengineeringdaily.com/category/devops/)** - Daily technical interviews

**Newsletters:**

- **[DevOps Weekly](https://www.devopsweekly.com/)** - Sunday, curated links, tool announcements
- **[Console Dev Tools](https://console.dev/)** - Weekly, developer tools + CI/CD platforms
- **[GitHub Changelog](https://github.blog/changelog/)** - Official, Actions features, platform updates
- **[GitLab Newsletter](https://about.gitlab.com/company/contact/)** - Monthly, features, case studies
- **[Earthly Blog](https://earthly.dev/blog/)** - Deep technical CI/CD posts, build optimization

### 🎪 Events & Conferences

**Major Events:**

- **[GitHub Universe](https://githubuniverse.com/)** - Annual, SF, $500-1500, Actions announcements, hands-on labs
- **[GitLab Commit](https://about.gitlab.com/events/commit/)** - Annual, virtual/in-person, free virtual tier, CI/CD talks
- **[DevOpsDays](https://devopsdays.org/)** - Local events worldwide, community-driven, CI/CD tracks
- **[KubeCon](https://www.cncf.io/kubecon-cloudnativecon-events/)** - Cloud-native CI/CD, GitOps, massive conference

**Online/Free:**

- **[CNCF Webinars](https://www.cncf.io/webinars/)** - Free, Tekton, ArgoCD, cloud-native CI/CD
- **[GitHub Actions Virtual Meetup](https://www.meetup.com/github-actions/)** - Monthly, community workflows
- **[GitLab Virtual Meetups](https://about.gitlab.com/community/events/)** - Regular, CI/CD focused

______________________________________________________________________

## Worth Checking

<div class="grid cards" markdown>

- 📚 __Official Docs__

    ______________________________________________________________________

    [GitHub Actions Docs](https://docs.github.com/en/actions)

    [GitLab CI/CD Docs](https://docs.gitlab.com/ee/ci/)

    [Jenkins Documentation](https://www.jenkins.io/doc/)

    [Martin Fowler: CI](https://martinfowler.com/articles/continuousIntegration.html)

- 🧪 __Hands-on Practice__

    ______________________________________________________________________

    [GitHub Skills](https://github.com/skills/hello-github-actions)

    [act - Local GitHub Actions](https://github.com/nektos/act)

    [GitLab CI Lint](https://gitlab.com/ci/lint)

    [Play with Docker](https://labs.play-with-docker.com/)

- 💻 __Real Code & Templates__

    ______________________________________________________________________

    [GitHub Starter Workflows](https://github.com/actions/starter-workflows)

    [Awesome Actions](https://github.com/sdras/awesome-actions)

    [GitLab CI Templates](https://gitlab.com/gitlab-org/gitlab-foss/-/tree/master/lib/gitlab/ci/templates)

    [Jenkins Pipeline Examples](https://github.com/jenkinsci/pipeline-examples)

- 🔥 __Deep Dives & War Stories__

    ______________________________________________________________________

    [Earthly Blog](https://earthly.dev/blog/)

    [CircleCI Blog](https://circleci.com/blog/)

    [Semaphore CI Blog](https://semaphore.io/blog/)

    [GitHub Engineering Blog](https://github.blog/category/engineering/)

- 🛠️ __Essential Tools__

    ______________________________________________________________________

    [Dagger - Pipelines as Code](https://dagger.io/)

    [Earthly - Better builds](https://earthly.dev/)

    [Shields.io - Status badges](https://shields.io/)

    [actionlint - Workflow linter](https://github.com/rhysd/actionlint)

- 📰 __News & Updates__

    ______________________________________________________________________

    [GitHub Changelog](https://github.blog/changelog/)

    [GitLab Releases](https://about.gitlab.com/releases/)

    [DevOps Weekly](https://www.devopsweekly.com/)

    [r/devops](https://reddit.com/r/devops)

</div>

______________________________________________________________________

## See Also

- **[GitHub](github.md)** - Git workflows, branching strategies, PR patterns
- **[GitHub Actions](github-actions.md)** - Detailed GitHub Actions reference
- **[Pre-Commit](pre-commit.md)** - Local CI checks before you push
- **[Azure DevOps](azure-devops.md)** - Microsoft's CI/CD platform
- **[Kubernetes](../containerization/kubernetes.md)** - Deployment target for pipelines

______________________________________________________________________

**Last Updated:** 2026-01-14 **Vibe Check:** 🌍 Mainstream - CI/CD is table stakes now. GitHub Actions dominates greenfield, Jenkins haunts enterprises, GitLab CI is the Swiss Army knife. YAML fatigue is real but automation beats manual deploys. The future? AI-generated pipelines, self-healing workflows, WebAssembly runners. But today? You're still debugging why tests pass locally but fail in CI.
