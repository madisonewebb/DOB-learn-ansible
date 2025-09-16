# DOB Chapter 8 - Ansible

This repository contains exercises and examples for learning Ansible, focusing on idempotency, AWS EC2 provisioning, and integration with Terraform.

## Exercises

### Exercise 2: Ansible and Idempotency
This exercise focuses on creating idempotent Ansible playbooks that can be run multiple times with the same result.

**Key Concepts:**
- Understanding idempotency in Ansible
- Using Ansible handlers
- Creating reusable and maintainable playbooks

### Exercise 3: Ansible and AWS EC2
In this exercise, you'll provision an AWS EC2 instance and install a GitHub self-hosted runner.

**Key Features:**
- AWS EC2 instance provisioning with Ansible
- GitHub self-hosted runner installation
- Running GitHub workflows on self-hosted runners

### Exercise 4: Terraform and Ansible
This exercise combines Terraform for infrastructure provisioning with Ansible for configuration management.

**Key Features:**
- EC2 instance provisioning using Terraform
- Ansible integration with Terraform using local-exec provisioner
- End-to-end automation of infrastructure and configuration

## Getting Started

### Prerequisites
- Ansible
- Vagrant
- Terraform
- AWS CLI configured with appropriate credentials
- GitHub account with repository access

### Directory Structure
- `Exercise2/` - Idempotent Ansible playbooks
- `Exercise3/` - AWS EC2 provisioning with Ansible
- `Exercise4/` - Terraform and Ansible integration
- `.github/workflows/` - GitHub Actions workflows

## Usage

### Running the Exercises
1. Navigate to the specific exercise directory
2. Follow the instructions in the exercise's README
3. Run the playbooks using the provided commands