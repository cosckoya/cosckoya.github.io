---
title: Google Gemini CLI
description: Google AI command-line interface - multimodal AI, code generation, image analysis via terminal
---

# :octicons-code-square-16: Google Gemini CLI

Command-line interface for Google's Gemini AI models. Multimodal capabilities (text, images, code). Free tier with generous limits. Good for quick queries and prototyping. Not as integrated into development workflows as Claude Code or Copilot, but powerful for general-purpose AI tasks.

!!! tip "2026 Update"
    Gemini 2.0 Flash is default model (fast, multimodal). Gemini Ultra 2.0 available for complex tasks. CLI supports image uploads, code execution, function calling. Free tier: 60 queries/minute. Paid tier (Google AI Premium) for higher limits and Gemini Ultra access.

______________________________________________________________________

## :octicons-zap-16: Quick Hits

=== ":octicons-checklist-16: Essential Commands"

    ```bash
    # Installation (Python)
    pip install google-generativeai

    # Or use official CLI wrapper
    npm install -g @google/generative-ai-cli

    # Authentication
    export GOOGLE_API_KEY="your-api-key"  # Get from https://makersuite.google.com/app/apikey

    # Or configure via CLI
    gai config set api_key YOUR_API_KEY

    # Basic usage (text generation)
    gai "explain quantum computing in simple terms"

    gai "write a Python function to validate email addresses"

    # Multimodal (image + text)
    gai "what's in this image?" --image photo.jpg

    gai "generate alt text for accessibility" --image screenshot.png

    # Code generation
    gai "create a React component for user profile card with avatar and bio"

    # Model selection
    gai --model gemini-2.0-flash "fast query"       # Default, fastest
    gai --model gemini-2.0-pro "complex analysis"   # Balanced
    gai --model gemini-ultra-2.0 "hard problem"     # Most capable (requires paid tier)

    # Streaming output (like ChatGPT)
    gai --stream "write a long essay on AI ethics"

    # JSON output mode
    gai --json "list 5 programming languages with their use cases"

    # Temperature control (creativity)
    gai --temperature 0.1 "precise code generation"  # Low = deterministic
    gai --temperature 0.9 "creative story ideas"     # High = creative
    ```

    **Real talk:**

    - Free tier is generous (60 RPM, 1500 RPD)
    - API key required (get from Google AI Studio)
    - Multimodal support is killer feature (analyze images)
    - Not as context-aware as Claude Code (no file system access)
    - Good for one-off queries, not autonomous workflows

=== ":octicons-zap-16: Common Patterns"

    ```bash
    # Code generation workflows
    gai "create FastAPI endpoint for user authentication with JWT"

    gai "write SQL query to find top 10 customers by purchase value"

    gai "generate Dockerfile for Node.js app with multi-stage build"

    # Code review and analysis
    cat src/api.js | gai "review this code for security issues"

    gai "explain what this regex does: ^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$]).{8,}$"

    # Documentation generation
    gai "generate JSDoc comments for this function" < utils/helpers.js

    gai "create README for this project" --context "$(ls -R)"

    # Data analysis
    gai "analyze this CSV and suggest insights" --file data.csv

    gai "convert this JSON to YAML" < config.json

    # Image analysis (multimodal)
    gai "describe this architecture diagram" --image diagram.png

    gai "extract text from this screenshot (OCR)" --image screenshot.png

    gai "what's wrong with this UI?" --image mockup.png

    # Script generation
    gai "bash script to backup PostgreSQL database to S3"

    gai "Python script to scrape website and save to CSV"

    # Testing
    gai "generate unit tests for this function" < src/calculate.py

    gai "create test data for user registration form (JSON)"

    # Debugging
    gai "why does this code throw TypeError?" --code "$(cat app.js)"

    gai "suggest fix for this error: $(npm run build 2>&1)"
    ```

    **Why this works:**

    - Gemini 2.0 Flash is very fast (sub-second responses)
    - Multimodal support enables image analysis workflows
    - Free tier sufficient for most personal use
    - Good at code generation and explanation
    - JSON mode useful for scripting and automation

