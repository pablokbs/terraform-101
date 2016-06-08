##

resource "digitalocean_droplet" "demo-www" {
    image = "ubuntu-14-04-x64"
    name = "demo-www"
    region = "nyc2"
    size = "512mb"
    private_networking = true
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]

  connection {
      user = "root"
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
    source = "www/do.html"
    destination = "/usr/share/nginx/html/index.html"
  }
}

# Add a record to the domain
resource "digitalocean_record" "nerdearla-do" {
  domain = "fredrikson.com.ar"
  type = "A"
  name = "nerdearla-do"
  value = "${digitalocean_droplet.demo-www.ipv4_address}"
}

resource "digitalocean_record" "nerdearla-aws" {
  domain = "fredrikson.com.ar"
  type = "A"
  name = "nerdearla-aws"
  value = "${aws_instance.demo-aws.public_ip}"
}
