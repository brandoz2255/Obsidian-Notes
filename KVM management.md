## **Managing VMs on KVM**

### **1️⃣ Graphical Management: Virt-Manager**

```bash
virt-manager
```

This will open the **Virt-Manager** GUI, allowing you to:

- **Create new VMs**
- **Manage existing VMs**
- **Configure networking, storage, and CPU/RAM settings**

---

### **2️⃣ CLI Management: Virsh**

You can also manage VMs using the **virsh** CLI tool.

#### **List all VMs (running and stopped)**

You can also manage VMs using the **virsh** CLI tool.

```bash
virsh list --all
```

Example with Ubuntu

```bash
virt-install \
  --name ubuntu-vm \
  --ram 4096 \
  --vcpus 2 \
  --disk path=/var/lib/libvirt/images/ubuntu.qcow2,size=20 \
  --os-type linux \
  --os-variant ubuntu22.04 \
  --cdrom /path/to/ubuntu.iso \
  --network network=default \
  --graphics spice
```

#### **Start and Stop VMs**

- Start a VM:

```bash
virsh start ubuntu-vm
```

Shutdown a VM:

```bash
virsh shutdown ubuntu-vm
```

Delete a VM:

```bash
virsh undefine ubuntu-vm --remove-all-storage
```

View VM Details

```bash
virsh dominfo ubuntu-vm
```

