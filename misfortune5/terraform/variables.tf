variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-west-2"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        us-west-2 = "ami-5e63d13e"
        us-west-1 = "ami-3e21725e"
        us-east-1 = "ami-49c9295f"
    }
}

variable "amis-api" {
    description = "AMIs by region"
    default = {
        us-west-2 = "ami-6a7ef20a"
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

