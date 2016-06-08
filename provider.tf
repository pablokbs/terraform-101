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

variable "ssh_key_content" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCbUnWc4NitVxn7GdEiIQlaAZd5vQDxHMrJjK/x2TC9ysxyGb5Q/jXKVqyp15qytQQkluGNEZkSVgjLIHum/E0IA6JTb12pARfLBs7G5NrkhDCZonhSln1u8Xr4co/9jXWaEU1dmrWesImKj+IKQR6CgnIR3fGsO2lpg1HiN3dDDuqrE5UihRYG86HRalxN9ClPKeyLgOExDiYcmVAlu6xcKstnTphrGOkpSYFU1+RYLTcHbIfQ5XGydbFfJqp7krsHD8F04keganY59xNoZ85LEIFUOnEJFVUPGj5yyc1MXFIlOY0ZE9vGXusr/Hw+98i2X+ofB3vxc0CinkjeCuLB kbs@retina"
}

variable "ssh_fingerprint" {
  default = "SshFingerprint"
}

provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

variable "aws_personal_key" {
  default = "AWS_Key"
}

variable "aws_personal_secret" {
  default = "AWS_SuchSecret"
}

provider "aws" {
  alias = "personal"
  access_key = "${var.aws_personal_key}"
  secret_key = "${var.aws_personal_secret}"
  region = "us-east-1"
}
