---
title: Linux
description: Linux system administration - kernel, networking, storage, and the fundamentals that never change (until they do). The OS that runs the internet.
tags:
  - linux
  - sysadmin
  - kernel
  - networking
  - storage
  - systemd
---

# Linux

It runs on your servers, your containers, your toaster, and probably your neighbor's smart fridge. 90% of cloud infrastructure, 100% of your "why is production down" nightmares. Master Linux and you'll never be unemployed. Ignore it and you'll spend your career clicking buttons in Windows Server Manager wondering why nothing works.

!!! abstract "What You'll Find Here"

    - Linux fundamentals - kernel, processes, file systems
    - System administration - user management, permissions, services
    - Networking - TCP/IP, routing, firewall configuration
    - Storage - LVM, RAID, file systems (ext4, XFS, Btrfs)
    - Performance tuning - CPU, memory, I/O optimization
    - Security hardening - SELinux, AppArmor, SSH hardening
    - Package management - apt, yum, dnf, pacman
    - Shell scripting - Bash automation and best practices

______________________________________________________________________

## The Linux Stack

```
┌─────────────────────────────────────┐
│     Applications & Services         │
├─────────────────────────────────────┤
│  System Libraries (glibc, etc.)     │
├─────────────────────────────────────┤
│  Shell (bash, zsh, fish)            │
├─────────────────────────────────────┤
│  System Services (systemd/init)     │
├─────────────────────────────────────┤
│  User Space Tools (coreutils)       │
├─────────────────────────────────────┤
│  Linux Kernel                       │
├─────────────────────────────────────┤
│  Hardware Abstraction Layer         │
├─────────────────────────────────────┤
│  Hardware (CPU, RAM, Disk, NIC)     │
└─────────────────────────────────────┘
```

______________________________________________________________________

## Learning Path

### Foundation (0-6 months)

1. **Command line basics** - Navigation, file operations, text manipulation
1. **File system hierarchy** - /etc, /var, /usr, /home - where everything lives
1. **Process management** - ps, top, kill, background jobs
1. **User management** - adduser, passwd, groups, sudo
1. **Package management** - Install, update, remove packages for your distro

### Intermediate (6-18 months)

1. **Shell scripting** - Automate repetitive tasks with Bash
1. **Systemd services** - Create, manage, and troubleshoot services
1. **Networking fundamentals** - Configure interfaces, routing, DNS
1. **File system management** - Mount points, fstab, disk quotas
1. **Log management** - journalctl, syslog, log rotation

### Advanced (18+ months)

1. **Kernel tuning** - sysctl, kernel parameters, custom modules
1. **Advanced networking** - VLANs, bonding, traffic shaping
1. **Storage engineering** - LVM, RAID levels, performance tuning
1. **Security hardening** - SELinux policies, iptables rules, audit framework
1. **Performance analysis** - perf, eBPF, system bottleneck identification

______________________________________________________________________

## Distribution Comparison

| Aspect             | Debian/Ubuntu         | RHEL/CentOS/Rocky    | Arch Linux          | SUSE                   |
| ------------------ | --------------------- | -------------------- | ------------------- | ---------------------- |
| **Philosophy**     | Stability             | Enterprise stability | Bleeding edge       | Enterprise + stability |
| **Package Mgr**    | apt/dpkg              | yum/dnf/rpm          | pacman              | zypper/rpm             |
| **Release Cycle**  | 2 years (LTS)         | 7-10 years (RHEL)    | Rolling release     | 3-4 years              |
| **Init System**    | systemd               | systemd              | systemd             | systemd                |
| **Best For**       | General purpose, dev  | Production servers   | Power users, latest | SAP, enterprise Linux  |
| **Support**        | Community / Canonical | Red Hat / Community  | Community           | SUSE / Community       |
| **Default Shell**  | bash                  | bash                 | bash                | bash                   |
| **Package Count**  | 60,000+               | 10,000+              | 13,000+ (AUR: 80k+) | 15,000+                |
| **Learning Curve** | Easy                  | Medium               | Steep               | Medium                 |
| **Docs Quality**   | Excellent             | Excellent (RHEL)     | Legendary (Wiki)    | Good                   |

______________________________________________________________________

## Essential Commands

### File Operations

```bash
# List files with details
ls -lah

# Find files by name
find /path -name "*.log"

# Find files by content
grep -r "search_term" /path

# Copy with progress
rsync -av --progress source/ dest/

# Disk usage by directory
du -sh * | sort -h
```

### Process Management

```bash
# List all processes
ps aux

# Interactive process viewer
htop

# Kill process by name
pkill process_name

# Monitor system resources
top

# Process tree
pstree -p
```

### Networking

```bash
# Show network interfaces
ip addr show

# Show routing table
ip route show

# Test connectivity
ping -c 4 google.com

# Check open ports
ss -tulpn

# Network statistics
netstat -i
```

### System Information

```bash
# Kernel version
uname -r

# Distribution info
cat /etc/os-release

# CPU info
lscpu

# Memory info
free -h

# Disk info
lsblk
```

### Service Management (systemd)

