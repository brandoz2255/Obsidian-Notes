### **1️⃣ Check Hardware Virtualization Support**

Before installing KVM, ensure your CPU supports hardware virtualization (VT-x for Intel or AMD-V for AMD):

```bash
egrep -c '(vmx|svm)' /proc/cpuinfo
```

- If the output is `0`, your CPU **does not** support virtualization.
- If the output is `1` or more, your CPU **supports** virtualization.

You can also check with:

```bash
lscpu | grep -E "Virtualization|Model name"
```

- If disabled, enable virtualization in your **BIOS/UEFI settings**

