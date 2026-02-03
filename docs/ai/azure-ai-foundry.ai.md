---
title: Azure AI Foundry
description: Azure's AI platform - OpenAI models, custom models, ML workflows, enterprise features, responsible AI tools
---

# :fontawesome-brands-microsoft: Azure AI Foundry

Microsoft's unified AI platform (formerly Azure AI Studio). Access GPT-4, GPT-4 Turbo, GPT-3.5 via Azure OpenAI Service. Custom models, prompt flow, evaluation tools. Enterprise-grade security and compliance. Integrated with Microsoft ecosystem.

!!! tip "2026 Update"
    GPT-4 Turbo with 128k context. DALL-E 3 for image generation. Whisper for speech-to-text. Custom GPTs in Azure. Content safety built-in. Private endpoints standard. On Your Data feature for RAG without code.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Essential API Usage"

    ```python
    # Install Azure SDK
    pip install openai azure-identity

    # Azure OpenAI with GPT-4
    from openai import AzureOpenAI
    from azure.identity import DefaultAzureCredential

    client = AzureOpenAI(
        api_version="2024-02-15-preview",
        azure_endpoint="https://myresource.openai.azure.com",
        azure_ad_token_provider=DefaultAzureCredential().get_token  # (1)!
    )

    response = client.chat.completions.create(
        model="gpt-4-turbo",  # (2)!
        messages=[
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": "Explain containerization"}
        ],
        max_tokens=800,
        temperature=0.7
    )

    print(response.choices[0].message.content)
    ```

    1. Managed Identity auth (recommended), or use API key
    2. Model is deployment name (created in Azure portal)

    ```python
    # Streaming responses
    response = client.chat.completions.create(
        model="gpt-4-turbo",
        messages=[{"role": "user", "content": "Write a poem"}],
        stream=True  # (1)!
    )

    for chunk in response:
        if chunk.choices[0].delta.content:
            print(chunk.choices[0].delta.content, end='', flush=True)
    ```

    1. Streaming recommended for better UX (token-by-token)

    ```python
    # Function calling (tools)
    import json

    tools = [{
        "type": "function",
        "function": {
            "name": "get_weather",
            "description": "Get weather for a location",
            "parameters": {
                "type": "object",
                "properties": {
                    "location": {"type": "string"},
                    "unit": {"type": "string", "enum": ["celsius", "fahrenheit"]}
                },
                "required": ["location"]
            }
        }
    }]  # (1)!

    response = client.chat.completions.create(
        model="gpt-4-turbo",
        messages=[{"role": "user", "content": "What's the weather in NYC?"}],
        tools=tools,
        tool_choice="auto"  # (2)!
    )

    # Check if function called
    if response.choices[0].message.tool_calls:
        tool_call = response.choices[0].message.tool_calls[0]
        function_args = json.loads(tool_call.function.arguments)
        print(f"Calling {tool_call.function.name} with {function_args}")  # (3)!
    ```

    1. Define functions GPT can call (JSON schema)
    2. `auto` lets model decide, `none` disables, `required` forces
    3. Your code executes function, sends result back to GPT

    ```python
    # On Your Data (RAG without infrastructure)
    response = client.chat.completions.create(
        model="gpt-4-turbo",
        messages=[{"role": "user", "content": "What are our Q4 results?"}],
        extra_body={
            "data_sources": [{
                "type": "azure_search",  # (1)!
                "parameters": {
                    "endpoint": "https://mysearch.search.windows.net",
                    "index_name": "financial-docs",
                    "authentication": {
                        "type": "api_key",
                        "key": "search-key"
                    }
                }
            }]
        }
    )

    print(response.choices[0].message.content)
    print("\nCitations:", response.choices[0].message.context)  # (2)!
    ```

    1. Azure AI Search integration for RAG (automatic)
    2. Citations show source documents

    **Real talk:**

    - Azure OpenAI is GPT-3.5/4 with enterprise features
    - Pay per token (input + output), no minimum spend
    - GPT-4 Turbo: $10/1M input, $30/1M output tokens
    - Regional quotas (TPM - tokens per minute)
    - Managed Identity better than API keys

