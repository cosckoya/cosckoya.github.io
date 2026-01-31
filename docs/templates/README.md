# Documentation Templates

Standardized templates for creating consistent, high-quality technical documentation following project best practices.

## Available Templates

### 1. tech-reference.template.md
**Use for:** Cloud platforms, services, major technologies (AWS, Azure, Kubernetes, etc.)

**Structure:**
- YAML frontmatter with metadata
- Quick Hits section with 3 tabbed code examples
- Multiple detailed sections
- Reference links section

### 2. tool-reference.template.md
**Use for:** Tools, CLI utilities, libraries (Terraform, Docker, kubectl, etc.)

**Structure:**
- YAML frontmatter with metadata
- Quick Hits section with commands and patterns
- Installation and Configuration sections
- Advanced usage section
- Reference links

## Template Placeholders

### Common Placeholders (Both Templates)

| Placeholder | Description | Example |
|------------|-------------|---------|
| `{{TITLE}}` | Technology/tool name | `Amazon Web Services (AWS)` |
| `{{DESCRIPTION}}` | One-line description for SEO | `AWS reference - cloud platform running half the internet` |
| `{{TAG_1}}`, `{{TAG_2}}`, `{{TAG_3}}` | Search tags | `aws`, `cloud`, `infrastructure` |
| `{{INTRO_PARAGRAPH}}` | Cynical, realistic intro (2-3 sentences) | `Cloud platform that runs half the internet. 200+ services (you'll use maybe 10). Pricing is a mystery, bills are scary, but it works.` |
| `{{CODE_LANGUAGE}}` | Language for syntax highlighting | `bash`, `python`, `hcl`, `yaml` |
| `{{LAST_UPDATED}}` | ISO date | `2026-01-31` |

### Tech Reference Specific

| Placeholder | Description | Example |
|------------|-------------|---------|
| `{{TAB_1_TITLE}}` | First tab title | `Essential Services`, `Core Concepts` |
| `{{TAB_1_CODE_EXAMPLES}}` | Code for first tab | Bash commands with inline comments |
| `{{TAB_1_REAL_TALK_BULLETS}}` | Practical tips as bullets | `- Start with EC2, S3, RDS\n- IAM is hell but critical` |
| `{{TAB_2_CODE_EXAMPLES}}` | Code for patterns tab | Implementation examples |
| `{{TAB_2_EXPLANATION_BULLETS}}` | Why patterns work | Bullet explanations |
| `{{PRO_TIPS_BULLETS}}` | Expert tips | Best practices bullets |
| `{{GOTCHAS_BULLETS}}` | Common mistakes | Pitfalls to avoid |
| `{{SECTION_2_TITLE}}` | Custom section name | `Architecture`, `Pricing Model` |
| `{{SECTION_2_CONTENT}}` | Section content | Markdown content |
| `{{DOC_LINK_1}}`, etc | Documentation links | `- [AWS Docs](url)` |
| `{{RELATED_SECTION_1}}`, etc | Related topics | `Deep Dives`, `Best Practices` |

### Tool Reference Specific

| Placeholder | Description | Example |
|------------|-------------|---------|
| `{{TOOL_NAME}}` | Tool name | `Terraform`, `kubectl` |
| `{{ONE_LINE_DESCRIPTION}}` | Brief description | `Infrastructure as Code from HashiCorp` |
| `{{ESSENTIAL_COMMANDS}}` | Basic commands | `terraform init\nterraform plan` |
| `{{REAL_TALK_BULLETS}}` | Practical advice | `- Always run plan before apply` |
| `{{COMMON_PATTERNS_CODE}}` | Usage patterns | Code examples |
| `{{PATTERN_EXPLANATION_BULLETS}}` | Pattern breakdown | Explanation bullets |
| `{{INSTALLATION_COMMANDS}}` | Install steps | Bash install commands |
| `{{CONFIGURATION_CONTENT}}` | Config details | Configuration explanation |
| `{{ADVANCED_SECTION_TITLE}}` | Custom section | `Advanced Usage`, `Integrations` |
| `{{ADVANCED_CONTENT}}` | Advanced content | Markdown content |
| `{{OFFICIAL_DOCS_URL}}` | Official docs link | `https://terraform.io/docs` |
| `{{GITHUB_URL}}` | GitHub repo | `https://github.com/hashicorp/terraform` |
| `{{COMMUNITY_URL}}` | Community link | Forums, Discord, etc. |

