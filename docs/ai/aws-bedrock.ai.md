---
title: AWS Bedrock
description: AWS managed AI service - foundation models from Anthropic, Meta, Mistral, serverless inference, RAG support
---

# :fontawesome-brands-aws: AWS Bedrock

AWS managed service for foundation models. Access Claude, Llama, Mistral, Titan via API. Serverless inference, no infrastructure management. RAG (Retrieval Augmented Generation) support with Knowledge Bases. Pay per token.

!!! tip "2026 Update"
    Claude 3.5 Sonnet and Opus 4 available. Multi-modal support (text, images, documents). Custom model import (bring your own weights). Agents framework for autonomous workflows. Guardrails for content filtering. Model evaluation tools integrated.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Essential API Usage"

    ```python
    # Install AWS SDK
    pip install boto3

    # Basic text generation with Claude 3.5 Sonnet
    import boto3
    import json

    bedrock = boto3.client('bedrock-runtime', region_name='us-east-1')

    prompt = "Explain quantum computing in simple terms"

    body = json.dumps({
        "anthropic_version": "bedrock-2023-05-31",
        "max_tokens": 1024,
        "messages": [
            {"role": "user", "content": prompt}
        ]
    })  # (1)!

    response = bedrock.invoke_model(
        modelId='anthropic.claude-3-5-sonnet-20240620-v1:0',  # (2)!
        body=body
    )

    response_body = json.loads(response['body'].read())
    print(response_body['content'][0]['text'])
    ```

    1. Anthropic's message format (not OpenAI-compatible)
    2. Model IDs are versioned, check console for latest

    ```python
    # Streaming responses (recommended for UX)
    response = bedrock.invoke_model_with_response_stream(
        modelId='anthropic.claude-3-5-sonnet-20240620-v1:0',
        body=body
    )

    for event in response['body']:
        chunk = json.loads(event['chunk']['bytes'])
        if chunk['type'] == 'content_block_delta':
            if 'delta' in chunk and 'text' in chunk['delta']:
                print(chunk['delta']['text'], end='', flush=True)  # (1)!
    ```

    1. Streaming provides real-time feedback (better user experience)

    ```python
    # Multi-modal input (image + text)
    import base64

    with open('diagram.png', 'rb') as f:
        image_data = base64.b64encode(f.read()).decode('utf-8')

    body = json.dumps({
        "anthropic_version": "bedrock-2023-05-31",
        "max_tokens": 2048,
        "messages": [{
            "role": "user",
            "content": [
                {
                    "type": "image",
                    "source": {
                        "type": "base64",
                        "media_type": "image/png",
                        "data": image_data
                    }
                },
                {
                    "type": "text",
                    "text": "Explain this architecture diagram"
                }
            ]
        }]
    })  # (1)!
    ```

    1. Claude 3 models support images (PNG, JPEG, WebP, GIF)

    ```bash
    # AWS CLI usage
    aws bedrock-runtime invoke-model \
        --model-id anthropic.claude-3-5-sonnet-20240620-v1:0 \
        --body '{"anthropic_version":"bedrock-2023-05-31","max_tokens":1024,"messages":[{"role":"user","content":"Hello"}]}' \
        --cli-binary-format raw-in-base64-out \
        response.json  # (1)!

    cat response.json | jq -r '.content[0].text'  # (2)!
    ```

    1. Response written to file (AWS CLI doesn't stream to stdout)
    2. Use jq to extract text from response JSON

    **Real talk:**

    - Pay per token (input + output), no upfront costs
    - Claude 3.5 Sonnet: $3/MTok input, $15/MTok output
    - No rate limits on API (scale infinitely)
    - Regional availability matters (us-east-1, us-west-2 have most models)
    - IAM permissions required (bedrock:InvokeModel)

=== ":fontawesome-solid-bolt: Common Patterns"

    ```python
    # RAG with Bedrock Knowledge Bases
    import boto3

    bedrock_agent = boto3.client('bedrock-agent-runtime', region_name='us-east-1')

    query = "What are the company policies on remote work?"

    response = bedrock_agent.retrieve_and_generate(
        input={'text': query},
        retrieveAndGenerateConfiguration={
            'type': 'KNOWLEDGE_BASE',
            'knowledgeBaseConfiguration': {
                'knowledgeBaseId': 'KB123ABC',  # (1)!
                'modelArn': 'arn:aws:bedrock:us-east-1::foundation-model/anthropic.claude-3-sonnet-20240229-v1:0'
            }
        }
    )

    print(response['output']['text'])
    print("\nSources:")
    for citation in response['citations']:
        for reference in citation['retrievedReferences']:
            print(f"- {reference['location']['s3Location']['uri']}")  # (2)!
    ```

    1. Knowledge Base ID from Bedrock console (indexes S3 documents)
    2. Citations show source documents (transparency for users)

    ```python
    # Bedrock Agents (autonomous workflows)
    agent_client = boto3.client('bedrock-agent-runtime')

    response = agent_client.invoke_agent(
        agentId='AGENT123',
        agentAliasId='ALIAS456',
        sessionId='session-001',  # (1)!
        inputText='Book a flight to NYC next week'
    )

    for event in response['completion']:
        if 'chunk' in event:
            chunk = event['chunk']
            if 'bytes' in chunk:
                print(chunk['bytes'].decode('utf-8'), end='', flush=True)  # (2)!
    ```

    1. Session ID maintains conversation context across requests
    2. Agents can call Lambda functions, APIs, query databases

    ```python
    # Guardrails (content filtering)
    body = json.dumps({
        "anthropic_version": "bedrock-2023-05-31",
        "max_tokens": 1024,
        "messages": [{"role": "user", "content": prompt}]
    })

    response = bedrock.invoke_model(
        modelId='anthropic.claude-3-5-sonnet-20240620-v1:0',
        body=body,
        guardrailIdentifier='guardrail-123',  # (1)!
        guardrailVersion='1'
    )

    # Response blocked if violates guardrails
    if response['ResponseMetadata']['HTTPStatusCode'] == 400:
        print("Content blocked by guardrails")  # (2)!
    ```

    1. Guardrails filter harmful content, PII, topics
    2. Guardrails can block input or output (configurable)

    ```python
    # Custom model import (fine-tuned models)
    # 1. Upload model weights to S3
    # 2. Create custom model in Bedrock console
    # 3. Use like foundation model

    response = bedrock.invoke_model(
        modelId='arn:aws:bedrock:us-east-1:123456789:custom-model/my-model-v1',  # (1)!
        body=body
    )
    ```

    1. Custom models use ARN instead of model ID

    ```python
    # Error handling and retries
    from botocore.exceptions import ClientError
    import time

    def invoke_with_retry(model_id, body, max_retries=3):
        for attempt in range(max_retries):
            try:
                response = bedrock.invoke_model(
                    modelId=model_id,
                    body=body
                )
                return json.loads(response['body'].read())
            except ClientError as e:
                if e.response['Error']['Code'] == 'ThrottlingException':  # (1)!
                    if attempt < max_retries - 1:
                        time.sleep(2 ** attempt)  # Exponential backoff
                        continue
                raise
    ```

    1. Throttling rare but can occur during traffic spikes

    **Why this works:**

    - Serverless means no cold starts (sub-second latency)
    - Knowledge Bases handle embeddings, vector search automatically
    - Agents framework simplifies complex workflows
    - Guardrails prevent brand risk (filter harmful content)
    - IAM integration provides fine-grained access control

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Streaming** - Always use `invoke_model_with_response_stream` for UX
        - **System prompts** - Use system field for instructions (separate from user content)
        - **Token management** - Monitor costs with CloudWatch metrics
        - **Regional failover** - Multi-region deployment for high availability
        - **Caching** - Cache common responses (DynamoDB, ElastiCache)
        - **Prompt engineering** - Claude responds well to XML tags for structure
        - **Guardrails** - Enable for production (filter PII, harmful content)

    !!! warning "Security"
        - **IAM permissions** - Restrict `bedrock:InvokeModel` to specific models
        - **VPC endpoints** - Use VPC endpoints for private access (no internet)
        - **Encryption** - Data encrypted in transit and at rest (automatic)
        - **Audit logging** - Enable CloudTrail for compliance
        - **API keys** - Don't expose AWS credentials in client-side code
        - **Guardrails** - Essential for user-generated content

    !!! tip "Performance"
        - **Streaming** - Reduces perceived latency significantly
        - **Batch processing** - Use `invoke_model` batch for high throughput
        - **Regional selection** - Choose region near users (latency)
        - **Model selection** - Claude Haiku for speed, Opus for quality
        - **Token limits** - Set max_tokens to prevent runaway costs

    !!! danger "Gotchas"
        - **Model availability** - Not all models in all regions (check console)
        - **Token counting** - Anthropic tokens != OpenAI tokens (estimate 1.3x)
        - **Context window** - Claude 3.5: 200k tokens (check current limits)
        - **Rate limits** - Soft limits per account (request increase via support)
        - **Pricing** - Input and output tokens priced differently
        - **Knowledge Bases** - S3 sync not instant (10-15 min indexing)
        - **Agents** - Preview feature, API may change

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning Resources

### :fontawesome-solid-book-open: Official Docs

- **[AWS Bedrock Documentation](https://docs.aws.amazon.com/bedrock/)** - Complete reference
- **[Bedrock Pricing](https://aws.amazon.com/bedrock/pricing/)** - Per-token costs
- **[Model IDs](https://docs.aws.amazon.com/bedrock/latest/userguide/model-ids.html)** - Current model versions

### :fontawesome-solid-rocket: Key Features

- **Foundation models** - Claude, Llama, Mistral, Cohere, Stability AI
- **Knowledge Bases** - RAG with S3 documents, automatic embeddings
- **Agents** - Autonomous workflows with function calling
- **Guardrails** - Content filtering, PII detection, topic blocking
- **Model evaluation** - Compare models, human feedback
- **Custom models** - Import fine-tuned weights

______________________________________________________________________

## :fontawesome-solid-star: Available Models (2026)

| Provider | Model | Input $ / 1M tokens | Output $ / 1M tokens | Context Window |
|----------|-------|---------------------|----------------------|----------------|
| Anthropic | Claude 3.5 Sonnet | $3 | $15 | 200k |
| Anthropic | Claude 3 Opus | $15 | $75 | 200k |
| Anthropic | Claude 3 Haiku | $0.25 | $1.25 | 200k |
| Meta | Llama 3.1 405B | $5.32 | $16 | 128k |
| Mistral | Mistral Large | $4 | $12 | 32k |
| Amazon | Titan Text G1 | $0.30 | $0.40 | 32k |

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-cloud: **AWS Integration** - Best choice if already on AWS. Serverless is real (no cold starts). Knowledge Bases simplify RAG. Claude models are excellent. Pricing transparent. Regional availability matters.

**Tags:** aws-bedrock, ai, llm, claude, aws
