---
title: Security
description: Comprehensive guide to security practices, tools, and methodologies for securing systems, applications, and data
tags:
  - security
  - pentesting
  - hacking
  - cybersecurity
---

# Security

Cybersecurity is the set of practices, technologies, and processes designed to protect systems, networks, programs, and
data from digital attacks, unauthorized access, and damage. In an increasingly connected world, information security is
essential to protect the confidentiality, integrity, and availability of information.

!!! abstract "Fundamental Principles"
    - **Confidentiality**: Protect sensitive information from unauthorized access
    - **Integrity**: Ensure data is not modified without authorization
    - **Availability**: Ensure systems and data are available when needed
    - **Authentication**: Verify the identity of users and systems
    - **Non-repudiation**: Ensure actions cannot be denied
    - **Authorization**: Control what resources authenticated users can access

______________________________________________________________________

## Cybersecurity Areas

### Defensive Security

Practices and technologies to protect systems from attacks and threats.

**Network Security:**

- Firewalls and intrusion detection/prevention systems
- Network segmentation and VLANs
- VPNs and secure communications
- Network traffic monitoring

**System Security:**

- Operating system hardening
- Patch management and updates
- Access control and least privilege
- Data encryption at rest and in transit

**Application Security:**

- Secure development (SDLC)
- Static (SAST) and Dynamic (DAST) code analysis
- Vulnerability management
- Web Application Firewalls (WAF)

### Offensive Security

Ethical hacking techniques and penetration testing to identify vulnerabilities.

**Ethical Hacking:**

- Reconnaissance and information gathering
- Scanning and enumeration
- Vulnerability exploitation
- Post-exploitation and lateral movement
- Reporting and remediation

**Bug Bounty:**

- Vulnerability reward programs
- Responsible disclosure
- Platforms: HackerOne, Bugcrowd, Synack

______________________________________________________________________

## Security Tools

### Security Distributions

Operating systems specialized in security and pentesting.

