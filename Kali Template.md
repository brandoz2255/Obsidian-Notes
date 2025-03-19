### 5️⃣ **Create the Kali Linux Packer Template**

Navigate to the `kali` directory:

```bash
cd ../kali
```

- Create a Packer template file named `kali.pkr.hclk`

```bash
vim kali.pkr.hcl
```

```bash
variable "iso_url" {
  type    = string
  default = "https://cdimage.kali.org/kali-2023.1/kali-linux-2023.1-installer-amd64.iso"
}
d
variable "iso_checksum" {
  type    = string
  default = "sha256:YOUR_ISO_CHECKSUM_HERE"
}

variable "ssh_username" {
  type    = string
  default = "kali"
}

variable "ssh_password" {
  type    = string
  default = "kali_password"
}

variable "ssh_timeout" {
  type    = string
  default = "20m"
}

variable "vm_name" {
  type    = string
  default = "kali-vm"
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

source "qemu" "kali" {
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
  sources = ["source.qemu.kali"]

  provisioner "shell" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y kali-linux-default"
    ]
  }
}
```

-  [Kali](https://cdimage.kali.org/kali-2025.1a/kali-linux-2025.1a-installer-amd64.iso)
- [ChecksumKali](https://cdimage.kali.org/kali-2025.1a/SHA256SUMS)

