
### Check the status of the default network
- Run the following command to check if the `default` network is active:

```bash
sudo virsh net-list --all
```

If the `default` network is listed but shows a state of `inactive`, proceed with the next steps.

- Start the `default` network manually:

```bash
sudo virsh net-start default
```

---

If this its because of the firewall parameters

Create a 'libvirt' zone file manually:

```bash
sudo vim /etc/firewalld/zones/libvirt.xml
```

```xml
<?xml version="1.0" encoding="utf-8"?>
<zone target="ACCEPT">
  <short>libvirt</short>
  <description>
    The default policy of "ACCEPT" allows all packets to/from
    interfaces in the zone to be forwarded, while the (*low priority*)
    reject rule blocks any traffic destined for the host, except those
    services explicitly listed.
  </description>
  <interface name="virbr0"/>
  <service name="dhcp"/>
  <service name="dns"/>
  <service name="ssh"/>
</zone>
```

- Save the file and exit the editor.
- Reload `firewalld` to apply the changes:

```bash
sudo firewall-cmd --reload
```

```bash
sudo virsh net-start default
```


Verify that it is now active:

```bash
sudo virsh net-list
```

To ensure that the `default` network starts automatically on system boot, run:

```bash
sudo virsh net-autostart default
```


----

If the `default` network does not appear in the list, you may need to recreate it. Use the following commands:


```bash
sudo virsh net-define /etc/libvirt/qemu/networks/default.xml
sudo virsh net-start default
sudo virsh net-autostart default
```

Restart the libvirt daemon to ensure all changes take effect:


```bash
sudo systemctl restart libvirtd
```

After ensuring that the `default` network is active, run Terraform again

```bash
terraform apply
```

- [[create a custom network with KVM]]