output "myapp-server" {
  value = aws_instance.myapp-server
}
output "key_pair" {
  value = aws_key_pair.ssh-key
}