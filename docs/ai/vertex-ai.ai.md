---
title: Google Vertex AI
description: Google's AI platform - Gemini models, custom models, ML workflows, AutoML, unified AI development
---

# :fontawesome-brands-google: Google Vertex AI

Google's unified AI platform. Access Gemini Pro, PaLM 2, Imagen via API. Custom model training with AutoML. MLOps for model deployment and monitoring. Native GCP integration. Multimodal capabilities (text, images, video, audio).

!!! tip "2026 Update"
    Gemini 2.0 Flash with native multimodal. 2M token context window. Grounding with Google Search. Extensions for real-time data. Vertex AI Agents for autonomous workflows. Model Garden with 100+ open-source models.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Essential API Usage"

    ```python
    # Install Vertex AI SDK
    pip install google-cloud-aiplatform

    # Initialize
    import vertexai
    from vertexai.generative_models import GenerativeModel

    vertexai.init(project="my-project", location="us-central1")

    # Gemini Pro text generation
    model = GenerativeModel("gemini-2.0-flash-exp")  # (1)!

    response = model.generate_content("Explain neural networks simply")
    print(response.text)
    ```

    1. Gemini 2.0 Flash: fastest, cheapest; Pro: balanced; Ultra: most capable

    ```python
    # Streaming responses
    responses = model.generate_content(
        "Write a story about AI",
        stream=True  # (1)!
    )

    for response in responses:
        print(response.text, end='', flush=True)
    ```

    1. Streaming recommended for long responses (better UX)

    ```python
    # Multimodal input (text + images + video)
    from vertexai.generative_models import Part
    import base64

    with open("architecture.png", "rb") as f:
        image_data = base64.b64encode(f.read()).decode()

    prompt = [
        "Explain this system architecture:",
        Part.from_data(image_data, mime_type="image/png")  # (1)!
    ]

    response = model.generate_content(prompt)
    print(response.text)

    # Video understanding
    video_part = Part.from_uri("gs://my-bucket/video.mp4", mime_type="video/mp4")  # (2)!
    response = model.generate_content(["Summarize this video", video_part])
    ```

    1. Native multimodal (not vision API + text API separately)
    2. Video input from Cloud Storage (long videos supported)

    ```python
    # Function calling (tools)
    from vertexai.generative_models import FunctionDeclaration, Tool

    get_weather = FunctionDeclaration(
        name="get_weather",
        description="Get current weather for a location",
        parameters={
            "type": "object",
            "properties": {
                "location": {"type": "string", "description": "City name"}
            },
            "required": ["location"]
        }
    )

    tool = Tool(function_declarations=[get_weather])

    model = GenerativeModel("gemini-2.0-flash-exp", tools=[tool])

    response = model.generate_content("What's the weather in Tokyo?")

    # Check if function called
    if response.candidates[0].function_calls:
        function_call = response.candidates[0].function_calls[0]
        print(f"Function: {function_call.name}")
        print(f"Args: {function_call.args}")  # (1)!
    ```

    1. Your code executes function, sends result back for final response

    ```python
    # Grounding with Google Search
    from vertexai.generative_models import Tool, grounding

    google_search_tool = Tool.from_google_search_retrieval(
        grounding.GoogleSearchRetrieval()  # (1)!
    )

    model = GenerativeModel("gemini-2.0-flash-exp", tools=[google_search_tool])

    response = model.generate_content("Latest developments in quantum computing 2026")

    print(response.text)
    print("\nSources:")
    for citation in response.candidates[0].grounding_metadata.grounding_citations:
        print(f"- {citation.uri}")  # (2)!
    ```

    1. Automatically queries Google Search for current information
    2. Citations show web sources (transparency)

    **Real talk:**

    - Pay per character (not token), easier to estimate
    - Gemini 2.0 Flash: $0.075/1M chars input, $0.30/1M output
    - 2M token context window (largest available)
    - Multimodal native (not bolted on)
    - Free tier: 15 requests/min, 1M chars/month

