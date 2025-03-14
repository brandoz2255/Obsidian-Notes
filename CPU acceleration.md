
**KVM with an NVIDIA GPU**, especially if you plan to run VMs that require **hardware acceleration** (like a Kali VM for GPU-based password cracking or a Rocky VM for AI workloads). Since you already have **NVIDIA drivers installed** via EndeavourOS, here are some additional steps you should consider:
## **1️⃣ Check if IOMMU is Enabled (Required for GPU Passthrough)**

Before enabling GPU passthrough, make sure **IOMMU (VT-d for Intel / AMD-Vi for AMD)** is enabled.

### **Check if IOMMU is enabled**

```bash
dmesg | grep -i -e DMAR -e IOMMU
```


- If you see `DMAR: IOMMU enabled`, you're good to go.
- If **not**, enable it in your BIOS:
    - **Intel CPUs:** Look for `VT-d` and enable it.
    - **AMD CPUs:** Look for `IOMMU` and enable it.