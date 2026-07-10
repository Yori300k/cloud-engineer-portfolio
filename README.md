# Cloud Engineering Portfolio

An end-to-end AWS portfolio built the way real infrastructure evolves: from manual builds, to Infrastructure as Code, to automated pipelines, to containers and orchestration, to serverless — with security, monitoring, and cost discipline threaded through every stage.

Every build here follows the same rules: solve a business problem, deploy it, **break it on purpose**, diagnose the failure from logs, fix it in code, and document the decisions — including the alternatives I didn't choose and why.

**Live demo:** a serverless URL-shortening API (Lambda + API Gateway + DynamoDB, 100% Terraform) is running right now at $0.00 idle cost. Details in [13-serverless-url-shortener](./13-serverless-url-shortener).

---

## What this portfolio demonstrates

**Infrastructure as Code & Automation** — Multi-tier AWS environments (VPC, public/private subnets, EC2, RDS) built manually first, then rebuilt entirely in Terraform with remote state (S3 + DynamoDB locking) — the same migration path real teams walk. CI/CD for infrastructure via GitHub Actions and a self-hosted 4-stage Jenkins pipeline: plan and apply on push, no console clicking.

**Networking & Security** — Private workloads reachable only through load balancers; internet egress through NAT with no ingress; bastion access with agent forwarding; IAM built deny-by-default and *proven* — policies scoped to single resources, with deliberate permission removals to demonstrate blast-radius containment (reads survived, writes failed, logs named the exact missing action).

**Containers & Orchestration** — Dockerized Python applications shipped to ECR; Kubernetes self-healing demonstrated live (deleted pods auto-replaced across 3 replicas).

**Serverless & Event-Driven** — Lambda + API Gateway + DynamoDB with least-privilege execution roles, environment-injected configuration, and observed cold-start behavior — chosen over always-on compute because the traffic profile demanded scale-to-zero, and documented for when the opposite choice wins.

**Observability & Operations** — CloudWatch metrics, alarms, and SNS alerting; log-driven root-cause analysis as a standard practice (including diagnosing an upstream failure from the *absence* of logs); a Python/boto3 account auditor that catches real waste — running instances, unattached EIPs, untagged resources.

**Linux & Scripting** — Bash health checks with threshold alerting; Python automation with proper dependency management.

---

## How each project is documented

Every project README states the business problem and its constraints, the architecture (with diagram), **the decisions and trade-offs** (why this service and when the alternative would win), what broke and how it was diagnosed, and what I'd change at production scale.

## Background

8 years in SaaS implementation and revenue roles before this — which means the business-impact framing in these READMEs (downtime cost, breach cost, deploy velocity) isn't decoration; it's the lens I've always worked through. Now the infrastructure side of it is in code.

📫 Open to remote cloud engineering contract roles — [LinkedIn](https://linkedin.com/in/tjstrategiccrm)
