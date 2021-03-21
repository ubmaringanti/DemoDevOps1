variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}
data "aws_ami" "demo_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["PackerAnsible-new"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["self"]
}
resource "aws_launch_configuration" "demo_lc" {
  image_id        = data.aws_ami.demo_ami.id
  instance_type   = "t2.medium"
#   security_groups = security_group_for_demo_websg
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "demo_asg" {
  name                 = "demo-asg-tomcat"
  launch_configuration = aws_launch_configuration.demo_lc.name
  min_size             = 2
  max_size             = 5
  health_check_type    = "ELB"
  availability_zones = ["us-east-1a"]
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_security_group" "demo_websg" {
  name = "security_group_for_demo_websg"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_security_group" "elbsg" {
  name = "security_group_for_elb"
  ingress {
    from_port   = 80
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
}

