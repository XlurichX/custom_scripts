output "instance_ip" {
  description = "pub_ip"
  value = aws_instance.web-server.public_ip
}
