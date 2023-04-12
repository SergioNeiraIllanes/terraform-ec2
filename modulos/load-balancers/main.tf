data "aws_vpc" "default" {
    default = true
}

resource "aws_security_group" "alb_sg" {
    name = "alb-sg-${var.env}"

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        description = "Access to 80 port"
        from_port = var.lb_port
        to_port = var.lb_port
        protocol = "TCP"
    }

    egress {
        cidr_blocks = ["0.0.0.0/0"]
        description = "Out ports"
        from_port = var.server_port
        to_port = var.server_port
        protocol = "TCP"
    }
}

resource "aws_lb" "alb_tf" {
    name = "tf-alb-${var.env}"
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb_sg.id]
    subnets = var.subnet_ids
}

resource "aws_lb_target_group" "tg_tf" {
    name = "tg-tf-${var.env}"
    port = var.lb_port
    vpc_id = data.aws_vpc.default.id
    protocol = "HTTP"

    health_check {
        enabled = true
        matcher = "200"
        path = "/"
        port = var.server_port
        protocol = "HTTP"
    }
}

resource "aws_lb_target_group_attachment" "attachment_tf" {
    count = length(var.id_instances)

    target_group_arn = aws_lb_target_group.tg_tf.arn
    target_id = element(var.id_instances, count.index)
    port = var.server_port
}

resource "aws_lb_listener" "alb-listener" {
    load_balancer_arn = aws_lb.alb_tf.arn
    port = var.lb_port

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.tg_tf.arn
    }
}