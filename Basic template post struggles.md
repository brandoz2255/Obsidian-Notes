
```yaml
provider "libvirt" {
  uri = "qemu:///system"
}

#########################
# Base Rocky Image Volume
#########################

resource "libvirt_volume" "rocky9_base" {
  name   = "rocky9-base.qcow2"
  source = "${path.module}/boxes/rocky9.qcow2"
  format = "qcow2"
}

#########################
# Rocky VM 1 Clone Volume
#########################

resource "libvirt_volume" "rocky9_vm1_vol" {
  name           = "rocky9_vm1.qcow2"
  base_volume_id = libvirt_volume.rocky9_base.id
  format         = "qcow2"
}

#########################
# Rocky VM 2 Clone Volume
#########################

resource "libvirt_volume" "rocky9_vm2_vol" {
  name           = "rocky9_vm2.qcow2"
  base_volume_id = libvirt_volume.rocky9_base.id
  format         = "qcow2"
}

#########################
# Kali Linux Volume (Assuming it's independent)
#########################

resource "libvirt_volume" "kali_vol" {
  name   = "kali.qcow2"
  source = "${path.module}/boxes/kali.qcow2"
  format = "qcow2"
}

#########################
# Define Rocky VM 1
#########################

resource "libvirt_domain" "rocky1" {
  name   = "rocky1_vm"
  memory = 2048
  vcpu   = 2

  disk {
    volume_id = libvirt_volume.rocky9_vm1_vol.id
  }

  network_interface {
    network_name = "default"
  }

  console {
    type        = "pty"
    target_port = "0"
  }
}

#########################
# Define Rocky VM 2
#########################

resource "libvirt_domain" "rocky2" {
  name   = "rocky2_vm"
  memory = 2048
  vcpu   = 2

  disk {
    volume_id = libvirt_volume.rocky9_vm2_vol.id
  }

  network_interface {
    network_name = "default"
  }

  console {
    type        = "pty"
    target_port = "0"
  }
}

#########################
# Define Kali VM
#########################

resource "libvirt_domain" "kali_vm" {
  name   = "kali_vm"
  memory = 2048
  vcpu   = 2

  disk {
    volume_id = libvirt_volume.kali_vol.id
  }

  network_interface {
    network_name = "default"
  }

  console {
    type        = "pty"
    target_port = "0"
  }
}
```

### Explanation

- **Base Volume (`rocky9_base`):**  
    This resource points to your original Rocky Linux image file. It remains read-only and is used as a backing image.
    
- **Clone Volumes (`rocky9_vm1_vol` and `rocky9_vm2_vol`):**  
    These resources use the `base_volume_id` attribute to create copy-on-write clones of the base image. Each clone can be written to independently by its respective VM.
    
- **Domain Resources:**  
    Each VM (rocky1, rocky2, and kali_vm) is defined with its own disk that references the appropriate volume.

---

### Troubleshooting Steps

- **Check Image Locks:**  
    If you ever see a write lock error, verify that you’re not accidentally attaching the same volume to multiple domains. The `virsh list --all` command (using `sudo` if needed) can help verify which domains are using which images.


```bash
TF_LOG=DEBUG terraform apply
```

