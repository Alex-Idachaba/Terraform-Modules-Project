output "vpc-main" {
  value = aws_vpc.main
}
output "subnet-public-1" {
  value = aws_subnet.main-public-1
}
output "subnet-public-2" {
  value = aws_subnet.main-public-2
}
output "subnet-public-3" {
  value = aws_subnet.main-public-3
}
output "subnet-private-1" {
  value = aws_subnet.main-private-1
}
output "subnet-private-2" {
  value = aws_subnet.main-private-2
}
output "subnet-private-3" {
  value = aws_subnet.main-private-3
}