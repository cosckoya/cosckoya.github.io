---
title: Google Cloud Platform (GCP)
description: GCP reference - Google's cloud, data/ML focus, Kubernetes-native, clean UX
tags:
  - gcp
  - cloud
  - google
---

# Google Cloud Platform (GCP)

Google's cloud platform. Third in market share but first in data analytics and ML. Kubernetes was born here (GKE is solid). Cleaner UX than AWS, better pricing calculators. BigQuery is ridiculously fast. Smaller service catalog than AWS/Azure, but quality over quantity.

______________________________________________________________________

## Quick Hits

=== "🎯 Essential Services"

    ```bash
    # Login
    gcloud auth login

    # Set project (required for most commands)
    gcloud config set project my-project-id

    # Compute Engine (VMs)
    gcloud compute instances create my-vm --zone=us-central1-a --machine-type=e2-medium

    # Cloud Storage (S3 equivalent)
    gsutil cp local.txt gs://my-bucket/remote.txt
    gsutil -m rsync -r ./local gs://my-bucket/path  # Sync directory

    # Cloud Functions (serverless)
    gcloud functions deploy my-function --runtime python312 --trigger-http --entry-point main

    # Cloud Run (serverless containers, pretty cool)
    gcloud run deploy my-service --image gcr.io/my-project/my-image --platform managed

    # GKE (Kubernetes)
    gcloud container clusters create my-cluster --num-nodes=3 --zone=us-central1-a

    # BigQuery (data warehouse - this is the killer app)
    bq query --use_legacy_sql=false 'SELECT * FROM `project.dataset.table` LIMIT 10'

    # Who am I?
    gcloud auth list
    gcloud config list
    ```

    **Real talk:**

    - Projects are the top-level organization (not accounts like AWS)
    - `gcloud` for most services, `gsutil` for storage, `bq` for BigQuery (inconsistent but manageable)
    - us-central1 is cheapest, us-east1 close second
    - Free tier is generous (GCE f1-micro always free, BigQuery 1TB queries/month free)
    - IAM is simpler than AWS (but still confusing at first)

=== "⚡ Common Patterns"

    ```python
    from google.cloud import storage
    from google.cloud import bigquery

    # Cloud Storage upload
    def upload_to_gcs(bucket_name, source_file, destination_blob):
        storage_client = storage.Client()
        bucket = storage_client.bucket(bucket_name)
        blob = bucket.blob(destination_blob)

        blob.upload_from_filename(source_file)
        print(f"Uploaded {source_file} to gs://{bucket_name}/{destination_blob}")

    # BigQuery query pattern
    def query_bigquery(query):
        client = bigquery.Client()

        query_job = client.query(query)
        results = query_job.result()  # Waits for job to complete

        for row in results:
            print(row)

    # Cloud Function pattern (Python)
    import functions_framework
    from flask import jsonify

    @functions_framework.http
    def main(request):
        try:
            request_json = request.get_json(silent=True)

            if not request_json or 'name' not in request_json:
                return jsonify({'error': 'Missing name parameter'}), 400

            name = request_json['name']
            result = process_data(name)

            return jsonify({'result': result}), 200

        except Exception as e:
            print(f"Error: {e}")
            return jsonify({'error': 'Internal error'}), 500
    ```

    ```yaml
    # Cloud Run service (deploy containers serverlessly)
    apiVersion: serving.knative.dev/v1
    kind: Service
    metadata:
      name: my-service
    spec:
      template:
        spec:
          containers:
          - image: gcr.io/my-project/my-image
            env:
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: db-secret
                  key: url
    ```

    ```hcl
    # Terraform for GCP (recommended)
    resource "google_compute_instance" "default" {
      name         = "my-instance"
      machine_type = "e2-medium"
      zone         = "us-central1-a"

      boot_disk {
        initialize_params {
          image = "debian-cloud/debian-11"
        }
      }

      network_interface {
        network = "default"
        access_config {
          // Ephemeral public IP
        }
      }
    }
    ```

