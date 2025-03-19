
### 3️⃣ **Create the Rocky Linux Packer Template**

Navigate to the `rocky` directory:

```bash
cd rocky
```

- Create a Packer template file named `rocky.pkr.hcl`:

```bash
vim rocky.pkr.hcl
```

add this to the  config

```yaml
variable "iso_url" {
  type    = string
  default = "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso"
}

variable "iso_checksum" {
  type    = string
  default = "sha256:YOUR_ISO_CHECKSUM_HERE"
}

variable "ssh_username" {
  type    = string
  default = "rocky"
}

variable "ssh_password" {
  type    = string
  default = "rocky_password"
}

variable "ssh_timeout" {
  type    = string
  default = "20m"
}

variable "vm_name" {
  type    = string
  default = "rocky-vm"
}

variable "disk_size" {
  type    = string
  default = "20G"
}

variable "memory" {
  type    = number
  default = 2048
}

variable "cpus" {
  type    = number
  default = 2
}

source "qemu" "rocky" {
  iso_url        = var.iso_url
  iso_checksum   = var.iso_checksum
  output_directory = "output/{{user `vm_name`}}"
  vm_name        = var.vm_name
  disk_size      = var.disk_size
  memory         = var.memory
  cpus           = var.cpus
  communicator   = "ssh"
  ssh_username   = var.ssh_username
  ssh_password   = var.ssh_password
  ssh_timeout    = var.ssh_timeout
  headless       = true
}

build {
  sources = ["source.qemu.rocky"]

  provisioner "shell" {
    scripts = [
      "scripts/install_docker.sh",
      "scripts/install_k3s.sh",
      "scripts/install_calico.sh"
    ]
  }
}

```

- Replace `YOUR_ISO_CHECKSUM_HERE` with the actual SHA256 checksum of the Rocky Linux ISO
- [Rocky-x86_64-minimal.iso](https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-x86_64-minimal.iso)
- [Checksum](https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-x86_64-minimal.iso.CHECKSUM)