=== ":octicons-flame-16: Pro Tips & Gotchas"

    !!! success "Best Use Cases"
        - **Quick code snippets** - Faster than searching Stack Overflow
        - **Image analysis** - Describe diagrams, extract text (OCR), analyze UI
        - **Data transformation** - JSON to YAML, CSV analysis, format conversion
        - **Learning** - Explain complex concepts, code review, debugging help
        - **Prototyping** - Generate boilerplate code quickly
        - **Content generation** - Documentation, commit messages, test data

    !!! warning "Limitations"
        - **No file system access** - Can't read/write files autonomously like Claude Code
        - **No bash execution** - Can't run commands or test generated code
        - **Limited context** - Must provide all context in prompt (no codebase awareness)
        - **Not workflow-integrated** - No git integration, no project understanding
        - **Stateless** - Each query is independent (no conversation memory)

    !!! tip "Optimization Techniques"
        - **Use piping** - `cat file.js | gai "review this"` for file input
        - **JSON mode** - Structured output for parsing in scripts
        - **Temperature tuning** - Lower for code (0.1-0.3), higher for ideas (0.7-0.9)
        - **Model selection** - Flash for speed, Pro for accuracy, Ultra for hard problems
        - **Streaming** - Use `--stream` for long responses (better UX)
        - **Caching prompts** - Save common prompts as shell aliases/functions

    !!! danger "Common Gotchas"
        - **Rate limits** - Free tier: 60 RPM (requests per minute), 1500 RPD (per day)
        - **API key security** - Don't commit to git, use environment variable
        - **Hallucinations** - Verify code/facts, especially for critical tasks
        - **Token limits** - Very long inputs may be truncated
        - **No vision in free tier** - Image analysis requires API key upgrade (check latest pricing)
        - **Context window** - 1M tokens for Gemini 2.0, but practical limit lower

    !!! info "Gemini vs Claude Code vs Copilot CLI"
        - **Use Gemini for:**
            - Multimodal tasks (image analysis, OCR)
            - Quick one-off queries
            - Data transformation and analysis
            - Learning and explanation
            - Budget-conscious usage (free tier is generous)
        - **Use Claude Code for:**
            - Autonomous coding workflows
            - Multi-file refactoring
            - Codebase-aware development
            - Git workflows and commits
        - **Use Copilot CLI for:**
            - Shell command discovery
            - Git operations
            - GitHub integration
            - Terminal-focused workflows

______________________________________________________________________

## :octicons-code-16: Practical Examples

### Shell Integration

```bash
# ~/.zshrc or ~/.bashrc

# Quick Gemini query
function ask() {
    gai "$*"
}

# Code review from clipboard
function review-clip() {
    pbpaste | gai "review this code for bugs and improvements"
}

# Image description
function describe-image() {
    gai "describe this image in detail" --image "$1"
}

# Generate commit message from diff
function ai-commit() {
    local diff=$(git diff --staged)
    local message=$(gai "generate concise git commit message for: $diff")
    echo "$message"
    read -p "Use this message? (y/n) " -n 1 -r
    [[ $REPLY =~ ^[Yy]$ ]] && git commit -m "$message"
}

# Explain command
function explain-cmd() {
    gai "explain this shell command: $*"
}
```

### Python Integration

```python
# Use Gemini API directly in Python scripts
import google.generativeai as genai
import os

genai.configure(api_key=os.environ["GOOGLE_API_KEY"])

# Text generation
model = genai.GenerativeModel("gemini-2.0-flash")
response = model.generate_content("Explain async/await in JavaScript")
print(response.text)

# Multimodal (image + text)
import PIL.Image
img = PIL.Image.open("diagram.png")
response = model.generate_content(["Explain this architecture diagram", img])
print(response.text)

# Streaming
response = model.generate_content("Write a long essay", stream=True)
for chunk in response:
    print(chunk.text, end="")

# Function calling (structured output)
tools = [{
    "function_declarations": [{
        "name": "get_weather",
        "description": "Get weather for location",
        "parameters": {
            "type": "object",
            "properties": {
                "location": {"type": "string"},
                "unit": {"type": "string", "enum": ["celsius", "fahrenheit"]}
            }
        }
    }]
}]

model = genai.GenerativeModel("gemini-2.0-flash", tools=tools)
response = model.generate_content("What's the weather in London?")
```