## Best Practices

### Content Guidelines

**Tone:**
- Cynical but helpful
- Realistic, not aspirational
- Technical but accessible
- No marketing speak

**Structure:**
- Keep intro paragraph to 2-3 sentences
- Use code blocks with inline comments
- Include "Real talk" bullets for practical advice
- Separate tips from gotchas
- End with references and related links

**Icons:**
- ALWAYS use octicons in markdown syntax (`:octicons-name-16:`)
- NEVER use plain emojis
- Common icons:
  - `:octicons-checklist-16:` - Essential/basics
  - `:octicons-zap-16:` - Common patterns/quick
  - `:octicons-flame-16:` - Pro tips/advanced
  - `:octicons-book-16:` - Documentation
  - `:octicons-tools-16:` - Tools/utilities
  - `:octicons-mark-github-16:` - GitHub links

**Code Examples:**
- Include inline comments
- Show realistic use cases
- Avoid "hello world" examples
- Include error handling where relevant

### Naming Conventions

**Files:**
- Cloud platforms: `{name}.cloud.md` (e.g., `aws.cloud.md`, `azure.cloud.md`)
- Tools: `{name}.tool.md` (e.g., `terraform.tool.md`, `kubectl.tool.md`)
- Services: `{name}.service.md` (e.g., `s3.service.md`, `lambda.service.md`)

**Tags:**
- Use lowercase
- Hyphenate multi-word tags
- Include category tags (cloud, tools, security, etc.)
- Add technology-specific tags

## Usage Examples

### Creating AWS Lambda Documentation

```bash
# 1. Copy template
cp templates/tech-reference.template.md cloud/aws/lambda.service.md

# 2. Fill in placeholders:
TITLE: "AWS Lambda"
DESCRIPTION: "Serverless compute - run code without servers, pay per millisecond, scale infinitely"
TAG_1: "aws"
TAG_2: "serverless"
TAG_3: "lambda"
INTRO_PARAGRAPH: "Serverless compute from AWS. Upload code, AWS runs it. No servers, no infrastructure, no maintenance. Pay only for execution time. Scales automatically. Cold starts are real."
TAB_1_TITLE: "Essential Commands"
CODE_LANGUAGE: "bash"
# ... fill remaining placeholders
```

### Creating Kubectl Documentation

```bash
# 1. Copy template
cp templates/tool-reference.template.md cloud/tools/kubectl.tool.md

# 2. Fill in placeholders:
TOOL_NAME: "kubectl"
ONE_LINE_DESCRIPTION: "Kubernetes CLI - your command center for cluster chaos"
TAG_1: "kubernetes"
TAG_2: "kubectl"
INTRO_PARAGRAPH: "Kubernetes command-line tool. Control clusters, deploy apps, debug production. Required for K8s operations. Syntax is verbose but powerful."
# ... fill remaining placeholders
```

## Template Updates

When updating templates:

1. **Maintain Structure:** Don't break the 3-tab Quick Hits format
2. **Test Rendering:** Validate with `mkdocs build --strict`
3. **Update README:** Document new placeholders
4. **Version Control:** Update existing docs to match new template

## Validation Checklist

Before publishing docs created from templates:

- [ ] All placeholders replaced (search for `{{` in file)
- [ ] Octicons used (no plain emojis)
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

1. **Read Template:** Load appropriate template file
2. **Gather Info:** Ask user for placeholder values
3. **Replace Placeholders:** Substitute `{{PLACEHOLDER}}` with actual content
4. **Validate:** Check all placeholders filled
5. **Write File:** Save to appropriate location
6. **Update Navigation:** Add to SUMMARY.md
7. **Build Test:** Run `mkdocs build --strict`

Example skill workflow:
```python
# Pseudocode for skill
template = read_file('templates/tool-reference.template.md')
content = template.replace('{{TOOL_NAME}}', user_input['name'])
# ... replace all placeholders
write_file(f'cloud/tools/{tool_name}.tool.md', content)
update_summary_md(tool_name)
run_build_test()
```

## Future Enhancements

**Potential additions:**
- API reference template
- Tutorial/guide template
- Troubleshooting template
- Comparison template (Tool A vs Tool B)
- Quick reference card template

---

**Last Updated:** 2026-01-31
**Maintained By:** mkdocs-material-expert skill
