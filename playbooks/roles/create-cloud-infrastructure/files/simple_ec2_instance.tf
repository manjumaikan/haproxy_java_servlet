provider "aws" {
# use export AWS_PROFILE=saml && export AWS_REGION=ap-southeast-2
}

terraform
{
  backend "s3" {
    bucket = "mmk-java-servlet-backend"
    key = "mmk-java-servlet-backend/terraform.tfstate"
    dynamodb_table = "mmk-java-servlet-dyn-table"
    region = "ap-southeast-2"
    encrypt = "true"
  }
}
data "aws_vpcs" "wwm-vpc" {
  tags {
    Name = "vpc1"
  }
}
locals {
#  subnets = "${sort(data.aws_subnet_ids.wwm-subnets.ids)}"
  subnets = "${data.aws_subnet_ids.wwm-subnets.0.ids}"
}
data "aws_subnet_ids" "wwm-subnets" {
  vpc_id = "${element(data.aws_vpcs.wwm-vpc.ids, 0)}"
  tags {
    Name = "vpc1-application-*"
  }
}

data "aws_route53_zone" "learning_zoneid"
{
  name = "apps.sandpit.nbn-aws.local."
  private_zone = "true"
}


resource "aws_route53_record" "r53_entry"
{
  zone_id = "${data.aws_route53_zone.learning_zoneid.zone_id}"
  name = "mmk-private-hosted-java-server.nbn-aws-learning.local."
  type = "A"
  ttl = "300"
  records = ["${aws_instance.mmk_java_servlet.*.private_ip}"]
}

resource "aws_security_group" "mmk-private-hosted-java-servlet-sg"
{
name= "sg_mmk_java_servlet_ip_range"
description= "custom java program to make use of ip range from 9000 - 9999"
vpc_id = "${element(data.aws_vpcs.wwm-vpc.ids, 0)}"

ingress 
{
  # custom application
from_port = 9000
to_port = 9000
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress 
{
  # ssh
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress 
{
  # haproxy stats
from_port = 9500
to_port = 9500
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress
{
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_instance" "mmk_java_servlet" {
  count = 1
  ami           = "ami-c4db27a6"
  key_name = "mmk-java-servlet-key-pair"
  tags = [{Name = "mmk-java-servlet-instance"
   }]
  instance_type = "t2.micro"
  subnet_id = "${local.subnets[count.index]}"
  security_groups = ["${aws_security_group.mmk-private-hosted-java-servlet-sg.*.id}"]
}