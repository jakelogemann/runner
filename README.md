# runners

builds a few custom self-hosted runners for github-actions on various targets.

- **Requirements**: make, ansible, packer, and any applicable builders' deps.
  - Docker engine for `make docker`

## Getting Started

```sh
# Assuming you did something like:
#   git clone <repo> ./runner && cd ./runner
make init 
```

## Validate the Template

```sh
make validate
```

## Build a Docker Image

```sh
make docker
```

## Clean up!

```sh
make clean
```

## See Also

- [GNU/Make](https://www.gnu.org/software/make/manual/)
- [Ansible](https://docs.ansible.com/ansible/latest/index.html)

### [Packer](https://www.packer.io/docs)

- [Docker Builder](https://www.packer.io/plugins/builders/docker)
- [QEMU Builder](https://www.packer.io/plugins/builders/qemu)

### Ubuntu

- [Packages available](https://repology.org/projects/?inrepo=ubuntu_21_04)
- [Potentially vulnerable](https://repology.org/projects/?inrepo=ubuntu_21_04&vulnerable=1)