output "ec2_public_ip" {
  value = aws_instance.app_server.public_ip
}

output "application_url" {
  value = "http://${aws_instance.app_server.public_ip}:${var.app_port}"
}