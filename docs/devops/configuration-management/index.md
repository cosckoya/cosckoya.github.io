---
title: Configuration Management
description: Comprehensive guide to configuration management tools including Ansible, Puppet, Chef, and SaltStack for automated server provisioning and configuration
tags:
  - configuration-management
  - ansible
  - puppet
  - chef
  - saltstack
  - devops
---

# Configuration Management

Configuration management tools enable consistent, automated, and repeatable server configuration across your infrastructure. They ensure servers are configured correctly and maintain desired state over time.

!!! abstract "Core Concepts"
    - **Idempotency**: Apply configurations multiple times safely without side effects
    - **Declarative**: Define desired state, not procedural steps
    - **Inventory**: Manage groups of servers and their properties
    - **Automation**: Eliminate manual configuration drift

---

## Why Configuration Management?

**Problems with Manual Configuration**:

- Configuration drift between servers
- Time-consuming, error-prone manual processes
- Difficulty replicating environments
- No audit trail of changes
- Inconsistent application deployment

**Configuration Management Benefits**:

- **Consistency**: All servers configured identically
- **Speed**: Provision and configure servers in minutes
- **Version Control**: Track all configuration changes
- **Disaster Recovery**: Rebuild servers quickly
- **Compliance**: Enforce security policies automatically

---

## Ansible

**Agentless automation** using SSH with simple YAML syntax.

### Ansible Core Concepts

**Agentless**: No software to install on managed nodes - uses SSH for Linux, WinRM for Windows.

**Playbooks**: YAML files that define automation tasks.

**Inventory**: List of managed hosts and groups.

**Modules**: Reusable units of code for specific tasks (package installation, service management, etc.).

**Roles**: Organized collections of playbooks, variables, files, and templates.

### Ansible Strengths

- **Easy to Learn**: Simple YAML syntax, no programming required
- **No Agents**: SSH-based, no additional software on managed nodes
- **Idempotent**: Safe to run playbooks multiple times
- **Large Ecosystem**: Thousands of modules for common tasks
- **Push-Based**: Control node pushes configuration to managed nodes

### Ansible Use Cases

- Server provisioning and configuration
- Application deployment
- Orchestration workflows
- Security and compliance automation

### Example: Ansible Playbook

```yaml
---
- name: Configure web servers
  hosts: webservers
  become: yes
  vars:
    http_port: 80
    max_clients: 200

  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Copy nginx configuration
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
        owner: root
        group: root
        mode: '0644'
      notify: Restart nginx

    - name: Ensure nginx is running
      service:
        name: nginx
        state: started
        enabled: yes

    - name: Open firewall for HTTP
      ufw:
        rule: allow
        port: '80'
        proto: tcp

  handlers:
    - name: Restart nginx
      service:
        name: nginx
        state: restarted
```

### Ansible Inventory Example

```ini
# inventory/hosts
[webservers]
web1.example.com ansible_host=192.168.1.10
web2.example.com ansible_host=192.168.1.11

[dbservers]
db1.example.com ansible_host=192.168.1.20
db2.example.com ansible_host=192.168.1.21

[production:children]
webservers
dbservers

[production:vars]
ansible_user=deploy
ansible_ssh_private_key_file=~/.ssh/deploy_key
```

### Ansible Commands

```bash
# Run ad-hoc command
ansible webservers -m ping

# Run playbook
ansible-playbook site.yml

# Check playbook syntax
ansible-playbook site.yml --syntax-check

# Dry run (check mode)
ansible-playbook site.yml --check

# Run with specific inventory
ansible-playbook -i inventory/hosts site.yml

# Limit to specific hosts
ansible-playbook site.yml --limit web1.example.com

# Verbose output
ansible-playbook site.yml -vvv
```

### Ansible Best Practices

=== "Role Structure"
    Organize playbooks into reusable roles:

    ```
    roles/
      webserver/
        tasks/
          main.yml
        handlers/
          main.yml
        templates/
          nginx.conf.j2
        files/
          index.html
        vars/
          main.yml
        defaults/
          main.yml
        meta/
          main.yml
    ```

