variable "instance_name" {
  description = "Value of the EC2 instance's Name tag."
  type        = string
  default     = "madi-dob-tf-ansible"
}

variable "bucket_name" {
  description = "Name of the website S3 bucket. Overrides the local module default."
  type        = string
  default     = "madi-tf-ansible"
}

variable "instance_type" {
  description = "The EC2 instance's type."
  type        = string
  default     = "t2.micro"
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "project-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["us-east-2a"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "sandbox"
  }
}

variable "aws_region" {
  description = "AWS region, maps to Ansible 'region'"
  type        = string
  default     = "us-east-2"
}

variable "ami_id" {
  description = "Override AMI ID to launch. If null, use latest Ubuntu 24.04 LTS"
  type        = string
  default     = null
}

variable "key_name" {
  description = "SSH key pair name to attach to the instance"
  type        = string
  default     = "madi-dob-ansible"
}

variable "aws_access_key" {
  description = "AWS access key (optional). Prefer using a profile or environment variables."
  type        = string
  default     = null
  sensitive   = false
}

variable "aws_secret_key" {
  description = "AWS secret key (optional). Prefer using a profile or environment variables."
  type        = string
  default     = null
  sensitive   = true
}

variable "aws_profile" {
  description = "AWS CLI profile name to use (optional)."
  type        = string
  default     = null
}

variable "github_pat" {
  type      = string
  sensitive = true
  description = "GitHub Personal Access Token"
}