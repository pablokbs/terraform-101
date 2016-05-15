#
# Estas variables se pueden sobre escribir poniendolas en el .bashrc de la siguiente forma
#
# TF_VAR_digitalocean_token="12345678"
# TF_VAR_ssh_fingerprint="a1:b2:c3:d4"
#
#

variable "digitalocean_token" {
	default = "DigitalOcean_Token"
}

variable "ssh_key" {
	default = "~/.ssh/id_rsa"
}

variable "ssh_fingerprint" {
	default = "SshFingerprint"
}

provider "digitalocean" {
  token = "${var.digitalocean_token}"
}