```bash
# Start service
systemctl start service_name

# Enable service at boot
systemctl enable service_name

# Check service status
systemctl status service_name

# View service logs
journalctl -u service_name -f

# Reload systemd daemon
systemctl daemon-reload
```

______________________________________________________________________

## File System Hierarchy

| Directory  | Purpose                                  | Examples                         |
| ---------- | ---------------------------------------- | -------------------------------- |
| **/bin**   | Essential user binaries                  | ls, cat, cp, bash                |
| **/boot**  | Boot loader files, kernel                | vmlinuz, initrd.img              |
| **/dev**   | Device files                             | /dev/sda, /dev/null, /dev/random |
| **/etc**   | System configuration files               | /etc/passwd, /etc/fstab          |
| **/home**  | User home directories                    | /home/username                   |
| **/lib**   | Shared libraries                         | libc.so, libm.so                 |
| **/media** | Removable media mount points             | /media/usb, /media/cdrom         |
| **/mnt**   | Temporary mount points                   | /mnt/backup                      |
| **/opt**   | Optional third-party software            | /opt/google, /opt/steam          |
| **/proc**  | Virtual filesystem (kernel/process info) | /proc/cpuinfo, /proc/meminfo     |
| **/root**  | Root user home directory                 | /root                            |
| **/run**   | Runtime data since last boot             | /run/lock, /run/user             |
| **/sbin**  | System administration binaries           | iptables, fdisk, useradd         |
| **/srv**   | Service data                             | /srv/http, /srv/ftp              |
| **/sys**   | Virtual filesystem (kernel/device info)  | /sys/class, /sys/devices         |
| **/tmp**   | Temporary files (cleared on reboot)      | /tmp                             |
| **/usr**   | User utilities and applications          | /usr/bin, /usr/lib, /usr/share   |
| **/var**   | Variable data (logs, caches, spool)      | /var/log, /var/cache, /var/www   |

______________________________________________________________________

## Related Sections

!!! info "Expand Your Skills"

    - **[Containerization](../containerization/)** - Docker, Kubernetes running on Linux
    - **[DevOps](../devops/)** - Automation, CI/CD on Linux infrastructure
    - **[Security](../security/)** - Linux security, hardening, pentesting
    - **[Cloud](../cloud/)** - Most cloud VMs run Linux
    - **[Tools](../tools/)** - Shell tools, editors, productivity

______________________________________________________________________

## Community & Resources

### 🐦 Follow These

- **r/linux** - 1.3M+ members, news and discussions
- **r/linuxadmin** - 200k+ members, sysadmin-focused
- **r/commandline** - Command-line tips and tricks
- **LinuxQuestions.org** - Active forum since 2001

### 📚 Essential Reading

- **The Linux Command Line** - William Shotts (free online)
- **UNIX and Linux System Administration Handbook** - Evi Nemeth (the bible)
- **How Linux Works** - Brian Ward (internals explained)
- **Linux Performance Tools** - Brendan Gregg (performance deep dive)

### 🎙️ Podcasts & Newsletters

- **Linux Action News** - Weekly Linux news
- **Late Night Linux** - Linux enthusiasts podcast
- **BSD Now** - BSD and Unix systems
- **Destination Linux** - Linux desktop and general topics

### 🎓 Certifications Worth It

- **RHCSA (Red Hat Certified System Administrator)** ($400) - Hands-on, highly respected
- **RHCE (Red Hat Certified Engineer)** ($400) - Advanced automation, worth it
- **LFCS (Linux Foundation Certified SysAdmin)** ($395) - Vendor-neutral, respected
- **LPIC-1 (Linux Professional Institute)** ($200 per exam) - Entry-level certification
- **CompTIA Linux+** ($348) - Entry-level, good for beginners
- **Skip**: CompTIA Server+ unless employer requires it

______________________________________________________________________

## Best Practices

!!! success "Core Principles"

    1. **Never log in as root** - Use sudo, track who did what
    1. **Automate everything** - Shell scripts, configuration management (Ansible)
    1. **Keep systems updated** - Security patches wait for no one
    1. **Monitor your systems** - You can't fix what you can't see
    1. **Document changes** - Future you will thank present you
    1. **Use version control** - Git for configs (/etc under version control)
    1. **Backups before changes** - Snapshot, backup, then modify
    1. **Least privilege always** - Minimum permissions needed, nothing more
    1. **Read the logs** - journalctl and /var/log are your friends
    1. **Test in non-prod first** - Production is not your test environment

______________________________________________________________________

## Common Pitfalls

### **Dangerous Commands** (Run at your own risk)

```bash
# NEVER run these without understanding them
rm -rf /                    # Deletes everything (protected in modern systems)
chmod -R 777 /              # Makes everything world-writable (security nightmare)
dd if=/dev/zero of=/dev/sda # Wipes disk (no undo)
:(){ :|:& };:               # Fork bomb (crashes system)
mkfs.ext4 /dev/sda          # Formats disk without warning

# Dangerous typos
rm -rf / home/user          # Space after / deletes root
sudo chmod -R 777 .         # Meant current dir, hit wrong key
```

### **Production Lessons (Learned the Hard Way)**