=== "Variable Precedence"
    Understand variable priority (lowest to highest):

    1. role defaults
    2. inventory vars
    3. playbook vars
    4. extra vars (`-e` on command line)

=== "Secrets Management"
    Use Ansible Vault for sensitive data:

    ```bash
    # Encrypt file
    ansible-vault encrypt secrets.yml

    # Run with vault password
    ansible-playbook site.yml --ask-vault-pass

    # Encrypt specific string
    ansible-vault encrypt_string 'secret_password' --name 'db_password'
    ```

### Ansible Resources

- [Ansible Documentation](https://docs.ansible.com/)
- [Ansible Galaxy](https://galaxy.ansible.com/) - Role repository
- [Ansible Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)

---

## Puppet

**Agent-based** declarative configuration management with pull-based architecture.

### Puppet Core Concepts

**Puppet Master**: Central server that stores configurations.

**Puppet Agent**: Runs on managed nodes, pulls configuration from master.

**Manifests**: Files defining desired state (`.pp` files).

**Resources**: Individual configuration items (packages, files, services).

**Puppet Forge**: Community repository of pre-built modules.

### Puppet Strengths

- **Mature**: Enterprise-grade, battle-tested
- **Strong Compliance**: Detailed reporting and auditing
- **Pull-Based**: Agents periodically check for configuration updates
- **Ruby DSL**: Powerful domain-specific language
- **Enterprise Support**: Commercial support available

### Puppet Use Cases

- Large-scale infrastructure (1000+ servers)
- Compliance and governance requirements
- Enterprise environments with strict change management
- Windows and Linux mixed environments

### Example: Puppet Manifest

```puppet
# Install and configure Apache
class apache {
  # Install Apache package
  package { 'apache2':
    ensure => installed,
  }

  # Manage Apache configuration
  file { '/etc/apache2/apache2.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/apache/apache2.conf',
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

  # Ensure Apache is running
  service { 'apache2':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/apache2/apache2.conf'],
  }
}

# Apply the class
include apache
```

### Puppet Resources

- [Puppet Documentation](https://puppet.com/docs/)
- [Puppet Forge](https://forge.puppet.com/) - Module repository

---

## Chef

**Agent-based** configuration management using Ruby for infrastructure as code.

### Chef Core Concepts

**Chef Server**: Central hub for cookbooks and node data.

**Chef Client**: Agent on managed nodes that applies configurations.

**Cookbooks**: Packages of recipes, templates, files, and resources.

**Recipes**: Ruby files defining configuration steps.

**Test Kitchen**: Tool for testing cookbooks in isolation.

### Chef Strengths

- **Flexible**: Powerful Ruby DSL for complex logic
- **Test-Driven**: Built-in testing with Test Kitchen
- **Version Control**: Strong Git integration
- **Cloud Integration**: Excellent support for cloud platforms

### Chef Use Cases

- Complex infrastructure automation
- DevOps-centric organizations
- Cloud and on-premise hybrid environments
- Organizations with Ruby expertise

### Example: Chef Recipe

```ruby
# Install and configure nginx
package 'nginx' do
  action :install
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[nginx]'
end

service 'nginx' do
  action [:enable, :start]
  supports status: true, restart: true, reload: true
end

# Create custom index page
file '/var/www/html/index.html' do
  content '<h1>Welcome to My Website</h1>'
  owner 'www-data'
  group 'www-data'
  mode '0644'
end
```

### Chef Resources

- [Chef Documentation](https://docs.chef.io/)
- [Chef Supermarket](https://supermarket.chef.io/) - Cookbook repository

---

## SaltStack

**Event-driven** automation with Python-based configuration management.

### SaltStack Core Concepts

**Salt Master**: Control server managing configurations.

**Salt Minions**: Agents on managed nodes.

**States**: YAML files defining desired configuration (SLS files).

**Grains**: System information about minions.

**Pillars**: Secure, targeted data for specific minions.

### SaltStack Strengths

- **Fast**: Uses ZeroMQ for high-speed communication
- **Scalable**: Handles tens of thousands of nodes
- **Remote Execution**: Immediate command execution
- **Event-Driven**: React to infrastructure events in real-time
- **Python-Based**: Extensible with Python

### SaltStack Use Cases

- Very large-scale environments
- Real-time orchestration and event response
- High-performance requirements
- Python-centric organizations

### Example: Salt State

```yaml
# Install and configure nginx
nginx:
  pkg.installed: []
  service.running:
    - enable: True
    - watch:
      - file: /etc/nginx/nginx.conf

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/files/nginx.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx
```

### SaltStack Resources

- [SaltStack Documentation](https://docs.saltproject.io/)

---

## Comparison: Choosing the Right Tool

| Tool | Architecture | Language | Learning Curve | Best For |
|------|--------------|----------|----------------|----------|
| **Ansible** | Agentless (SSH) | YAML | Easy | Small to medium infrastructure, quick start |
| **Puppet** | Agent-based (pull) | Ruby DSL | Moderate | Large enterprise, compliance-heavy |
| **Chef** | Agent-based (pull) | Ruby | Steep | Complex automation, dev-heavy teams |
| **SaltStack** | Agent-based (push/pull) | YAML/Python | Moderate | Very large scale, event-driven |

### Decision Guide

**Choose Ansible if:**

- You want to get started quickly
- You prefer agentless architecture
- Your team prefers YAML over code
- You have small to medium infrastructure

**Choose Puppet if:**

- You need enterprise-grade compliance reporting
- You manage very large infrastructure (1000+ servers)
- You require commercial support
- Pull-based model fits your security requirements

**Choose Chef if:**

- Your team has strong Ruby skills
- You need test-driven infrastructure
- You want maximum flexibility and power
- You're deeply invested in DevOps culture

**Choose SaltStack if:**

- You manage tens of thousands of nodes
- You need real-time event-driven automation
- Performance and scalability are critical
- Your team prefers Python

---

## Best Practices

=== "Idempotency"
    - Always write idempotent configurations
    - Test by running multiple times
    - Avoid commands that cause state changes
    - Use built-in modules over shell commands

=== "Version Control"
    - Store all configuration code in Git
    - Use feature branches for changes
    - Require code reviews for production
    - Tag releases for rollback capability

=== "Testing"
    - Test in dev/staging before production
    - Use linters (ansible-lint, puppet-lint)
    - Implement automated testing (Test Kitchen, Molecule)
    - Validate syntax before committing

=== "Secrets Management"
    - Never commit secrets to version control
    - Use encryption (Ansible Vault, encrypted data bags)
    - Integrate with secret management services
    - Rotate secrets regularly

=== "Documentation"
    - Document roles, playbooks, and cookbooks
    - Maintain README files for each role
    - Comment complex logic
    - Keep runbooks updated

---

## Learning Path

### Beginner

1. **Start with Ansible**: Easiest learning curve
2. **Simple Tasks**: Install packages, manage files, start services
3. **Inventory Management**: Organize hosts into groups
4. **Basic Playbooks**: Write your first automated configuration

### Intermediate

1. **Roles**: Organize playbooks into reusable roles
2. **Templates**: Use Jinja2 templates for dynamic configuration
3. **Variables**: Master variable precedence and scoping
4. **Handlers**: Implement proper service restart patterns

### Advanced

1. **Custom Modules**: Write your own modules
2. **Dynamic Inventory**: Integrate with cloud providers
3. **CI/CD Integration**: Automate testing and deployment
4. **Multi-Tool Strategy**: Combine CM with IaC tools

---

## Related Topics

- [Infrastructure as Code](../iac/) - Terraform, CloudFormation for infrastructure provisioning
- [CI/CD](../ci-cd/) - Integrate configuration management into pipelines
- [DevSecOps](../devsecops/) - Security in configuration management
- [SysAdmin](../../sysadmin/) - Foundation for server management