=== ":fontawesome-solid-bolt: Common Patterns"

    ```python
    # RAG with Vertex AI Search
    from google.cloud import discoveryengine_v1beta as discoveryengine

    client = discoveryengine.SearchServiceClient()

    request = discoveryengine.SearchRequest(
        serving_config="projects/123/locations/global/collections/default_collection/dataStores/my-datastore/servingConfigs/default_config",
        query="company remote work policy",
        page_size=5
    )

    response = client.search(request)

    # Combine search results with Gemini
    context = "\n".join([result.document.derived_struct_data["snippet"] for result in response.results])

    prompt = f"""Based on this information:
{context}

Answer: What is our remote work policy?"""

    gemini_response = model.generate_content(prompt)
    print(gemini_response.text)  # (1)!
    ```

    1. Vertex AI Search provides retrieval, Gemini generates answer

    ```python
    # Safety settings (content filtering)
    from vertexai.generative_models import HarmCategory, HarmBlockThreshold

    safety_settings = {
        HarmCategory.HARM_CATEGORY_HATE_SPEECH: HarmBlockThreshold.BLOCK_LOW_AND_ABOVE,
        HarmCategory.HARM_CATEGORY_DANGEROUS_CONTENT: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
        HarmCategory.HARM_CATEGORY_SEXUALLY_EXPLICIT: HarmBlockThreshold.BLOCK_LOW_AND_ABOVE,
        HarmCategory.HARM_CATEGORY_HARASSMENT: HarmBlockThreshold.BLOCK_LOW_AND_ABOVE
    }  # (1)!

    model = GenerativeModel("gemini-2.0-flash-exp")

    response = model.generate_content(
        "User input here",
        safety_settings=safety_settings
    )

    # Check if blocked
    if response.candidates[0].finish_reason == "SAFETY":
        print("Content blocked by safety filters")  # (2)!
    ```

    1. Thresholds: BLOCK_NONE, BLOCK_LOW_AND_ABOVE, BLOCK_MEDIUM_AND_ABOVE, BLOCK_ONLY_HIGH
    2. Safety ratings in response metadata

    ```python
    # Custom model deployment (AutoML)
    from google.cloud import aiplatform

    aiplatform.init(project="my-project", location="us-central1")

    # Deploy custom model
    model = aiplatform.Model.upload(
        display_name="my-custom-model",
        artifact_uri="gs://my-bucket/model/",
        serving_container_image_uri="us-docker.pkg.dev/vertex-ai/prediction/tf2-cpu.2-13:latest"
    )

    endpoint = model.deploy(
        machine_type="n1-standard-4",
        min_replica_count=1,
        max_replica_count=5,
        traffic_split={"0": 100}  # (1)!
    )

    # Predict
    prediction = endpoint.predict(instances=[{"input": "data"}])
    ```

    1. Traffic split enables A/B testing (multiple model versions)

    ```python
    # Batch prediction (cost-effective)
    batch_job = model.batch_predict(
        job_display_name="batch-prediction-job",
        gcs_source=["gs://my-bucket/input.jsonl"],
        gcs_destination_prefix="gs://my-bucket/output/",
        machine_type="n1-standard-4",
        starting_replica_count=1,
        max_replica_count=5
    )

    batch_job.wait()  # (1)!
    ```

    1. Batch jobs cheaper than real-time (no endpoint costs)

    ```python
    # Model Garden (pre-trained models)
    from vertexai.preview.language_models import TextEmbeddingModel

    # Use open-source models from Model Garden
    embedding_model = TextEmbeddingModel.from_pretrained("textembedding-gecko@003")

    embeddings = embedding_model.get_embeddings(["Text to embed"])
    print(embeddings[0].values)  # (1)!

    # Other Model Garden models: Llama 3, Mistral, Stable Diffusion, etc.
    ```

    1. Embeddings for similarity search, clustering, RAG

    ```javascript
    // Node.js SDK
    const {VertexAI} = require('@google-cloud/vertexai');

    const vertexAI = new VertexAI({
      project: 'my-project',
      location: 'us-central1'
    });

    const generativeModel = vertexAI.getGenerativeModel({
      model: 'gemini-2.0-flash-exp'
    });

    const result = await generativeModel.generateContent('Explain REST APIs');
    console.log(result.response.text());  // (1)!
    ```

    1. Node.js SDK mirrors Python API (consistent experience)

    **Why this works:**

    - Unified platform (training, deployment, monitoring)
    - Native multimodal (text, image, video, audio)
    - Grounding provides current information
    - AutoML simplifies custom model training
    - Model Garden offers 100+ pre-trained models

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Streaming** - Essential for long responses (better UX)
        - **Grounding** - Use for time-sensitive information
        - **Safety settings** - Configure per use case (not one-size-fits-all)
        - **Batch prediction** - 60% cheaper for non-real-time
        - **Model Garden** - Explore open-source models (free hosting)
        - **Embeddings** - gecko-003 for RAG (768 dimensions)
        - **Context caching** - Reuse long context (50% discount)

    !!! warning "Security"
        - **IAM permissions** - Least privilege (Vertex AI User role)
        - **VPC Service Controls** - Prevent data exfiltration
        - **Private endpoints** - Keep traffic in VPC
        - **Data residency** - Choose region for compliance
        - **Audit logging** - Enable Cloud Audit Logs
        - **Safety filters** - Always enabled (configurable thresholds)

    !!! tip "Performance"
        - **Streaming** - Sub-second time to first token
        - **Regional selection** - us-central1 has most capacity
        - **Model selection** - Flash for speed, Pro for quality, Ultra for reasoning
        - **Context caching** - Reuse long prompts (cached for 1 hour)
        - **Batch jobs** - High throughput at lower cost

    !!! danger "Gotchas"
        - **Character-based pricing** - Not tokens (4 chars ≈ 1 token)
        - **Context window** - 2M tokens (but expensive for long context)
        - **Free tier limits** - 15 RPM, 1M chars/month (shared across models)
        - **Grounding costs** - Google Search queries charged separately
        - **Video processing** - Slow for long videos (minutes to process)
        - **Safety filters** - Can over-block, test thresholds
        - **Model availability** - Not all models in all regions

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning Resources

