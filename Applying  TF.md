### Troubleshooting Steps

1. **Verify File Paths:**  
    Ensure that the qcow2 files are located exactly at `${path.module}/boxes/rocky9.qcow2` and `${path.module}/boxes/kali.qcow2`.
    
2. **Check Volume Format:**  
    Make sure the images are in `qcow2` format. You can run:

```bash
qemu-img info path/to/rocky9.qcow2
```

**Network Configuration:**  
- Confirm that the libvirt network "default" exists and provides connectivity to your VMs.  

You can list networks with:

```bash
virsh net-list --all
```



Domain Logs:
If a domain fails to start, check the VM console logs via:

```bash
virsh console rocky9_vm1
```


**Terraform Debug Mode:**  
Run `Terraform` with debugging enabled to see more detailed logs:

```bash
TF_LOG=DEBUG terraform apply
```

