---
title: macOS
description: macOS reference - Unix-based OS for Apple hardware, developer-friendly with premium price tag
---

# :octicons-device-desktop-16: macOS

Unix-based operating system for Apple hardware. BSD foundation with polished UI. Popular among developers for Unix compatibility plus commercial software support. Expensive hardware, locked ecosystem, but excellent build quality. Terminal is real bash/zsh, runs Docker natively (ish), has Homebrew.

!!! tip "2026 Update"
    Apple Silicon (M-series chips) changed the game - ARM architecture, incredible performance, amazing battery life. Most developer tools now ARM-native. macOS Sequoia introduces better window management and enhanced security features.

______________________________________________________________________

## :octicons-zap-16: Quick Hits

=== ":octicons-checklist-16: Essential Commands"

    ```bash
    # System information
    sw_vers                       # macOS version
    system_profiler SPHardwareDataType  # Hardware info
    sysctl -n machdep.cpu.brand_string  # CPU model

    # Package management (Homebrew)
    brew install package-name     # Install package
    brew update && brew upgrade   # Update all packages
    brew search keyword           # Search for packages
    brew list                     # List installed packages

    # Application management
    open -a "Safari" file.html    # Open file with app
    mdfind -name "filename"       # Spotlight search from terminal
    defaults write com.apple.finder AppleShowAllFiles YES  # Show hidden files
    killall Finder                # Restart Finder

    # Networking
    networksetup -listallnetworkservices  # List network interfaces
    ifconfig                      # Show network configuration
    scutil --dns                  # Show DNS configuration

    # Disk management
    diskutil list                 # List all disks
    df -h                         # Disk space usage
    du -sh *                      # Directory sizes

    # Process management
    ps aux | grep appname         # Find processes
    top                           # Process monitor (use htop if installed)
    launchctl list                # List all services
    ```

    **Real talk:**

    - Install Homebrew first - it's the missing package manager
    - Use Spotlight (Cmd+Space) for everything - faster than clicking
    - Learn keyboard shortcuts - trackpad gestures are nice but slow
    - Terminal.app is fine, but iTerm2 is better
    - Enable tap-to-click - System Settings → Trackpad

=== ":octicons-zap-16: Common Patterns"

    ```bash
    # Homebrew setup (install from https://brew.sh)
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Essential developer tools
    brew install git
    brew install node
    brew install python@3.12
    brew install docker
    brew install visual-studio-code

    # Shell configuration (~/.zshrc)
    export PATH="/opt/homebrew/bin:$PATH"  # Homebrew on Apple Silicon
    export PATH="$HOME/.local/bin:$PATH"   # User binaries

    # Useful aliases
    alias ll='ls -lah'
    alias cleanup='brew cleanup && brew autoremove'

    # Spotlight indexing (fix slow search)
    sudo mdutil -E /                # Rebuild Spotlight index

    # Reset DNS cache (networking issues)
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder

    # Screenshot shortcuts (built-in)
    Cmd+Shift+3  # Full screen screenshot
    Cmd+Shift+4  # Select area screenshot
    Cmd+Shift+5  # Screenshot menu with recording
    ```

    **Why this works:**

    - Homebrew is standard for macOS development
    - zsh is default shell since Catalina (2019)
    - Spotlight indexing can get corrupted, rebuild fixes it
    - DNS cache causes weird networking issues