=== "🔥 Pro Tips & Gotchas"

    **Cost optimization:**

    - Use Committed Use Discounts (CUD) for predictable workloads (up to 57% savings)
    - Preemptible VMs for batch jobs (up to 80% off, 24h max lifetime)
    - Set up billing alerts in Cloud Console IMMEDIATELY
    - Use Cloud Storage lifecycle policies (auto-delete old objects)
    - BigQuery pricing: $5/TB scanned (use partitioned tables to save $$$$)

    **Security:**

    - Use Service Accounts with minimal permissions (not user accounts)
    - Enable Organization Policies (prevent public buckets, enforce encryption)
    - Use Secret Manager for credentials (NOT environment variables)
    - VPC Service Controls for data exfiltration protection
    - Enable 2FA on Google Account (duh)

    **Performance:**

    - Use Cloud CDN for static content
    - Memorystore (Redis/Memcached) for caching
    - Cloud SQL read replicas for read-heavy workloads
    - Premium Tier networking for lower latency (vs Standard Tier)

    **Gotchas (Google's quirks):**

    - Project quotas can bite you (request increases proactively)
    - Some services only in certain regions (Cloud Run not everywhere yet)
    - Egress costs are high (like all clouds, but GCP's inter-region can surprise you)
    - Preemptible VMs can disappear mid-task (handle gracefully)
    - IAM bindings are eventually consistent (can take seconds to propagate)
    - BigQuery costs sneak up (scanning 1PB = $5k, partition your tables!)
    - Free tier VMs are slow (f1-micro is... micro)

    **Monitoring:**

    - Cloud Monitoring (was Stackdriver, rebranded)
    - Cloud Logging for centralized logs (decent search)
    - Cloud Trace for distributed tracing
    - Error Reporting catches exceptions automatically

    **When NOT to use GCP:**

    - Need Windows/Microsoft ecosystem (Azure better fit)
    - Largest service catalog matters (AWS has more niche services)
    - Team has no GCP experience (less learning resources than AWS)
    - Risk-averse company (GCP has killed products before - RIP Google Cloud IoT Core)

______________________________________________________________________

## Learning Paths

### 🎓 Free Resources

- **[Google Cloud Skills Boost](https://www.cloudskillsboost.google/)** - Official training, lots of free quests (start here)
- **[GCP Free Tier](https://cloud.google.com/free)** - $300 credit for 90 days + always-free tier
- **[freeCodeCamp GCP Course](https://www.youtube.com/watch?v=jpno8FSqpc8)** - 8+ hour deep dive
- **[GCP Documentation](https://cloud.google.com/docs)** - Official docs (well-written, good examples)
- **[Google Codelabs](https://codelabs.developers.google.com/?cat=Cloud)** - Hands-on tutorials
- **[Coursera GCP Courses](https://www.coursera.org/googlecloud)** - Some free, some paid

### 🧪 Interactive Labs

- **[Qwiklabs](https://www.cloudskillsboost.google/catalog)** - Hands-on labs, temporary GCP projects (some free, some paid)
- **[Cloud Shell](https://shell.cloud.google.com/)** - Browser-based terminal with gcloud pre-installed
- **[GCP Marketplace](https://console.cloud.google.com/marketplace)** - One-click deployments
- **[Terraform GCP Provider Docs](https://registry.terraform.io/providers/hashicorp/google/latest/docs)** - Lots of examples

### 📜 Certifications Worth It

- **[Cloud Digital Leader](https://cloud.google.com/learn/certification/cloud-digital-leader)** - $99, non-technical, business-focused (skip if technical)
- **[Associate Cloud Engineer](https://cloud.google.com/learn/certification/cloud-engineer)** - $125, **most popular**, hands-on focused (this one matters)
- **[Professional Cloud Architect](https://cloud.google.com/learn/certification/cloud-architect)** - $200, design-focused, tough but valuable
- **[Professional Data Engineer](https://cloud.google.com/learn/certification/data-engineer)** - $200, worth it if doing data/ML on GCP
- **[Professional Cloud Developer](https://cloud.google.com/learn/certification/cloud-developer)** - $200, app development focus

**Reality check:**

- Associate Cloud Engineer is the best starting point (practical, hands-on)
- Google certs don't expire (unlike Azure's 1 year, AWS's 3 years) - nice!
- Study 1-2 months, use practice exams
- [Whizlabs](https://www.whizlabs.com/google-cloud-certified-associate-cloud-engineer/) and [Tutorials Dojo](https://tutorialsdojo.com/courses/google-certified-associate-cloud-engineer-practice-exams/) for practice

### 🚀 Projects to Build

**Beginner (learn the basics):**

- Static website on Cloud Storage + Cloud CDN
- Serverless API with Cloud Functions + Firestore

**Intermediate (portfolio-worthy):**

- Web app with Cloud Run + Cloud SQL + Memorystore + Cloud Build CI/CD
- Data pipeline with Pub/Sub + Dataflow + BigQuery
- GKE cluster with Ingress, monitoring, autoscaling

**Advanced (job-interview flex):**

- Multi-region app with Global Load Balancer + Cloud SQL cross-region replication
- ML pipeline with Vertex AI + Cloud Storage + Cloud Functions
- Real-time analytics with Pub/Sub + Dataflow + BigQuery streaming inserts

______________________________________________________________________

## Community Pulse

### 🐦 Who to Follow

**Twitter/X:**

- [@GCPcloud](https://twitter.com/GCPcloud) - Official GCP updates
- [@kelseyhightower](https://twitter.com/kelseyhightower) - Kelsey Hightower, staff dev advocate, Kubernetes OG
- [@gregsramblings](https://twitter.com/gregsramblings) - Greg Wilson, dev advocate, quality content
- [@gregsramblings](https://twitter.com/gregsramblings) - Julia Ferraioli, Open Source Strategy at Google
- [@sethvargo](https://twitter.com/sethvargo) - Seth Vargo, solutions architect, Terraform expert
- [@ThatGuyInTheSky](https://twitter.com/ThatGuyInTheSky) - Priyanka Vergadia, developer advocate, visual guides

**YouTube/Streamers:**

- [Google Cloud Tech](https://www.youtube.com/c/GoogleCloudTech) - Official channel, quality tutorials
- [Google Cloud Next](https://www.youtube.com/c/GoogleCloudNext) - Conference talks
- [Priyanka Vergadia](https://www.youtube.com/c/pvergadia) - Visual guides, "Sketchtember" series
- [Serverless Toolbox](https://www.youtube.com/c/ServerlessToolbox) - Cloud Run, Functions deep dives

### 💬 Active Communities

- **[r/googlecloud](https://reddit.com/r/googlecloud)** - 50k+ members, active, helpful community
- **[GCP Community Discord](https://discord.gg/google-cloud-community)** - Active, friendly, product teams participate
- **[Dev.to #gcp](https://dev.to/t/gcp)** - Quality articles and tutorials
- **[Google Cloud Community](https://www.googlecloudcommunity.com/)** - Official forums, product teams answer questions
- **[Stack Overflow [google-cloud-platform]](https://stackoverflow.com/questions/tagged/google-cloud-platform)** - 75k+ questions

### 🎙️ Podcasts & Newsletters

**Podcasts:**

- **[Google Cloud Podcast](https://www.gcppodcast.com/)** - Weekly, quality guests, technical deep dives
- **[Kubernetes Podcast](https://kubernetespodcast.com/)** - By Google, not GCP-specific but relevant

**Newsletters:**

- **[Google Cloud Newsletter](https://cloud.google.com/newsletter)** - Official, weekly updates
- **[GCP Weekly](https://www.gcpweekly.com/)** - Curated news, community-driven
- **[Google Cloud Blog](https://cloud.google.com/blog)** - Official blog, product announcements

### 🎪 Events & Conferences

- **[Google Cloud Next](https://cloud.withgoogle.com/next)** - Annual, April-ish, San Francisco + virtual, biggest GCP event
- **[Google Cloud Summit](https://cloudonair.withgoogle.com/events/summit)** - Free, regional, various cities
- **[Google Developer Groups (GDG) Cloud](https://developers.google.com/community/gdg)** - Local meetups worldwide
- **[Community Day Cloud](https://www.communitydaycloud.com/)** - Community-organized, free

______________________________________________________________________

## Worth Checking

<div class="grid cards" markdown>

- 📚 __Official Stuff__

    ______________________________________________________________________

    [GCP Docs](https://cloud.google.com/docs)

    [gcloud CLI Reference](https://cloud.google.com/sdk/gcloud/reference)

    [Architecture Center](https://cloud.google.com/architecture)

    [Best Practices](https://cloud.google.com/architecture/framework)

- 🧪 __Hands-on__

    ______________________________________________________________________

    [GCP Free Tier](https://cloud.google.com/free)

    [Qwiklabs](https://www.cloudskillsboost.google/)

    [Cloud Shell](https://shell.cloud.google.com/)

    [Google Codelabs](https://codelabs.developers.google.com/?cat=Cloud)

- 💻 __Real Code__

    ______________________________________________________________________

    [Awesome GCP](https://github.com/GoogleCloudPlatform/awesome-google-cloud)

    [GCP Samples](https://github.com/GoogleCloudPlatform)

    [Terraform GCP Examples](https://github.com/terraform-google-modules)

    [GCP Sketchnote](https://github.com/priyankavergadia/GCPSketchnote) (Visual guides)

- 🔥 __Deep Dives__

    ______________________________________________________________________

    [Architecture Center](https://cloud.google.com/architecture)

    [Solutions Library](https://cloud.google.com/solutions)

    [Google Cloud Blog](https://cloud.google.com/blog)

    [GCP Weekly](https://www.gcpweekly.com/)

- 🛠️ __Tools & Extensions__

    ______________________________________________________________________

    [gcloud CLI](https://cloud.google.com/sdk/gcloud)

    [Cloud Code (VSCode/IntelliJ)](https://cloud.google.com/code)

    [Terraform GCP Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)

    [gcsfuse](https://github.com/GoogleCloudPlatform/gcsfuse) (Mount GCS as filesystem)

    [BigQuery CLI (bq)](https://cloud.google.com/bigquery/docs/bq-command-line-tool)

- 📰 __News & Updates__

    ______________________________________________________________________

    [GCP Release Notes](https://cloud.google.com/release-notes)

    [Google Cloud Blog](https://cloud.google.com/blog)

    [r/googlecloud](https://reddit.com/r/googlecloud)

    [GCP Status Dashboard](https://status.cloud.google.com/) (When shit breaks)

</div>

______________________________________________________________________

**Last Updated:** 2026-01-13 **Vibe Check:** 🎯 Niche Excellence - GCP is the data/ML cloud. Not as big as AWS/Azure, but BigQuery is unmatched, GKE is top-tier, and the UX is cleanest. Pick GCP if you're doing data analytics, ML, or Kubernetes at scale. Enterprise adoption growing but still behind AWS/Azure.
