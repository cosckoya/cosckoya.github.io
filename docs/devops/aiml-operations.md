---
title: AI/ML Operations
description: Guide to Artificial Intelligence, Machine Learning, MLOps, and integrating AI into DevOps workflows
tags:
  - ai
  - machine-learning
  - mlops
  - devops
---

# AI/ML Operations

Artificial Intelligence (AI) is the discipline that creates systems capable of performing tasks that normally require human intelligence. From Machine Learning to Large Language Models, AI is transforming how we develop software, analyze data, and solve complex problems.

!!! abstract "Fundamental Areas"
    - **Machine Learning**: Systems that learn from data without being explicitly programmed
    - **Deep Learning**: Deep neural networks for complex pattern recognition
    - **Natural Language Processing**: Processing and understanding human language
    - **Computer Vision**: Interpretation and analysis of images and video
    - **Generative AI**: Systems that create new content (text, images, code)
    - **MLOps**: Operational practices for deploying and maintaining models in production

---

## Machine Learning Fundamentals

### Learning Types

=== "Supervised Learning"
    Learning with labeled data to predict outputs.

    **Common algorithms**:
    - **Classification**: Logistic Regression, SVM, Random Forest, XGBoost
    - **Regression**: Linear Regression, Ridge, Lasso, Polynomial Regression

    **Use cases**:
    - Email classification (spam/not spam)
    - House price prediction
    - Medical diagnosis
    - Image recognition

=== "Unsupervised Learning"
    Learning without labels, finding patterns in data.

    **Common algorithms**:
    - **Clustering**: K-Means, DBSCAN, Hierarchical Clustering
    - **Dimensionality Reduction**: PCA, t-SNE, UMAP
    - **Anomaly Detection**: Isolation Forest, One-Class SVM

    **Use cases**:
    - Customer segmentation
    - Fraud detection
    - Dimensionality reduction for visualization
    - Data compression

=== "Reinforcement Learning"
    Learning through interaction with environment and rewards.

    **Common algorithms**:
    - Q-Learning, Deep Q-Networks (DQN)
    - Policy Gradient methods
    - Actor-Critic methods (A3C, PPO)

    **Use cases**:
    - Games (AlphaGo, video games)
    - Robotics and control
    - System optimization
    - Algorithmic trading

### Machine Learning Pipeline

```text
1. Problem Definition → 2. Data Collection → 3. Data Exploration (EDA)
                             ↓
6. Monitoring & Maintenance ← 5. Deployment ← 4. Model Training & Evaluation
```

!!! tip "ML Workflow Best Practices"
    1. **Understand the problem**: Define clear success metrics
    2. **Data quality**: "Garbage in, garbage out"
    3. **Start simple**: Baseline models first
    4. **Feature engineering**: Often more important than algorithm
    5. **Cross-validation**: Avoid overfitting
    6. **Track experiments**: MLflow, Weights & Biases
    7. **Document everything**: Reproducibility is key

---

## Deep Learning

### Neural Networks

=== "Basic Architectures"
    **Feedforward Neural Networks (FNN)**:
    - Simplest neural network
    - Densely connected layers
    - For tabular data

    **Convolutional Neural Networks (CNN)**:
    - For image processing
    - Convolutional layers extract features
    - Architectures: ResNet, VGG, EfficientNet

    **Recurrent Neural Networks (RNN)**:
    - For sequential data
    - Variants: LSTM, GRU
    - Applications: Time series, text

=== "Transformers"
    Revolutionary architecture based on attention mechanisms.

    **Key components**:
    - Self-Attention mechanisms
    - Positional Encoding
    - Multi-Head Attention
    - Feed-Forward Networks

    **Notable models**:
    - **BERT**: Bidirectional Encoder Representations
    - **GPT**: Generative Pre-trained Transformer
    - **T5**: Text-to-Text Transfer Transformer
    - **Vision Transformer (ViT)**: Transformers for images

=== "Generative Models"
    Models that generate new content.

    **Main types**:
    - **GANs (Generative Adversarial Networks)**: Generator vs Discriminator
    - **VAEs (Variational Autoencoders)**: Probabilistic encoding
    - **Diffusion Models**: Stable Diffusion, DALL-E
    - **Large Language Models (LLMs)**: GPT-4, Claude, LLaMA

---

## Natural Language Processing (NLP)

### NLP Fundamental Tasks

