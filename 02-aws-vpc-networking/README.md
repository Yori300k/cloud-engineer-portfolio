


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
## Database Layer (RDS)

- **Database:** `cloud-portfolio-db` — MySQL, free-tier instance
- **DB subnet group:** `private-db-subnet-group` — spans `private-subnet-1` (us-east-1b) and `private-subnet-2` (us-east-1c)
- **Security group:** `db-security-group` — inbound rule allows MySQL (port 3306) only from the EC2 instance's security group, not from any IP range
- **Public access:** Disabled — the database has no public IP and no internet gateway route, making it unreachable from outside the VPC entirely

## End-to-End Connectivity Test

1. SSH'd into `public-test-instance` (in `public-subnet-1`) from a local machine
2. Installed the MySQL client (`mariadb105`) on the instance
3. Connected from the EC2 instance to the RDS database using its internal endpoint
4. Successfully authenticated and reached a `MySQL [(none)]>` prompt — confirming the public subnet can reach the private database, while the open internet cannot

This proves the core 3-tier security pattern: web/app tier is reachable from the internet, data tier is reachable only from inside the VPC.
## Next steps

- Rebuild this entire setup using Terraform (Infrastructure as Code) instead of manual console steps
