This repository documents my hands-on learning with Terraform and AWS EC2.
The purpose of this project was to understand Infrastructure as Code (IaC) concepts by provisioning, managing, and destroying cloud resources in AWS using Terraform.

This project focuses on:

Configuring the AWS provider

Dynamically retrieving the latest Ubuntu AMI

Deploying EC2 instances

Managing Terraform state

Applying proper Git and repository hygiene practices

Project Structure
Terraform_Basic_Exercises/
  └── EC2_Instance/
        ├── main.tf
        ├── terraform.tf
        ├── .terraform.lock.hcl
        ├── .gitignore

File Descriptions

main.tf – Defines AWS provider, AMI data source, and EC2 resource.

terraform.tf – Additional Terraform configuration.

.terraform.lock.hcl – Locks provider versions for reproducibility.

.gitignore – Prevents committing Terraform state files and provider binaries.

What This Project Does

Configures Terraform to use AWS.

Looks up the latest Ubuntu 24.04 AMI dynamically using a data source.

Launches one or more EC2 instances (t2.micro).

Demonstrates use of count for multi-instance deployment.

Properly destroys infrastructure using terraform destroy.

Key Learnings
Terraform Concepts

Terraform is declarative — you define desired state, not procedural steps.

Data sources allow dynamic lookups (e.g., latest AMI).

Implicit dependencies are created through resource references.

terraform init, plan, apply, and destroy serve distinct purposes.

The Terraform state file tracks infrastructure reality.

AWS & IAM

Terraform requires both read and write IAM permissions.

Missing permissions (e.g., ec2:DescribeImages) will block deployment.

AMIs are region-specific.

Some regions may not have a default VPC.

Credentials configured via aws configure are stored locally and not committed.

Git & Best Practices

.terraform/ must never be committed (contains large provider binaries).

terraform.tfstate should not be committed.

.gitignore does not retroactively remove committed files.

Repository root location determines how folder structure appears in GitHub.

Security Practices

AWS credentials are not stored in this repository.

Terraform state files are ignored.

Provider binaries are ignored.

IAM authentication is handled via AWS CLI configuration.

How to Use

Navigate to the EC2 project folder:

cd EC2_Instance


Initialize Terraform:

terraform init


Preview changes:

terraform plan


Deploy infrastructure:

terraform apply


Destroy infrastructure:

terraform destroy

Future Improvements

Convert EC2 configuration into reusable Terraform modules

Add remote state using an S3 backend

Create separate environments (dev / prod)

Add VPC, subnet, and security group configuration

Output instance metadata (public IP, instance ID)

Purpose

This project represents foundational cloud and DevOps skills built through hands-on experimentation with Terraform and AWS. It demonstrates infrastructure provisioning, debugging IAM permissions, repository structuring, and production-aware practices.