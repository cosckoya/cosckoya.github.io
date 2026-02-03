---
title: Windows
description: Windows reference - dominant desktop OS, WSL2 makes it developer-viable, gaming platform
---

# :octicons-device-desktop-16: Windows

Dominant desktop operating system (75%+ market share). Gaming platform of choice. Enterprise standard. Used to be hostile to developers, but WSL2 changed everything. PowerShell is powerful if you learn it. Active Directory runs corporate networks. Office suite integration unmatched.

!!! tip "2026 Update"
    Windows 11 matured significantly. WSL2 is production-ready with GUI support, GPU acceleration, and systemd. Windows Terminal is excellent. Native package manager (winget) finally works. Developer experience improved dramatically.

______________________________________________________________________

## :octicons-zap-16: Quick Hits

=== ":octicons-checklist-16: Essential Commands"

    ```powershell
    # System information
    systeminfo                    # Detailed system information
    Get-ComputerInfo              # PowerShell system info
    winver                        # Windows version GUI

    # Package management (winget)
    winget search package-name    # Search for packages
    winget install package-name   # Install package
    winget upgrade --all          # Update all packages
    winget list                   # List installed packages

    # Process management
    tasklist                      # List running processes
    taskkill /F /IM process.exe   # Force kill process
    Get-Process | Sort-Object CPU -Descending  # Top CPU users (PowerShell)

    # Networking
    ipconfig /all                 # Network configuration
    netstat -ano                  # Show all connections with PIDs
    Test-NetConnection google.com # Test connectivity (PowerShell)
    nslookup example.com          # DNS lookup

    # Disk management
    Get-PSDrive                   # Show all drives (PowerShell)
    Get-Volume                    # Volume information (PowerShell)
    chkdsk C: /F                  # Check and fix disk errors

    # Services
    Get-Service                   # List all services (PowerShell)
    Start-Service ServiceName     # Start service
    Stop-Service ServiceName      # Stop service
    ```

    **Real talk:**

    - Learn PowerShell, not cmd.exe - it's way more powerful
    - Install Windows Terminal - default terminal is terrible
    - Enable WSL2 immediately if you develop anything web-related
    - Use winget for packages - no more downloading .exe files
    - Windows Update breaks things - always have backups

=== ":octicons-zap-16: Common Patterns"

    ```powershell
    # WSL2 setup (run in PowerShell as Administrator)
    wsl --install                 # Installs WSL2 + Ubuntu
    wsl --set-default-version 2   # Ensure WSL2 (not WSL1)
    wsl --list --verbose          # List installed distros

    # After WSL2 install, inside Ubuntu:
    sudo apt update && sudo apt upgrade
    sudo apt install build-essential git curl

    # Windows Terminal customization (settings.json)
    {
      "defaultProfile": "{Ubuntu GUID}",
      "copyOnSelect": true,
      "theme": "dark"
    }

    # PowerShell profile (~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1)
    Set-Alias -Name ll -Value Get-ChildItem
    Set-PSReadLineOption -PredictionSource History

    # Environment variables (PowerShell)
    $env:PATH += ";C:\Custom\Path"              # Temporary
    [System.Environment]::SetEnvironmentVariable("VAR", "value", "User")  # Permanent

    # File operations
    Get-ChildItem -Recurse -Filter "*.log"      # Find files
    Get-Content file.txt -Tail 10 -Wait         # Tail -f equivalent

    # Network troubleshooting
    ipconfig /flushdns                          # Clear DNS cache
    netsh winsock reset                         # Reset network stack
    netsh int ip reset                          # Reset TCP/IP
    ```

    **Why this works:**

    - WSL2 gives you real Linux, not emulation
    - Windows Terminal supports tabs, panes, GPU acceleration
    - PowerShell is object-based, more powerful than bash for Windows tasks
    - winget eliminates manual installations

