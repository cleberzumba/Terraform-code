provider "aws" {
  region = "us-west-2"
  access_key = "AKIAZ46M74IYSGWIKDT3"
  secret_key = "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"
}

variable "elb_names" {
    type = list
    default = ["dev-loadbalancer","stage-loadbalancer","prod-loadbalancer"]
}

resource "aws_iam_user" "lb" {
    name = var.elb_names[count.index]
    count = 3
    path = "/system/"
}

/*resource "aws_instance" "instance-1" {
  ami = "ami-0e5b6b6a9f3db6db8"
  instance_type = "t2.micro"
  count = 5
}*/

/*resource "aws_instance" "instance-2" {
  ami = "ami-0e5b6b6a9f3db6db8"
  instance_type = "t2.micro"
}

resource "aws_instance" "instance-3" {
  ami = "ami-0e5b6b6a9f3db6db8"
  instance_type = "t2.micro"
}*/