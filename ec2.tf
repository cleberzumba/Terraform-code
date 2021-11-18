resource "aws_instance" "myec2-dev" {
  ami = "ami-0e5b6b6a9f3db6db8"
  instance_type = "t2.micro"
}