=== ":octicons-flame-16: Pro Tips & Gotchas"

    !!! success "Developer Setup"
        - **WSL2** - Must-have for web development, runs Docker natively
        - **Windows Terminal** - Modern terminal with tabs, split panes
        - **Visual Studio Code** - Excellent WSL integration (Remote - WSL extension)
        - **PowerToys** - Microsoft utilities (window management, keyboard remapping)
        - **winget** - Native package manager (finally!)
        - **Docker Desktop for Windows** - Uses WSL2 backend (fast)

    !!! warning "WSL2 Specific"
        - **File system performance** - Keep files in WSL filesystem (`/home`), not `/mnt/c`
        - **Memory usage** - WSL2 can consume lots of RAM, configure in `.wslconfig`
        - **Networking** - WSL2 uses virtualized network (can cause VPN issues)
        - **systemd support** - Enable in `/etc/wsl.conf` for proper service management
        - **GUI apps** - WSLg supports Linux GUI apps since Windows 11

    !!! tip "Performance Optimization"
        - **Disable unnecessary startup programs** - Task Manager → Startup tab
        - **Windows Search indexing** - Exclude development folders
        - **Antivirus exclusions** - Add dev folders to Windows Defender exclusions
        - **Disk cleanup** - Storage Sense auto-cleanup, run Disk Cleanup utility
        - **Power plan** - High Performance for desktops (hidden in advanced settings)

    !!! danger "Common Gotchas"
        - **Windows Update** - Can force restart during work (delay in Pro version)
        - **Path length limit** - 260 character limit (enable long paths in registry)
        - **Line endings** - Git config `core.autocrlf=true` to avoid LF/CRLF hell
        - **Admin privileges** - Many operations require "Run as Administrator"
        - **Antivirus false positives** - Dev tools often flagged, add exclusions
        - **WSL2 + VPN issues** - VPN can break WSL2 networking (vendor-specific fixes)

    !!! info "Gaming Optimizations"
        - **Game Mode** - Windows 11 built-in (Settings → Gaming)
        - **Disable fullscreen optimizations** - Right-click .exe → Compatibility
        - **Update GPU drivers** - Directly from NVIDIA/AMD, not Windows Update
        - **Hardware-accelerated GPU scheduling** - Enable in Graphics Settings
        - **Xbox Game Bar** - Useful for recording, but disable if performance issues

______________________________________________________________________

## :octicons-book-16: Learning Resources

### :octicons-mortar-board-16: Free Resources

