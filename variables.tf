variable "region" {
  type        = string
  default     = "us-east-1"
}

variable "ubuntu_ami" {
    description = "Ubuntu images"
    type = map(string)

    default = {
        us-east-1 = "ami-007855ac798b5175e"
    }
}

variable "env" {
    type = string
    default = "dev"
}

variable "servers" {
    type = map(object({
        name = string,
        az = string
    }))

    default = {
        server-1 = {name = "server-1", az = "a"},
        server-2 = {name = "server-2", az = "b"}
    }
}