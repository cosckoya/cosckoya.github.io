---
title: Monitoring & Observability
description: Comprehensive guide to modern monitoring and observability tools for tracking system health, application performance, and infrastructure metrics.
---

# Monitoring & Observability

Modern monitoring and observability tools for tracking system health, application performance, and infrastructure metrics across distributed systems.

!!! abstract "Quick Reference"
    - **Metrics**: Time-series data collection with Prometheus and Grafana
    - **Logging**: Centralized log management with ELK Stack or Loki
    - **Tracing**: Distributed request tracking with OpenTelemetry and Jaeger
    - **Alerting**: Proactive notification systems with Alertmanager and PagerDuty

---

## Overview

Monitoring and observability are critical practices for maintaining reliable, performant systems. While traditional monitoring focuses on collecting predefined metrics, modern observability embraces the ability to ask arbitrary questions about your system's behavior.

**The Three Pillars of Observability:**

1. **Metrics** - Numerical measurements over time (CPU usage, request rates, error rates)
2. **Logs** - Discrete events with contextual information
3. **Traces** - Request flows through distributed systems

Together, these pillars enable teams to understand system behavior, diagnose issues, and maintain high availability in complex, distributed architectures.

---

## Core Concepts

### The Four Golden Signals

The foundational metrics every service should monitor (from Google's Site Reliability Engineering):

!!! tip "Golden Signals"
    1. **Latency**: Time to service requests (distinguish successful vs. failed)
    2. **Traffic**: Amount of demand on your system
    3. **Errors**: Rate of failed requests
    4. **Saturation**: How "full" your service is (CPU, memory, I/O)

### RED Method

For microservices monitoring:

- **Rate**: Requests per second
- **Errors**: Number of failed requests
- **Duration**: Time taken per request

### USE Method

For infrastructure monitoring (by Brendan Gregg):

- **Utilization**: Time resource is busy
- **Saturation**: Work queued but not yet serviced
- **Errors**: Error events

---

## Metrics & Time Series

Metrics collection and visualization for system performance monitoring.

=== "Core Platforms"
    - **[Prometheus](https://prometheus.io)** - Industry-standard metrics collection and alerting
    - **[Grafana](https://grafana.com)** - Beautiful visualization and dashboarding
    - **[VictoriaMetrics](https://victoriametrics.com)** - High-performance Prometheus alternative
    - **[InfluxDB](https://www.influxdata.com)** - Time-series database for metrics
    - **[Thanos](https://thanos.io)** - Prometheus long-term storage and federation

=== "Exporters & Agents"
    - [Node Exporter](https://github.com/prometheus/node_exporter) - Linux system metrics
    - [Blackbox Exporter](https://github.com/prometheus/blackbox_exporter) - HTTP/TCP/DNS probing
    - [cAdvisor](https://github.com/google/cadvisor) - Container metrics
    - [Awesome Prometheus](https://github.com/roaldnefs/awesome-prometheus) - Curated exporter list

=== "Documentation"
    - [Prometheus Docs](https://prometheus.io/docs/introduction/overview)
    - [Grafana Docs](https://grafana.com/docs/)
    - [Prometheus Operator](https://prometheus-operator.dev)
    - [Prometheus Best Practices](https://prometheus.io/docs/practices/naming/)

!!! example "Quick Prometheus Setup"
    ```yaml
    # prometheus.yml
    global:
      scrape_interval: 15s

    scrape_configs:
      - job_name: 'node'
        static_configs:
          - targets: ['localhost:9100']
    ```

---

## Logging & Log Management

Centralized logging for debugging, auditing, and troubleshooting.

=== "Full Stacks"
    - **ELK Stack**:
        - [Elasticsearch](https://www.elastic.co/elasticsearch/) - Search and analytics engine
        - [Logstash](https://www.elastic.co/logstash/) - Log processing pipeline
        - [Kibana](https://www.elastic.co/kibana/) - Visualization and exploration
    - **Grafana Loki** - [Loki](https://grafana.com/oss/loki/) - Prometheus-inspired log aggregation

=== "Alternative Platforms"
    - [Graylog](https://www.graylog.org) - Open-source log management
    - [Fluentd](https://www.fluentd.org) - Unified logging layer

=== "Log Shippers"
    - [Filebeat](https://www.elastic.co/beats/filebeat) - Lightweight log forwarder
    - [Promtail](https://grafana.com/docs/loki/latest/clients/promtail/) - Loki log collector
    - [Vector](https://vector.dev) - High-performance observability data pipeline
    - [Fluent Bit](https://fluentbit.io) - Lightweight log processor

=== "Community"
    - [r/ElasticStack](https://www.reddit.com/r/elastic/)
    - [Grafana Community](https://community.grafana.com/)

!!! warning "Log Volume Management"
    Excessive logging can overwhelm systems. Implement:

    - Log levels (DEBUG, INFO, WARN, ERROR)
    - Sampling for high-volume events
    - Retention policies
    - Index lifecycle management

---

## Application Performance Monitoring (APM)

Deep visibility into application behavior and performance.

=== "Open Source APM"
    - **[OpenTelemetry](https://opentelemetry.io)** - Vendor-neutral observability framework
    - **[Jaeger](https://www.jaegertracing.io)** - Distributed tracing platform
    - **[Zipkin](https://zipkin.io)** - Distributed tracing system
    - [SkyWalking](https://skywalking.apache.org) - APM for microservices
    - [Elastic APM](https://www.elastic.co/apm) - Application performance monitoring

=== "Commercial APM"
    - [Datadog](https://www.datadoghq.com) - Full-stack observability platform
    - [New Relic](https://newrelic.com) - Complete observability platform
    - [Dynatrace](https://www.dynatrace.com) - AI-powered full-stack monitoring
    - [AppDynamics](https://www.appdynamics.com) - Business performance monitoring

=== "Documentation"
    - [OpenTelemetry Docs](https://opentelemetry.io/docs/)
    - [Jaeger Architecture](https://www.jaegertracing.io/docs/latest/architecture/)

!!! success "Why APM Matters"
    APM helps identify:

    - Slow database queries
    - Memory leaks
    - External API latency
    - Code-level bottlenecks

---

## Distributed Tracing

Track requests across microservices to understand system behavior.

=== "Tracing Tools"
    - **[OpenTelemetry](https://opentelemetry.io)** - Industry standard for tracing
    - **[Jaeger](https://www.jaegertracing.io)** - Distributed tracing backend
    - **[Zipkin](https://zipkin.io)** - Twitter's distributed tracing system
    - **[Tempo](https://grafana.com/oss/tempo/)** - High-scale distributed tracing backend

=== "Instrumentation"
    - [OpenTelemetry Collector](https://opentelemetry.io/docs/collector/) - Vendor-agnostic collector
    - [Auto-instrumentation](https://opentelemetry.io/docs/instrumentation/) - Automatic tracing
    - [OpenTracing](https://opentracing.io) - Deprecated, use OpenTelemetry

!!! tip "When to Use Tracing"
    Essential for:

    - Microservices architectures
    - Debugging latency issues
    - Understanding service dependencies
    - Performance optimization

---

## Alerting & On-Call Management

Proactive notification and incident management systems.

=== "Alerting Systems"
    - **[Alertmanager](https://prometheus.io/docs/alerting/latest/alertmanager/)** - Prometheus alerting
    - [Grafana Alerting](https://grafana.com/docs/grafana/latest/alerting/) - Multi-source alerting
    - [Bosun](https://bosun.org) - Time-series alerting framework
    - [Cabot](https://cabotapp.com) - Self-hosted watchdog

=== "On-Call Platforms"
    - **[PagerDuty](https://www.pagerduty.com)** - Industry-leading incident management
    - [Opsgenie](https://www.atlassian.com/software/opsgenie) - Atlassian incident response
    - [VictorOps](https://victorops.com) - Splunk on-call
    - [OnCall by Grafana](https://grafana.com/products/oncall/) - Open-source on-call

=== "Status Pages"
    - [Statuspage](https://www.atlassian.com/software/statuspage) - Public status communication
    - [Cachet](https://cachethq.io) - Open-source status page
    - [Uptime Kuma](https://github.com/louislam/uptime-kuma) - Self-hosted monitoring

!!! warning "Alert Fatigue"
    **Avoid alert fatigue by:**

    - Setting appropriate thresholds
    - Aggregating related alerts
    - Creating runbooks for common issues
    - Regularly reviewing and pruning alerts

---

## Synthetic Monitoring & Uptime

Proactive monitoring simulating user interactions.

=== "Uptime Monitoring"
    - **[Uptime Kuma](https://github.com/louislam/uptime-kuma)** - Beautiful self-hosted monitoring
    - [Uptime Robot](https://uptimerobot.com) - Free website monitoring
    - [Pingdom](https://www.pingdom.com) - Website performance monitoring
    - [StatusCake](https://www.statuscake.com) - Uptime and performance monitoring
    - [Blackbox Exporter](https://github.com/prometheus/blackbox_exporter) - Prometheus probing

=== "Self-Hosted"
    - [Gatus](https://github.com/TwiN/gatus) - Automated service health dashboard
    - [Statping](https://github.com/statping/statping) - Status page and monitoring
    - [Healthchecks.io](https://healthchecks.io) - Cron job monitoring

!!! example "Blackbox Exporter Config"
    ```yaml
    modules:
      http_2xx:
        prober: http
        timeout: 5s
        http:
          valid_status_codes: [200]
          method: GET
    ```

---

## Infrastructure Monitoring

Monitor servers, networks, and cloud resources.

=== "System Monitoring"
    - **[Netdata](https://www.netdata.cloud)** - Real-time performance monitoring
    - [Zabbix](https://www.zabbix.com) - Enterprise monitoring solution
    - [Nagios](https://www.nagios.org) - Classic infrastructure monitoring
    - [Icinga](https://icinga.com) - Modern Nagios fork
    - [Sensu](https://sensu.io) - Multi-cloud monitoring

=== "Cloud Monitoring"
    - [AWS CloudWatch](https://aws.amazon.com/cloudwatch/) - AWS native monitoring
    - [Azure Monitor](https://azure.microsoft.com/products/monitor/) - Azure observability
    - [Google Cloud Monitoring](https://cloud.google.com/monitoring) - GCP operations suite

=== "Network Monitoring"
    - [LibreNMS](https://www.librenms.org) - Auto-discovering network monitoring
    - [Smokeping](https://oss.oetiker.ch/smokeping/) - Latency measurement
    - [PRTG](https://www.paessler.com/prtg) - Network monitoring suite

---

## Dashboarding & Visualization

Create meaningful visualizations of your data.

=== "Dashboarding Tools"
    - **[Grafana](https://grafana.com)** - Industry-leading visualization
    - [Kibana](https://www.elastic.co/kibana/) - Elasticsearch visualization
    - [Apache Superset](https://superset.apache.org) - Business intelligence
    - [Metabase](https://www.metabase.com) - Easy-to-use BI tool

=== "Learning Resources"
    - [Grafana Dashboards](https://grafana.com/grafana/dashboards/) - Community dashboards
    - [Grafana Play](https://play.grafana.org) - Live demo environment
    - [Dashboard Best Practices](https://grafana.com/docs/grafana/latest/dashboards/build-dashboards/best-practices/)

!!! tip "Dashboard Design Principles"
    1. **Focus on key metrics** - Don't overwhelm with data
    2. **Use consistent colors** - Red for errors, green for success
    3. **Add context** - Include historical baselines
    4. **Make it actionable** - Link to runbooks or detailed views

---

## Observability Platforms

All-in-one observability solutions.

=== "Commercial Platforms"
    - **[Datadog](https://www.datadoghq.com)** - Full-stack observability
    - **[New Relic](https://newrelic.com)** - Complete observability platform
    - [Elastic Observability](https://www.elastic.co/observability) - Unified observability
    - [Splunk](https://www.splunk.com) - Data-to-everything platform

=== "Open Source Platforms"
    - **[Grafana Stack (LGTM)](https://grafana.com/oss/)** - Loki, Grafana, Tempo, Mimir
    - [SigNoz](https://signoz.io) - Open-source APM and observability
    - [Uptrace](https://uptrace.dev) - OpenTelemetry APM
    - [HyperDX](https://www.hyperdx.io) - Developer-friendly observability

!!! success "Choosing a Platform"
    **Consider:**

    - Data volume and retention needs
    - Budget (open-source vs. commercial)
    - Integration with existing tools
    - Team expertise and learning curve
    - Vendor lock-in concerns

---

## Best Practices

### Monitoring Strategy

!!! success "Essential Practices"
    1. **Monitor user experience first** - Focus on customer-facing metrics
    2. **Use the Four Golden Signals** - Latency, traffic, errors, saturation
    3. **Implement progressive alerting** - Warn → alert → page
    4. **Create comprehensive runbooks** - Document response procedures
    5. **Review and iterate** - Regularly assess monitoring effectiveness
    6. **Plan for scale** - Design for data growth

### Alert Design

!!! warning "Common Pitfalls"
    - ❌ **Too many alerts** - Leads to alert fatigue and ignored pages
    - ❌ **Vague alert names** - "Service Down" vs. "API Gateway 5xx Errors >10%"
    - ❌ **No context** - Include links to dashboards and runbooks
    - ❌ **Alert on symptoms** - Not just on component failures

### Data Retention

| Data Type | Recommended Retention | Reasoning |
|-----------|----------------------|-----------|
| Raw logs | 7-30 days | High volume, expensive storage |
| Aggregated logs | 90-365 days | Compliance and trend analysis |
| Metrics (high-res) | 7-15 days | Detailed troubleshooting |
| Metrics (downsampled) | 1-2 years | Long-term capacity planning |
| Traces | 3-7 days | High volume, specific debugging |

---

## Learning Resources

### Books & Publications

=== "Essential Reading"
    - **[Site Reliability Engineering](https://sre.google/books/)** - Google's SRE practices
    - **[The Site Reliability Workbook](https://sre.google/workbook/table-of-contents/)** - Practical SRE guidance
    - **[Observability Engineering](https://www.oreilly.com/library/view/observability-engineering/9781492076438/)** - Charity Majors et al.
    - **[Prometheus: Up & Running](https://www.oreilly.com/library/view/prometheus-up/9781492034131/)** - Brian Brazil

=== "Blogs & Articles"
    - [Brendan Gregg's Blog](https://www.brendangregg.com/blog/) - Performance analysis
    - [Grafana Blog](https://grafana.com/blog/) - Observability insights
    - [Elastic Blog](https://www.elastic.co/blog/) - Search and observability
    - [Google SRE](https://sre.google/) - SRE best practices

=== "Podcasts"
    - [Grafana's Big Tent](https://grafana.com/blog/tags/bigtent/) - Observability discussions
    - [The Observability Podcast](https://www.observabilitypodcast.com/) - Industry insights

### Standards & Specifications

=== "Key Standards"
    - **[OpenTelemetry](https://opentelemetry.io)** - Observability standard
    - [OpenMetrics](https://openmetrics.io) - Metrics format specification
    - [CloudEvents](https://cloudevents.io) - Event data specification
    - [W3C Trace Context](https://www.w3.org/TR/trace-context/) - Distributed tracing standard

### Communities

=== "Online Communities"
    - [r/DevOps](https://www.reddit.com/r/devops/) - DevOps discussions
    - [r/SRE](https://www.reddit.com/r/sre/) - Site reliability engineering
    - [CNCF Slack](https://slack.cncf.io) - Cloud native community
    - [Grafana Community](https://community.grafana.com/) - Grafana users

---

## Quick Stack Recommendations

### Small Team / Startup

!!! example "Lightweight Stack"
    - **Metrics**: Prometheus + Grafana
    - **Logging**: Grafana Loki
    - **Tracing**: Jaeger (optional)
    - **Alerting**: Alertmanager + PagerDuty free tier
    - **Cost**: Mostly free, minimal infrastructure

### Enterprise / Large Scale

!!! example "Enterprise Stack"
    - **Metrics**: Prometheus + Thanos (long-term storage)
    - **Logging**: Elasticsearch + Logstash + Kibana
    - **Tracing**: OpenTelemetry + Jaeger or Tempo
    - **APM**: Datadog or New Relic
    - **Alerting**: PagerDuty or Opsgenie

### Cloud-Native Kubernetes

!!! example "Kubernetes Stack"
    - **Metrics**: Prometheus Operator
    - **Logging**: Loki + Promtail
    - **Tracing**: OpenTelemetry Operator + Tempo
    - **Dashboards**: Grafana
    - **Deployment**: Helm charts or operators

---

## Quick Command Reference

| Task | Tool | Command |
|------|------|---------|
| Check Prometheus targets | Prometheus | Visit `http://localhost:9090/targets` |
| Query metrics | Prometheus | `promql: rate(http_requests_total[5m])` |
| Test alert rules | Prometheus | `promtool check rules rules.yml` |
| Tail logs | Loki | `logcli query '{job="varlogs"}'` |
| Export Grafana dashboard | Grafana | Dashboard Settings → JSON Model |
| Check OTel collector | OpenTelemetry | `otelcol validate --config=config.yaml` |

---

## Additional Resources

### Official Documentation

- [Prometheus Documentation](https://prometheus.io/docs/) - Complete Prometheus guide
- [Grafana Documentation](https://grafana.com/docs/) - Grafana reference
- [OpenTelemetry Docs](https://opentelemetry.io/docs/) - OTel specification and SDKs
- [Elastic Documentation](https://www.elastic.co/guide/) - ELK Stack guides

### Community Resources

- [Awesome Prometheus](https://github.com/roaldnefs/awesome-prometheus) - Curated Prometheus resources
- [Awesome Observability](https://github.com/adriannovegil/awesome-observability) - Observability tools and resources
- [CNCF Landscape - Observability](https://landscape.cncf.io/guide#observability-and-analysis) - Cloud-native observability tools
