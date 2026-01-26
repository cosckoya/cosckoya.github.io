# Ansible: The Agentless Overlord

*In the beginning, there was SSH. And from SSH sprang forth an automation empire that required nothing but credentials and ambition. Where Chef demanded Ruby priests and Puppet required agent daemons on every node, Ansible walked the path of simplicity—agentless, YAML-driven, radically mundane. Born from the chaos of manual server configuration, it rose to dominance not through technical superiority, but through the ancient wisdom that "good enough and easy" beats "perfect and complicated" every single time.*

Configuration management and orchestration tool. Push-based, agentless, uses SSH. YAML playbooks define infrastructure as code. Owned by Red Hat since 2015. The "it just works" of automation.

______________________________________________________________________

## Quick Hits

=== "🎯 Essential Commands"

    ```bash
    # Install Ansible
    pip install ansible

    # Check version
    ansible --version

    # Ping all hosts in inventory
    ansible all -m ping -i inventory.ini

    # Run ad-hoc command across hosts
    ansible webservers -a "uptime" -i inventory.ini

    # Execute playbook
    ansible-playbook site.yml

    # Execute with verbose output (debugging)
    ansible-playbook site.yml -vvv

    # Dry run (check mode)
    ansible-playbook site.yml --check

    # Syntax validation
    ansible-playbook site.yml --syntax-check

    # List all tasks in playbook
    ansible-playbook site.yml --list-tasks

    # Execute specific tags only
    ansible-playbook site.yml --tags "deploy"

    # Skip specific tags
    ansible-playbook site.yml --skip-tags "slow"

    # Run as different user
    ansible-playbook site.yml -u root

    # Use vault-encrypted variables
    ansible-playbook site.yml --ask-vault-pass

    # Limit execution to specific hosts
    ansible-playbook site.yml --limit "webserver01"
    ```

    **Real talk:**

    - Ansible is agentless—uses SSH (Linux) or WinRM (Windows)
    - Control node requires Python 3.9+ (managed nodes need Python 2.7+ or 3.5+)
    - Ad-hoc commands are quick, playbooks are repeatable
    - Always test with `--check` before running against production
    - `-vvv` shows SSH debugging, `-vvvv` adds connection plugin debugging
    - Inventory can be static (INI/YAML) or dynamic (cloud APIs)

=== "⚡ Common Patterns"

    ```yaml
    # Basic playbook structure
    ---
    - name: Configure web servers
      hosts: webservers
      become: yes
      vars:
        http_port: 80
        max_clients: 200

      tasks:
        - name: Install Apache
          ansible.builtin.yum:
            name: httpd
            state: present

        - name: Start Apache service
          ansible.builtin.systemd:
            name: httpd
            state: started
            enabled: yes

        - name: Deploy config file
          ansible.builtin.template:
            src: templates/httpd.conf.j2
            dest: /etc/httpd/conf/httpd.conf
          notify: Restart Apache

      handlers:
        - name: Restart Apache
          ansible.builtin.systemd:
            name: httpd
            state: restarted
    ```

    ```ini
    # Inventory file (inventory.ini)
    [webservers]
    web01.example.com ansible_host=192.168.1.10
    web02.example.com ansible_host=192.168.1.11

    [dbservers]
    db01.example.com ansible_host=192.168.1.20

    [production:children]
    webservers
    dbservers

    [production:vars]
    ansible_user=deploy
    ansible_ssh_private_key_file=~/.ssh/id_rsa
    ```

    ```yaml
    # Role structure (roles/webserver/)
    # roles/webserver/tasks/main.yml
    ---
    - name: Install packages
      ansible.builtin.package:
        name: "{{ item }}"
        state: present
      loop:
        - nginx
        - certbot

    - name: Deploy site config
      ansible.builtin.template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
      notify: reload nginx

    # roles/webserver/handlers/main.yml
    ---
    - name: reload nginx
      ansible.builtin.systemd:
        name: nginx
        state: reloaded

    # roles/webserver/defaults/main.yml
    ---
    nginx_worker_processes: auto
    nginx_worker_connections: 1024
    ```

    ```yaml
    # Using roles in playbook
    ---
    - name: Deploy application
      hosts: app_servers
      roles:
        - common
        - { role: webserver, nginx_port: 8080 }
        - database
    ```

    **Pattern wisdom:**

    - **Idempotency**: Tasks should be safe to run repeatedly
    - **Handlers**: Trigger actions only when changes occur (restarts, reloads)
    - **Templates**: Use Jinja2 for dynamic config files
    - **Roles**: Group related tasks/vars/files for reusability
    - **Tags**: Enable selective execution (`--tags deploy`)
    - **Check mode**: Always test destructive playbooks first

