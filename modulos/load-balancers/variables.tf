variable "subnet_ids" {
    description = "Subnet ids"
    type = set(string)
}

variable "id_instances" {
    description = "EC2's ID instances"
    type = list(string)
}

variable "server_port" {
    description = "Server port"
    type = number
    default = 8080

    validation {
        condition = var.server_port > 0 && var.server_port <= 65536
        error_message = "Range available 1 to 65536"
    }
}

variable "lb_port" {
    description = "LB port to listen"
    type = number
    default = 80
}

variable "env" {
    description = "ENV"
    type = string
}