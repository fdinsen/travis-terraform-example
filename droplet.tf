variable "region" {
    type = string
    default = "ams3"
}

variable "droplet_count" {
  type = number
  default = 1
}

variable "droplet_size" {
    type = string
    default = "s-1vcpu-512mb-10gb"
}

data "digitalocean_ssh_key" "mykey" {
  name = "fdinsen-desktop"
}

resource "digitalocean_droplet" "web" {
    count = var.droplet_count
    image = "ubuntu-22-10-x64"
    name = "test-${var.region}-${count.index +1}"
    region = var.region
    size = var.droplet_size
    ssh_keys = [data.digitalocean_ssh_key.mykey.id]

    lifecycle {
        create_before_destroy = false
    }
}

output "server_ip" {
    value = digitalocean_droplet.web.*.ipv4_address
}