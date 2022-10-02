variable "region" {
    description = "Region Name"
    type = string
}

variable "vpc_id" {
    description = "VPC ID"
    type = string
}

variable "launch_config_sg_tags" {
    description = "Launch Configuration Security Group Tags"
    type = map(string)
}

variable "launch_config_sg_ingress_tcp_ports" {
    description = "Launch Configuration Security Group TCP in ports"
    type = list(number)
}

variable "launch_config_sg_cidr_block" {
    description = "CIDR block of incoming connections to the ASG"
    type = list(string)
    default = [ "0.0.0.0/0" ]
}

variable "asg_name" {
    description = "Name of ASG Launch Configuration"
    type = string
}

variable "ami_id" {
    description = "ID of ASG Launch Configuration ami"
    type = string
}

variable "iam_instance_profile" {
    description = "IAM Instance profile for ASG LC"
    type = string
    default = null
}

variable "rsa_key_name" {
    description = "Instance key name"
    type = string
    default = null
}

variable "instance_type" {
    description = "Instance type name"
    type = string
}

variable "launch_config_user_data" {
    description = "User Data for launch configuration"
    type = string
    default = null
}

variable "subnet_ids" {
    description = "Subnet IDs"
    type = list(string)
}

variable "asg_min_size" {
    description = "Minimum instances for ASG"
    type = number
    default = 1
}

variable "asg_max_size" {
    description = "Maximum instances for ASG"
    type = number
    default = 3
}

variable "asg_tags" {
    description = "ASG Tags"
    type = map(string)
}