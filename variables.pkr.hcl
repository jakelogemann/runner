variable "docker_image" {
  type    = string
  default = "ubuntu:xenial"
}

variable "gh_version" {
  type    = string
  default = "2.10.1"
}

variable "packages" {
  type = list(string)
  default = [
    "bash",
    "build-essential",
    "ca-certificates",
    "containerd.io",
    "curl",
    "dnsutils",
    "docker-ce",
    "docker-ce-cli",
    "ftp",
    "git-core",
    "iproute2",
    "iptables",
    "iputils-ping",
    "jq",
    "libunwind8",
    "locales",
    "net-tools",
    "netcat",
    "nodejs",
    "openssh-client",
    "packer",
    "parallel",
    "python3-pip",
    "rsync",
    "shellcheck",
    "sudo",
    "supervisor",
    "telnet",
    // "terraform",
    "time",
    "tzdata",
    "unzip",
    "upx",
    "vault",
    "wget",
    "zip",
    "zstd",
  ]
}