=== "Text Processing"
    **Basic techniques**:
    - Tokenization (word, subword, character-level)
    - Stemming and Lemmatization
    - Named Entity Recognition (NER)
    - Part-of-Speech (POS) Tagging
    - Dependency Parsing

    **Tools**:
    - [spaCy](https://spacy.io) - Industrial NLP library
    - [NLTK](https://www.nltk.org) - Natural Language Toolkit
    - [Stanza](https://stanfordnlp.github.io/stanza/) - Stanford NLP

=== "Text Classification"
    Assign categories to texts.

    **Use cases**:
    - Sentiment analysis
    - Topic classification
    - Spam detection
    - Intent classification

    **Models**:
    - Bag of Words + Traditional ML
    - Word Embeddings (Word2Vec, GloVe) + RNN/CNN
    - Transformers (BERT, RoBERTa)

=== "Text Generation"
    Generate new text based on context.

    **Applications**:
    - Chatbots and assistants
    - Machine translation
    - Text summarization
    - Code generation

    **Models**:
    - GPT series (GPT-3, GPT-4)
    - Claude (Anthropic)
    - LLaMA, Mistral, Mixtral

=== "Embeddings"
    Vector representations of text.

    **Evolution**:
    - **Word2Vec, GloVe**: Word embeddings
    - **BERT**: Contextual embeddings
    - **Sentence-BERT**: Sentence embeddings
    - **OpenAI Embeddings**: text-embedding-ada-002

    **Applications**:
    - Semantic search
    - Recommendation systems
    - Document clustering
    - Retrieval Augmented Generation (RAG)

---

## Large Language Models (LLMs)

### Proprietary Models

=== "OpenAI"
    - **GPT-4**: Most advanced multimodal model
    - **GPT-3.5**: Balance between performance and cost
    - **GPT-4o**: Optimized for conversation
    - **[OpenAI API](https://platform.openai.com/docs)**: API access

=== "Anthropic"
    - **Claude 3 Opus**: Maximum performance
    - **Claude 3 Sonnet**: Performance/cost balance
    - **Claude 3 Haiku**: Fast and economical
    - **[Anthropic API](https://docs.anthropic.com/)**: Official documentation

=== "Google"
    - **Gemini Pro**: General-purpose model
    - **Gemini Ultra**: Maximum capacity
    - **PaLM 2**: Previous generation
    - **[Google AI Studio](https://ai.google.dev/)**: Development platform

### Open Source Models

=== "Meta"
    - **[LLaMA 2](https://ai.meta.com/llama/)**: 7B-70B parameter models
    - **[LLaMA 3](https://github.com/meta-llama/llama3)**: Improved new generation
    - **Code LLaMA**: Specialized in code

=== "Mistral AI"
    - **[Mistral 7B](https://mistral.ai/news/announcing-mistral-7b/)**: Efficient 7B parameter model
    - **[Mixtral 8x7B](https://mistral.ai/news/mixtral-of-experts/)**: Mixture of Experts
    - **Mistral Medium/Large**: Larger models

=== "Other Notable"
    - **[Falcon](https://falconllm.tii.ae/)**: TII (UAE) open models
    - **[Yi](https://01.ai/)**: High-performance Chinese models
    - **[Phi-2/3](https://www.microsoft.com/en-us/research/blog/phi-2-the-surprising-power-of-small-language-models/)**: Powerful small Microsoft models
    - **[Gemma](https://ai.google.dev/gemma)**: Google open models

### Prompt Engineering

Techniques to get better responses from LLMs.

!!! success "Best Practices"
    1. **Be specific**: Clear and detailed instructions
    2. **Provide context**: Relevant background information
    3. **Use examples**: Few-shot learning improves results
    4. **Structure output**: Specify desired format
    5. **Iterate**: Refine prompts based on results
    6. **Chain prompts**: Break down complex tasks
    7. **System prompts**: Define role and behavior

**Advanced techniques**:

- **Zero-shot prompting**: Without examples
- **Few-shot prompting**: With examples
- **Chain-of-Thought (CoT)**: Step-by-step reasoning
- **ReAct**: Reasoning + Acting
- **Tree of Thoughts**: Exploring multiple paths

---

## Computer Vision

### Computer Vision Fundamental Tasks

=== "Image Classification"
    Assign labels to complete images.

    **Architectures**:
    - ResNet, EfficientNet, Vision Transformer (ViT)

    **Frameworks**:
    - TensorFlow/Keras, PyTorch, timm

=== "Object Detection"
    Locate and classify multiple objects in images.

    **Models**:
    - **YOLO (You Only Look Once)**: Real-time detection
    - **Faster R-CNN**: High accuracy
    - **EfficientDet**: Speed/accuracy balance
    - **DETR**: Detection Transformer

=== "Semantic Segmentation"
    Pixel-level classification.

    **Architectures**:
    - U-Net, DeepLab, Mask R-CNN

    **Applications**:
    - Medical images
    - Autonomous driving
    - Satellite analysis

=== "Image Generation"
    Create new images.

    **Models**:
    - **Stable Diffusion**: Open-source text-to-image
    - **DALL-E 3**: OpenAI text-to-image
    - **Midjourney**: Artistic generation platform
    - **StyleGAN**: Face generation

---

## AI Tools & Frameworks

### ML/DL Frameworks

=== "Python Libraries"
    **Core ML/DL**:
    - **[TensorFlow](https://www.tensorflow.org)**: Complete Google framework
    - **[PyTorch](https://pytorch.org)**: Flexible framework, research preferred
    - **[JAX](https://github.com/google/jax)**: Composable transformations
    - **[Keras](https://keras.io)**: High-level deep learning API

    **Traditional ML**:
    - **[scikit-learn](https://scikit-learn.org)**: Traditional ML
    - **[XGBoost](https://xgboost.readthedocs.io)**: Gradient boosting
    - **[LightGBM](https://lightgbm.readthedocs.io)**: Fast gradient boosting
    - **[CatBoost](https://catboost.ai)**: Gradient boosting with categorical features

    **Data Processing**:
    - **[pandas](https://pandas.pydata.org)**: Data manipulation
    - **[NumPy](https://numpy.org)**: Numerical computing
    - **[Polars](https://www.pola.rs)**: Fast DataFrame
    - **[Dask](https://www.dask.org)**: Parallel computing

=== "Specialized Tools"
    **NLP**:
    - **[Hugging Face Transformers](https://huggingface.co/transformers)**: Pre-trained models
    - **[spaCy](https://spacy.io)**: Industrial NLP
    - **[LangChain](https://langchain.com)**: Framework for LLM applications
    - **[LlamaIndex](https://www.llamaindex.ai)**: Data framework for LLMs

    **Computer Vision**:
    - **[OpenCV](https://opencv.org)**: Computer vision
    - **[Detectron2](https://github.com/facebookresearch/detectron2)**: Object detection
    - **[timm](https://github.com/huggingface/pytorch-image-models)**: PyTorch image models
    - **[Ultralytics YOLOv8](https://github.com/ultralytics/ultralytics)**: YOLO implementation

### MLOps Tools

=== "Experiment Tracking"
    - **[MLflow](https://mlflow.org)**: Complete ML lifecycle platform
    - **[Weights & Biases](https://wandb.ai)**: Experiment tracking and visualization
    - **[Neptune.ai](https://neptune.ai)**: Metadata store for MLOps
    - **[TensorBoard](https://www.tensorflow.org/tensorboard)**: TensorFlow visualization

=== "Model Serving"
    - **[FastAPI](https://fastapi.tiangolo.com)**: Fast APIs for models
    - **[TorchServe](https://pytorch.org/serve/)**: PyTorch model serving
    - **[TensorFlow Serving](https://www.tensorflow.org/tfx/guide/serving)**: TensorFlow serving
    - **[BentoML](https://www.bentoml.com)**: Model serving framework
    - **[Seldon Core](https://www.seldon.io)**: ML deployment on Kubernetes

=== "Feature Stores"
    - **[Feast](https://feast.dev)**: Open-source feature store
    - **[Tecton](https://www.tecton.ai)**: Enterprise feature platform
    - **[Hopsworks](https://www.hopsworks.ai)**: Feature store and MLOps platform

=== "AutoML"
    - **[Auto-sklearn](https://automl.github.io/auto-sklearn)**: Automated sklearn
    - **[TPOT](http://epistasislab.github.io/tpot/)**: Automated pipeline optimization
    - **[H2O AutoML](https://docs.h2o.ai/h2o/latest-stable/h2o-docs/automl.html)**: Automated ML platform
    - **[PyCaret](https://pycaret.org)**: Low-code ML library

---

## Retrieval Augmented Generation (RAG)

RAG combines LLMs with information retrieval to provide answers based on updated data.

### RAG Architecture

```text
Query → Embedding → Vector Search → Top-K Results → Context + Query → LLM → Response
```

### Components

=== "Vector Databases"
    - **[Pinecone](https://www.pinecone.io)**: Managed vector database
    - **[Weaviate](https://weaviate.io)**: Open-source vector database
    - **[Milvus](https://milvus.io)**: Scalable vector database
    - **[Qdrant](https://qdrant.tech)**: High-performance vector search
    - **[ChromaDB](https://www.trychroma.com)**: Embedding database
    - **[pgvector](https://github.com/pgvector/pgvector)**: PostgreSQL extension

=== "RAG Frameworks"
    - **[LangChain](https://langchain.com)**: Complete framework for LLM apps
    - **[LlamaIndex](https://www.llamaindex.ai)**: Data framework for RAG
    - **[Haystack](https://haystack.deepset.ai)**: NLP framework with RAG

### Best Practices

!!! tip "RAG Optimization"
    1. **Chunk strategically**: Chunk size and overlap
    2. **Quality embeddings**: Use domain-specific models
    3. **Hybrid search**: Combine vector search with keyword search
    4. **Reranking**: Order results before sending to LLM
    5. **Context window management**: Optimize context usage
    6. **Metadata filtering**: Filter by date, category, etc.
    7. **Monitor performance**: Latency, relevance, cost

---

## AI Ethics & Safety

### Ethical Considerations

!!! warning "Risks and Challenges"
    - **Bias and Fairness**: Models can perpetuate training data biases
    - **Privacy**: Protection of personal data in training
    - **Transparency**: Explainability of AI decisions
    - **Accountability**: Responsibility for automated decisions
    - **Environmental Impact**: Energy consumption of training
    - **Job Displacement**: Impact on employment
    - **Misinformation**: Generation of false content
    - **Security**: Adversarial attacks and model robustness

### Responsible AI Frameworks

- **[Anthropic's Constitutional AI](https://www.anthropic.com/index/claudes-constitution)**: Value alignment
- **[Google's AI Principles](https://ai.google/responsibility/principles/)**: Responsible AI principles
- **[Microsoft's Responsible AI](https://www.microsoft.com/en-us/ai/responsible-ai)**: Tools and practices
- **[OECD AI Principles](https://www.oecd.org/digital/devops/aiml-operations.md)**: International principles

---

## Learning Resources

=== "Courses & Tutorials"
    **Fundamentals**:
    - [Fast.ai Practical Deep Learning](https://www.fast.ai)
    - [Andrew Ng's Machine Learning](https://www.coursera.org/learn/machine-learning)
    - [Stanford CS229 Machine Learning](http://cs229.stanford.edu)
    - [MIT 6.S191 Deep Learning](http://introtodeeplearning.com)

    **Advanced**:
    - [Stanford CS224N NLP](http://web.stanford.edu/class/cs224n/)
    - [Stanford CS231N Computer Vision](http://cs231n.stanford.edu)
    - [Berkeley CS285 Deep RL](http://rail.eecs.berkeley.edu/deeprlcourse/)
    - [Hugging Face Course](https://huggingface.co/learn)

=== "Books"
    - **Hands-On Machine Learning** - Aurélien Géron
    - **Deep Learning** - Ian Goodfellow et al.
    - **Pattern Recognition and Machine Learning** - Christopher Bishop
    - **Designing Machine Learning Systems** - Chip Huyen
    - **Natural Language Processing with Transformers** - Lewis Tunstall et al.

=== "Communities"
    - [r/MachineLearning](https://www.reddit.com/r/MachineLearning/)
    - [r/artificial](https://www.reddit.com/r/artificial/)
    - [r/LocalLLaMA](https://www.reddit.com/r/LocalLLaMA/)
    - [Hugging Face Forums](https://discuss.huggingface.co)
    - [Papers With Code](https://paperswithcode.com)

=== "Research & News"
    - [arXiv.org](https://arxiv.org) - Research preprints
    - [Papers With Code](https://paperswithcode.com) - Papers with implementations
    - [Distill.pub](https://distill.pub) - Visual ML explanations
    - [The Batch](https://www.deeplearning.ai/the-batch/) - Andrew Ng's newsletter

---

## Related Topics

- [DevOps & Automation](index.md) - MLOps and model deployment
- [Cloud Platforms](../cloud/) - AI services in cloud (SageMaker, Vertex AI)
- [Containerization](../containerization/) - Docker and Kubernetes for model deployment
