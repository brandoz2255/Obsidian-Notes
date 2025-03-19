## **Networking with KVM**

By default, KVM uses **NAT networking** (`virbr0`). If you need **bridged networking** (so VMs get an IP from your router), you'll need to configure a bridge manually.

To see active networks:

```bash
virsh net-list --all
```

To restart the default network:

```bash
virsh net-start default
virsh net-autostart default
```

---

## **Checking Virtualization Performance**

Use `virt-host-validate` to check if `KVM` is running optimally:

```bash
sudo virt-host-validate
```

