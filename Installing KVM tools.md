### **2️⃣ Install KVM and Required Packages**

Run the following command to install **KVM**, **QEMU**, **libvirt**, and **virt-manager**:

```bash
sudo pacman -S qemu-full libvirt virt-manager virt-viewer dnsmasq vde2 bridge-utils ebtables openbsd-netcat
```

- **qemu-full**: The QEMU emulator (supports full virtualization)
- **libvirt**: The core library for managing virtual machines
- **virt-manager**: A GUI to manage virtual machines
- **dnsmasq**: DHCP and DNS support for networking
- **vde2, bridge-utils, ebtables**: Needed for advanced networking
- **openbsd-netcat**: Required for some networking configurations

### **3️⃣ Enable and Start libvirt Service**

After installation, start and enable the `libvirtd` daemon:

```bash
sudo systemctl enable --now libvirtd
```

Verify that `libvirtd` is running:

```bash
systemctl status libvirtd
```

---

### **4️⃣ Add Your User to the libvirt Group (Optional)**

To manage VMs without `sudo`, add yourself to the `libvirt` group:

```bash
sudo usermod -aG libvirt $USER
newgrp libvirt
```

- Logout and log back in for the changes to take effect.

### **5️⃣ Check KVM Status**

Run:

```bash
sudo virsh list --all
```

If KVM is working correctly, this should return an empty list, meaning it's ready for VMs.'


