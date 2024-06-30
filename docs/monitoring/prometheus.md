# Prometheus

## Add Prometheus Helm repository

Add [Prometheus Helm repo](https://github.com/prometheus-community/helm-charts) as follows:

```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```

Also we need to install [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics) Helm repo:

```sh
helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
```

Update Helm repository list:
```sh
helm repo update
```

Run following command to see the charts:
```sh
helm search repo prometheus-community
```

## Install Prometheus server (default) with Helm

```sh
helm install prometheus prometheus-community/prometheus --namespace monitoring --create-namespace
```

Expose services and access to the URL:

Prometheus:
```sh
kubectl port-forward service/prometheus-server 8080:80
```

Then access: http://localhost:8080

Alertmanager:
```sh
kubectl port-forward service/prometheus-alertmanager 8081:80
```
Then access: http://localhost:8081



---
# AlertManager
## Configure Alert-Manager

AlertManager is the tool that sends all notifications via mail or API. Prometheus server has all the alert rules, when an alert is triggered by a rule, Alertmanager will send the notification.

First step is to configure Alertmanager config file (alertmanager.yml)

In here we could add some customization parameters like:

- **Global**: Where we can set our notification sender by SMTP (SendGrid, Gmail...), API (Slack, WeChat..) or simply set the timeouts.

- **Route**: We set a sending logic here, how the mails and to who the notifications will be sent.

- **Inhibit Rules**: Add another set of rules to set diffferent route rules to different receivers

- **Receivers**: Here we set the different receivers. Maybe we need to send notifications to slack, mail, or both. In here we need to add as much receviers that we want to.

In this sample I will set up an API (via Slack) and a mail (via SendGrid)

```yaml
global:
  # Sendgrid SMTP properties.
  smtp_smarthost: 'smtp.sendgrid.net:587'
  smtp_from: 'Alertmanager <alertmanager@cosckoya.io>'
  smtp_auth_username: 'apikey'
  smtp_auth_password: '<API KEY HERE>'

  # Slack API properties
  slack_api_url: 'https://hooks.slack.com/services/<API TOKEN HERE>'

  receivers:
  - name: mail
    email_configs:
    - to: "admins@mail.me"
      headers:
        Subject: "Alert ({{ .Status }}): {{ .CommonLabels.severity }} {{ .CommonAnnotations.message }} ({{ .CommonLabels.alertname }})"
      html: |
        Greetings,
        <p>
        You have the following firing alerts:
        <ul>
        {{ range .Alerts }}
        <li>{{.Labels.alertname}} on {{.Labels.instance}}</li>
        <li>Labels:</li>
        <li>{{ range .Labels.SortedPairs }} - {{ .Name }} = {{ .Value }}</li>
        <li>{{ end }}Annotations:</li>
        <li>{{ range .Annotations.SortedPairs }} - {{ .Name }} = {{ .Value }}</li>
        <li>{{ end }}---</li>
        {{ end }}
        </ul>
        </p>

  - name: slack
    slack_configs:
    - channel: '#alerting'
      send_resolved: true
      icon_url: https://avatars3.githubusercontent.com/u/3380462
      title: |-
       [{{ .Status | toUpper }}{{ if eq .Status "firing" }}:{{ .Alerts.Firing | len }}{{ end }}] {{ .CommonLabels.alertname }} for {{ .CommonLabels.job }}
       {{- if gt (len .CommonLabels) (len .GroupLabels) -}}
         {{" "}}(
         {{- with .CommonLabels.Remove .GroupLabels.Names }}
           {{- range $index, $label := .SortedPairs -}}
             {{ if $index }}, {{ end }}
             {{- $label.Name }}="{{ $label.Value -}}"
           {{- end }}
         {{- end -}}
         )
       {{- end }}
      text: >-
       {{ range .Alerts -}}
       *Alert:* {{ .Annotations.title }}{{ if .Labels.severity }} - `{{ .Labels.severity }}`{{ end }}

       *Description:* {{ .Annotations.description }}

       *Details:*
         {{ range .Labels.SortedPairs }} • *{{ .Name }}:* `{{ .Value }}`
         {{ end }}
       {{ end }}

  route:
    group_wait: 10s
    group_interval: 5m
    receiver: mail
    repeat_interval: 10s
    routes:
    - match:
        #alertname: DeadMansSwitc
        severity: High
      repeat_interval: 1m
      receiver: slack
```
This parameters will setup AlertManager to send notifications to the declared "routes"; mail as default and Slack API when the match case is setted up.

Now we have to setup some alerts. These ones are just for demostration and testing that the alert triggers works.

```yaml
  groups:
  - name: deadman.rules
    rules:
    - alert: deadman
      expr: vector(1)
      for: 10s
      labels:
        severity: Critical
      annotations:
        message: Dummy Check
        summary: This is a dummy check meant to ensure that the entire lerting pipeline is functional.
  - name: pod.rules
    rules:
    - alert: PodLimit
      expr: kubelet_running_pods > 0
      for: 15m
      labels:
        severity: High
      annotations:
        message: 'Kubelet {{$labels.instance}} is running {{$value}} pods.'
```

Last Step is to setup "alerting" in the prometheus server config file (prometheus.yml):
```yaml
[...]
  alerting:
    alertmanagers:
      - static_configs:
        - targets:
          - prometheus-alertmanager:80
[...]
```


## REFERENCES
- https://awesome-prometheus-alerts.grep.to/rules.html
---
## InfluxDB v1
### Chronograf
### Kapacitor

## InfluxDB v2
## Telegraf
- [Telegraf](https://docs.influxdata.com/telegraf)
- [InfluxDB](https://docs.influxdata.com/influxdb/v2.0)
---
## Install InfluxDBv2 in Kubernetes
```bash
CMD> kubectl create namespace monitoring
```

### Deploy Service Account

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: cthulhu
  namespace: monitoring
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cthulhu-clusterrole
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: cthulhu
  namespace: monitoring
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: cthulhu-role
  namespace: monitoring
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: cthulhu
  namespace: monitoring
```

### Deploy our InfluxDB v2 server
```yaml
apiVersion: v1
kind: Service
metadata:
  name: influxdb
  namespace: monitoring
spec:
  type: ClusterIP
  selector:
    app: influxdb
  ports:
  - name: api
    port: 9999
  - name: gui
    port: 8086
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: influxdb
  namespace: monitoring
spec:
  serviceName: "influxdb"
  selector:
    matchLabels:
      app: influxdb
  template:
    metadata:
      labels:
        app: influxdb
    spec:
      serviceAccount: cthulhu
      containers:
      - name: influxdb
        image: quay.io/influxdb/influxdb:v2.0.3
        resources:
          limits:
            memory: "128Mi"
            cpu: 1
        ports:
        - name: api
          containerPort: 9999
        - name: gui
          containerPort: 8086
        volumeMounts:
        - name: data
          mountPath: /root/.influxdbv2
  volumeClaimTemplates:
    - metadata:
        name: data
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: 1Gi
        volumeMode: Filesystem
```
### Run a Job to configure the server
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: influxdb-setup
  namespace: monitoring
spec:
  template:
    spec:
      restartPolicy: Never
      containers:
        - name: create-credentials
          image: quay.io/influxdb/influxdb:v2.0.3
          command:
            - influx
          args:
            - setup
            - --host
            - http://influxdb.monitoring:8086
            - --bucket
            - kubernetes
            - --org
            - InfluxData
            - --password
            - yogsothoth
            - --username
            - admin
            - --token
            - secret-token
            - --force
```

### Deploy Telegraf

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: telegraf
  namespace: monitoring
spec:
  selector:
    matchLabels:
      app: telegraf
  template:
    metadata:
      labels:
        app: telegraf
    spec:
      serviceAccount: cthulhu
      volumes:
      - name: config
        configMap:
          name: telegraf
      containers:
      - name: telegraf
        image: telegraf:alpine
        imagePullPolicy: IfNotPresent
        volumeMounts:
        - name: config
          mountPath: /etc/telegraf/telegraf.conf
          subPath: telegraf.conf
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: telegraf
  namespace: monitoring
data:
  telegraf.conf: |
    [global_tags]
      infra = "minikube"

    [agent]

      interval            = "10s"
      round_interval      = true
      metric_batch_size   = 1000
      metric_buffer_limit = 10000
      collection_jitter   = "0s"
      flush_interval      = "10s"
      flush_jitter        = "0s"
      precision           = ""
      debug               = false
      quiet               = false
      logfile             = ""
      hostname            = "telegraf"
      omit_hostname       = false

    [[outputs.influxdb_v2]]
      urls         = ["http://influxdb:8086"]

      organization = "InfluxData"
      bucket       = "kubernetes"
      token        = "secret-token"

    [[inputs.cpu]]
      percpu           = true
      totalcpu         = true
      collect_cpu_time = false
      report_active    = false

    [[inputs.disk]]
       ignore_fs = ["rootfs","tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "aufs", "squashfs"]
```

### Login with "username" & "password"
```bash
kubectl port-forward service/influxdb 8086:8086
```
