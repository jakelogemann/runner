build {
  name = "runner"
  sources = [
    "source.docker.xenial",
    "source.digitalocean.xenial",
  ]

  provisioner "shell" {
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive",
    ]
    inline = [
      "apt-get update -qqy && apt-get install -qy ca-certificates sudo curl gnupg lsb-release software-properties-common apt-transport-https",
      "add-apt-repository -y ppa:git-core/ppa",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg && echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && echo \"deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main\" | tee /etc/apt/sources.list.d/hashicorp.list > /dev/null",
      "curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor -o /usr/share/keyrings/nodejs.gpg && echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/nodejs.gpg] https://deb.nodesource.com/node_16.x $(lsb_release -cs) main\" | tee /etc/apt/sources.list.d/nodesource.list > /dev/null",
      "apt-get update -yq && apt-get install -qy --no-install-recommends  ${join(" ", var.packages)}",
      "curl -fsSLo gh.deb https://github.com/cli/cli/releases/download/v${var.gh_version}/gh_${var.gh_version}_linux_$(dpkg --print-architecture).deb && dpkg -i gh.deb && rm -v gh.deb",
      "ln -sf /usr/bin/python3 /usr/bin/python && ln -sf /usr/bin/pip3 /usr/bin/pip",
      "rm -rf /var/lib/apt/lists/*",
    ]
  }

  provisioner "ansible" {
    playbook_file = "./provision.yml"
  }

  post-processors {
    post-processor "docker-import" {
      repository          = "ghcr.io/fnctl/runner"
      keep_input_artifact = true
      tag                 = "latest"
    }

    post-processor "docker-push" { }

    post-processor "manifest" {
      output              = "target/manifest.json"
      keep_input_artifact = true
      strip_path          = true
      custom_data = {
        my_custom_data = "example"
      }
    }
    post-processor "checksum" {
      checksum_types      = ["sha1", "sha256"]
      keep_input_artifact = true
      output              = "target/{{.BuildName}}_{{.ChecksumType}}.checksum"
    }
  }
}
