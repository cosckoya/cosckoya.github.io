---
title: Amazon Web Services (AWS)
description: AWS reference - cloud platform running half the internet, 200+ services, pricing mystery
tags:
  - aws
  - cloud
---

# AWS (Amazon Web Services)

Cloud platform that runs half the internet. 200+ services (you'll use maybe 10). 33+ regions globally. Industry standard for cloud infrastructure. Pricing is a mystery, bills are scary, but it works.

______________________________________________________________________

## Quick Hits

=== ":fontawesome-solid-list-check: Essential Services"

    ```bash
    # EC2 - Virtual machines (you'll use this)
    aws ec2 run-instances --image-id ami-xxx --instance-type t3.micro

    # S3 - Object storage (everyone uses this)
    aws s3 cp file.txt s3://bucket-name/
    aws s3 sync ./local s3://bucket/path --delete

    # Lambda - Serverless functions (scales like crazy)
    aws lambda invoke --function-name my-function output.txt

    # RDS - Managed databases (don't run your own DB)
    aws rds describe-db-instances

    # IAM - Identity management (painful but critical)
    aws iam create-user --user-name dev-user
    aws sts get-caller-identity  # "Who the fuck am I?"

    # CloudWatch - Logs and monitoring (set billing alarms!)
    aws logs tail /aws/lambda/my-function --follow

    # ECS/EKS - Container orchestration
    aws ecs list-clusters
    aws eks list-clusters
    ```

    **Real talk:**

    - Start with EC2, S3, RDS - that's 80% of use cases
    - IAM is hell, but you MUST learn it - security nightmare otherwise
    - Enable MFA on root account RIGHT NOW (seriously, stop reading and do it)
    - us-east-1 is cheapest but goes down more often (Murphy's law applies)
    - Use `--profile` for multiple accounts (you'll have dev/staging/prod)

=== ":fontawesome-solid-bolt: Common Patterns"

    ```python
    import boto3
    from botocore.exceptions import ClientError

    # S3 upload with proper error handling
    def upload_to_s3(file_path, bucket, key):
        s3 = boto3.client('s3')
        try:
            s3.upload_file(
                file_path,
                bucket,
                key,
                ExtraArgs={'ACL': 'private'}  # Don't leak shit
            )
            return True
        except ClientError as e:
            print(f"Upload failed: {e}")
            return False

    # Lambda handler pattern (use this)
    def lambda_handler(event, context):
        try:
            # Parse event (API Gateway, SQS, etc.)
            body = json.loads(event.get('body', '{}'))

            # Do work
            result = process_data(body)

            # Return proper response
            return {
                'statusCode': 200,
                'headers': {'Content-Type': 'application/json'},
                'body': json.dumps(result)
            }
        except Exception as e:
            print(f"Error: {e}")  # Goes to CloudWatch
            return {'statusCode': 500, 'body': 'Internal error'}

    # DynamoDB pattern (NoSQL done right)
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('Users')

    # Query (efficient)
    response = table.query(
        KeyConditionExpression='user_id = :uid',
        ExpressionAttributeValues={':uid': '12345'}
    )

    # Scan (expensive, avoid in prod)
    response = table.scan(Limit=100)
    ```

    ```yaml
    # CloudFormation/SAM pattern (infrastructure as code)
    AWSTemplateFormatVersion: '2010-09-09'
    Transform: AWS::Serverless-2016-10-31

    Resources:
      MyFunction:
        Type: AWS::Serverless::Function
        Properties:
          Runtime: python3.12
          Handler: app.lambda_handler
          Environment:
            Variables:
              TABLE_NAME: !Ref MyTable
          Policies:
            - DynamoDBCrudPolicy:
                TableName: !Ref MyTable

      MyTable:
        Type: AWS::DynamoDB::Table
        Properties:
          BillingMode: PAY_PER_REQUEST
          AttributeDefinitions:
            - AttributeName: id
              AttributeType: S
          KeySchema:
            - AttributeName: id
              KeyType: HASH
    ```

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    **Cost optimization (your CFO will thank you):**

    - Use Reserved Instances for predictable workloads (up to 72% savings)
    - Spot Instances for batch jobs (up to 90% savings, but can be terminated)
    - S3 Intelligent-Tiering for storage (automatic cost optimization)
    - Set CloudWatch billing alarms IMMEDIATELY (save yourself from $10k surprises)
    - Delete unused snapshots, AMIs, and elastic IPs (they add up fast)

    **Security (don't get hacked):**

    - Never hardcode credentials - use IAM roles everywhere
    - Enable CloudTrail + GuardDuty (detect breaches before bankruptcy)
    - Use Systems Manager Parameter Store for secrets (free for \<10k params)
    - VPC Flow Logs for network debugging
    - Principle of least privilege (IAM policies should be restrictive AF)

    **Performance:**

    - Keep traffic in same region/AZ (cross-region costs money + latency)
    - Use CloudFront CDN for static content (S3 alone is slow)
    - RDS read replicas for read-heavy workloads
    - ElastiCache (Redis/Memcached) for caching (sub-ms latency)

    **Gotchas (learn from others' pain):**

    - Data transfer OUT costs add up fast (in is free, out is $$$$)
    - NAT Gateway costs more than the EC2 instances sometimes
    - CloudWatch Logs can get expensive with verbose logging
    - DynamoDB scans will bankrupt you at scale (use queries)
    - Lambda cold starts can be 1-2 seconds (use provisioned concurrency if critical)
    - EBS snapshots are incremental but deletions are confusing (read the docs)

    **Monitoring:**

    - CloudWatch is included but basic (consider Datadog/New Relic for serious monitoring)
    - X-Ray for distributed tracing (debug microservices hell)
    - Set up alarms for: billing, CPU, disk, error rates

    **When NOT to use AWS:**

    - Small personal projects (Vercel/Netlify/Railway way easier)
    - You hate vendor lock-in (consider Kubernetes on any cloud)
    - Budget is tiny (free tier ends, bills start)
    - Team has no cloud experience (steep learning curve)

______________________________________________________________________

## Learning Paths

### :fontawesome-solid-graduation-cap: Free Resources

- **[AWS Skill Builder](https://skillbuilder.aws)** - Official training, tons of free courses (start here)
- **[AWS Free Tier](https://aws.amazon.com/free)** - 12 months free for core services (stay within limits!)
- **[freeCodeCamp AWS Course](https://www.youtube.com/watch?v=ulprqHHWlng)** - 10+ hour deep dive, quality content
- **[AWS Workshops](https://workshops.aws)** - Hands-on labs, various topics
- **[A Cloud Guru Free Tier](https://learn.acloud.guru/search?query=aws&type=free)** - Quality video courses
- **[AWS Getting Started Guides](https://aws.amazon.com/getting-started/)** - Official tutorials

### :fontawesome-solid-flask: Interactive Labs

- **[AWS Sandbox Accounts](https://aws.amazon.com/getting-started/hands-on/)** - Official hands-on tutorials in real AWS
- **[Qwiklabs AWS](https://www.cloudskillsboost.google/catalog?keywords=aws)** - Temporary accounts for safe experimentation
- **[Instruqt AWS Labs](https://play.instruqt.com/public/topics/aws)** - Browser-based scenarios
- **[LocalStack](https://localstack.cloud/)** - Run AWS locally for development

### :fontawesome-solid-certificate: Certifications Worth It

- **[Cloud Practitioner](https://aws.amazon.com/certification/certified-cloud-practitioner/)** - $100, easiest, good starting point if totally new
- **[Solutions Architect Associate](https://aws.amazon.com/certification/certified-solutions-architect-associate/)** - $150, **most popular**, worth it for resume (this one matters)
- **[Developer Associate](https://aws.amazon.com/certification/certified-developer-associate/)** - $150, worth it if you code on AWS daily
- **[SysOps Administrator Associate](https://aws.amazon.com/certification/certified-sysops-admin-associate/)** - $150, operations-focused
- **Skip unless senior/employer pays:** Professional certs ($300), Specialty certs ($300) - overkill for most

**Reality check:**

- Solutions Architect Associate is the sweet spot (most job postings ask for this)
- Study 2-3 months, practice exams are critical
- Use [Tutorials Dojo practice exams](https://tutorialsdojo.com/) ($15, best investment)

### :fontawesome-solid-rocket: Projects to Build

**Beginner (learn the basics):**

- Static website on S3 + CloudFront (learn storage + CDN)
- Serverless URL shortener (Lambda + DynamoDB + API Gateway)

**Intermediate (portfolio-worthy):**

- REST API with Lambda + API Gateway + DynamoDB + Cognito auth
- File processing pipeline (S3 triggers Lambda, stores results in RDS)
- CI/CD pipeline with CodePipeline + CodeBuild + ECR + ECS

**Advanced (job-interview flex):**

- Multi-region application with Route 53 failover + RDS cross-region replicas
- Event-driven microservices with SQS/SNS/EventBridge
- Cost optimization dashboard with Lambda + Cost Explorer API + QuickSight

______________________________________________________________________

## Community Pulse

### :fontawesome-solid-users: Who to Follow

**Twitter/X:**

- [@awscloud](https://twitter.com/awscloud) - Official updates, new service launches
- [@QuinnyPig](https://twitter.com/QuinnyPig) - Corey Quinn, AWS cost optimization, hilarious roasts
- [@ben11kehoe](https://twitter.com/ben11kehoe) - Serverless expert, AWS Community Builder
- [@nathankpeck](https://twitter.com/nathankpeck) - AWS Principal Dev Advocate, ECS/containers expert
- [@jeremy_daly](https://twitter.com/jeremy_daly) - Serverless champion, great technical insights
- [@neiltheblue](https://twitter.com/neiltheblue) - Solutions Architect, hands-on tutorials
- [@esh](https://twitter.com/esh) - AWS Chief Evangelist (Jeff Barr)

**YouTube/Streamers:**

- [AWS Online Tech Talks](https://www.youtube.com/c/AWSOnlineTechTalks) - Deep dives, re:Invent sessions
- [FooBar Serverless](https://www.youtube.com/c/FooBarServerless) - Serverless tutorials
- [Be A Better Dev](https://www.youtube.com/c/BeABetterDev) - Practical AWS projects
- [TechWorld with Nana](https://www.youtube.com/c/TechWorldwithNana) - DevOps + AWS tutorials
- [AWS Events](https://www.youtube.com/c/AWSEventsChannel) - Conference talks, workshops

### :fontawesome-solid-comments: Active Communities

- **[r/aws](https://reddit.com/r/aws)** - 250k+ members, active daily, mix of beginner + advanced (best community)
- **[AWS Community Discord](https://discord.gg/aws)** - Official, helpful, core team present
- **[Dev.to #aws](https://dev.to/t/aws)** - Quality tutorials, case studies, community posts
- **[AWS Community Builders](https://aws.amazon.com/developer/community/community-builders/)** - Official program, great networking
- **[AWS re:Post](https://repost.aws/)** - Official Q&A (replaces old forums)
- **[ServerlessLand Community](https://serverlessland.com/)** - Serverless-focused, active Slack/Discord

### :fontawesome-solid-podcast: Podcasts & Newsletters

**Podcasts:**

- **[AWS Podcast](https://aws.amazon.com/podcasts/aws-podcast/)** - Official, weekly, new features + customer stories
- **[Screaming in the Cloud](https://www.lastweekinaws.com/podcast/screaming-in-the-cloud/)** - Corey Quinn, hilarious, critical of AWS (in good way)
- **[AWS TechChat](https://aws.amazon.com/podcasts/aws-techchat/)** - Technical deep dives
- **[AWS Morning Brief](https://www.lastweekinaws.com/podcast/aws-morning-brief/)** - Short daily AWS news

**Newsletters:**

- **[Last Week in AWS](https://www.lastweekinaws.com/)** - Weekly, irreverent, critical analysis (subscribe now)
- **[Off-by-none](https://offbynone.io/)** - Serverless newsletter, Jeremy Daly, quality content
- **[AWS Week in Review](https://aws.amazon.com/blogs/aws/category/week-in-review/)** - Official blog, weekly updates
- **[AWS Open Source News](https://dev.to/aws/aws-open-source-newsletter-191-4e9b)** - Open source projects on AWS

### :fontawesome-solid-calendar: Events & Conferences

- **[AWS re:Invent](https://reinvent.awsevents.com/)** - Las Vegas, late November, 50k+ attendees, $2k+ (worth it once in career)
- **[AWS Summit](https://aws.amazon.com/events/summits/)** - Free, regional (20+ cities), good for networking
- **[AWS Community Day](https://www.awscommunity.day/)** - Free, community-organized, worldwide, quality talks
- **[ServerlessDays](https://serverlessdays.io/)** - Free/cheap, serverless-focused, technical talks

______________________________________________________________________

## Worth Checking

<div class="grid cards" markdown>

- :fontawesome-solid-book: __Official Stuff__

    ______________________________________________________________________

    [AWS Docs](https://docs.aws.amazon.com/)

    [AWS CLI Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/index.html)

    [AWS Architecture Center](https://aws.amazon.com/architecture/)

    [Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)

- :fontawesome-solid-flask: __Hands-on__

    ______________________________________________________________________

    [AWS Free Tier](https://aws.amazon.com/free/)

    [AWS Workshops](https://workshops.aws/)

    [Qwiklabs AWS](https://www.cloudskillsboost.google/catalog?keywords=aws)

    [LocalStack](https://localstack.cloud/)

- :fontawesome-solid-code: __Real Code__

    ______________________________________________________________________

    [Awesome AWS](https://github.com/donnemartin/awesome-aws)

    [AWS Samples](https://github.com/aws-samples)

    [Serverless Examples](https://www.serverless.com/examples/)

    [CDK Patterns](https://cdkpatterns.com/)

    [AWS CDK Examples](https://github.com/aws-samples/aws-cdk-examples)

- :fontawesome-solid-fire: __Deep Dives__

    ______________________________________________________________________

    [AWS Well-Architected](https://aws.amazon.com/architecture/well-architected/)

    [Last Week in AWS Blog](https://www.lastweekinaws.com/blog/)

    [AWS Heroes Blogs](https://aws.amazon.com/developer/community/heroes/)

    [AWS This Week](https://aweeklydigest.com/)

    [Corey Quinn's Blog](https://www.lastweekinaws.com/blog/)

- :fontawesome-solid-screwdriver-wrench: __Tools & Extensions__

    ______________________________________________________________________

    [AWS CLI](https://aws.amazon.com/cli/)

    [AWS CDK](https://aws.amazon.com/cdk/) (Infrastructure as Code)

    [Serverless Framework](https://www.serverless.com/)

    [AWS SAM](https://aws.amazon.com/serverless/sam/) (Serverless Application Model)

    [AWS Toolkit (VSCode)](https://aws.amazon.com/visualstudiocode/)

    [Steampipe](https://steampipe.io/) (SQL for AWS APIs)

- :fontawesome-solid-rss: __News & Updates__

    ______________________________________________________________________

    [AWS What's New](https://aws.amazon.com/new/)

    [AWS Blog](https://aws.amazon.com/blogs/)

    [r/aws](https://reddit.com/r/aws)

    [Hacker News AWS](https://hn.algolia.com/?q=AWS)

    [AWS Status](https://status.aws.amazon.com/) (When shit breaks)

</div>

______________________________________________________________________

**Last Updated:** 2026-01-13 **Vibe Check:** :fontawesome-solid-globe: Mainstream - AWS is the default cloud. Not the coolest kid anymore (Vercel/Railway have better DX), but runs most production workloads. If you're doing cloud professionally, you're learning AWS.