### :fontawesome-solid-book-open: Official Docs

- **[Vertex AI Documentation](https://cloud.google.com/vertex-ai/docs)** - Complete reference
- **[Gemini API Reference](https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/gemini)** - Model details
- **[Pricing](https://cloud.google.com/vertex-ai/pricing)** - Per-character costs

### :fontawesome-solid-rocket: Key Features

- **Gemini models** - Text, multimodal (image, video, audio)
- **Grounding** - Real-time data from Google Search
- **Model Garden** - 100+ pre-trained models (Llama, Mistral, etc.)
- **AutoML** - No-code custom model training
- **Vertex AI Search** - Enterprise RAG solution
- **MLOps** - Model monitoring, versioning, A/B testing

______________________________________________________________________

## :fontawesome-solid-star: Model Pricing (2026)

| Model | Input $ / 1M chars | Output $ / 1M chars | Context Window |
|-------|-------------------|---------------------|----------------|
| Gemini 2.0 Flash | $0.075 | $0.30 | 2M tokens |
| Gemini 1.5 Pro | $1.25 | $5.00 | 2M tokens |
| Gemini 1.5 Flash | $0.075 | $0.30 | 1M tokens |
| PaLM 2 Text | $0.25 | $0.50 | 32k tokens |
| Imagen 3 | $0.04/image | - | - |

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-rocket: **Innovation Leader** - Best multimodal capabilities. 2M token context is huge. Grounding provides current data. Character-based pricing clearer. Free tier generous. Model Garden excellent for experimentation.

**Tags:** vertex-ai, ai, llm, gemini, google-cloud
