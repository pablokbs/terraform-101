
resource "aws_key_pair" "pablokbs" {
  key_name = "pablokbs"
  public_key = "${var.ssh_key_content}"
  provider = "aws.personal"
}

resource "aws_security_group" "custom" {
  name = "custom"
  description = "Allow inbound http and ssh"
  provider = "aws.personal"
  ingress = {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress = {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress = {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress = {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_instance" "demo-aws" {
  ami = "ami-452bd728"
  instance_type = "t2.micro"
  key_name = "pablokbs"
  security_groups = [ "custom" ]
  provider = "aws.personal"

  connection {
    user = "ubuntu"
    type = "ssh"
    key_file = "${var.ssh_key}"
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt-get update",
      "sudo apt-get -y install nginx"
    ]
  }

  provisioner "file" {
    source = "www/aws.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/index.html /usr/share/nginx/html/index.html"
    ]
  }
}
