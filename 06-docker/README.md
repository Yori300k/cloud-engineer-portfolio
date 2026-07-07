# Project 06 - Docker: Containerizing an Application

## Business problem this solves
"Works on my machine" burns days of engineering time chasing bugs that only exist because environments do not match. Containers end the argument — the environment ships with the app, identical everywhere, and a new developer goes from days of setup to hours.

## What I built
A Python web application containerized using Docker — built locally, 
verified running in a container, and ready to deploy to AWS.

## Why containerization matters
Before Docker, deploying an app meant manually installing the right 
Python version, the right dependencies, and the right configuration 
on every server — and hoping it matched the development environment. 
With Docker, the container IS the environment. The same image runs 
identically on a Mac, a Windows machine, an EC2 instance, or a 
Kubernetes cluster. One build, runs anywhere.

## What I built
- `app.py` — a simple Python HTTP server responding on port 8080
- `Dockerfile` — instructions for building the container image:
  - Starts from official Python 3.11 slim base image
  - Sets working directory inside container
  - Copies application code in
  - Exposes port 8080
  - Runs the app on container start
- Built the image locally with `docker build`
- Ran it with `docker run -p 8080:8080` and verified it in a browser

## Real problems I hit
- Pasted Dockerfile contents directly into terminal instead of into 
  nano — got `zsh: command not found: FROM`. Learned the hard way 
  that nano has to be open before you paste file contents into it

 ## What I completed
- Built Docker image locally and verified running in browser
- Authenticated Docker to AWS ECR using `aws ecr get-login-password`
- Tagged and pushed image to private ECR repository
- Image now lives at `344838028727.dkr.ecr.us-east-1.amazonaws.com/cloud-portfolio-app:latest`

## What's next
- Deploy this image to EKS (Elastic Kubernetes Service) — Project 07
- Connect it to the VPC infrastructure from Projects 02 and 03
