# Project 02 - AWS VPC Networking

A custom AWS VPC built by hand in the console to demonstrate core networking concepts: public/private subnet separation, internet routing, and connectivity testing.

## Architecture

- **VPC:** `cloud-portfolio-vpc` — CIDR `10.0.0.0/16`
- **Public subnet:** `public-subnet-1` — CIDR `10.0.2.0/24` — AZ `us-east-1a`
- **Private subnet:** `private-subnet-1` — CIDR `10.0.1.0/24` — AZ `us-east-1b`
- **Internet Gateway:** `cloud-portfolio-igw` — attached to the VPC
- **Route table:** `public-route-table` — routes `0.0.0.0/0` to the Internet Gateway, associated with `public-subnet-1`

## What it demonstrates

- VPC and subnet design with non-overlapping CIDR blocks
- Public vs. private subnet separation — a core security pattern (web-facing resources in public, sensitive resources like databases kept private)
- Spreading subnets across multiple Availability Zones for fault tolerance
- Internet Gateway + route table configuration to enable outbound internet access
- Security group configuration restricting SSH access to a specific IP
- End-to-end connectivity testing: SSH into a live EC2 instance in the public subnet, then verified outbound internet access via `ping`

## How it was tested

1. Launched a `t3.micro` EC2 instance (`public-test-instance`) inside `public-subnet-1` with a public IP enabled
2. SSH'd into the instance from a local machine using a key pair
3. Ran `ping google.com` from inside the instance to confirm outbound internet connectivity

## Next steps

- Add an RDS database inside `private-subnet-1`, accessible only from the public subnet (not directly from the internet)
- Rebuild this entire setup using Terraform (Infrastructure as Code) instead of manual console steps