=== "🔥 Pro Tips & Gotchas"

    **Performance:**

    - Use `strategy: free` for parallel execution (default is `linear`)
    - Set `forks = 20` in ansible.cfg (default 5 is slow)
    - Enable pipelining in ansible.cfg for 3-5x SSH speedup
    - Use `async` and `poll` for long-running tasks
    - Fact gathering is slow—disable with `gather_facts: no` if not needed

    **Secrets Management:**

    - Ansible Vault encrypts sensitive vars (`ansible-vault encrypt secrets.yml`)
    - Store vault password in file, set `ANSIBLE_VAULT_PASSWORD_FILE`
    - Never commit unencrypted credentials to git
    - Use external secret managers (HashiCorp Vault, AWS Secrets Manager)

    **Debugging:**

    - `debug` module is your friend: `- debug: var=my_variable`
    - Use `ansible-playbook -vvv` for SSH debugging
    - Check mode shows what would change: `--check --diff`
    - `register` captures task output for later use
    - `failed_when` customizes failure conditions

    **Common Gotchas:**

    - **YAML indentation matters**: 2 spaces, no tabs, or suffer
    - **become vs become_user**: `become: yes` escalates privileges (sudo), `become_user` specifies which user
    - **when conditions**: Use Jinja2 syntax without double braces: `when: ansible_os_family == "Debian"`
    - **Loop variable naming**: Don't name loop vars `item` if nesting loops
    - **SSH host key checking**: Disable in ansible.cfg or pre-populate known_hosts
    - **Python dependencies**: Modules may require Python packages on managed nodes
    - **Fact caching**: Cache facts to speed up subsequent runs (Redis, JSON file)
    - **Delegated execution**: `delegate_to: localhost` runs task on control node
    - **Serial execution**: Use `serial: 1` for rolling deployments

    **Anti-Patterns (Don't Do This):**

    - ❌ Massive monolithic playbooks (break into roles)
    - ❌ Hardcoded values (use variables and group_vars)
    - ❌ Ignoring errors everywhere (`ignore_errors: yes` is code smell)
    - ❌ Shell commands for everything (use native modules when possible)
    - ❌ No version control (git is mandatory)
    - ❌ Running playbooks manually in production (use CI/CD)

______________________________________________________________________

## Learning Paths

### 🎓 Official Resources

- **[Ansible Documentation](https://docs.ansible.com/)** - Comprehensive, well-written, actually useful (rare for vendor docs)
- **[Ansible Getting Started](https://docs.ansible.com/ansible/latest/getting_started/index.html)** - Begin here, covers core concepts
- **[Ansible Best Practices](https://docs.ansible.com/ansible/latest/tips_tricks/ansible_tips_tricks.html)** - Official wisdom from the trenches
- **[Ansible Galaxy](https://galaxy.ansible.com/)** - Community roles and collections (quality varies wildly)

### 🎥 Video Learning

- **[Jeff Geerling's Ansible 101](https://www.youtube.com/playlist?list=PL2_OBreMn7FqZkvMYt6ATmgC0KAGGJNAN)** - Best YouTube series, practical and honest
- **[Red Hat Ansible Automation](https://www.youtube.com/@AnsibleAutomation)** - Official channel, enterprise-focused but solid

### 📚 Books Worth Reading

- **[Ansible for DevOps](https://www.ansiblefordevops.com/)** by Jeff Geerling - The canonical reference
- **[Ansible: Up and Running](https://www.ansiblebook.com/)** by Lorin Hochstein - Excellent second book

### 🧪 Hands-On Labs

- **[Ansible Interactive Labs](https://www.ansible.com/products/ansible-training)** - Official Red Hat labs (some free)
- **[Katacoda Ansible Scenarios](https://www.katacoda.com/courses/ansible)** - Browser-based practice (if still active)
- **[DigitalOcean Ansible Tutorials](https://www.digitalocean.com/community/tags/ansible)** - Practical, real-world focused

### 🎓 Certification

- **[Red Hat Certified Specialist in Ansible Automation (EX294)](https://www.redhat.com/en/services/training/ex294-red-hat-certified-engineer-rhce-exam-red-hat-enterprise-linux-8)** - Respected credential if you're into that

______________________________________________________________________

## Ansible vs The World

### Configuration Management Showdown

| Feature              | Ansible                        | Puppet                       | Chef                   | SaltStack                    |
| :------------------- | :----------------------------- | :--------------------------- | :--------------------- | :--------------------------- |
| **Architecture**     | Agentless (SSH)                | Agent-based                  | Agent-based            | Agent-based (also agentless) |
| **Language**         | YAML                           | Puppet DSL (Ruby)            | Ruby DSL               | YAML + Python                |
| **Learning Curve**   | Easy                           | Steep                        | Steeper                | Medium                       |
| **Execution**        | Push (procedural)              | Pull (declarative)           | Pull (declarative)     | Push or Pull                 |
| **Speed**            | Slower (SSH overhead)          | Fast (compiled)              | Fast                   | Fastest (ZeroMQ)             |
| **State Management** | None (stateless)               | Centralized                  | Centralized            | Centralized                  |
| **Windows Support**  | Yes (WinRM)                    | Limited                      | Yes                    | Yes                          |
| **Community**        | Massive                        | Large but declining          | Medium, declining      | Small                        |
| **Ownership**        | Red Hat                        | Perforce                     | Progress Chef          | VMware (dead)                |
| **Best For**         | Quick wins, small-medium scale | Large enterprise, compliance | Developer-centric orgs | Speed, event-driven (RIP)    |

### When NOT to Use Ansible

**Terraform territory:**

- Provisioning cloud infrastructure (EC2, VPCs, S3)
- Managing cloud-native resources with state dependencies
- Multi-cloud orchestration with unified state

**Use both:** Terraform creates infra, Ansible configures it (Day 0 vs Day 1+).

**Too slow for your scale:**

- 10,000+ nodes? Consider Salt or custom tooling
- Real-time event response? Salt was better (VMware killed it)
- Pull-based model needed? Puppet still exists

**Not actually configuration management:**

- Kubernetes workloads (use Helm, Kustomize)
- Container orchestration (that's K8s' job)
- Service mesh config (use operator patterns)

### The Honest Take

**Ansible wins because:**

- No agents = no agent failures, no agent upgrades, no agent drift
- YAML is readable by humans (mostly)
- Ad-hoc execution is a superpower for ops
- Community momentum is unstoppable
- Red Hat backing means it's not disappearing

**Ansible loses because:**

- SSH overhead makes it slow at scale
- No persistent state means no rollback mechanisms
- Procedural model can create messy playbooks
- YAML hell is real (whitespace nightmares)
- Not truly idempotent without careful design

**Reality:** Ansible won the config management wars not by being best, but by being easiest. In infrastructure automation, adoption beats perfection. Every. Single. Time.

______________________________________________________________________

## Production Patterns

### Directory Structure (Best Practice)

```text
ansible-project/
├── ansible.cfg              # Project config
├── inventory/
│   ├── production/
│   │   ├── hosts.ini       # Production inventory
│   │   └── group_vars/
│   │       ├── all.yml     # Global vars
│   │       └── webservers.yml
│   └── staging/
│       ├── hosts.ini
│       └── group_vars/
├── roles/
│   ├── common/             # Base role for all servers
│   ├── webserver/
│   ├── database/
│   └── requirements.yml    # External role dependencies
├── playbooks/
│   ├── site.yml           # Master playbook
│   ├── deploy.yml         # Application deployment
│   └── provision.yml      # Server provisioning
├── group_vars/
│   ├── all.yml            # Variables for all hosts
│   └── production.yml     # Production-specific vars
├── host_vars/
│   └── special-server.yml # Host-specific overrides
├── files/                 # Static files to copy
├── templates/             # Jinja2 templates
├── vault/
│   └── secrets.yml        # Encrypted secrets (Vault)
└── scripts/               # Helper scripts
```

### ansible.cfg (Production Ready)

```ini
[defaults]
inventory = inventory/production/hosts.ini
remote_user = ansible
private_key_file = ~/.ssh/ansible_id_rsa
host_key_checking = False
retry_files_enabled = False
gathering = smart
fact_caching = jsonfile
fact_caching_connection = /tmp/ansible_fact_cache
fact_caching_timeout = 3600
callback_whitelist = profile_tasks, timer
forks = 20
timeout = 30

[ssh_connection]
pipelining = True
ssh_args = -o ControlMaster=auto -o ControlPersist=600s

[privilege_escalation]
become = True
become_method = sudo
become_user = root
become_ask_pass = False
```

### CI/CD Integration

#### GitHub Actions

```yaml
name: Ansible Deployment

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Install Ansible
        run: |
          pip install ansible
          ansible-galaxy install -r roles/requirements.yml

      - name: Configure SSH
        run: |
          mkdir -p ~/.ssh
          echo "${{ secrets.SSH_PRIVATE_KEY }}" > ~/.ssh/id_rsa
          chmod 600 ~/.ssh/id_rsa
          ssh-keyscan -H ${{ secrets.DEPLOY_HOST }} >> ~/.ssh/known_hosts

      - name: Run playbook
        run: |
          ansible-playbook playbooks/deploy.yml \
            --vault-password-file <(echo "${{ secrets.VAULT_PASSWORD }}")
        env:
          ANSIBLE_HOST_KEY_CHECKING: False
```

#### GitLab CI

```yaml
stages:
  - validate
  - deploy

variables:
  ANSIBLE_HOST_KEY_CHECKING: "False"

validate:
  stage: validate
  image: cytopia/ansible:latest
  script:
    - ansible-playbook playbooks/site.yml --syntax-check
    - ansible-lint playbooks/site.yml
  only:
    - merge_requests

deploy_production:
  stage: deploy
  image: cytopia/ansible:latest
  before_script:
    - eval $(ssh-agent -s)
    - echo "$SSH_PRIVATE_KEY" | ssh-add -
    - mkdir -p ~/.ssh
  script:
    - ansible-playbook playbooks/deploy.yml
      --inventory inventory/production/hosts.ini
      --vault-password-file <(echo "$VAULT_PASSWORD")
  only:
    - main
  when: manual
```

#### Jenkins Pipeline

```groovy
pipeline {
    agent any

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Validate') {
            steps {
                sh 'ansible-playbook playbooks/site.yml --syntax-check'
                sh 'ansible-lint playbooks/'
            }
        }

        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                withCredentials([
                    sshUserPrivateKey(credentialsId: 'ansible-ssh-key', keyFileVariable: 'SSH_KEY'),
                    string(credentialsId: 'vault-password', variable: 'VAULT_PASS')
                ]) {
                    sh """
                        ansible-playbook playbooks/deploy.yml \\
                            --private-key=\$SSH_KEY \\
                            --vault-password-file <(echo "\$VAULT_PASS")
                    """
                }
            }
        }
    }
}
```

### Real-World Use Cases

**Server Provisioning (Day 1):**

```yaml
---
- name: Provision new web server
  hosts: new_webservers
  become: yes

  roles:
    - common                    # Base packages, users, SSH hardening
    - security                  # Firewall, fail2ban, SELinux
    - monitoring                # Prometheus node_exporter, logs
    - webserver                 # Nginx, SSL, configs
    - { role: app, app_env: production }
```

**Application Deployment:**

```yaml
---
- name: Deploy web application
  hosts: webservers
  serial: 2                    # Rolling deployment (2 at a time)
  max_fail_percentage: 0       # Stop on first failure

  pre_tasks:
    - name: Remove from load balancer
      community.general.haproxy:
        state: disabled
        host: "{{ inventory_hostname }}"
      delegate_to: "{{ item }}"
      loop: "{{ groups['loadbalancers'] }}"

  tasks:
    - name: Pull latest code
      ansible.builtin.git:
        repo: 'https://github.com/company/app.git'
        dest: /var/www/app
        version: "{{ app_version | default('main') }}"
      notify: restart app

    - name: Install dependencies
      ansible.builtin.pip:
        requirements: /var/www/app/requirements.txt
        virtualenv: /var/www/app/venv

    - name: Run database migrations
      ansible.builtin.command:
        cmd: /var/www/app/venv/bin/python manage.py migrate
      run_once: yes

  post_tasks:
    - name: Add back to load balancer
      community.general.haproxy:
        state: enabled
        host: "{{ inventory_hostname }}"
      delegate_to: "{{ item }}"
      loop: "{{ groups['loadbalancers'] }}"

    - name: Health check
      ansible.builtin.uri:
        url: "http://{{ inventory_hostname }}/health"
        status_code: 200
      retries: 5
      delay: 10
```

**Disaster Recovery:**

```yaml
---
- name: Restore from backup
  hosts: db_servers
  become: yes

  tasks:
    - name: Stop database service
      ansible.builtin.systemd:
        name: postgresql
        state: stopped

    - name: Download backup from S3
      amazon.aws.s3_object:
        bucket: backups
        object: "postgres/{{ backup_date }}/backup.tar.gz"
        dest: /tmp/backup.tar.gz
        mode: get

    - name: Restore data directory
      ansible.builtin.unarchive:
        src: /tmp/backup.tar.gz
        dest: /var/lib/postgresql/
        remote_src: yes

    - name: Start database service
      ansible.builtin.systemd:
        name: postgresql
        state: started

    - name: Verify restoration
      community.postgresql.postgresql_query:
        query: SELECT COUNT(*) FROM users;
      register: row_count
      failed_when: row_count.query_result[0].count < 1000
```

______________________________________________________________________

## Advanced Techniques

### Dynamic Inventory (AWS)

```yaml
# aws_ec2.yml (dynamic inventory plugin)
plugin: amazon.aws.aws_ec2
regions:
  - us-east-1
  - us-west-2
filters:
  instance-state-name: running
  tag:Environment: production
keyed_groups:
  - key: tags.Role
    prefix: role
  - key: placement.availability_zone
    prefix: az
hostnames:
  - tag:Name
  - private-ip-address
compose:
  ansible_host: private_ip_address
```

```bash
# Use dynamic inventory
ansible-playbook -i aws_ec2.yml playbooks/site.yml
```

### Ansible Vault Workflows

```bash
# Create encrypted file
ansible-vault create vault/secrets.yml

# Edit encrypted file
ansible-vault edit vault/secrets.yml

# Encrypt existing file
ansible-vault encrypt group_vars/production.yml

# View encrypted file
ansible-vault view vault/secrets.yml

# Rekey (change password)
ansible-vault rekey vault/secrets.yml

# Encrypt specific variables inline
ansible-vault encrypt_string 'secret_password' --name 'db_password'
```

### Testing with Molecule

```bash
# Install Molecule
pip install molecule molecule-docker ansible-lint

# Initialize new role with tests
molecule init role my_role --driver-name docker

# Run tests
cd my_role
molecule test

# Test sequence: create → converge → verify → destroy
molecule converge  # Run playbook
molecule verify    # Run tests
molecule destroy   # Clean up
```

______________________________________________________________________

## Community Pulse

### 🐦 Who to Follow

- **[@ansible](https://twitter.com/ansible)** - Official account (Red Hat marketing)
- **[@geerlingguy](https://twitter.com/geerlingguy)** - Jeff Geerling, Ansible MVP, legend
- **[@nixcraft](https://twitter.com/nixcraft)** - Linux/DevOps wisdom, frequent Ansible tips

### 💬 Active Communities

- **[Ansible Forum](https://forum.ansible.com/)** - Official, active, helpful (rare combo)
- **[r/ansible](https://reddit.com/r/ansible)** - 50k members, mix of beginners and experts
- **[Ansible Matrix Chat](https://matrix.to/#/#ansible:ansible.com)** - Real-time help
- **[Stack Overflow](https://stackoverflow.com/questions/tagged/ansible)** - 40k+ questions

### 📝 Essential Blogs

- **[Jeff Geerling's Blog](https://www.jeffgeerling.com/)** - Best Ansible content, period
- **[Ansible Blog](https://www.ansible.com/blog)** - Official Red Hat blog (skip the marketing)
- **[Dev.to #ansible](https://dev.to/t/ansible)** - Community tutorials and experiences

______________________________________________________________________

## Worth Checking

<div class="grid cards" markdown>

- 📚 __Official Docs__

    ______________________________________________________________________

    **[Ansible Documentation](https://docs.ansible.com/)** Actually readable, comprehensive, frequently updated

    **[Ansible Galaxy](https://galaxy.ansible.com/)** Community roles—quality varies, read code before using

    **[GitHub: ansible/ansible](https://github.com/ansible/ansible)** 67k stars, 24k forks, 5k contributors—the source

    **[Ansible Collections Index](https://docs.ansible.com/ansible/latest/collections/index.html)** Official modules and plugins by vendor

- 🧪 __Hands-On Learning__

    ______________________________________________________________________

    **[DigitalOcean Ansible Tutorials](https://www.digitalocean.com/community/tags/ansible)** Practical, real-world focused, excellent for beginners

    **[Ansible for DevOps Examples](https://github.com/geerlingguy/ansible-for-devops)** Jeff Geerling's book companion repo—gold mine

    **[Awesome Ansible](https://github.com/ansible-community/awesome-ansible)** Curated list of tools, roles, tutorials

    **[Ansible Examples](https://github.com/ansible/ansible-examples)** Official example playbooks (somewhat outdated but useful)

- 💻 __Tools & Extensions__

    ______________________________________________________________________

    **[ansible-lint](https://github.com/ansible/ansible-lint)** Best practice checker—use it, fix warnings

    **[Molecule](https://github.com/ansible/molecule)** Test framework for roles—write tests, catch bugs

    **[AWX](https://github.com/ansible/awx)** Web UI and REST API—upstream for Ansible Tower

    **[Semaphore](https://www.ansible-semaphore.com/)** Modern web UI alternative to AWX (lightweight)

- 🔥 __Deep Dives & War Stories__

    ______________________________________________________________________

    **[Ansible Best Practices](https://docs.ansible.com/ansible/latest/tips_tricks/ansible_tips_tricks.html)** Official wisdom—read this before writing production playbooks

    **[How Ansible Works](https://www.ansible.com/overview/how-ansible-works)** Architecture explained, understand before scaling

    **[Ansible vs Terraform](https://spacelift.io/blog/ansible-vs-terraform)** Honest comparison, use cases, when to use both

    **[Ansible Performance Tuning](https://www.redhat.com/sysadmin/ansible-performance-tuning)** Scale beyond 100 nodes without suffering

</div>

______________________________________________________________________

## Ecosystem & Collections

### Essential Collections

```yaml
# requirements.yml
collections:
  # Cloud providers
  - name: amazon.aws
    version: ">=7.0.0"
  - name: azure.azcollection
    version: ">=2.0.0"
  - name: google.cloud
    version: ">=1.2.0"

  # Containers & orchestration
  - name: kubernetes.core
    version: ">=3.0.0"
  - name: community.docker
    version: ">=3.4.0"

  # Networking
  - name: cisco.ios
    version: ">=5.0.0"
  - name: arista.eos
    version: ">=6.0.0"

  # General utilities
  - name: community.general
    version: ">=8.0.0"
  - name: ansible.posix
    version: ">=1.5.0"
```

```bash
# Install collections
ansible-galaxy collection install -r requirements.yml
```

### Module Highlights (Built-in Gems)

**System:**

- `ansible.builtin.systemd` - Service management
- `ansible.builtin.user` - User accounts
- `ansible.builtin.cron` - Cron jobs
- `ansible.builtin.mount` - Filesystem mounts

**Files:**

- `ansible.builtin.copy` - Copy files
- `ansible.builtin.template` - Jinja2 templating
- `ansible.builtin.file` - File/directory properties
- `ansible.builtin.lineinfile` - Edit specific lines

**Packages:**

- `ansible.builtin.package` - OS-agnostic package manager
- `ansible.builtin.yum` / `ansible.builtin.apt` - Distro-specific
- `ansible.builtin.pip` - Python packages

**Commands:**

- `ansible.builtin.command` - Execute commands (no shell processing)
- `ansible.builtin.shell` - Execute shell commands (with pipes, redirects)
- `ansible.builtin.script` - Run local script on remote

**Cloud:**

- `amazon.aws.ec2_instance` - Manage EC2 instances
- `azure.azcollection.azure_rm_virtualmachine` - Azure VMs
- `google.cloud.gcp_compute_instance` - GCP instances

**When to use `shell` vs `command`:**

- Prefer `command` (safer, no shell injection)
- Use `shell` when you need pipes, redirects, shell variables
- Both are code smells—native modules are better

______________________________________________________________________

**Last Updated:** 2026-01-14

**Vibe Check:** 🔥 **Dominant** — Ansible reigns as the undisputed king of configuration management. Not because it's the best technically (it's not), but because it's the easiest to adopt and hardest to justify replacing. Red Hat's backing ensures longevity. The agentless model aged like wine while agent-based competitors aged like milk.

**Realm Status:** Mature, battle-tested, ubiquitous. Every DevOps engineer knows it, most production environments run it, and it's not going anywhere. The YAML may drive you insane and SSH overhead may test your patience, but when you need to configure 50 servers in 10 minutes, Ansible delivers. Like the old gods—simple, reliable, occasionally frustrating, ultimately essential.
