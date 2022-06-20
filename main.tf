terraform {
    required_providers {
        aws = {
        source = "hashicorp/aws"
      }
   }
}
 provider "aws" {
       region = var.aws_region
       profile = var.profile
 }
 resource "aws_vpc" "foodiesvpc" {
    cidr_block = var.vpc_cidr 
    tags = {
      Name = "foodiesvpc"
    }
 }
 resource "aws_subnet" "foodiespubsub" {
    vpc_id = aws_vpc.foodiesvpc.id
    cidr_block = var.subnet_cidr
    tags = {
      Name = "foodiespubsub"  
    }
 }
 resource "aws_internet_gateway" "foodies_ig" {
    vpc_id = aws_vpc.foodiesvpc.id
    tags = {
      Name = "foodies_ig"  
    }
 }
 resource "aws_route_table" "foodiesrt" {
    vpc_id = aws_vpc.foodiesvpc.id
    route {
    cidr_block = var.ig_cidr
    gateway_id = aws_internet_gateway.foodies_ig.id
    }
 }
 resource "aws_route_table_association" "foodiesroute_association" {
    route_table_id = aws_route_table.foodiesrt.id
    subnet_id = aws_subnet.foodiespubsub.id
 }
 resource "aws_security_group" "foodiessg" {
   vpc_id = aws_vpc.foodiesvpc.id
      ingress {
           from_port = var.ingress_rules.from_port
           to_port = var.ingress_rules.to_port
           protocol = var.ingress_rules.protocol
           cidr_blocks = [var.ingress_rules.cidr_blocks]
        }
        egress {
            from_port = var.egress_rules.from_port
            to_port = var.egress_rules.to_port   
            protocol = var.egress_rules.protocol
            cidr_blocks = [var.egress_rules.cidr_blocks]
        }
      }
 resource "aws_key_pair" "foodieskp" {
    key_name = "foodiespkp"
    public_key = var.ssh_key
 }
 resource "aws_instance" "foodiesec2" {
    subnet_id = aws_subnet.foodiespubsub.id
    vpc_security_group_ids = [aws_security_group.foodiessg.id]
    instance_type = var.ec2instance.instance_type
    ami = var.ec2instance.ami
    tags = {
      Name = "foodiesec2"  
       }
    }