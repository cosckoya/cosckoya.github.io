![!](resources/img/rorschach.png#center)

# Klaatu Barada Nikto

*You've seen the mask. The ink blot test that reveals more about you than it. Here's the truth: infrastructure breaks, clouds bill you into bankruptcy, and at 3 AM when production is on fire, nobody's coming to save you. This isn't a hero's journey—it's a survival manual. Never compromise, even when AWS support tells you to "try turning it off and on again."*

Technical documentation for people who've learned the hard way. Everything here has been paid for in production incidents, surprise cloud bills, and that special kind of regret that comes from running `rm -rf` without the trailing asterisk.

---

## The Five Pillars of Tech Chaos

*Or: How I Learned to Stop Worrying and Embrace the Reality*

<div class="grid cards" markdown>

- ☁️ **[Cloud](cloud/)**

    ---

    Rent someone else's computer at premium prices. AWS has 200+ services you'll never use. Your bill will surprise you. Every. Single. Month.

- ⚙️ **[DevOps](devops/)**

    ---

    "You build it, you run it." Sounds great until the pager goes off at 2 AM. Automate everything, then automate the automation. It's pipelines all the way down.

- 🐳 **[Containerization](containerization/)**

    ---

    Docker: because your app works on your machine. Kubernetes: because one container orchestrator wasn't painful enough. "It's just YAML" they said. 8000 lines later...

- 🔐 **[Security](security/)**

    ---

    Everything is vulnerable. Your firewall is probably misconfigured. That S3 bucket? Public. The only question is whether you find it before someone else does.

- 🔧 **[Tools](tools/)**

    ---

    Your terminal is your home. Zsh, Neovim, and an unhealthy collection of CLI tools you swear you'll learn properly someday. Probably.

</div>

---

## What's Actually In Here

*Skip the marketing BS. Here's what you're getting.*

| Section | Reality Check | Who This Is For |
|---------|---------------|-----------------|
| **[Cloud](cloud/)** | AWS, Azure, GCP, FinOps (aka "why is our bill $50k?"), Terraform, security theater | Cloud architects who've seen things |
| **[DevOps](devops/)** | Git workflows, CI/CD pipelines, the eternal quest to automate yourself out of a job | SREs and their stockholm syndrome |
| **[Containerization](containerization/)** | Docker, Kubernetes, the YAML industrial complex | Masochists and cloud-native devotees |
| **[Security](security/)** | OSINT, recon, pentesting, breaking things so others can't | Red teams, blue teams, people with questionable hobbies |
| **[Tools](tools/)** | Shell mastery, scanners, editors, the CLI weapons you actually use | Terminal dwellers and vim evangelists |

---

## Choose Your Suffering

*Every role has its special brand of pain.*

### DevOps Engineer

*The pager is your constant companion.*

1. **[DevOps](devops/)** - Learn to love YAML and fear Fridays
2. **[Containerization](containerization/)** - Package your problems in Docker
3. **[Cloud](cloud/)** - Watch your AWS bill climb like Bitcoin in 2021

### Software Developer

*"But it works on my machine" is not a deployment strategy.*

1. **[GitHub](devops/github.md)** - Git gud or go home
2. **[GitHub Actions](devops/github-actions.md)** - CI/CD: Continuous Incidents, Continuous Disappointment
3. **[Containerization](containerization/)** - Containerize before someone makes you
4. **[Claude Code](devops/claude-code.md)** - Let AI write your bugs faster

### Cloud Architect

*Because someone has to make sense of this distributed chaos.*

1. **[Cloud](cloud/)** - AWS, Azure, GCP—pick your poison
2. **[Containerization](containerization/)** - Kubernetes orchestration at scale
3. **[DevOps](devops/)** - Infrastructure as Code or infrastructure as chaos
4. **[Security](security/)** - Know how they'll break in

### Security Engineer

*Everyone's problem becomes your problem.*

1. **[Security](security/)** - Learn to think like an attacker
2. **[Containerization](containerization/container-security.md)** - Yes, containers have vulnerabilities too
3. **[Cloud Security](cloud/cloud-security.md)** - Misconfigured S3 buckets as far as the eye can see
4. **[Tools](tools/)** - Build your arsenal of scanners and exploits

---

## How to Use This Thing

### Navigation

Standard stuff:
- **Breadcrumbs** so you don't get lost
- **Tags** because someone thought they were useful
- **Cross-references** that may or may not be up to date

### Harsh Truths

!!! tip "Bookmark Everything"
    You'll be back. Production will break again. That command you need is buried somewhere in these pages.

!!! info "Search Actually Works"
    Use it. Ctrl+F is faster than scrolling through my ramblings.

!!! success "Try Before You Cry"
    Code examples are here to be copied. Test in dev. Learn from mistakes. Preferably other people's.

!!! danger "Everything Expires"
    Tech moves fast. Commands change. APIs deprecate. Verify dates. Trust nothing.

---

## The Uncompromising Truth

*Ten rules that will save your ass:*

1. **Never hardcode secrets** - Git remembers. Forever.
2. **Automate ruthlessly** - Humans make mistakes. Scripts make consistent mistakes.
3. **Test your backups** - Schrödinger's backup: simultaneously good and worthless until tested
4. **Least privilege always** - Give them root, they'll find new ways to break things
5. **Infrastructure as Code** - ClickOps doesn't scale, doesn't version, doesn't survive you leaving
6. **Monitor or fail silently** - If a service crashes in production and nobody notices, does it make a sound?
7. **Document immediately** - Future you has amnesia and a grudge
8. **Security first** - Because explaining a breach is worse than preventing one
9. **Plan for failure** - Murphy was an optimist
10. **Keep learning** - Today's cutting edge is tomorrow's legacy

---

## The Fine Print

*This documentation grows when I have time and shrinks when I don't.*

Found something wrong? Course you did. Submit a fix or live with it. Perfection is a myth sold by people who don't run production systems.

---

![!](resources/img/zelda.png#center)

![!](resources/img/welcome.png#center)

![!](resources/img/drizzt.jpg#center)

*The ink blot doesn't change. Your interpretation does. You came here looking for answers. What you'll find are problems, solutions that create new problems, and the occasional moment of clarity between incidents. The ranger keeps watch not because the darkness will end, but because someone has to. Rorschach's journal sits on a desk somewhere, recording it all. "None of you understand. I'm not locked in here with you. You're locked in here with me."*

*Welcome to the show.*

**— Klaatu Barada Nikto**