=== ":fontawesome-solid-bolt: Common Patterns"

    ```python
    # Prompt Flow (visual workflow designer)
    # Define in Azure portal, execute via SDK

    from azure.ai.ml import MLClient
    from azure.identity import DefaultAzureCredential

    ml_client = MLClient(
        DefaultAzureCredential(),
        subscription_id="sub-id",
        resource_group_name="rg-name",
        workspace_name="workspace-name"
    )

    # Execute prompt flow
    result = ml_client.promptflow.invoke(
        flow="customer-support-flow",  # (1)!
        data={"question": "How do I reset my password?"}
    )

    print(result['answer'])
    ```

    1. Flows created in Azure AI Foundry UI (drag-and-drop)

    ```python
    # Content Safety (moderation)
    from azure.ai.contentsafety import ContentSafetyClient
    from azure.core.credentials import AzureKeyCredential

    safety_client = ContentSafetyClient(
        endpoint="https://mysafety.cognitiveservices.azure.com",
        credential=AzureKeyCredential("key")
    )

    from azure.ai.contentsafety.models import AnalyzeTextOptions

    result = safety_client.analyze_text(
        AnalyzeTextOptions(text="User input text here")
    )  # (1)!

    # Check severity (0-6, higher = more severe)
    if result.hate_result.severity > 4:
        print("Content blocked: hate speech")  # (2)!
    ```

    1. Analyzes text for hate, violence, self-harm, sexual content
    2. Severity thresholds configurable per category

    ```python
    # Custom model fine-tuning
    # 1. Prepare training data (JSONL format)
    # 2. Upload to Azure Blob Storage
    # 3. Create fine-tuning job

    from azure.ai.ml.entities import FineTuningJob

    job = FineTuningJob(
        model="gpt-3.5-turbo",
        training_file="azureml://datastores/workspaceblobstore/paths/train.jsonl",
        validation_file="azureml://datastores/workspaceblobstore/paths/val.jsonl",
        hyperparameters={
            "n_epochs": 3,
            "batch_size": 8,
            "learning_rate_multiplier": 0.1
        }
    )

    fine_tuned = ml_client.jobs.create_or_update(job)  # (1)!
    ```

    1. Fine-tuning creates custom deployment (use like base model)

    ```python
    # Batch processing (cost-effective for bulk)
    # Upload JSONL with multiple requests
    batch_input = [
        {"custom_id": "req-1", "method": "POST", "url": "/chat/completions", "body": {...}},
        {"custom_id": "req-2", "method": "POST", "url": "/chat/completions", "body": {...}}
    ]

    # Submit batch job (50% discount vs real-time)
    batch_job = client.batches.create(
        input_file_id="file-123",
        endpoint="/v1/chat/completions",
        completion_window="24h"  # (1)!
    )

    # Retrieve results later
    results = client.batches.retrieve(batch_job.id)
    ```

    1. Batch jobs complete within 24 hours, much cheaper

    ```csharp
    // C# SDK (first-class Azure support)
    using Azure.AI.OpenAI;
    using Azure.Identity;

    var client = new OpenAIClient(
        new Uri("https://myresource.openai.azure.com"),
        new DefaultAzureCredential()  // (1)!
    );

    var chatOptions = new ChatCompletionsOptions
    {
        DeploymentName = "gpt-4-turbo",
        Messages =
        {
            new ChatRequestSystemMessage("You are helpful"),
            new ChatRequestUserMessage("Explain async/await")
        },
        MaxTokens = 800
    };

    var response = await client.GetChatCompletionsAsync(chatOptions);
    Console.WriteLine(response.Value.Choices[0].Message.Content);  // (2)!
    ```

    1. Managed Identity seamless in Azure environment
    2. C# SDK is excellent (Microsoft's primary language)

    **Why this works:**

    - Enterprise features out of box (compliance, security)
    - Managed Identity eliminates credential management
    - Content Safety prevents brand risk
    - On Your Data simplifies RAG (no vector DB setup)
    - Prompt Flow enables non-developers to build AI apps

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Managed Identity** - Use instead of API keys (better security)
        - **Content Safety** - Always filter user input/output in production
        - **Private endpoints** - Keep traffic within Azure network
        - **Prompt Flow** - Visual workflows easier to maintain than code
        - **Regional deployment** - Deploy near users (latency)
        - **Quotas** - Request TPM increases early (process takes days)
        - **Monitoring** - Use Application Insights for observability

    !!! warning "Security"
        - **Private endpoints** - Disable public access for production
        - **RBAC** - Use Cognitive Services User role (least privilege)
        - **Network isolation** - VNet integration for sensitive workloads
        - **Data residency** - Choose region for compliance (EU, US)
        - **Audit logs** - Enable diagnostics for compliance
        - **Content filtering** - Required for responsible AI

    !!! tip "Performance"
        - **Streaming** - Reduces time to first token significantly
        - **Batch API** - 50% discount for non-real-time workloads
        - **Caching** - Cache common responses (Redis, Cosmos DB)
        - **Regional selection** - East US 2 has most capacity
        - **Model selection** - GPT-3.5 Turbo for speed, GPT-4 for quality

    !!! danger "Gotchas"
        - **Quotas (TPM)** - Per-region, per-model limits (request increase)
        - **Model names** - Deployment names, not OpenAI model names
        - **API versions** - Preview features in specific API versions
        - **Rate limits** - TPM can be hit under load (implement backoff)
        - **Fine-tuning** - Only available for GPT-3.5 Turbo (not GPT-4)
        - **On Your Data** - Requires Azure AI Search (additional cost)
        - **Content Safety** - Can over-filter, test thresholds carefully

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning Resources

### :fontawesome-solid-book-open: Official Docs

- **[Azure AI Foundry Documentation](https://learn.microsoft.com/azure/ai-studio/)** - Complete guide
- **[Azure OpenAI Service](https://learn.microsoft.com/azure/ai-services/openai/)** - API reference
- **[Pricing Calculator](https://azure.microsoft.com/pricing/calculator/)** - Cost estimation

### :fontawesome-solid-rocket: Key Features

- **Azure OpenAI Service** - GPT-4, GPT-3.5, DALL-E, Whisper
- **Prompt Flow** - Visual workflow designer for AI apps
- **Content Safety** - Moderation, PII detection
- **On Your Data** - RAG with Azure AI Search integration
- **Custom models** - Fine-tuning GPT-3.5
- **Responsible AI** - Built-in tools for ethical AI

______________________________________________________________________

## :fontawesome-solid-star: Model Pricing (2026)

| Model | Input $ / 1M tokens | Output $ / 1M tokens | Context Window |
|-------|---------------------|----------------------|----------------|
| GPT-4 Turbo | $10 | $30 | 128k |
| GPT-4 | $30 | $60 | 32k |
| GPT-3.5 Turbo | $0.50 | $1.50 | 16k |
| GPT-4o (optimized) | $5 | $15 | 128k |
| DALL-E 3 | $0.040/image (1024x1024) | - | - |

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-building: **Enterprise Standard** - Best for Microsoft shops. Managed Identity is great. Content Safety essential. On Your Data simplifies RAG. Quotas can be limiting. Excellent C# support.

**Tags:** azure-ai-foundry, ai, llm, gpt-4, microsoft
