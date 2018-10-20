provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "ap-south-1"
}

variable "aws_access_key"{}
variable "aws_secret_key"{}
variable "key_name"{}

resource "aws_security_group" "allow_all" {
  name        = "aws_sg"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "test" {
  ami = "ami-0912f71e06545ad88"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"
  security_groups = ["aws_sg"]
}

output "aws_instance_public_dns" {
  value = "${aws_instance.test.public_dns}"
}

output "aws_instance_public_ip" {
  value = "${aws_instance.test.public_ip}"
}
