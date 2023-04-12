resource "aws_security_group" "sg" {
    name = "tf-sg-${var.env}"

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        description = "Security Group for project"
        from_port = var.server_port
        to_port = var.server_port
        protocol = "TCP"
    }
}

resource "aws_instance" "server" {
    for_each = var.servers

    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = each.value.subnet_id
    vpc_security_group_ids = [aws_security_group.sg.id]

    user_data = <<-EOF
        #!/bin/bash
        echo "Hola Terraformers! Soy ${each.value.name} ${var.env}" > index.html
        nohup busybox httpd -f -p ${var.server_port} &
        EOF

    tags = {
        Name = each.value.name
    }
}