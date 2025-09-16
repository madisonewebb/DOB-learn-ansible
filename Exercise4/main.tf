terraform {
  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"
}

provider "aws" {
  region  = var.aws_region
  profile = "AWSAdministratorAccess-095329250105"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_dns_hostnames = true
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

  count = 1
  name  = "my-ec2-cluster-${count.index}"

  ami           = var.ami_id != null ? var.ami_id : data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  associate_public_ip_address = true

  vpc_security_group_ids = concat(
    [module.vpc.default_security_group_id],
    [aws_security_group.allow_ssh.id]
  )
  subnet_id = module.vpc.public_subnets[0]

  tags = {
    Name = var.instance_name
  }
}

# Security group to allow SSH access
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

# Local-exec provisioner to run Ansible playbook
resource "null_resource" "run_ansible" {
  depends_on = [module.ec2_instance]

  triggers = {
    instance_id = module.ec2_instance[0].id
  }

  provisioner "local-exec" {
    command = "ansible-playbook playbook.yaml -i '${module.ec2_instance[0].public_ip},'"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
      GITHUB_PAT                = var.github_pat != null ? var.github_pat : ""
    }
  }
}