- Always use absolute paths in cron jobs and scripts
- Test systemd service files before enabling at boot
- Verify disk mounts before rm -rf operations
- Check free space before large operations (df -h)
- Never kill -9 the init process (PID 1)
- SELinux denials mean read the logs, don't disable SELinux
- Firewall rules: Add before removing (or you'll lock yourself out)
- vim vs vi: Know the difference on minimal systems

______________________________________________________________________

## Security Hardening Checklist

### Essential Steps

- [ ] **SSH Hardening**

    - Disable root login: `PermitRootLogin no`
    - Use key-based authentication
    - Change default port (security by obscurity, but helps)
    - Enable fail2ban for brute force protection

- [ ] **Firewall Configuration**

    - Enable and configure firewalld or ufw
    - Default deny incoming, allow necessary ports only
    - Log dropped packets for analysis

- [ ] **User Management**

    - Enforce strong password policies
    - Regular user account audits
    - Disable unused accounts
    - Implement sudo with limited permissions

- [ ] **System Updates**

    - Enable automatic security updates
    - Subscribe to security mailing lists
    - Test updates in staging first
    - Document update procedures

- [ ] **Audit & Monitoring**

    - Enable auditd for security logging
    - Configure centralized logging
    - Set up intrusion detection (AIDE, Tripwire)
    - Monitor disk usage and performance

- [ ] **SELinux/AppArmor**

    - Enable and configure (don't disable because it's "hard")
    - Review and understand denial logs
    - Create custom policies when needed

______________________________________________________________________

## Troubleshooting Guide

### System Won't Boot

```bash
# Boot into rescue mode (GRUB menu)
# Check file system integrity
fsck /dev/sda1

# Check fstab for errors
cat /etc/fstab

# Review boot logs
journalctl -xb

# Check disk space (full / partition)
df -h
```

### High Load Average

```bash
# Check what's consuming CPU
top
htop

# Check I/O wait
iostat -x 1

# Find processes using disk
iotop

# Check memory usage
free -h
vmstat 1
```

### Network Issues

```bash
# Verify interface is up
ip link show

# Check IP configuration
ip addr show

# Test connectivity
ping 8.8.8.8

# Check DNS resolution
nslookup google.com
dig google.com

# Review firewall rules
iptables -L -n -v

# Check routing
ip route show
```

### Disk Full

```bash
# Find large directories
du -sh /* | sort -h

# Find large files
find / -type f -size +100M -exec ls -lh {} \;

# Check inode usage (can be full with small files)
df -i

# Clean package cache
apt clean  # Debian/Ubuntu
yum clean all  # RHEL/CentOS

# Clean old logs
journalctl --vacuum-time=7d
```

______________________________________________________________________

## Performance Tuning

### CPU Optimization

```bash
# Check CPU governor (performance vs powersave)
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Set to performance mode
echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Check CPU frequency
lscpu | grep MHz

# Monitor per-core usage
mpstat -P ALL 1
```

### Memory Tuning

```bash
# Check memory usage
free -h

# View memory details
cat /proc/meminfo

# Tune swappiness (lower = less swap usage)
sysctl vm.swappiness=10

# Clear page cache (emergency only)
sync; echo 3 > /proc/sys/vm/drop_caches
```

### I/O Optimization

```bash
# Check disk scheduler
cat /sys/block/sda/queue/scheduler

# Set to deadline (SSDs) or none (NVMe)
echo deadline > /sys/block/sda/queue/scheduler

# Monitor disk I/O
iostat -x 1

# Check for I/O wait
vmstat 1
```

______________________________________________________________________

## Bash Scripting Best Practices

### Script Template

```bash
#!/usr/bin/env bash

# Script: example.sh
# Purpose: Do something useful
# Author: Your Name
# Date: 2026-01-26

set -euo pipefail  # Exit on error, undefined vars, pipe failures
IFS=$'\n\t'        # Set Internal Field Separator

# Functions
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Options:
    -h, --help      Show this help message
    -v, --verbose   Verbose output
EOF
    exit 0
}

# Main logic
main() {
    [[ $# -eq 0 ]] && usage

    echo "Starting script..."
    # Your code here
}

main "$@"
```

### Common Patterns

```bash
# Check if running as root
[[ $EUID -ne 0 ]] && error_exit "Must run as root"

# Check if command exists
command -v docker >/dev/null 2>&1 || error_exit "docker not found"

# Create temp directory
TMP_DIR=$(mktemp -d)
trap "rm -rf '$TMP_DIR'" EXIT

# Logging with timestamps
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

# Prompt for confirmation
read -p "Continue? (y/n): " -n 1 -r
echo
[[ $REPLY =~ ^[Yy]$ ]] || exit 1
```

______________________________________________________________________

**Last Updated:** 2026-01-26

**Vibe Check:** 🌍 **Fundamental** - Linux runs 90% of the internet. Master it or forever be at the mercy of "the Linux guy" in your team. The command line seems arcane until the GUI fails. Then it's your only hope. Systemd won the init wars (deal with it). Containers run on Linux. Cloud runs on Linux. Your career depends on Linux. Learn it. Love it. Curse it at 3 AM when production is down. But never, ever, underestimate it.
