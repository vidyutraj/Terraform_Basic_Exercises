provider "aws" {       // configures the AWS provider
  region = "us-east-1" // managing AWS resources in the us-east-1 region
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
  count         = 2
  ami           = data.aws_ami.ubuntu.id // use the AMI ID returned from the data lookup
  instance_type = "t2.micro"             // instance type

  tags = {
    Name = "learn-terraform-${count.index}" // name of the EC2 instance
  }                                         // creates an actual EC2 instance
}

// terraform fmt formats your code