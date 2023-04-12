variable "server_port" {
    description = "Server port"
    type = number
    default = 8080

    validation {
        condition = var.server_port > 0 && var.server_port < 65536
        error_message = "Port must be grather than 0 and less than 65536"
    }
}

variable "instance_type" {
    description = "Instance type to server EC2"
    type = string
}

variable "ami_id" {
    description = "AMI to use with EC2 server"
    type = string
}

variable "servers" {
    type = map(object({
        name = string,
        subnet_id = string
    }))
}

variable "env" {
    description = "Environment when use it"
    type = string
}