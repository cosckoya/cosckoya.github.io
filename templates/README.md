# Documentation Templates

Standardized templates for creating consistent, high-quality technical documentation following project best practices.

## Available Templates

### 1. page.template.md (Recommended)
**Use for:** All pages — tools, cloud platforms, services, technologies, OS, languages.

**Structure:**
- YAML frontmatter with title, description, and tags array
- Quick Hits section with 3 tabbed code examples (Essential / Common Patterns / Pro Tips & Gotchas)
- Optional sections: installation, configuration, custom deep-dives
- Reference links
- Vibe Check footer

### 2. tech-reference.template.md (Deprecated)
**Use for:** Cloud platforms, services, major technologies.
**Status:** ⚠️ **Deprecated** — Use `page.template.md` instead.

### 3. tool-reference.template.md (Deprecated)
**Use for:** Tools, CLI utilities, libraries.
**Status:** ⚠️ **Deprecated** — Use `page.template.md` instead.

## Template Placeholders (page.template.md)

| Placeholder | Required | Description | Example |
|------------|----------|-------------|---------|
| `{{TITLE}}` | Yes | Technology/tool name | `Amazon Web Services (AWS)` |
| `{{TITLE_ICON}}` | Yes | FontAwesome icon prefix | `:fontawesome-brands-aws:` |
| `{{DESCRIPTION}}` | Yes | One-line description for SEO | `AWS reference - cloud platform running half the internet` |
| `{{INTRO_PARAGRAPH}}` | Yes | Cynical, realistic intro (2-3 sentences) | `Cloud platform that runs half the internet. 200+ services (you'll use maybe 10).` |
| `{{YEAR_UPDATE_NOTE}}` | Yes | Annual update highlight | `AI-powered vulnerability discovery tools.` |
| `{{CODE_LANGUAGE}}` | Yes | Language for syntax highlighting | `bash`, `python`, `hcl`, `yaml` |
| `{{TAB_1_TITLE}}` | Yes | First tab title | `Essential Services`, `Essential Commands` |
| `{{TAB_1_CODE_EXAMPLES}}` | Yes | Code for first tab | Bash commands with inline comments |
| `{{TAB_1_REAL_TALK}}` | Yes | Practical tips as bullet list | `- Start with EC2, S3, RDS\n- IAM is hell but critical` |
| `{{TAB_2_CODE_EXAMPLES}}` | Yes | Code for patterns tab | Implementation examples |
| `{{TAB_2_EXPLANATION}}` | Yes | Why patterns work | Bullet explanations |
| `{{PRO_TIPS}}` | Yes | Expert tips as bullets | Best practices |
| `{{GOTCHAS}}` | Yes | Common mistakes as bullets | Pitfalls to avoid |
| `{{OPTIONAL_INSTALL_SECTION}}` | No | Installation section (omit if N/A) | `## Installation\n\n\`\`\`bash\nbrew install tool\n\`\`\`` |
| `{{OPTIONAL_CONFIG_SECTION}}` | No | Configuration section (omit if N/A) | `## Configuration\n\nConfig details...` |
| `{{OPTIONAL_SECTION_1_TITLE}}` | No | Custom section heading | `## Architecture`, `## Pricing Model` |
| `{{OPTIONAL_SECTION_1_CONTENT}}` | No | Custom section content | Markdown content |
| `{{OPTIONAL_SECTION_2_TITLE}}` | No | Second custom section heading | `## Integrations` |
| `{{OPTIONAL_SECTION_2_CONTENT}}` | No | Second custom section content | Markdown content |
| `{{DOCS_URL}}` | Yes | Official documentation URL | `https://aws.amazon.com/documentation/` |
| `{{GITHUB_URL}}` | No | GitHub repository URL | `https://github.com/aws/aws-cli` |
| `{{RELATED_1}}` | No | Related topic 1 | `Deep Dives`, `Best Practices` |
| `{{RELATED_2}}` | No | Related topic 2 | `Troubleshooting Guide` |
| `{{LAST_UPDATED}}` | Yes | ISO date | `2026-06-01` |
| `{{VIBE_CHECK_ICON}}` | Yes | FontAwesome icon for vibe | `:fontawesome-solid-globe:` |
| `{{VIBE_CHECK_TITLE}}` | Yes | Short vibe label | `Mainstream`, `Industry Standard`, `Essential` |
| `{{VIBE_CHECK_DESC}}` | Yes | Vibe explanation (1 sentence) | `AWS is the default cloud for most production workloads.` |
| `{{TAG_1}}`, `{{TAG_2}}`, `{{TAG_3}}` | Yes | Lowercase search tags | `aws`, `cloud`, `infrastructure` |