=== ":octicons-flame-16: Pro Tips & Gotchas"

    !!! success "Productivity Boosters"
        - **Rectangle/Magnet** - Window management (native snapping is weak)
        - **Alfred** - Spotlight replacement on steroids
        - **iTerm2** - Better terminal than Terminal.app
        - **Raycast** - Modern Alfred alternative, free, excellent
        - **Homebrew Cask** - Install GUI apps via CLI (`brew install --cask`)
        - **Hidden Bar** - Clean up menu bar clutter

    !!! warning "Apple Silicon (M1/M2/M3) Notes"
        - **Rosetta 2** - Translates x86 apps, install with `softwareupdate --install-rosetta`
        - **Architecture check** - `arch -arm64` or `arch -x86_64` to force architecture
        - **Docker** - Use Docker Desktop for Mac (ARM native since 2021)
        - **Homebrew paths** - Intel: `/usr/local`, Apple Silicon: `/opt/homebrew`
        - **Some apps still x86** - Check "Open using Rosetta" in Get Info

    !!! tip "Developer Setup"
        - **Xcode Command Line Tools** - `xcode-select --install` (required for compiling)
        - **pyenv/nvm/rbenv** - Version managers better than system installs
        - **Docker Desktop** - Required for containers (no native Docker engine)
        - **VS Code** - Excellent on macOS, native Apple Silicon support
        - **Oh My Zsh** - Shell framework with plugins and themes

    !!! danger "Common Gotchas"
        - **Gatekeeper blocks apps** - Right-click → Open to bypass first time
        - **Case-insensitive filesystem** - Default APFS is case-insensitive (can cause issues)
        - **$PATH pollution** - Multiple package managers can conflict
        - **Sudo password** - Required frequently, use Touch ID if available
        - **System updates** - Can break homebrew packages, reinstall after major updates
        - **Storage optimization** - System takes 40GB+, clear Xcode cache regularly

    !!! info "System Settings Worth Tweaking"
        - **Dock** - Auto-hide, position on left (more vertical space)
        - **Mission Control** - Disable "Automatically rearrange Spaces"
        - **Keyboard** - Key repeat rate to fast, delay to short
        - **Trackpad** - Enable tap-to-click, three-finger drag
        - **Accessibility → Pointer** - Shake to locate (useful on large displays)

______________________________________________________________________

## :octicons-book-16: Learning Resources

### :octicons-mortar-board-16: Free Resources

