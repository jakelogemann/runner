packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
    digitalocean = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/digitalocean"
    }
  }
}