## Best Practices

### Content Guidelines

**Tone:**
- Cynical but helpful
- Realistic, not aspirational
- Technical but accessible
- No marketing speak

**Structure:**
- Keep intro paragraph to 2-3 sentences
- Use code blocks with inline comments (`# (1)!`)
- Include "Real talk" bullets for practical advice
- Separate tips from gotchas in the third tab
- End with Vibe Check, date, and tags

**Icons:**
- ALWAYS use FontAwesome (`:fontawesome-solid-...:`)
- NEVER use plain emojis
- Common icons:
  - `:fontawesome-solid-list-check:` - Essential/basics
  - `:fontawesome-solid-bolt:` - Common patterns/quick
  - `:fontawesome-solid-fire:` - Pro tips/advanced
  - `:fontawesome-solid-book:` - Documentation
  - `:fontawesome-solid-wrench:` - Tools/utilities
  - `:fontawesome-brands-github:` - GitHub links

**Code Examples:**
- Include inline annotations `# (1)!`
- Show realistic use cases
- Avoid "hello world" examples
- Include error handling where relevant

### Naming Conventions

**Files:**
- Cloud platforms: `{name}.cloud.md` (e.g., `aws.cloud.md`, `azure.cloud.md`)
- Tools: `{name}.tool.md` (e.g., `terraform.tool.md`, `kubectl.tool.md`)
- Services: `{name}.service.md` (e.g., `s3.service.md`, `lambda.service.md`)
- Operating systems: `{name}.os.md` (e.g., `linux.os.md`)
- AI platforms: `{name}.ai.md` (e.g., `vertex-ai.ai.md`)
- Security: `{name}.1337.md` (e.g., `offensive-security.1337.md`)

**Tags:**
- Use lowercase
- Hyphenate multi-word tags
- Include category tags (cloud, tools, security, etc.)
- Add technology-specific tags

## Usage

```bash
# 1. Copy template to target location
cp templates/page.template.md cloud/tools/new-tool.tool.md

# 2. Replace all {{PLACEHOLDER}} values
# 3. Add entry to appropriate SUMMARY.md
# 4. Validate
zensical build --strict
```

## Validation Checklist

Before publishing docs created from templates:

- [ ] All placeholders replaced (search for `{{` in file)
- [ ] FontAwesome icons used (no plain emojis)
- [ ] Code blocks have language specified
- [ ] "Real talk" bullets are practical and honest
- [ ] Reference links are valid
- [ ] Tags include at least category tag
- [ ] Last updated date is current
- [ ] File follows naming convention
- [ ] Added to appropriate SUMMARY.md
- [ ] Build passes strict mode

## Integration with Skills

Skills can use these templates by:

1. **Read Template:** Load `page.template.md`
2. **Gather Info:** Ask user for placeholder values
3. **Replace Placeholders:** Substitute `{{PLACEHOLDER}}` with actual content
4. **Validate:** Check all placeholders filled
5. **Write File:** Save to appropriate location
6. **Update Navigation:** Add to SUMMARY.md
7. **Build Test:** Run `zensical build --strict`

---

**Last Updated:** 2026-06-01
**Maintained By:** zensical-ecosystem skill
