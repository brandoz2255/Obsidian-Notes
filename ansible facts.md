
**What are Ansible facts?**

- _Facts_ are variables that Ansible automatically collects from each host you manage.
- Think of them as a “snapshot” of the host’s current state (name, OS, IPs, memory, etc.).
- You can use them just like any other variable in your playbooks.

---

## 1. How facts are gathered

|Step|What happens|Why it matters|
|---|---|---|
|**Setup**|Ansible runs `ansible.builtin.setup` before the first task.|It pulls all the facts for you.|
|**Debug**|`ansible.builtin.debug` can print the facts.|Handy for troubleshooting or learning.|

```yaml
- name: Fact dump
  hosts: all
  tasks:
    - name: Print all facts
      ansible.builtin.debug:
        var: ansible_facts
```

Running the playbook shows a huge `JSON` dictionary in the output.

---

## 2. Common facts you’ll see

|Fact|Variable|Example|
|---|---|---|
|Short hostname|`ansible_facts['hostname']`|`demo1`|
|Fully‑qualified domain name|`ansible_facts['fqdn']`|`demo1.example.com`|
|Default IPv4 address|`ansible_facts['default_ipv4']['address']`|`172.25.250.10`|
|All network interfaces|`ansible_facts['interfaces']`|`['eth0', 'lo']`|
|Disk size (`/dev/vda1`)|`ansible_facts['devices']['vda']['partitions']['vda1']['size']`|`50G`|
|DNS servers|`ansible_facts['dns']['nameservers']`|`['8.8.8.8', '8.8.4.4']`|
|Kernel version|`ansible_facts['kernel']`|`5.14.0-70.13.1.el9_0.x86_64`|

> **Tip:**  
> You can write the same fact in two ways:  
> `ansible_facts['default_ipv4']['address']` **or** `ansible_facts.default_ipv4.address`.

---

## 3. Using facts in a playbook

```yaml
---
- hosts: all
  tasks:
    - name: Show host info
      ansible.builtin.debug:
        msg: |
          Host {{ ansible_facts.fqdn }} has IP
          {{ ansible_facts.default_ipv4.address }}
```

Output:

```
The default IPv4 address of demo1.example.com is 172.25.250.10
```

---

## 4. Custom facts

- You can create your own facts that are stored on the host.
- Useful for values that aren’t automatically discovered (e.g., a custom service version).
- Stored in `/etc/ansible/facts.d/` as JSON or YAML files.

---

## 5. Why facts are useful

|Situation|How facts help|
|---|---|
|**Conditional tasks**|Run a task only if the host has a certain OS or CPU count.|
|**Loops**|Iterate over all network interfaces or disks.|
|**Dynamic inventory**|Build inventory based on host properties.|
|**Debugging**|Quickly see what Ansible thinks about a host.|

---

### Quick mnemonic

**F**acts **A**re **N**ot **S**tatic – they’re **F**resh **A**s **N**ew **S**tate.  
Remember: _Facts = Fresh State_.

---





---


Ansible facts are vars that are automatically discovred by ansi on a managed host which contains specific information that can be used just like a regular var in plays 


it handles conditinals loops and other statements that dpened on a value collected from a managed host 




Some facts gathered for a managed host might include:

- The host name
- The kernel version
- Network interface names
- Network interface IP addresses
- Operating system version
- Number of CPUs
- Available or free memory
- Size and free space of storage devices


You can evern create custom facts which are then stored on the managed host and are unique to that system 

Facts are a convenient way to retrieve the state of a managed host and to determin what actions to take based on that state 


In every project normally ansible runs the `ansible.builtin.setup` module automatically to gather facts before it performs the first tasks


`ansible.builtin.debug` it gathers facts and the module is used to print the value of the `ansible_facts` var

```yaml
- name: Fact dump
  hosts: all
  tasks:
    - name: Print all facts
      ansible.builtin.debug:
        var: ansible_facts
```

When you run the playbook, the facts are displayed in the job output:

```yaml
[user@demo ~]$ **`ansible-navigator run -m stdout facts.yml`**

PLAY [Fact dump] ***************************************************************

TASK [Gathering Facts] *********************************************************
ok: [demo1.example.com]

TASK [Print all facts] *********************************************************
ok: [demo1.example.com] => {
    "ansible_facts": {
        "all_ipv4_addresses": [
            "10.30.0.178",
            "172.25.250.10"
        ],
        "all_ipv6_addresses": [
            "fe80::8389:96fd:e53e:979",
            "fe80::cb51:6814:6342:7bbc"
        ],
        "ansible_local": {}
            }
        },
        "apparmor": {
            "status": "disabled"
        },
        "architecture": "x86_64",
        "bios_date": "04/01/2014",
        "bios_vendor": "SeaBIOS",
        "bios_version": "1.13.0-2.module+el8.2.1+7284+aa32a2c4",
        "board_asset_tag": "NA",
        "board_name": "NA",
        "board_serial": "NA",
        "board_vendor": "NA",
        "board_version": "NA",
        "chassis_asset_tag": "NA",
        "chassis_serial": "NA",
        "chassis_vendor": "Red Hat",
        "chassis_version": "RHEL 7.6.0 PC (i440FX + PIIX, 1996)",
        "cmdline": {
            "BOOT_IMAGE": "(hd0,gpt3)/vmlinuz-5.14.0-70.13.1.el9_0.x86_64",
            "console": "ttyS0,115200n8",
            "crashkernel": "1G-4G:192M,4G-64G:256M,64G-:512M",
            "net.ifnames": "0",
            "no_timer_check": true,
            "root": "UUID=fb535add-9799-4a27-b8bc-e8259f39a767"
        },
_...output omitted..._
```

The playbook displays the content of the `ansible_facts` variable in JSON format as a dictionary of variables.

The following table shows some facts that might be gathered from a managed node and which might be useful in a playbook:


**Table 3.3. Examples of Ansible Facts**

|Fact|Variable|
|:--|:--|
|Short hostname|`ansible_facts['hostname']`|
|Fully qualified domain name|`ansible_facts['fqdn']`|
|Main IPv4 address (based on routing)|`ansible_facts['default_ipv4']['address']`|
|List of the names of all network interfaces|`ansible_facts['interfaces']`|
|Size of the `/dev/vda1` disk partition|`ansible_facts['devices']['vda']['partitions']['vda1']['size']`|
|List of DNS servers|`ansible_facts['dns']['nameservers']`|
|Version of the currently running kernel|`ansible_facts['kernel']`|


### Note

Remember that when a variable's value is a dictionary, one of two syntaxes can be used to retrieve the value. To take two examples from the preceding table:

- `ansible_facts['default_ipv4']['address']` can also be written `ansible_facts.default_ipv4.address`
- `ansible_facts['dns']['nameservers']` can also be written `ansible_facts.dns.nameservers`


When a fact is used in a playbook, Ansible dynamically substitutes the variable name for the fact with the corresponding value:

```yaml
---
- hosts: all
  tasks:
  - name: Prints various Ansible facts
    ansible.builtin.debug:
      msg: >
        The default IPv4 address of {{ ansible_facts.fqdn }}
        is {{ ansible_facts.default_ipv4.address }}
```


```yaml
[user@demo ~]$ **`ansible-navigator run -m stdout playbook.yml`**
PLAY [all] ***********************************************************************

TASK [Gathering Facts] *****************************************************
ok: [demo1.example.com]

TASK [Prints various Ansible facts] ****************************************
ok: [demo1.example.com] => {
    "msg": "The default IPv4 address of demo1.example.com is 172.25.250.10\n"
}

PLAY RECAP *****************************************************************
demo1.example.com    : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```


