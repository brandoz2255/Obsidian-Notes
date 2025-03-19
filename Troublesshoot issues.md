## **1️⃣ KVM Not Detected / Virtualization Not Supported**

### **Issue:** Running `egrep -c '(vmx|svm)' /proc/cpuinfo` returns `0`

#### **Fix:**

- **Enable virtualization in BIOS/UEFI**:
    - Reboot and enter your BIOS (usually by pressing `F2`, `F10`, `Del`, or `Esc`).
    - Look for `Intel VT-x` (Intel CPUs) or `AMD-V` (AMD CPUs).
    - Enable it and save changes.
- **Check if it's enabled in the kernel**:

```bash
lscpu | grep Virtualization
```

- If it says `None`, your BIOS settings may still be incorrect.


**Ensure KVM modules are loaded**:

```bash
lsmod | grep kvm
```

- If no output, manually load them:

```bash
sudo modprobe kvm
sudo modprobe kvm_intel  # For Intel CPUs
sudo modprobe kvm_amd    # For AMD CPUs
```

## **2️⃣ libvirtd Service Not Running**

### **Issue:** Running `systemctl status libvirtd` shows **inactive (dead) or failed**

#### **Fix:**

1. Restart the service:

```bash
sudo systemctl restart libvirtd
```

2. If it fails, check logs:

```bash
journalctl -xeu libvirtd
```

3. Ensure the service is enabled at boot:

```bash
sudo systemctl enable --now libvirtd
```

## **3️⃣ Permission Issues When Running Virt-Manager**

### **Issue:** Error: `"Failed to connect to socket /var/run/libvirt/libvirt-sock: Permission denied"`

#### **Fix:**

- Ensure your user is in the `libvirt` group:

```bash
sudo usermod -aG libvirt $USER
```

 Log out and log back in, or run:

```bash
newgrp libvirt
```

If still not working, restart `libvirtd`:

```bash
sudo systemctl restart libvirtd
```


## **4️⃣ No Available Networks in Virt-Manager**

### **Issue:** `"No active networks found"` when trying to create a VM

#### **Fix:**

1. Check if the default network exists:

```bash
virsh net-list --all
```

If `default` is **inactive**, start and enable it:

```bash
virsh net-start default
virsh net-autostart default
```

If the `default` network is missing, recreate it:

```bash
sudo virsh net-define /usr/share/libvirt/networks/default.xml
sudo virsh net-start default
sudo virsh net-autostart default
```

## **5️⃣ VM Won't Start ("QEMU/KVM: Permission Denied")**

### **Issue:** Trying to start a VM results in `Permission denied` errors.

#### **Fix:**

- If using `AppArmor` or `SELinux`, check logs:

```bash
dmesg | grep -i apparmor
```

```bash
sudo ausearch -m AVC -c qemu
```

```bash
sudo aa-complain /etc/apparmor.d/usr.sbin.libvirtd
```

```bash
sudo chown -R libvirt-qemu:kvm /var/lib/libvirt/images/
```


## **6️⃣ USB Passthrough Not Working**

### **Issue:** Can't attach USB devices to VMs.

#### **Fix:**

- Ensure your user has permission to access USB devices:

```bash
sudo usermod -aG libvirt,kvm,input $USER
```

```bash
sudo systemctl restart usbredir
```

```bash
lsusb
```

Attach it manually in **Virt-Manager** under **"Add Hardware" → "USB Host Device"**.



## **7️⃣ "KVM Acceleration Not Available, Using TCG Instead"**

### **Issue:** VM is using **TCG (software emulation)** instead of hardware acceleration.

#### **Fix:**

1. Ensure KVM is loaded:

```bash
lsmod | grep kvm
```

If not, load the module manually:

```bash
sudo modprobe kvm_intel  # For Intel
sudo modprobe kvm_amd    # For AMD
```

Check QEMU settings:

```bash
virsh edit your-vm-name
```

Look for:

```xml
<type arch='x86_64' machine='pc-q35-6.2'>hvm</type>
```

If missing, change it to:

```xml
<type arch='x86_64' machine='pc-q35-6.2'>kvm</type>
```

If using **Nested Virtualization**, enable it:

```bash
sudo modprobe -r kvm_intel
sudo modprobe kvm_intel nested=1
```

## **8️⃣ Can't Connect to VM via SSH or Network**

### **Issue:** Can't ping or SSH into the VM from the host.

#### **Fix:**

1. Check if the VM has an IP:

```bash
virsh domifaddr your-vm-name
```

If no IP, restart the VM's network:

```bash
virsh net-destroy default
virsh net-start default
```

If using `virt-manager`, switch to **Bridged Networking**:

- Go to **VM Settings → NIC → Change NAT to Bridged Adapter**.
- Restart the VM.

If using `iptables` or `firewalld`, allow traffic:

```bash
sudo firewall-cmd --permanent --zone=trusted --add-interface=virbr0
sudo firewall-cmd --reload
```


## **9️⃣ VM is Slow or Lagging**

### **Issue:** VMs are running **slower than expected**.

#### **Fix:**

- Enable **CPU host-passthrough** for better performance:

```bash
virsh edit your-vm-name
```

Change:

```xml
<cpu mode='custom' match='exact'>
    <model fallback='allow'>qemu64</model>
</cpu>
```

To:

```bash
<cpu mode='host-passthrough'/>
```

Allocate more memory and CPU:

```bash
virsh setvcpus your-vm-name 4 --config
virsh setmem your-vm-name 8G --config
```

## **1️⃣0️⃣ Deleted VM, But Image is Still Taking Space**

### **Issue:** VM is deleted, but disk space isn’t freed.

#### **Fix:**

1. Locate unused disk images:

```bash
sudo du -sh /var/lib/libvirt/images/*
```

Manually remove them:

```bash
sudo rm -rf /var/lib/libvirt/images/your-vm.qcow2
```

### **Final Debugging Steps**

If none of these solutions work:

- Check **system logs**:

```bash
journalctl -xeu libvirtd
```

Check **QEMU logs**:

```bash
sudo cat /var/log/libvirt/qemu/your-vm-name.log
```


Try running virt-manager with debugging:

```bash
virt-manager --debug
```

