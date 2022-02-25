# Provisionando na Amazon Web Services (AWS) uma instancia EC2, conectando remoto e instalando Nginx web-server com Terraform.

provider "aws" {
  region     = "us-west-2"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "myec2" {
  ami = "ami-0e5b6b6a9f3db6db8"
  instance_type = "t2.micro"
  key_name = "labs-terraform"


  provisioner "remote-exec" {
      inline = [
          "sudo amazon-linux-extras install -y nginx1.12",
          "sudo systemctl start nginx"
      ]

  connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("./labs-terraform.pem")
      host = self.public_ip
  }
  }

}