=== "Main Distributions"
    - **[Kali Linux](https://www.kali.org)** - Most popular pentesting distribution
    - **[Parrot Security](https://www.parrotsec.org)** - Kali alternative with privacy focus
    - **[BlackArch](https://blackarch.org)** - Arch Linux distribution with 2000+ security tools
    - **[BackBox](https://www.backbox.org)** - Ubuntu-based pentesting distribution
    - **[Fedora Security Spin](https://labs.fedoraproject.org/es/security)** - Fedora for security auditing

=== "Docker Resources"
    - [Kali Docker Images](https://www.kali.org/docs/containers/official-kalilinux-docker-images) - Official Kali Linux
        containers

### Pentesting Tools

=== "Complete Suites"
    - **[Kali Tools Listing](https://tools.kali.org/tools-listing)** - Complete Kali tools catalog
    - **[Burp Suite](https://portswigger.net/burp)** - Integrated web security testing platform
    - **[OWASP ZAP](https://owasp.org/www-project-zap)** - Open-source web security scanner

=== "Reconnaissance"
    - **[Nmap](https://nmap.org)** - Network scanner and security auditing
    - **[Recon-ng](https://github.com/lanmaster53/recon-ng)** - Web reconnaissance framework
    - **[DMitry](https://mor-pah.net/software/dmitry-deepmagic-information-gathering-tool)** - Deepmagic Information
        Gathering Tool
    - **[Skipfish](https://github.com/spinkham/skipfish)** - Active web security scanner
    - **[NmapAutomator](https://github.com/21y4d/nmapAutomator)** - Script to automate Nmap scans

    **Online Tools:**

    - [ping.eu](https://ping.eu) - Network diagnostic tools
    - [HostingChecker](https://hostingchecker.co) - Hosting verification
    - [HTTPStatus](https://httpstatus.io) - HTTP status code verification
    - [SSL Server Test](https://www.ssllabs.com/ssltest) - SSL/TLS configuration testing
    - [Security Headers](https://securityheaders.com) - Security headers analysis
    - [Mozilla SSL Config](https://ssl-config.mozilla.org) - SSL configuration generator

=== "Web Scanning"
    - **[dirsearch](https://github.com/maurosoria/dirsearch)** - Web directory and file search
    - **[DirBuster](https://sourceforge.net/projects/dirbuster)** - Java directory brute force tool
    - **[GoBuster](https://github.com/OJ/gobuster)** - Brute force tool in Go
    - **[Nikto](https://github.com/sullo/nikto)** - Web server scanner
    - **[Dirb](https://github.com/v0re/dirb)** - Web content scanner
    - **[ffuf](https://github.com/ffuf/ffuf)** - Fast web fuzzer in Go
    - **[Wfuzz](https://github.com/xmendez/wfuzz)** - Web fuzzing tool

=== "SSL/TLS Testing"
    - **[sslscan](https://github.com/rbsec/sslscan)** - SSL/TLS cipher testing

=== "Exploitation"
    - **[Metasploit Framework](https://www.metasploit.com)** - Most popular exploitation framework
    - **[Metasploit GitHub](https://github.com/rapid7/metasploit-framework)** - Official repository
    - **[Exploit Database](https://www.exploit-db.com)** - Public exploit archive

=== "Decoding"
    - **[Rot Decode](https://rot13.com)** - ROT13/ROT47 decoder
    - **[Reqbin](https://reqbin.com)** - API development and testing tools

=== "OSINT"
    - **[Maltego](https://www.maltego.com)** - Intelligence and link analysis platform
    - **[CaseFile](https://gitlab.com/kalilinux/packages/casefile)** - Offline analysis tool

______________________________________________________________________

## Google Dorking

Google Dorking is the technique of using Google advanced search operators to find sensitive information.

=== "Resources"
    - **[ExploitDB Google Dorks](https://www.exploit-db.com/google-hacking-database)** - Google Dorks database
    - **[GBHackers Dorks List](https://gbhackers.com/latest-google-dorks-list)** - Updated Google Dorks list
    - **[go-dork](https://github.com/dwisiswant0/go-dork)** - Tool to automate Google Dorking

=== "Dork Examples"
    ```text
    # Search for exposed webcams
    inurl:/view.shtml

    # Search for PDF files on specific site
    site:example.com filetype:pdf

    # Search for passwords in PDFs
    password filetype:pdf site:example.com

    # Search for vulnerable parameters
    ?action= site:example.com

    # Search for configuration files
    intitle:"index of" config.php

    # Search for exposed databases
    intitle:"phpMyAdmin" "Welcome to phpMyAdmin"
    ```

______________________________________________________________________

## Bug Bounty

Vulnerability discovery reward programs.

=== "Resources"
    - **[Holy Tips](https://github.com/HolyBugx/HolyTips)** - Tips collection for bug bounty hunters
    - **[OWASP Juice Shop](https://owasp.org/www-project-juice-shop/)** - Vulnerable web application for practice
    - **[Juice Shop Demo](https://juice-shop.herokuapp.com)** - Juice Shop online demo

=== "Platforms"
    - **HackerOne** - Leading bug bounty platform
    - **Bugcrowd** - Crowdsourced security platform
    - **Synack** - Security researcher network
    - **Intigriti** - European bug bounty platform
    - **YesWeHack** - Collaborative security platform

______________________________________________________________________

## Frameworks and Standards

### OWASP (Open Web Application Security Project)

=== "OWASP Resources"
    - **[OWASP Foundation](https://github.com/OWASP)** - Non-profit organization for application security
    - **[OWASP Cheatsheets](https://github.com/OWASP/CheatSheetSeries)** - Security reference sheets
    - **[OWASP Top 10](https://owasp.org/www-project-top-ten/)** - 10 most critical web security risks

    **OWASP Top 10 (2021):**

    1. Broken Access Control
    1. Cryptographic Failures
    1. Injection
    1. Insecure Design
    1. Security Misconfiguration
    1. Vulnerable and Outdated Components
    1. Identification and Authentication Failures
    1. Software and Data Integrity Failures
    1. Security Logging and Monitoring Failures
    1. Server-Side Request Forgery (SSRF)

### Other Frameworks

- **NIST Cybersecurity Framework**: Cybersecurity risk management framework
- **ISO 27001**: International standard for information security management
- **CIS Controls**: Priority actions set for cyber defense
- **MITRE ATT&CK**: Knowledge base of adversary tactics and techniques

______________________________________________________________________

## Wordlists

Word lists for brute force attacks and fuzzing.

=== "Wordlist Resources"
    - **[Awesome Wordlist](https://github.com/gmelodie/awesome-wordlists)** - Curated wordlist collection
    - **[Probable Wordlists](https://github.com/berzerk0/Probable-Wordlists)** - Real data-based wordlists
    - **[SecLists](https://github.com/danielmiessler/SecLists)** - Security testing list collection
    - **[RockYou](https://github.com/brannondorsey/naive-hashcat/releases/tag/data)** - Leaked password wordlist

=== "Custom Wordlist Ideas"
    - **[Fictional Deities](https://en.wikipedia.org/wiki/List_of_fictional_deities)** - Fictional deities
    - **[Mythologies](https://simple.wikipedia.org/wiki/List_of_mythologies)** - World mythologies
    - **[Vampires](https://en.wikipedia.org/wiki/Vampire_folklore_by_region)** - Vampire folklore by region
    - **[Lovecraft Creatures](https://lovecraft.fandom.com/wiki/Category:Creatures)** - Lovecraft creatures
    - **[Behind the Name](https://www.behindthename.com)** - Name etymology

______________________________________________________________________

## Learning & Practice

### Learning Platforms

=== "Online Labs"
    - **[HackTheBox](https://www.hackthebox.com)** - Pentesting practice platform
    - **[TryHackMe](https://tryhackme.com)** - Gamified cybersecurity learning
    - **[PentesterLab](https://pentesterlab.com)** - Web pentesting exercises
    - **[OverTheWire](https://overthewire.org)** - Security wargames
    - **[VulnHub](https://www.vulnhub.com)** - Vulnerable virtual machines
    - **[Root-Me](https://www.root-me.org)** - Hacking challenge platform

=== "CTF (Capture The Flag)"
    - **[CTFtime](https://ctftime.org)** - CTF calendar and rankings
    - **[PicoCTF](https://picoctf.org)** - Educational CTF
    - **[HackThisSite](https://www.hackthissite.org)** - Legal hacking challenges

=== "Learning Resources"
    - **[Hackaday.io](https://hackaday.io)** - Hackers and makers community
    - **[Hackster.io](https://www.hackster.io)** - Hardware and software projects
    - **[PortSwigger Web Security Academy](https://portswigger.net/web-security)** - Free web security academy

______________________________________________________________________

## Security Certifications

### Offensive Certifications

- **OSCP (Offensive Security Certified Professional)**: Practical pentesting
- **OSWE (Offensive Security Web Expert)**: Web application security
- **OSCE (Offensive Security Certified Expert)**: Advanced exploitation
- **GPEN (GIAC Penetration Tester)**: Penetration testing
- **CEH (Certified Ethical Hacker)**: Ethical hacking

### Defensive Certifications

- **CISSP (Certified Information Systems Security Professional)**: Security management
- **Security+**: Security fundamentals (CompTIA)
- **GCIA (GIAC Certified Intrusion Analyst)**: Intrusion analysis
- **GCIH (GIAC Certified Incident Handler)**: Incident handling
- **CISM (Certified Information Security Manager)**: Security management

### Cloud Security Certifications

- **AWS Certified Security - Specialty**: AWS security
- **Azure Security Engineer Associate**: Azure security
- **Google Cloud Professional Cloud Security Engineer**: GCP security

______________________________________________________________________

## Best Practices

!!! success "Security Principles"
    1. **Defense in Depth**: Multiple security layers
    1. **Least Privilege**: Minimum necessary privileges
    1. **Separation of Duties**: Segregation of critical functions
    1. **Zero Trust**: Don't trust any entity by default
    1. **Security by Design**: Security integrated from design
    1. **Keep it Simple**: Complexity is the enemy of security
    1. **Fail Securely**: Failures should be secure
    1. **Security Awareness**: Continuous security training
    1. **Regular Audits**: Periodic security audits
    1. **Incident Response Plan**: Incident response plan

______________________________________________________________________

## Communities and Resources

=== "Communities"
    - **[r/netsec](https://www.reddit.com/r/netsec/)** - Network security
    - **[r/AskNetsec](https://www.reddit.com/r/AskNetsec/)** - Security Q&A
    - **[r/cybersecurity](https://www.reddit.com/r/security/)** - General cybersecurity
    - **[SecurityTube](http://www.securitytube.net/)** - Security videos

=== "Blogs and Resources"
    - **[Krebs on Security](https://krebsonsecurity.com)** - Brian Krebs blog
    - **[Troy Hunt's Blog](https://www.troyhunt.com)** - Security and breach notifications
    - **[Schneier on Security](https://www.schneier.com)** - Bruce Schneier blog
    - **[The Hacker News](https://thehackernews.com)** - Cybersecurity news

=== "Podcasts"
    - **Darknet Diaries**: Cybersecurity stories
    - **Security Now**: Security news and analysis
    - **Risky Business**: Information security news

______________________________________________________________________

## Related Topics

- [DevOps Tools](../devops/) - Security tools and automation
- [Cloud Security](../cloud/) - Cloud platform security
- [Containerization Security](../containerization/container-security.md) - Container hardening and security
