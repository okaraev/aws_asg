provider "aws" {
  region     = var.region
}

resource "aws_security_group" "launch_config_sg" {
    name = "${var.asg_name}_launch_config_sg"
    description = "Security Group of launch configuration ${var.asg_name}_launch_config"
    vpc_id = var.vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = var.launch_config_sg_tags
}

resource "aws_security_group_rule" "lc_sg_tcp_in" {
    count = length(var.launch_config_sg_ingress_tcp_ports)
    
    protocol = "tcp"
    type = "ingress"
    from_port = var.launch_config_sg_ingress_tcp_ports[count.index]
    to_port = var.launch_config_sg_ingress_tcp_ports[count.index]
    cidr_blocks = var.launch_config_sg_cidr_block
    security_group_id = aws_security_group.launch_config_sg.id
}

resource "aws_launch_configuration" "launch_config" {
    name_prefix = "${var.asg_name}_launch_config"
    image_id = var.ami_id
    iam_instance_profile = var.iam_instance_profile
    key_name = var.rsa_key_name
    instance_type = var.instance_type
    security_groups = [ aws_security_group.launch_config_sg.id ]
    user_data = var.launch_config_user_data

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "asg" {
    name = "${var.asg_name}"
    launch_configuration = aws_launch_configuration.launch_config.name
    vpc_zone_identifier = [for id in var.subnet_ids: id]

    min_size = var.asg_min_size
    max_size = var.asg_max_size

    dynamic "tag" {
      for_each = var.asg_tags
      content {
        key = tag.key
        value = tag.value
        propagate_at_launch = true  
      }
    }
}