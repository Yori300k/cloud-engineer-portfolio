# Project 05 - Terraform Remote State (S3 Backend)

## What I built
A Terraform remote backend using S3 for state storage and DynamoDB for 
state locking — the production-grade solution to the state divergence 
problem I hit in Project 04.

## The problem this solves
In Project 04, my CI/CD pipeline ran `terraform apply` and created real 
AWS resources, but used a temporary state file that disappeared when 
GitHub's server shut down after the run. My local Terraform had no record 
of those resources existing. I couldn't destroy them with Terraform — had 
to manually hunt them down in the AWS console.

That's not a minor inconvenience in a real team environment. That's 
two engineers running Terraform against the same AWS account with 
different state files — one thinks the VPC exists, one thinks it 
doesn't. They'd overwrite each other's work, create duplicate resources, 
or destroy things that shouldn't be destroyed. Remote state is what 
prevents that.

## How it works
- **S3 bucket** stores the actual state file at a specific path 
  (`05-remote-state/terraform.tfstate`)
- **State locking** prevents two simultaneous Terraform runs from 
  corrupting the state file
- **Versioning enabled** on the S3 bucket means every state change 
  is preserved — if a bad run corrupts state, you can restore a 
  previous version
- **Encryption enabled** because state files can contain sensitive 
  data (passwords, keys, resource IDs)

 ## Why remote state matters in production

Terraform's state file is its memory. Store it locally and the moment 
a second person — or a CI/CD pipeline — runs Terraform against the same 
AWS account, you have two machines with two different versions of reality. 
One thinks the VPC exists. The other doesn't. That's how infrastructure 
gets accidentally duplicated or destroyed.

S3 remote state gives every machine a single shared source of truth. 
That's not a nice-to-have in a team environment — it's what makes 
Terraform safe to use at all.

## Real problems I hit
- **VPC limit exceeded:** Had too many VPCs from previous projects 
  sitting around. Had to clean up old infrastructure before this 
  would apply. Real lesson: always destroy lab resources when you're 
  done with them, not just stop them
- **Stale AWS credentials:** Access keys from earlier in the session 
  were no longer valid after rotating keys for GitHub secrets. Had to 
  create fresh keys and reconfigure both AWS CLI and GitHub secrets. 
  Learned that key rotation affects every place those credentials are 
  stored — not just one

## Infrastructure
- S3 bucket: `cloud-portfolio-terraform-state-yori` with versioning 
  and encryption enabled
- DynamoDB table: `terraform-state-lock` for concurrent access 
  protection
- Verified: state file appears in S3 after apply, persists after 
  destroy (showing empty resources), never touches local disk
