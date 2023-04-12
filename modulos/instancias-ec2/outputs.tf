output "id_instances" {
    description = "ID instances list"
    value = [for server in aws_instance.server: server.id]
}