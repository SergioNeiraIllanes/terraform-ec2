terraform {
    cloud {
        organization = "tf-sergio"

        workspaces {
            name = "tf-sergio-2"
        }
    }
}

provider "aws" {
    region = var.region
}

data "aws_subnet" "pub_subnets" {
    for_each = var.servers

    availability_zone = "${var.region}${each.value.az}"
}

module "ec2_instances" {
    source = "./modulos/instancias-ec2"
    
    server_port = 8080
    instance_type = "t2.nano"
    ami_id = var.ubuntu_ami[var.region]
    env = var.env
    servers = {
        for id, value in var.servers: 
        id => {
            name = value.name,
            subnet_id = data.aws_subnet.pub_subnets[id].id
        }
    }
}

module "load_balancer" {
    source = "./modulos/load-balancers"

    server_port = 8080
    lb_port = 80
    env = var.env
    subnet_ids = [for sub in data.aws_subnet.pub_subnets: sub.id]
    id_instances = module.ec2_instances.id_instances
}