### Automation Scripts

```bash
#!/bin/bash
# auto-document.sh - Generate documentation for all functions in a file

for file in src/**/*.js; do
    echo "Documenting $file..."
    gai "add JSDoc comments to all functions" < "$file" > "$file.documented"
    diff "$file" "$file.documented"
    read -p "Apply changes? (y/n) " -n 1 -r
    [[ $REPLY =~ ^[Yy]$ ]] && mv "$file.documented" "$file"
done
```

______________________________________________________________________

## :octicons-book-16: Learning Resources

### :octicons-mortar-board-16: Official Resources

- **[Google AI Studio](https://makersuite.google.com/)** - Web interface and API key management
- **[Gemini API Documentation](https://ai.google.dev/docs)** - Official API docs
- **[Gemini Quickstart](https://ai.google.dev/tutorials/python_quickstart)** - Python quickstart guide
- **[Gemini Models](https://ai.google.dev/models/gemini)** - Model capabilities and pricing

### :octicons-code-16: Example Use Cases

!!! example "Development"
    - **Code generation** - "Create Express middleware for rate limiting"
    - **Refactoring** - "Convert this class to functional component"
    - **Testing** - "Generate edge case tests for password validation"
    - **Documentation** - "Write API docs for these endpoints"

!!! example "Data & Analysis"
    - **CSV analysis** - "Summarize trends in this sales data"
    - **JSON transformation** - "Convert this OpenAPI spec to Postman collection"
    - **Regex** - "Create regex to validate phone numbers (international)"
    - **SQL** - "Write query to find duplicate records"

!!! example "Multimodal Tasks"
    - **OCR** - "Extract text from this receipt"
    - **Diagram analysis** - "Explain this system architecture diagram"
    - **UI feedback** - "Suggest improvements to this landing page design"
    - **Accessibility** - "Generate alt text for these product images"

______________________________________________________________________

## :octicons-star-16: Worth Checking

<div class="grid cards" markdown>

- :octicons-book-16: __Official Docs__

    ______________________________________________________________________

    [Google AI Studio](https://makersuite.google.com/)

    [Gemini API Docs](https://ai.google.dev/docs)

    [Python SDK](https://ai.google.dev/tutorials/python_quickstart)

    [Gemini Models](https://ai.google.dev/models/gemini)

- :octicons-tools-16: __Tools & SDKs__

    ______________________________________________________________________

    [Python Client](https://pypi.org/project/google-generativeai/)

    [Node.js SDK](https://www.npmjs.com/@google/generative-ai)

    [REST API](https://ai.google.dev/api/rest)

- :octicons-people-16: __Community__

    ______________________________________________________________________

    [Google AI Community](https://developers.google.com/community)

    [r/googlecloud](https://reddit.com/r/googlecloud)

    [Stack Overflow [gemini-api]](https://stackoverflow.com/questions/tagged/gemini-api)

- :octicons-mortar-board-16: __Learning__

    ______________________________________________________________________

    [Prompt Engineering](https://ai.google.dev/docs/prompt_best_practices)

    [Code Examples](https://github.com/google/generative-ai-docs)

    [Gemini Cookbook](https://github.com/google-gemini/cookbook)

</div>

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :octicons-zap-16: **Solid Alternative** - Gemini CLI is good for quick queries and multimodal tasks. Free tier is generous. Not as workflow-integrated as Claude Code or Copilot, but powerful for general-purpose AI. Best for one-off tasks, image analysis, and learning.
**Tags:** gemini, google, ai, cli, multimodal
