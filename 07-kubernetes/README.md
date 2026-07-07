# Project 07 - Kubernetes: Container Orchestration

## Business problem this solves
Downtime is money leaving the building by the minute. I killed a running server on purpose and watched Kubernetes rebuild it in under 30 seconds — no human, no 3am page, no lost sales. That is what companies are actually paying for when they run Kubernetes.

## What I built
Deployed my containerized application (from Project 06) into a real 
Kubernetes cluster, running 3 self-healing replicas, and verified it 
serving live traffic.

## What Kubernetes actually does
Docker puts an app in a container. Kubernetes manages containers at 
scale — it keeps them running, restarts them when they crash, spreads 
them across servers, and routes traffic to healthy copies. You declare 
what you want ("keep 3 copies running") and Kubernetes continuously 
makes reality match that, without human intervention.

## What I did
- Installed kubectl (the command-line tool for Kubernetes) and kind 
  (runs a local Kubernetes cluster inside Docker)
- Created a local Kubernetes cluster
- Loaded my Docker image into the cluster
- Wrote a Deployment defining 3 replicas of my app
- Deployed it and confirmed 3 running pods
- Accessed the app in a browser via port-forwarding

## Proving self-healing
I deleted one of the 3 running pods on purpose. Within seconds, 
Kubernetes automatically created a new pod to replace it — because 
my deployment declared "always keep 3 running." I never intervened. 
This is the core value of Kubernetes: in production, this is what 
keeps applications online when a server crashes at 3am and nobody 
is awake to fix it.

## Key concept: declarative infrastructure
Kubernetes is declarative — you describe the desired state ("3 
replicas"), not the steps to get there. If I want 5 copies instead 
of 3, I change one number (replicas: 3 to replicas: 5) and re-apply. 
Kubernetes handles the how. This is the same declarative philosophy 
as Terraform, applied to running applications instead of 
infrastructure.

## Real problems I hit
- kind runs in an isolated Docker environment and can't see images 
  on my regular Docker. Had to load the image into the cluster 
  explicitly with `kind load docker-image`. On real EKS this isn't 
  needed since EKS pulls directly from ECR
- Used imagePullPolicy: Never so Kubernetes uses the locally loaded 
  image instead of trying to download it from a registry — again, 
  a local-kind detail that changes on EKS

## What's next
- Deploy this same app to AWS EKS (Elastic Kubernetes Service) — 
  real production Kubernetes, pulling the image from ECR
- Add a Kubernetes Service to expose the app properly instead of 
  port-forwarding
