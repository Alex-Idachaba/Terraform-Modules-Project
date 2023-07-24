output "ec2_public_ip" {
  value = module.compute-module.myapp-server.public_ip
}
output "rds" {
  value = module.db-module.db-instance.endpoint
}
output "eb" {
  value = module.app-beanstalk-module.beanstalk-environment.cname
}
