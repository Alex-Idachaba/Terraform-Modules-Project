resource "aws_security_group" "allow-ssh-http" {
  vpc_id = var.vpc_id
  name        = "allow-ssh and http"
  description = "security group that allows ssh, http and all egress traffic"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.my_ip]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name: "${var.env_prefix}-myapp-sg"
  }
}

data "aws_ami" "latest_ubuntu_linux_image" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = [var.image_name]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name = "server-key"
  public_key = file(var.public_key_location)
}

resource "aws_instance" "myapp-server" {
  ami = data.aws_ami.latest_ubuntu_linux_image.id
  instance_type = var.instance_type1

  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.allow-ssh-http.id]
  availability_zone = var.avail_zone1

  associate_public_ip_address = true
  key_name = aws_key_pair.ssh-key.key_name

  user_data = file("entry-script.sh")

  tags = {
    Name: "${var.env_prefix}-myapp-server"
  }
  # role:
  iam_instance_profile = var.iam_instance_profile
}

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = var.avail_zone1
  size              = 20
  type              = "gp2"
  tags = {
    Name = "extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name                    = "/dev/xvdh"
  volume_id                      = aws_ebs_volume.ebs-volume-1.id
  instance_id                    = aws_instance.myapp-server.id
  stop_instance_before_detaching = true
}
