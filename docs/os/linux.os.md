---
title: Linux
description: Linux reference - open source Unix-like OS powering servers, containers, and the cloud
---

# :fontawesome-solid-terminal: Linux

Open source Unix-like operating system. Powers 90%+ of cloud infrastructure, every container, and most embedded systems. Free as in freedom and free as in beer. Hundreds of distributions (you'll use Ubuntu, Debian, or RHEL family). Learning curve exists but worth climbing.

!!! tip "2026 Update"
    Linux dominates cloud and containers. Focus on systemd, networking, package management, and shell scripting. WSL2 made Linux essential even for Windows developers. Understanding Linux internals is a career multiplier.

______________________________________________________________________

## :fontawesome-solid-bolt: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # File operations
    ls -lah                    # List files with hidden ones
    find /path -name "*.log"   # Find files by pattern
    grep -r "pattern" /path    # Search in files recursively

    # System information
    uname -a                   # Kernel and system info
    top                        # Process monitor (use htop if available)
    df -h                      # Disk space usage
    free -h                    # Memory usage

    # Process management
    ps aux | grep nginx        # Find processes
    kill -9 PID                # Force kill process
    systemctl status nginx     # Check service status
    journalctl -u nginx -f     # Follow service logs

    # Package management (Ubuntu/Debian)
    apt update && apt upgrade  # Update packages
    apt install package-name   # Install package
    apt search keyword         # Search for packages

    # Package management (RHEL/CentOS/Fedora)
    dnf update                 # Update packages
    dnf install package-name   # Install package
    dnf search keyword         # Search for packages

    # Networking
    ip addr show               # Show IP addresses
    ss -tuln                   # Show listening ports
    curl -I https://example.com # Check HTTP headers
    ping -c 4 8.8.8.8          # Test connectivity
    ```

    **Real talk:**

    - Master the command line - GUI is training wheels
    - Learn systemd - it's everywhere now whether you like it or not
    - Understand file permissions (chmod, chown) - security basics
    - Use SSH keys, not passwords - generate with `ssh-keygen`
    - Read logs in /var/log - that's where problems reveal themselves

=== ":fontawesome-solid-bolt: Common Patterns"

    ```bash
    # SSH configuration (~/.ssh/config)
    Host myserver
        HostName 192.168.1.100
        User admin
        Port 2222
        IdentityFile ~/.ssh/id_rsa

    # Then connect with: ssh myserver

    # Systemd service management
    sudo systemctl start nginx      # Start service
    sudo systemctl enable nginx     # Auto-start on boot
    sudo systemctl restart nginx    # Restart service
    sudo systemctl status nginx     # Check status

    # Log monitoring
    journalctl -xe                  # Recent logs with explanations
    journalctl -u nginx --since today  # Today's nginx logs
    tail -f /var/log/syslog        # Follow system log

    # Disk usage investigation
    du -sh /*                       # Size of root directories
    ncdu /                          # Interactive disk usage (install ncdu)

    # Finding large files
    find / -type f -size +100M 2>/dev/null
    ```

    **Why this works:**

    - SSH config eliminates repetitive typing
    - systemd is standard init system since 2015
    - journalctl provides structured logging
    - Understanding disk usage prevents surprises

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Productivity Boosters"
        - **tmux/screen** - Terminal multiplexing, survive disconnects
        - **zsh + oh-my-zsh** - Better shell experience than bash
        - **vim/neovim** - Learn the basics, it's on every server
        - **fzf** - Fuzzy finder for command history and files
        - **bat** - Better cat with syntax highlighting
        - **exa** - Modern replacement for ls

    !!! warning "Security Essentials"
        - **Never run as root** - Use sudo for privileged operations
        - **SSH key authentication only** - Disable password auth in /etc/ssh/sshd_config
        - **Firewall always on** - ufw (Ubuntu) or firewalld (RHEL)
        - **Keep system updated** - Set up unattended-upgrades
        - **fail2ban** - Auto-ban brute force attempts
        - **Check /var/log/auth.log** - Monitor authentication attempts

    !!! tip "Performance"
        - **Use systemd timers** - Instead of cron (better logging)
        - **Monitor with netdata** - Real-time performance monitoring
        - **Tune swappiness** - Set to 10 for desktops, 1 for servers
        - **Use tmpfs for temporary files** - RAM-based file system
        - **Enable SSD TRIM** - `sudo systemctl enable fstrim.timer`

    !!! danger "Common Gotchas"
        - **/tmp cleanup** - Some distros auto-delete old files
        - **OOM killer** - Will kill processes when out of memory
        - **File descriptor limits** - Check with `ulimit -n`, increase if needed
        - **Timezone issues** - Set with `timedatectl set-timezone`
        - **SELinux/AppArmor** - Can block legitimate actions, check logs first

______________________________________________________________________

## :fontawesome-solid-book: Learning Resources

### :fontawesome-solid-graduation-cap: Free Resources

- **[Linux Journey](https://linuxjourney.com/)** - Interactive tutorials, beginner-friendly
- **[The Linux Documentation Project](https://tldp.org/)** - Comprehensive guides
- **[ArchWiki](https://wiki.archlinux.org/)** - Best documentation for any distro
- **[linuxcommand.org](https://linuxcommand.org/)** - Command line basics

### :fontawesome-solid-microchip: Distribution Choices

!!! success "Server Use"
    - **Ubuntu Server LTS** - Most popular, 5 years support, massive community
    - **Debian** - Stable, packages tested extensively
    - **RHEL/Rocky/AlmaLinux** - Enterprise standard, 10 years support
    - **Alpine Linux** - Tiny footprint, perfect for containers

!!! example "Desktop Use"
    - **Ubuntu Desktop** - Just works, large software repos
    - **Fedora** - Cutting edge, Red Hat sponsored
    - **Pop!_OS** - Ubuntu-based, excellent for developers
    - **Linux Mint** - Windows-like experience, beginner-friendly

______________________________________________________________________

## :octicons-shield-check-16: Security Audit Tools

Tools for system hardening audits, privilege escalation detection, and security posture assessment. Run these before bad actors do.

### :fontawesome-solid-list-check: Tool Overview

| Tool | Purpose | Type | Best For |
|------|---------|------|----------|
| **Lynis** | Comprehensive hardening audit | OSS | System health checks, compliance scanning |
| **LinPEAS** | Privilege escalation enumeration | OSS | Finding attack paths, pentesting, CTFs |
| **Osquery** | SQL-based system introspection | OSS | Fleet-wide auditing, threat hunting |
| **Rkhunter** | Rootkit and backdoor detection | OSS | Malware detection, incident response |

### :fontawesome-solid-gear: Installation & Usage

=== "Lynis - System Hardening Audit"

    ```bash
    # Installation (Ubuntu/Debian)
    sudo apt install lynis

    # Installation (RHEL/CentOS/Fedora)
    sudo dnf install lynis

    # Or use latest from GitHub
    git clone https://github.com/CISOfy/lynis
    cd lynis
    sudo ./lynis audit system

    # Basic system audit (generates detailed report)
    sudo lynis audit system

    # Audit with custom profile
    sudo lynis audit system --profile /etc/lynis/custom.prf

    # Quick scan (no wait between tests)
    sudo lynis audit system --quick

    # Output to log file
    sudo lynis audit system --logfile /var/log/lynis.log

    # Check for updates
    sudo lynis update info
    ```

    **What it does:**

    - Scans 200+ security controls (SSH config, file permissions, kernel parameters)
    - Checks hardening opportunities (ASLR, compiler protections, logging)
    - Validates compliance baselines (PCI-DSS, HIPAA, ISO27001)
    - Identifies misconfigurations and weak settings
    - Generates actionable hardening recommendations

    **Real talk:**

    - Run on every new server before production deployment
    - Hardening index <70 means you have work to do
    - Review `/var/log/lynis.log` for detailed findings
    - Automate with cron for continuous monitoring
    - Not a vulnerability scanner - it checks configuration only

=== "LinPEAS - Privilege Escalation"

    ```bash
    # Download and run (always get latest version)
    curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh | sh

    # Or download, review, then execute
    wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh
    chmod +x linpeas.sh
    ./linpeas.sh

    # Save output to file (recommended - long output)
    ./linpeas.sh -a > linpeas_report.txt

    # Fast mode (skip some checks)
    ./linpeas.sh -q

    # Stealth mode (avoid detection)
    ./linpeas.sh -s

    # Check specific privilege escalation vectors
    ./linpeas.sh -o SysI,Devs  # System info + devices only
    ```

    **What it does:**

    - Enumerates SUID/SGID binaries (common privesc vector)
    - Checks writable files in PATH
    - Identifies sudo misconfigurations
    - Scans for kernel exploits (DirtyCOW, etc.)
    - Finds credentials in files, environment variables, history
    - Detects Docker socket exposure, capabilities abuse
    - Checks cronjobs for writable scripts

    **Real talk:**

    - Color-coded output: red/yellow = high priority findings
    - Will generate LOTS of output - save to file and analyze
    - Use in pentesting, CTFs, and defensive security audits
    - Run as unprivileged user to find escalation paths
    - Noisy tool - don't run on production without approval

=== "Osquery - SQL System Queries"

    ```bash
    # Installation (Ubuntu/Debian)
    wget https://pkg.osquery.io/deb/osquery_5.11.0-1.linux_amd64.deb
    sudo dpkg -i osquery_5.11.0-1.linux_amd64.deb

    # Installation (RHEL/CentOS)
    sudo yum install https://pkg.osquery.io/rpm/osquery-5.11.0-1.linux.x86_64.rpm

    # Start osquery interactive shell
    osqueryi

    # Example queries (run in osqueryi)
    SELECT * FROM users WHERE uid < 1000;  # System users
    SELECT * FROM processes WHERE name LIKE '%ssh%';  # SSH processes
    SELECT * FROM listening_ports;  # Open ports
    SELECT * FROM logged_in_users;  # Currently logged in
    SELECT * FROM shell_history WHERE command LIKE '%sudo%';  # Sudo usage

    # Run query from command line
    echo "SELECT * FROM users;" | osqueryi --json

    # Configuration file-based monitoring (/etc/osquery/osquery.conf)
    sudo systemctl start osqueryd
    sudo systemctl enable osqueryd

    # Check osquery logs
    tail -f /var/log/osquery/osqueryd.results.log
    ```

    **What it does:**

    - Exposes OS as SQL database (query processes, users, network, files)
    - Real-time monitoring with scheduled queries
    - Fleet-wide deployment for centralized visibility
    - Threat hunting across entire infrastructure
    - Compliance checking (installed software, patch levels)
    - Works with tools like Kolide Fleet for management

    **Real talk:**

    - Steep learning curve but incredibly powerful
    - Use with configuration management (queries as code)
    - Performance impact minimal if queries optimized
    - Better than writing shell scripts for system inventory
    - Integrates with SIEM tools for alerting

=== "Rkhunter - Rootkit Detection"

    ```bash
    # Installation (Ubuntu/Debian)
    sudo apt install rkhunter

    # Installation (RHEL/CentOS/Fedora)
    sudo dnf install rkhunter

    # Update definitions
    sudo rkhunter --update

    # Initial file properties database
    sudo rkhunter --propupd

    # Full system scan
    sudo rkhunter --check

    # Check specific items
    sudo rkhunter --check --rwo  # Report warnings only
    sudo rkhunter --check --sk   # Skip keypress (automated)

    # View scan logs
    cat /var/log/rkhunter.log

    # Update file properties after legitimate changes
    sudo rkhunter --propupd

    # Schedule daily scans (cron)
    sudo rkhunter --cronjob --report-warnings-only
    ```

    **What it does:**

    - Scans for rootkits, backdoors, local exploits
    - Checks binary integrity (common commands like ls, ps, netstat)
    - Detects hidden files and suspicious directories
    - Identifies kernel module tampering
    - Monitors listening ports and startup scripts
    - Validates file permissions on critical system files

    **Real talk:**

    - False positives are common (especially after updates)
    - Run `--propupd` after system updates to avoid noise
    - Not a replacement for proper endpoint security
    - Best used as part of layered defense
    - Check logs regularly - don't just automate and forget

### :fontawesome-solid-lightbulb: Best Practices

!!! success "Audit Strategy"
    - **Baseline first** - Run Lynis on fresh install, track improvements over time
    - **Regular scans** - Weekly Lynis, monthly rkhunter, continuous osquery
    - **Document findings** - Track remediation progress in ticketing system
    - **Test remediations** - Changes can break applications, test thoroughly
    - **Automate reporting** - Email results to security team automatically

!!! warning "Authorization & Ethics"
    - **Get permission** - Always obtain written authorization before scanning
    - **LinPEAS is loud** - Creates logs, may trigger IDS/IPS alerts
    - **Pentesting context** - These tools are for authorized security assessments
    - **CTF/lab use** - Perfect for HackTheBox, TryHackMe, home labs
    - **Defensive use** - Run on your own systems to find issues first

!!! tip "Integration Ideas"
    - **CI/CD pipeline** - Run Lynis in pipeline, fail on low hardening score
    - **Ansible/Chef/Puppet** - Deploy osquery configuration as code
    - **Centralized logging** - Send findings to Splunk/ELK for trend analysis
    - **Vulnerability management** - Cross-reference findings with CVE databases
    - **Change detection** - Use rkhunter for file integrity monitoring

!!! danger "Common Mistakes"
    - **Ignoring findings** - Running scans without fixing issues is pointless
    - **Outdated tools** - Always use latest versions (signatures matter)
    - **No context** - Understand findings before blindly applying fixes
    - **Breaking production** - Test hardening changes in staging first
    - **Alert fatigue** - Too many false positives = ignored alerts

______________________________________________________________________

## :fontawesome-solid-star: Worth Checking

<div class="grid cards" markdown>

- :fontawesome-solid-book: __Official Docs__

    ______________________________________________________________________

    [Linux man pages](https://linux.die.net/man/)

    [Ubuntu Documentation](https://help.ubuntu.com/)

    [RHEL Documentation](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/)

- :fontawesome-solid-code: __Essential Skills__

    ______________________________________________________________________

    [Bash Scripting Guide](https://www.gnu.org/software/bash/manual/)

    [Linux From Scratch](http://www.linuxfromscratch.org/)

    [systemd for Administrators](https://www.freedesktop.org/wiki/Software/systemd/)

- :fontawesome-solid-wrench: __Tools__

    ______________________________________________________________________

    [Oh My Zsh](https://ohmyz.sh/)

    [tmux](https://github.com/tmux/tmux)

    [fzf](https://github.com/junegunn/fzf)

- :fontawesome-solid-users: __Community__

    ______________________________________________________________________

    [r/linux](https://reddit.com/r/linux)

    [Unix & Linux StackExchange](https://unix.stackexchange.com/)

    [Hacker News](https://news.ycombinator.com/)

</div>

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-fire: **Foundation** - If you're doing anything serious with technology, you'll touch Linux. It's not optional anymore.
**Tags:** linux, operating-system, unix
