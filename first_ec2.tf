provider "aws" {
  region = "us-west-2"
  access_key = "AKIAZ46M74IYSGWIKDT3"
  secret_key = "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"
}

resource "aws_instance" "myec2" {
  ami = "ami-0e5b6b6a9f3db6db8"
  instance_type = "t2.micro"
}

