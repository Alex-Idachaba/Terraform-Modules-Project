output "myapp-server" {
  value = aws_instance.myapp-server
}
output "key_pair" {
  value = aws_key_pair.ssh-key
}
output "main_security_group" {
  value = aws_security_group.allow-ssh-http
}