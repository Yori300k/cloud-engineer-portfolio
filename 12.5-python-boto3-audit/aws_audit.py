#!/usr/bin/env python3
"""
AWS Account Audit Script
Checks for common cost and hygiene issues across the account.
"""
import boto3

def check_running_instances():
    """Find EC2 instances that are running (costing money)."""
    print("\n=== RUNNING EC2 INSTANCES (costing money) ===")
    ec2 = boto3.client('ec2', region_name='us-east-1')
    response = ec2.describe_instances(
        Filters=[{'Name': 'instance-state-name', 'Values': ['running']}]
    )

    found = False
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            found = True
            instance_id = instance['InstanceId']
            instance_type = instance['InstanceType']
            # Get the Name tag if it exists
            name = "(no name tag)"
            for tag in instance.get('Tags', []):
                if tag['Key'] == 'Name':
                    name = tag['Value']
            print(f"  {instance_id}  |  {instance_type}  |  {name}")

    if not found:
        print("  None running. Clean.")


def check_unattached_eips():
    """Find Elastic IPs not attached to anything (they bill while idle)."""
    print("\n=== UNATTACHED ELASTIC IPs (wasting money) ===")
    ec2 = boto3.client('ec2', region_name='us-east-1')
    response = ec2.describe_addresses()

    found = False
    for address in response['Addresses']:
        # If there's no AssociationId, it's not attached to anything
        if 'AssociationId' not in address:
            found = True
            ip = address['PublicIp']
            alloc = address['AllocationId']
            print(f"  {ip}  |  {alloc}  |  NOT ATTACHED")

    if not found:
        print("  None unattached. Clean.")


def check_untagged_instances():
    """Find EC2 instances missing a Name tag (hygiene issue)."""
    print("\n=== EC2 INSTANCES MISSING A NAME TAG ===")
    ec2 = boto3.client('ec2', region_name='us-east-1')
    response = ec2.describe_instances()

    found = False
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            # Skip terminated instances
            if instance['State']['Name'] == 'terminated':
                continue
            has_name = any(tag['Key'] == 'Name' for tag in instance.get('Tags', []))
            if not has_name:
                found = True
                print(f"  {instance['InstanceId']}  |  {instance['State']['Name']}  |  NO NAME TAG")

    if not found:
        print("  All instances tagged. Clean.")


def main():
    print("=" * 50)
    print("  AWS ACCOUNT AUDIT")
    print("=" * 50)
    check_running_instances()
    check_unattached_eips()
    check_untagged_instances()
    print("\n" + "=" * 50)
    print("  Audit complete.")
    print("=" * 50 + "\n")


if __name__ == "__main__":
    main()
