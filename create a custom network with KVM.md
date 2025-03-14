Define a new network (e.g., `custom_network.xml`) with similar content as above but with a unique name and IP range.

```bash
sudo virsh net-define custom_network.xml
sudo virsh net-start custom_network
sudo virsh net-autostart custom_network
```

Update your Terraform configuration to use this custom network:

```yaml
resource "libvirt_domain" "example" {
  name = "example_vm"

  network_interface {
    network_name = "custom_network"
  }
  # Other configurations...
}
```

