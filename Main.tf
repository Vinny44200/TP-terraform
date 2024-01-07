terraform {

  required_providers {

    aws = {

      source  = "hashicorp/aws"

      version = "~> 5.0"

    }

  }
 
  backend "s3" {

    bucket = "bucketdevinny"

    key    = "tfstate/bucketdevinny.tfstate"

    region = "eu-west-3"

  }

}
 
# Configure the AWS Provider

provider "aws" {

  region = "eu-west-3"

  access_key = "access_key"

  secret_key = "secret_key"

}

resource "aws_instance" "app_server" {

  ami           = "ami-02ea01341a2884771"

  instance_type = var.instance_type
 
  vpc_security_group_ids = ["aws_security_group.allow_tls.id"]
 
  tags = {

    Name = "var.name"

  }

}
 
resource "aws_security_group" "allow_tls" {

  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id


 
  ingress {

    description      = "TLS from VPC"

    from_port        = 443

    to_port          = 443

    protocol         = "tcp"

    cidr_blocks      = [aws_vpc.main.cidr_block]

    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]

  }
 
  egress {

    from_port        = 0

    to_port          = 0

    protocol         = "-1"

    cidr_blocks      = ["0.0.0.0/0"]

    ipv6_cidr_blocks = ["::/0"]

  }

 
  tags = {
   Name = "allow_tls"
  }
}