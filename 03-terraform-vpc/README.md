# Project 03 - Terraform: AWS VPC as Code

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
