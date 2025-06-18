#!/bin/bash

# move to terraform directory
cd terraform || exit 1

# extract the EC2 public IP from Terraform output
EC2_IP=$(terraform output -raw jenkins_public_ip)

if [[ -z "$EC2_IP" ]]; then
  echo "❌ Failed to get EC2 IP. Make sure terraform has been applied."
  exit 1
fi

echo "✅ EC2 Public IP is: $EC2_IP"

# go back to project root and update inventory file
cd ../ansible || exit 1

# update the IP inside inventory file
sed -i "s/^ec2-jenkins .*/ec2-jenkins ansible_host=${EC2_IP} ansible_user=ec2-user ansible_ssh_private_key_file=~\/\.ssh\/jenkins/" inventory

echo "✅ Inventory file updated with EC2 IP."
