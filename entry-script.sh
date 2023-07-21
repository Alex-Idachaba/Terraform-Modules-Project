#!/bin/bash
sudo yum check-update -y && sudo yum install docker -y
sudo systemctl start docker
sudo usermod -aG docker ec2-user
sudo docker run -p 8080:80 nginx