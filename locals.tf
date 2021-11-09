provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAZ46M74IYSGWIKDT3"
  secret_key = "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"
}

locals {
  common_tags = {
    Owner   = "DevOps Team"
    service = "backend"
  }
}

resource "aws_instance" "app-dev" {
  ami           = "ami-0e5b6b6a9f3db6db8"
  instance_type = "t2.micro"
  tags          = local.common_tags
}

resource "aws_instance" "db-dev" {
  ami           = "ami-0e5b6b6a9f3db6db8"
  instance_type = "t2.small"
  tags          = local.common_tags
}

resource "aws_ebs_volume" "db-ebs" {
  availability_zone = "us-west-2a"
  size              = 8
  tags              = local.common_tags
}