- **[Windows Documentation](https://docs.microsoft.com/en-us/windows/)** - Official Microsoft docs
- **[PowerShell Docs](https://docs.microsoft.com/en-us/powershell/)** - PowerShell reference
- **[WSL Documentation](https://docs.microsoft.com/en-us/windows/wsl/)** - Official WSL guide
- **[PowerShell Gallery](https://www.powershellgallery.com/)** - PowerShell modules

### :octicons-terminal-16: PowerShell Learning

- **[PowerShell in a Month of Lunches](https://www.manning.com/books/learn-powershell-in-a-month-of-lunches)** - Best beginner book
- **[PowerShell.org](https://powershell.org/)** - Community resources
- **[PSKoans](https://github.com/vexx32/PSKoans)** - Interactive PowerShell learning

______________________________________________________________________

## :octicons-shield-check-16: Security Audit Tools

Windows security auditing tools for finding privilege escalation paths, Active Directory weaknesses, and configuration issues. Essential for pentesting and defensive security.

### :octicons-checklist-16: Tool Overview

| Tool | Purpose | Type | Best For |
|------|---------|------|----------|
| **WinPEAS** | Privilege escalation enumeration | OSS | Finding privesc vectors, pentesting |
| **BloodHound** | Active Directory attack paths | OSS | AD security analysis, red teaming |
| **PingCastle** | AD security assessment | Freemium | Quick AD security posture checks |
| **Seatbelt** | Security configuration collection | OSS | Defensive security audits |
| **Snaffler** | Sensitive data discovery | OSS | Finding secrets in file shares |
| **Osquery** | SQL-based system monitoring | OSS | Fleet management, EDR-style queries |

### :octicons-gear-16: Installation & Usage

=== "WinPEAS - Privilege Escalation"

    ```powershell
    # Download latest release
    Invoke-WebRequest -Uri "https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASx64.exe" -OutFile "winPEAS.exe"

    # Run basic enumeration
    .\winPEAS.exe

    # Output to file (recommended - lots of output)
    .\winPEAS.exe > winpeas_output.txt

    # Fast scan (skip some checks)
    .\winPEAS.exe fast

    # Quiet mode (less verbose)
    .\winPEAS.exe quiet

    # Check specific categories
    .\winPEAS.exe systeminfo userinfo  # Only system and user info

    # Bypass AMSI (if Windows Defender blocks)
    # Use obfuscated version: winPEASx64_ofs.exe
    ```

    **What it does:**

    - Enumerates system information (OS, patches, hotfixes)
    - Checks AlwaysInstallElevated registry keys (easy privesc)
    - Identifies vulnerable services (unquoted paths, weak permissions)
    - Scans for stored credentials (Registry, files, memory)
    - Lists scheduled tasks with writable paths
    - Checks DLL hijacking opportunities
    - Identifies weak file/folder permissions
    - Enumerates token privileges and user groups

    **Real talk:**

    - Color-coded output: red = high-priority finding
    - Windows Defender WILL flag this (expected behavior)
    - Use obfuscated version (ofs) to reduce AV detection
    - Save output to file - there's A LOT of information
    - Standard for Windows privilege escalation in CTFs and pentests

=== "BloodHound - Active Directory Analysis"

    ```powershell
    # Prerequisites: .NET Framework, Neo4j database

    # Install Neo4j (graph database)
    # Download from: https://neo4j.com/download/
    # Or via Chocolatey:
    choco install neo4j-community

    # Start Neo4j
    neo4j.bat console

    # Download BloodHound GUI
    # https://github.com/BloodHoundAD/BloodHound/releases

    # Download SharpHound collector (C# version)
    Invoke-WebRequest -Uri "https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.exe" -OutFile "SharpHound.exe"

    # Collect AD data (run on domain-joined machine)
    .\SharpHound.exe --CollectionMethod All

    # Or use PowerShell collector
    Import-Module .\SharpHound.ps1
    Invoke-BloodHound -CollectionMethod All -Domain company.local

    # Output: ZIP file with JSON data
    # Import into BloodHound GUI for analysis
    ```

    **What it does:**

    - Maps Active Directory relationships and trusts
    - Identifies shortest paths to Domain Admin
    - Finds Kerberoastable accounts
    - Detects weak ACLs and permissions
    - Discovers local admin rights across machines
    - Analyzes group membership chains
    - Highlights high-value targets

    **Real talk:**

    - Absolute game-changer for AD pentesting
    - GUI makes complex AD relationships visual
    - Will show you attack paths you didn't know existed
    - Essential for red team engagements
    - Blue teams: use it defensively to find weaknesses first
    - SOC teams will notice SharpHound running (noisy)

=== "PingCastle - AD Security Assessment"

    ```powershell
    # Download PingCastle
    Invoke-WebRequest -Uri "https://github.com/vletoux/pingcastle/releases/latest/download/PingCastle.zip" -OutFile "PingCastle.zip"
    Expand-Archive -Path "PingCastle.zip" -DestinationPath ".\PingCastle"
    cd PingCastle

    # Run basic healthcheck (generates HTML report)
    .\PingCastle.exe --healthcheck

    # Scan specific domain
    .\PingCastle.exe --healthcheck --server dc01.company.local

    # Advanced scan with all options
    .\PingCastle.exe --healthcheck --level Full

    # Scanner mode (find vulnerabilities)
    .\PingCastle.exe --scanner aclcheck

    # Available scanners:
    # - aclcheck: Dangerous ACLs
    # - antivirus: AV status on computers
    # - computerversion: OS versions
    # - foreignusers: Users from external domains
    # - laps_bitlocker: LAPS and BitLocker deployment
    # - nullsession: Null session vulnerabilities
    # - oxidbindings: Network interface enumeration
    # - smb: SMB signing and encryption
    # - spooler: Print Spooler service
    # - startup: GPO startup scripts
    # - zerologon: ZeroLogon vulnerability (CVE-2020-1472)
    ```

    **What it does:**

    - Generates comprehensive AD security report
    - Assigns security score (0-100) with risk breakdown
    - Checks for common AD misconfigurations
    - Identifies stale accounts and weak passwords
    - Validates delegation settings
    - Reviews GPO security
    - Detects vulnerable protocols (LLMNR, NBT-NS)
    - Tracks security posture over time

    **Real talk:**

    - Freemium model (basic features free, advanced paid)
    - Fastest way to get AD security score
    - HTML reports are executive-friendly
    - Run quarterly to track security improvements
    - Less technical than BloodHound, more compliance-focused
    - Great for audit preparation (SOC 2, ISO 27001)

=== "Seatbelt - Security Posture Collection"

    ```powershell
    # Download compiled binary
    Invoke-WebRequest -Uri "https://github.com/GhostPack/Seatbelt/releases/latest/download/Seatbelt.exe" -OutFile "Seatbelt.exe"

    # Run all checks
    .\Seatbelt.exe -group=all

    # Run specific check groups
    .\Seatbelt.exe -group=system      # System information
    .\Seatbelt.exe -group=user        # User context
    .\Seatbelt.exe -group=misc        # Miscellaneous
    .\Seatbelt.exe -group=chromium    # Browser data
    .\Seatbelt.exe -group=remote      # Remote session info

    # Run specific checks
    .\Seatbelt.exe WindowsDefender    # Windows Defender status
    .\Seatbelt.exe AntiVirus          # Installed AV products
    .\Seatbelt.exe CredEnum           # Credential enumeration
    .\Seatbelt.exe Processes          # Running processes
    .\Seatbelt.exe NetworkShares      # Network shares

    # Output to file
    .\Seatbelt.exe -group=all -outputfile="seatbelt_output.txt"

    # Quiet mode (less output)
    .\Seatbelt.exe -group=all -q
    ```

    **What it does:**

    - Enumerates security configurations (not exploitation)
    - Checks Windows Defender and AV status
    - Lists EDR products and security tools
    - Enumerates running processes and services
    - Collects PowerShell logging settings
    - Reviews AppLocker and WDAC policies
    - Identifies interesting files (KeePass, PuTTY configs)
    - Checks LAPS (Local Admin Password Solution) status

    **Real talk:**

    - Part of GhostPack toolkit (C#, well-maintained)
    - Designed for post-exploitation situational awareness
    - Less aggressive than WinPEAS (defensive focus)
    - Great for blue team assessments
    - Won't suggest exploits, just reports facts
    - Compile from source if AV blocks pre-built binary

=== "Snaffler - Sensitive File Hunter"

    ```powershell
    # Download from releases
    Invoke-WebRequest -Uri "https://github.com/SnaffCon/Snaffler/releases/latest/download/Snaffler.exe" -OutFile "Snaffler.exe"

    # Basic scan (current user context)
    .\Snaffler.exe -s

    # Scan specific domain
    .\Snaffler.exe -d company.local -s

    # Output to file
    .\Snaffler.exe -s -o snaffler_results.txt

    # Verbose logging
    .\Snaffler.exe -s -v Trace

    # Target specific file shares
    .\Snaffler.exe -s -n \\fileserver\share

    # Search for specific patterns
    .\Snaffler.exe -s -m "password|secret|confidential"
    ```

    **What it does:**

    - Crawls network file shares for sensitive data
    - Searches for passwords in files (config, scripts, documents)
    - Identifies PII (social security numbers, credit cards)
    - Finds database connection strings
    - Discovers SSH keys, certificates, API tokens
    - Locates KeePass databases, password managers
    - Checks for overly permissive share permissions
    - Classifies findings by sensitivity

    **Real talk:**

    - VERY noisy - generates tons of SMB traffic
    - IT/SOC will notice if monitoring file access
    - Great for finding shadow IT and data sprawl
    - Use in authorized pentests or defensive audits
    - Results often include false positives (review manually)
    - Legal/compliance nightmare if misused

=== "Osquery - System Monitoring"

    ```powershell
    # Download Windows installer
    Invoke-WebRequest -Uri "https://pkg.osquery.io/windows/osquery-5.11.0.msi" -OutFile "osquery.msi"

    # Install silently
    msiexec /i osquery.msi /quiet

    # Start interactive shell
    osqueryi

    # Example queries (run in osqueryi)
    SELECT * FROM users WHERE type = 'local';  # Local users
    SELECT * FROM processes WHERE name = 'powershell.exe';  # PowerShell processes
    SELECT * FROM services WHERE start_type = 'AUTO_START';  # Auto-start services
    SELECT * FROM registry WHERE path LIKE 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run%';  # Startup items
    SELECT * FROM patches;  # Installed patches

    # Windows-specific queries
    SELECT * FROM windows_security_center;  # Security product status
    SELECT * FROM bitlocker_info;  # BitLocker status
    SELECT * FROM windows_crashes;  # Recent crashes
    SELECT * FROM wmi_cli_event_consumers;  # WMI persistence

    # Run as service (persistent monitoring)
    Start-Service osqueryd
    Set-Service osqueryd -StartupType Automatic
    ```

    **What it does:**

    - Exposes Windows system state as SQL database
    - Real-time monitoring of processes, registry, files
    - Fleet-wide deployment for centralized visibility
    - Detects unauthorized software installations
    - Monitors security configuration drift
    - Integrates with Kolide Fleet, Uptycs for management
    - Threat hunting across Windows fleet

    **Real talk:**

    - EDR-lite functionality for free
    - Performance impact low if queries optimized
    - Essential for Windows fleet security at scale
    - Better than SCCM for security queries
    - Integrates with SIEM tools for alerting
    - Learning curve steep but worth it

### :octicons-light-bulb-16: Best Practices

!!! success "Windows Security Hardening"
    - **Windows Defender** - Keep enabled and updated (it's actually good now)
    - **BitLocker** - Enable full-disk encryption on all drives
    - **LAPS** - Randomize local admin passwords across fleet
    - **AppLocker/WDAC** - Application whitelisting (blocks most malware)
    - **Credential Guard** - Protects against credential theft
    - **PowerShell logging** - Enable script block and module logging

!!! warning "Authorization & Ethics"
    - **Get written permission** - Always obtain authorization before testing
    - **Active Directory scans** - BloodHound/PingCastle will alert SOC teams
    - **Network shares** - Snaffler creates massive file access logs
    - **Legal compliance** - Unauthorized use violates CFAA (Computer Fraud and Abuse Act)
    - **Corporate environments** - Coordinate with IT security team

!!! tip "Enterprise Deployment"
    - **Osquery + Fleet** - Centralized Windows fleet monitoring
    - **Scheduled PingCastle** - Monthly AD security reports
    - **SIEM integration** - Ship logs to Splunk, Sentinel, or ELK
    - **GPO enforcement** - Deploy security baselines via Group Policy
    - **Automated remediation** - Use findings to drive Ansible/PowerShell DSC configs

!!! danger "Common Mistakes"
    - **Running as admin by default** - Use standard user, elevate when needed
    - **Disabling Windows Defender** - Don't do this, exclude specific paths instead
    - **Ignoring AMSI** - Anti-Malware Scan Interface blocks malicious scripts
    - **Not testing in lab first** - Tools can crash services or trigger alerts
    - **Blindly trusting findings** - Always validate before exploiting
    - **Old tool versions** - Update monthly, security tools evolve rapidly

______________________________________________________________________

## :octicons-star-16: Worth Checking

<div class="grid cards" markdown>

- :octicons-book-16: __Official Docs__

    ______________________________________________________________________

    [Windows Documentation](https://docs.microsoft.com/en-us/windows/)

    [PowerShell Docs](https://docs.microsoft.com/en-us/powershell/)

    [WSL Documentation](https://docs.microsoft.com/en-us/windows/wsl/)

- :octicons-package-16: __Package Managers__

    ______________________________________________________________________

    [winget](https://docs.microsoft.com/en-us/windows/package-manager/)

    [Chocolatey](https://chocolatey.org/)

    [Scoop](https://scoop.sh/)

- :octicons-tools-16: __Essential Tools__

    ______________________________________________________________________

    [Windows Terminal](https://github.com/microsoft/terminal)

    [PowerToys](https://github.com/microsoft/PowerToys)

    [Visual Studio Code](https://code.visualstudio.com/)

    [Docker Desktop](https://www.docker.com/products/docker-desktop/)

- :octicons-people-16: __Community__

    ______________________________________________________________________

    [r/Windows11](https://reddit.com/r/Windows11)

    [r/PowerShell](https://reddit.com/r/PowerShell)

    [r/bashonubuntuonwindows](https://reddit.com/r/bashonubuntuonwindows)

</div>

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :octicons-rocket-16: **Improved** - Windows finally respects developers thanks to WSL2. Still not as smooth as Linux/macOS for dev work, but gaming + productivity combo is unbeatable.
**Tags:** windows, operating-system, microsoft, wsl
