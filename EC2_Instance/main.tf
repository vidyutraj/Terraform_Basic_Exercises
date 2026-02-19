provider "aws" {               // configures the AWS provider
  region = var.instance_region // variable driven region selection
}

data "aws_ami" "ubuntu" { // “What is the most recent Ubuntu 24.04 AMI that matches this naming pattern?”
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical. Ensures that the AMI is from Canonical (Ubuntu's official AWS account)
}

resource "aws_instance" "app_server" {
  count         = var.instance_count
  ami           = data.aws_ami.ubuntu.id // use the AMI ID returned from the data lookup
  instance_type = var.instance_type      // instance type variable

  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.private_subnets[count.index % length(module.vpc.private_subnets)] // rotate instances across available private subnets

  tags = {
    Name = "${var.instance_name}-${count.index + 1}" // instance name variable
  }                                                  // creates an actual EC2 instance
}

data "aws_availability_zones" "available" { // Give me all available AZs for the region configured in the provider
  state = "available"
}

module "vpc" {                              // Explicitly creating our own VPC infrastructure
  source  = "terraform-aws-modules/vpc/aws" // community maintained Terraform module
  version = "5.19.0"

  name = "example-vpc"
  cidr = "10.0.0.0/16" // define VPC CIDR range

  azs             = slice(data.aws_availability_zones.available.names, 0, 3) // only take the first 3 available AZs
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]            // private subnet CIDR
  public_subnets  = ["10.0.101.0/24"]                                        // public subnet CIDR

  enable_dns_hostnames = true
}


// terraform fmt formats your code