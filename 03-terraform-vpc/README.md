# Project 03 - Terraform Infrastructure as Code + CI/CD Pipeline

## What I built
The same AWS architecture from Project 02, rebuilt entirely as Terraform code — plus a GitHub Actions CI/CD pipeline that deploys it automatically on every push.

### Infrastructure defined as code
- VPC, public + private subnets across 2 AZs
- Internet Gateway + route table + subnet association
- Security group with SSH ingress
- EC2 instance in public subnet

### CI/CD pipeline (GitHub Actions)
- Triggers automatically when code in this folder changes
- Runs on a fresh Ubuntu server spun up by GitHub
- Authenticates to AWS using encrypted GitHub secrets
- Runs `terraform init` → `plan` → `apply` automatically
- Proven working: `public-ec2-tf` appeared in AWS without touching a terminal

## Why I rebuilt Project 02 in Terraform
"I clicked through the console" is not repeatable, not version-controlled, and not scalable. Terraform means: delete everything, run one command, get it all back identically. That's how production infrastructure is actually managed.

## Why CI/CD matters
Manual `terraform apply` from a laptop means: only one person can deploy, mistakes happen from wrong directories or wrong accounts, and there's no audit trail. A pipeline means: every change goes through the same automated process, is triggered by a code review/merge, and is logged in GitHub. That's the difference between a hobby project and production infrastructure.

## Real problems I ran into
- **Homebrew/sudo password issue:** Installing Terraform required admin access on Mac. Took multiple attempts because the sudo password prompt doesn't show characters as you type
- **`t2.micro` not free tier eligible:** Got `InvalidParameterCombination` error — had to switch to `t3.micro`. Taught me to always check current free tier eligibility, not assume
- **648MB provider binary committed to Git:** Accidentally committed the Terraform AWS provider binary (648MB), which GitHub rejected. Fixed with `.gitignore`, `git rm --cached`, and `git commit --amend`. Now know exactly what should never go in a repo
- **GitHub Actions token scope:** Personal Access Token didn't have `workflow` scope, so pushing the workflow file was rejected. Had to generate a new token with the right permissions
- **CI/CD secrets named wrong:** First attempt at GitHub Actions secrets named them `AWS` instead of `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`. Pipeline failed with credentials error until secrets were re-entered with exact names matching the workflow file
- **Terraform state divergence:** Pipeline ran `terraform apply` creating real AWS resources, but used a temporary state file that disappeared after the run. Local Terraform had no record of those resources. This is why remote state storage (S3 backend) is required in real teams — covered in Project 05

## Key concepts this demonstrates
- Infrastructure as Code with Terraform (init, plan, apply, destroy lifecycle)
- Resource references and automatic dependency ordering
- CI/CD pipeline design with GitHub Actions
- Secrets management (never hardcode credentials in code)
- `.gitignore` best practices for Terraform projects
- Terraform state management and why it matters

## What I'd add next
- Terraform remote state backend using S3 + DynamoDB (Project 05)
- Separate `plan` and `apply` into different pipeline stages with manual approval gate
- Add `terraform destroy` to pipeline for teardown automation# Project 03 - Terraform: AWS VPC as Code

Rebuilding the AWS VPC from Project 02, this time using Terraform (Infrastructure as Code) instead of manual console steps.

## What this demonstrates
- Installing and configuring a full IaC toolchain from scratch: Homebrew, Terraform, AWS CLI
- Authenticating Terraform to AWS using IAM access keys
- Writing a Terraform configuration file (`main.tf`) defining real infrastructure
- Using `terraform init`, `plan`, and `apply` to safely preview and deploy infrastructure changes
- Understanding that infrastructure is now reproducible from code, not dependent on manual console clicks

## Resources created
- 1 VPC (`cloud-portfolio-vpc-tf`) — CIDR `10.0.0.0/16`

## Next steps
- Add subnets, Internet Gateway, and route table to fully match the Project 02 architecture in code
# Terraform VPC Project
