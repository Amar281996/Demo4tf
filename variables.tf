variable "aws_region" {
    type = string
    description = "choose aws region"
    default = "us-west-2"
}
variable "profile" {
    type = string
    description = "user credentials"
    default = "default"
}
variable "vpc_cidr" {
    type = string
    description = "cidr to be used while provisoining ec2" 
}
variable "subnet_cidr" {
    type = string
    description = "subnet cidr"
}
variable "ig_cidr" {
    type = string
    description = "ig cidr "
    default = "0.0.0.0/0"
}
variable "ingress_rules" {
    type = object ({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks =string
    })
    description = "ingress rules configurations"
    default = {
        from_port = 22
        to_port = 22
        protocol = "tcp"   
        cidr_blocks = "0.0.0.0/0"
     }
}
variable "egress_rules" {
    type = object ({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = string
    })
    default = { 
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = "0.0.0.0/0"
    }
}     
variable "ssh_key" {
   type = string
   description = "pem key"
   default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDievjAPjJAT+KPj9A5wSE0fcAHYyIwZnd2ObtmXrTnWYHgofiXewJ+3WQqKtU8gEL058gfmi+Bjkj+A+E7anr9Q0+IARyt8yk66D9B8xMASG4R9GTJpqGJ+qZyJ9oYg/6Rgd1pseaBYA1fksQ2OdCgz42B5rpVIi6MtQqTeI2mfsHu1nBmTkT/pKEVZX3K3hY7hY1aLxm1ZtQV9FpjzRTU3UcNIifnrfegg8xFLiirC/rLynhWiCd1SXqBo5Amsi/apC1ZNs/2wlZAE4swIwuCrMlqX6yLYHzMMaATEgxFWdySvDTnpQhPamVqJ8kIhKRabnp21DpE6iOChf8ABZ5wsZMaobQja04ustzmV701Zel5rea6m/9ewHIAgGYapdjpy3c0s3wJRG3u9RwhQGsJ2k8FsPb8ZKnK9717TaF94ctDYdF3ppGJZCel1lSroW6ZlSF6jTLLiieabSvo6TLLJYZQttrU4+HvograWHY0L9yTtdKeEduImvf+dVKJ2y0= SRS@DESKTOP-99M97DV"
}
variable "ec2instance" {
    type = object({
        instance_type = string
        ami = string
        })
        default = {
            instance_type = "t2.micro"
            ami = "ami-00af37d1144686454"
        }
}