- **[macOS User Guide](https://support.apple.com/guide/mac-help/)** - Official Apple docs
- **[Mac Power Users Podcast](https://www.relay.fm/mpu)** - Tips and workflows
- **[Awesome macOS](https://github.com/iCHAIT/awesome-macOS)** - Curated list of apps/tools

### :octicons-terminal-16: Command Line

- **[macOS Terminal Guide](https://support.apple.com/guide/terminal/)** - Official terminal docs
- **[Homebrew Documentation](https://docs.brew.sh/)** - Package manager docs
- **[Oh My Zsh Wiki](https://github.com/ohmyzsh/ohmyzsh/wiki)** - Shell customization

______________________________________________________________________

## :octicons-shield-check-16: Security Audit Tools

Tools for macOS security auditing, compliance checking, and vulnerability assessment. Because Apple's security is good, but not perfect.

### :octicons-checklist-16: Tool Overview

| Tool | Purpose | Type | Best For |
|------|---------|------|----------|
| **Lynis** | System hardening audit | OSS | Configuration review, compliance checks |
| **LinPEAS** | Privilege escalation enumeration | OSS | Finding misconfigurations, pentesting |
| **Apple-Check** | macOS-specific security audit | OSS | Apple compliance baselines, MDM checks |
| **Osquery** | SQL-based system monitoring | OSS | Fleet management, threat hunting |

### :octicons-gear-16: Installation & Usage

=== "Lynis - macOS Hardening Audit"

    ```bash
    # Installation via Homebrew (easiest)
    brew install lynis

    # Or clone from GitHub for latest version
    git clone https://github.com/CISOfy/lynis
    cd lynis
    ./lynis audit system

    # Basic audit (requires sudo for full access)
    sudo lynis audit system

    # Quick scan (no pauses)
    sudo lynis audit system --quick

    # Generate report with specific output
    sudo lynis audit system --logfile ~/lynis-audit.log

    # Update Lynis to latest version
    brew upgrade lynis
    # Or: lynis update info
    ```

    **What it does:**

    - Audits macOS security configuration (FileVault, Firewall, Gatekeeper)
    - Checks file permissions on critical system files
    - Reviews installed software and vulnerable packages
    - Validates system hardening (SIP, secure boot, firmware password)
    - Identifies weak SSH configurations
    - Checks for suspicious processes and services

    **Real talk:**

    - Default macOS gets ~65-75 hardening score (not terrible)
    - Enable FileVault, Firewall, and automatic updates for +10 points
    - SIP (System Integrity Protection) should ALWAYS be enabled
    - Review `/var/log/lynis.log` for detailed findings
    - macOS-specific checks include Gatekeeper and XProtect status

=== "LinPEAS - Privilege Escalation"

    ```bash
    # Download latest release
    curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh -o linpeas.sh
    chmod +x linpeas.sh

    # Run with output to file (recommended)
    ./linpeas.sh -a > linpeas_macos.txt

    # Fast mode
    ./linpeas.sh -q

    # Check specific areas
    ./linpeas.sh -o SysI,Devs  # System info + devices only
    ```

    **What it does:**

    - Enumerates SUID/SGID binaries
    - Checks for writable paths in $PATH
    - Identifies sudo misconfigurations
    - Scans for weak file permissions
    - Detects credentials in shell history and config files
    - Reviews cron jobs and LaunchAgents/LaunchDaemons
    - Checks Docker socket permissions (if Docker Desktop installed)

    **Real talk:**

    - macOS permissions are stricter than Linux (TCC framework)
    - Still finds misconfigurations in Homebrew installs
    - Useful for CTF-style challenges and authorized testing
    - Color output: red/yellow = actionable findings
    - Will flag Homebrew's world-writable directories (expected)

=== "Apple-Check - macOS Compliance"

    ```bash
    # Clone Apple-Check repository
    git clone https://github.com/usnistgov/macos_security
    cd macos_security

    # Or use individual compliance scripts
    git clone https://github.com/kristovatlas/osx-config-check
    cd osx-config-check
    python3 app.py

    # Example: Check CIS macOS Benchmark compliance
    # Download from https://www.cisecurity.org/benchmark/apple_os
    # Run provided scripts or use tools like:
    git clone https://github.com/mvdbos/macos-audit
    cd macos-audit
    ./audit.sh

    # NIST macOS Security Compliance Project
    git clone https://github.com/usnistgov/macos_security
    cd macos_security
    # Follow repo instructions for baseline generation
    ```

    **What it does:**

    - Validates compliance with CIS, NIST, DISA STIG benchmarks
    - Checks macOS security settings programmatically
    - Audits FileVault, Firewall, Gatekeeper, SIP status
    - Reviews MDM (Mobile Device Management) profiles
    - Validates user account security (password policies, admin users)
    - Checks for unauthorized startup items

    **Real talk:**

    - No single "Apple-Check" tool - multiple projects exist
    - Best for enterprise compliance requirements
    - NIST project most comprehensive (requires Python)
    - CIS benchmarks available but manual review needed
    - Useful for SOC 2, ISO 27001, HIPAA compliance

=== "Osquery - System Introspection"

    ```bash
    # Installation via Homebrew
    brew install --cask osquery

    # Or download from GitHub releases
    # https://github.com/osquery/osquery/releases

    # Start interactive shell
    osqueryi

    # Example queries (run in osqueryi)
    SELECT * FROM users WHERE uid < 500;  # System accounts
    SELECT * FROM processes WHERE name = 'ssh';  # SSH processes
    SELECT * FROM listening_ports;  # Open ports
    SELECT * FROM apps;  # Installed applications
    SELECT * FROM startup_items;  # Auto-start items
    SELECT * FROM kernel_extensions;  # Loaded kexts

    # macOS-specific queries
    SELECT * FROM gatekeeper WHERE assessments_enabled = 0;  # Gatekeeper status
    SELECT * FROM sip_config;  # System Integrity Protection
    SELECT * FROM disk_encryption;  # FileVault status

    # Run as daemon (launchd integration)
    sudo cp /opt/homebrew/Cellar/osquery/*/com.osquery.osqueryd.plist /Library/LaunchDaemons/
    sudo launchctl load /Library/LaunchDaemons/com.osquery.osqueryd.plist
    ```

    **What it does:**

    - Queries macOS system state as SQL database
    - Real-time monitoring of processes, network, files
    - Fleet-wide deployment for Mac management
    - Detects unauthorized software installations
    - Monitors security configuration drift
    - Integrates with Kolide Fleet, Zentral for centralized management

    **Real talk:**

    - Incredibly powerful for Mac fleet management
    - Great for detecting when FileVault gets disabled
    - Monitor for unauthorized admin user creation
    - Performance impact negligible if queries optimized
    - Essential for enterprise Mac security at scale

### :octicons-light-bulb-16: Best Practices

!!! success "macOS-Specific Hardening"
    - **FileVault** - Full-disk encryption (non-negotiable for laptops)
    - **Firewall** - Enable in System Settings → Network → Firewall
    - **Gatekeeper** - Keep enabled, verify with `spctl --status`
    - **SIP** - System Integrity Protection, check with `csrutil status`
    - **Firmware password** - Set at boot (prevents single-user mode)
    - **Auto-updates** - Enable for system and App Store apps

!!! warning "Authorization & Ethics"
    - **Get permission** - Always obtain authorization before security testing
    - **Corporate Macs** - Check with IT before running audit tools (MDM may alert)
    - **Legal compliance** - Some tools may violate CFAA without proper authorization
    - **Educational use** - Perfect for personal Macs and learning environments

!!! tip "Enterprise Deployment"
    - **MDM integration** - Use Jamf, Mosyle, or Kandji for policy enforcement
    - **Osquery deployment** - Kolide or Zentral for fleet-wide monitoring
    - **Automated auditing** - Schedule Lynis scans via LaunchDaemons
    - **Centralized logging** - Ship audit logs to SIEM (Splunk, ELK)
    - **Compliance reporting** - Generate reports for SOC 2, ISO 27001

!!! danger "Common Mistakes"
    - **Disabling SIP** - Don't do it unless absolutely necessary (breaks security)
    - **Ignoring TCC prompts** - Transparency, Consent, and Control is critical
    - **Running as root constantly** - Use sudo when needed, not `su -`
    - **Homebrew security** - Keep updated, audit installed packages regularly
    - **Outdated tools** - Update audit tools monthly (security landscape changes)

______________________________________________________________________

## :octicons-star-16: Worth Checking

<div class="grid cards" markdown>

- :octicons-book-16: __Official Docs__

    ______________________________________________________________________

    [macOS User Guide](https://support.apple.com/guide/mac-help/)

    [Apple Developer](https://developer.apple.com/)

    [macOS Release Notes](https://developer.apple.com/documentation/macos-release-notes)

- :octicons-package-16: __Package Managers__

    ______________________________________________________________________

    [Homebrew](https://brew.sh/)

    [MacPorts](https://www.macports.org/)

    [Nix](https://nixos.org/download.html#nix-install-macos)

- :octicons-tools-16: __Essential Tools__

    ______________________________________________________________________

    [iTerm2](https://iterm2.com/)

    [Rectangle](https://rectangleapp.com/)

    [Raycast](https://www.raycast.com/)

    [Alfred](https://www.alfredapp.com/)

- :octicons-people-16: __Community__

    ______________________________________________________________________

    [r/macOS](https://reddit.com/r/macOS)

    [r/MacApps](https://reddit.com/r/MacApps)

    [Mac Rumors Forums](https://forums.macrumors.com/)

</div>

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :octicons-heart-16: **Premium** - macOS is the developer's choice if you can afford it. Unix power with GUI polish, but you're locked into Apple's ecosystem.
**Tags:** macos, operating-system, apple, unix
