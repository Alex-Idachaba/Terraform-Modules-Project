output "ec2_public_ip" {
  value = module.compute-module.myapp-server.public_ip
}