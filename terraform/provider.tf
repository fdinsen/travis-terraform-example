terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}
# variable "pvt_key" {}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_account" "account_info" {

}

output "droplet_limit" {
    value = data.digitalocean_account.account_info.droplet_limit
}

terraform {
  cloud {
    organization = "fdinsen"

    workspaces {
      name = "test-workspace"
    }
  }
}