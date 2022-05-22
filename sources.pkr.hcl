source "docker" "xenial" {
  image       = var.docker_image
  export_path = "target/docker.tar"
  run_command = ["-d", "-i", "-t", "--entrypoint=/bin/bash", "{{.Image}}"]
}

source "digitalocean" "xenial" {
  #api_token   = "DIGITALOCEAN_TOKEN"
  image        = "ubuntu-22-04-x64"
  region       = "nyc3"
  droplet_name = "runner"
  tags         = ["runner"]
  size         = "s-2vcpu-2gb-intel"
  ssh_username = "root"
}