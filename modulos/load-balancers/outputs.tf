output "DNS_lb" {
    description = "DNS lb"
    value = "http://${aws_lb.alb_tf.dns_name}"
}