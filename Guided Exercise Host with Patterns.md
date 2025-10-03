# Guided Exercise: Selecting Hosts with Host Patterns

Explore how to use host patterns to specify hosts from the inventory for plays. You are provided with several example inventories to explore host patterns.

## Outcomes

- Use different host patterns to access various hosts in an inventory.

## Setup

As the student user on the workstation machine, use the lab command to prepare your system for this exercise.

This command prepares your environment and ensures that all required resources are available.

```bash
[student@workstation ~]$ lab start projects-host
```

## Instructions

### 1. Navigate to Working Directory and Review Files

Change into the `/home/student/projects-host` directory, and review the playbook and inventory files in the directory.

```bash
[student@workstation ~]$ cd ~/projects-host
[student@workstation projects-host]$
```

List the contents of the directory.

```bash
[student@workstation projects-host]$ ls
ansible.cfg inventory1 inventory2 playbook.yml
```

### 2. Inspect Example Inventories

Inspect the first example inventory file, inventory1. Observe how the inventory is organized. Identify what hosts and groups are in the inventory, and which domains are used.

```ini
srv1.example.com
srv2.example.com
s1.lab.example.com
s2.lab.example.com

[web]
jupiter.lab.example.com
saturn.example.com

[db]
db1.example.com
db2.example.com
db3.example.com

[lb]
lb1.lab.example.com
lb2.lab.example.com

[boston]
db1.example.com
jupiter.lab.example.com
lb2.lab.example.com

[london]
db2.example.com
db3.example.com
file1.lab.example.com
lb1.lab.example.com

[dev]
web1.lab.example.com
db3.example.com

[stage]
file2.example.com
db2.example.com

[prod]
lb2.lab.example.com
db1.example.com
jupiter.lab.example.com

[function:children]
web
db
lb
city

[city:children]
boston
london
environments

[environments:children]
dev
stage
prod
new

[new]
172.25.252.23
172.25.252.44
172.25.252.32
```

Inspect the second example inventory file, inventory2. Observe how this inventory is organized. Identify what hosts and groups are in the inventory, and which domains are used.

```ini
workstation.lab.example.com

[london]
servera.lab.example.com

[berlin]
serverb.lab.example.com

[tokyo]
serverc.lab.example.com

[atlanta]
serverd.lab.example.com

[europe:children]
london
berlin
```

### 3. Inspect the Playbook

Inspect the contents of the playbook, playbook.yml. It currently has db1.example.com as the host pattern for its play. Observe how that play uses the ansible.builtin.debug module to display the name of each managed host.

```yaml
- name: Resolve host patterns
  hosts: db1.example.com
  gather_facts: false
  tasks:
  - name: Display managed hosts matching the host pattern
    ansible.builtin.debug:
      msg: "{{ inventory_hostname }}"
```

### 4. Test Basic Host Pattern

Run the playbook.yml playbook using the inventory1 inventory file and review the output to verify that the db1.example.com server is present in the inventory1 inventory file.

```bash
[student@workstation projects-host]$ ansible-navigator run \
> -m stdout playbook.yml -i inventory1

PLAY [Resolve host patterns] ***************************************************

TASK [Display managed hosts matching the host pattern] *************************
ok: [db1.example.com] => {
    "msg": "db1.example.com"
}

PLAY RECAP *********************************************************************
db1.example.com            : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 5. Test IP Address Pattern

Modify the host pattern in the playbook to reference an IP address contained in the inventory1 inventory file. Run the playbook using the inventory1 inventory file.

```bash
[student@workstation projects-host]$ cat playbook.yml
---
- name: Resolve host patterns
  hosts: 172.25.252.44
  gather_facts: false
  tasks:
  - name: Display managed hosts matching the host pattern
    ansible.builtin.debug:
      msg: "{{ inventory_hostname }}"

[student@workstation projects-host]$ ansible-navigator run \
> -m stdout playbook.yml -i inventory1

PLAY [Resolve host patterns] ***************************************************

TASK [Display managed hosts matching the host pattern] *************************
ok: [172.25.252.44] => {
    "msg": "172.25.252.44"
}

PLAY RECAP *********************************************************************
172.25.252.44              : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 6. Test "all" Group Pattern

Modify the host pattern to use the all group to list all managed hosts in the inventory1 inventory file. Run the playbook using the inventory1 inventory file.

```bash
[student@workstation projects-host]$ cat playbook.yml
---
- name: Resolve host patterns
  hosts: all
  gather_facts: false
  tasks:
  - name: Display managed hosts matching the host pattern
    ansible.builtin.debug:
      msg: "{{ inventory_hostname }}"

[student@workstation projects-host]$ ansible-navigator run \
> -m stdout playbook.yml -i inventory1

PLAY [Resolve host patterns] ***************************************************

TASK [Display managed hosts matching the host pattern] *************************
ok: [srv1.example.com] => {
    "msg": "srv1.example.com"
}
ok: [srv2.example.com] => {
    "msg": "srv2.example.com"
}
ok: [s1.lab.example.com] => {
    "msg": "s1.lab.example.com"
}
ok: [s2.lab.example.com] => {
    "msg": "s2.lab.example.com"
}
ok: [jupiter.lab.example.com] => {
    "msg": "jupiter.lab.example.com"
}
ok: [saturn.example.com] => {
    "msg": "saturn.example.com"
}
ok: [db1.example.com] => {
    "msg": "db1.example.com"
}
ok: [db2.example.com] => {
    "msg": "db2.example.com"
}
ok: [db3.example.com] => {
    "msg": "db3.example.com"
}
ok: [lb1.lab.example.com] => {
    "msg": "lb1.lab.example.com"
}
ok: [lb2.lab.example.com] => {
    "msg": "lb2.lab.example.com"
}
ok: [file1.lab.example.com] => {
    "msg": "file1.lab.example.com"
}
ok: [web1.lab.example.com] => {
    "msg": "web1.lab.example.com"
}
ok: [file2.example.com] => {
    "msg": "file2.example.com"
}
ok: [172.25.252.23] => {
    "msg": "172.25.252.23"
}
ok: [172.25.252.44] => {
    "msg": "172.25.252.44"
}
ok: [172.25.252.32] => {
    "msg": "172.25.252.32"
}

PLAY RECAP *********************************************************************
172.25.252.23              : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.25.252.32              : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.25.252.44              : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
db1.example.com            : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
db2.example.com            : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
db3.example.com            : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
file1.lab.example.com      : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
file2.example.com          : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
jupiter.lab.example.com    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
lb1.lab.example.com        : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
lb2.lab.example.com        : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
s1.lab.example.com         : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
s2.lab.example.com         : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
saturn.example.com         : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
srv1.example.com           : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
srv2.example.com           : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
web1.lab.example.com       : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 7. Test Wildcard Pattern

Modify the host pattern to use the asterisk (*) character to list all hosts that end in example.com in the inventory1 inventory file. Run the playbook using the inventory1 inventory file.

```bash
[student@workstation projects-host]$ cat playbook.yml
---
- name: Resolve host patterns
  hosts: '*example.com'
  gather_facts: false
  tasks:
  - name: Display managed hosts matching the host pattern
    ansible.builtin.debug:
      msg: "{{ inventory_hostname }}"

[student@workstation projects-host]$ ansible-navigator run \
> -m stdout playbook.yml -i inventory1

PLAY [Resolve host patterns] ***************************************************

TASK [Display managed hosts matching the host pattern] *************************
ok: [srv1.example.com] => {
    "msg": "srv1.example.com"
}
ok: [srv2.example.com] => {
    "msg": "srv2.example.com"
}
ok: [s1.lab.example.com] => {
    "msg": "s1.lab.example.com"
}
ok: [s2.lab.example.com] => {
    "msg": "s2.lab.example.com"
}
ok: [jupiter.lab.example.com] => {
    "msg": "jupiter.lab.example.com"
}
ok: [saturn.example.com] => {
    "msg": "saturn.example.com"
}
ok: [db1.example.com] => {
    "msg": "db1.example.com"
}
ok: [db2.example.com] => {
    "msg": "db2.example.com"
}
ok: [db3.example.com] => {
    "msg": "db3.example.com"
}
ok: [lb1.lab.example.com] => {
    "msg": "lb1.lab.example.com"
}
ok: [lb2.lab.example.com] => {
    "msg": "lb2.lab.example.com"
}
ok: [file1.lab.example.com] => {
    "msg": "file1.lab.example.com"
}
ok: [web1.lab.example.com] => {
    "msg": "web1.lab.example.com"
}
ok: [file2.example.com] => {
    "msg": "file2.example.com"
}

PLAY RECAP *********************************************************************
db1.example.com            : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
db2.example.com            : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
db3.example.com            : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
file1.lab.example.com      : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
file2.example.com          : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
jupiter.lab.example.com    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
lb1.lab.example.com        : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
lb2.lab.example.com        : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
s1.lab.example.com         : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
s2.lab.example.com         : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
saturn.example.com         : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
srv1.example.com           : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
srv2.example.com           : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
web1.lab.example.com       : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 8. Test Exclusion Pattern

As you can see in the output of the preceding command, the *.example.com domain contains 14 hosts. Modify the host pattern so that hosts in the *.lab.example.com domain are ignored. Run the playbook using the inventory1 inventory file.

```bash
[student@workstation projects-host]$ cat playbook.yml
---
- name: Resolve host patterns
  hosts: '*.example.com, !*.lab.example.com'
  gather_facts: false
  tasks:
  - name: Display managed hosts matching the host pattern
    ansible.builtin.debug:
      msg: "{{ inventory_hostname }}"

[student@workstation projects-host]$ ansible-navigator run \
> -m stdout playbook.yml -i inventory1

PLAY [Resolve host patterns] ***************************************************

TASK [Display managed hosts matching the host pattern] *************************
ok: [srv1.example.com] => {
    "msg": "srv1.example.com"
}
ok: [srv2.example.com] => {
    "msg": "srv2.example.com"
}
ok: [saturn.example.com] => {
    "msg": "saturn.example.com"
}
ok: [db1.example.com] => {
    "msg": "db1.example.com"
}
ok: [db2.example.com] => {
    "msg": "db2.example.com"
}
ok: [db3.example.com] => {
    "msg": "db3.example.com"
}
ok: [file2.example.com] => {
    "msg": "file2.example.com"
}

PLAY RECAP *********************************************************************
db1.example.com            : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
db2.example.com            : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
db3.example.com            : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
file2.example.com          : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
saturn.example.com         : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
srv1.example.com           : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
srv2.example.com           : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 9. Test Comma-Separated List

Without accessing the groups in the inventory1 inventory file, modify the host pattern to list these three hosts: lb1.lab.example.com, s1.lab.example.com, and db1.example.com. Run the playbook using the inventory1 inventory file.

```bash
[student@workstation projects-host]$ cat playbook.yml
---
- name: Resolve host patterns
  hosts: lb1.lab.example.com,s1.lab.example.com,db1.example.com
  gather_facts: false
  tasks:
  - name: Display managed hosts matching the host pattern
    ansible.builtin.debug:
      msg: "{{ inventory_hostname }}"

[student@workstation projects-host]$ ansible-navigator run \
> -m stdout playbook.yml -i inventory1

PLAY [Resolve host patterns] ***************************************************

TASK [Display managed hosts matching the host pattern] *************************
ok: [lb1.lab.example.com] => {
    "msg": "lb1.lab.example.com"
}
ok: [s1.lab.example.com] => {
    "msg": "s1.lab.example.com"
}
ok: [db1.example.com] => {
    "msg": "db1.example.com"
}

PLAY RECAP *********************************************************************
db1.example.com            : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
lb1.lab.example.com        : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
s1.lab.example.com         : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 10. Test IP Address Wildcard

Use a wildcard host pattern to list hosts that start with a 172.25. IP address in the inventory1 inventory file. Run the playbook using the inventory1 inventory file.

```bash
[student@workstation projects-host]$ cat playbook.yml
---
- name: Resolve host patterns
  hosts: '172.25.*'
  gather_facts: false
  tasks:
  - name: Display managed hosts matching the host pattern
    ansible.builtin.debug:
      msg: "{{ inventory_hostname }}"

[student@workstation projects-host]$ ansible-navigator run \
> -m stdout playbook.yml -i inventory1

PLAY [Resolve host patterns] ***************************************************

TASK [Display managed hosts matching the host pattern] *************************
ok: [172.25.252.23] => {
    "msg": "172.25.252.23"
}
ok: [172.25.252.44] => {
    "msg": "172.25.252.44"
}
ok: [172.25.252.32] => {
    "msg": "172.25.252.32"
}

PLAY RECAP *********************************************************************
172.25.252.23              : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.25.252.32              : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.25.252.44              : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 11. Test Letter Wildcard with Groups

Use a host pattern to list all hosts in the inventory1 inventory file that start with the letter "s". Run the playbook using the inventory1 inventory file.

```bash
[student@workstation projects-host]$ cat playbook.yml
---
- name: Resolve host patterns
  hosts: 's*'
  gather_facts: false
  tasks:
  - name: Display managed hosts matching the host pattern
    ansible.builtin.debug:
      msg: "{{ inventory_hostname }}"

[student@workstation projects-host]$ ansible-navigator run \
> -m stdout playbook.yml -i inventory1

PLAY [Resolve host patterns] ***************************************************

TASK [Display managed hosts matching the host pattern] *************************
ok: [file2.example.com] => {
    "msg": "file2.example.com"
}
ok: [db2.example.com] => {
    "msg": "db2.example.com"
}
ok: [srv1.example.com] => {
    "msg": "srv1.example.com"
}
ok: [srv2.example.com] => {
    "msg": "srv2.example.com"
}
ok: [s1.lab.example.com] => {
    "msg": "s1.lab.example.com"
}
ok: [s2.lab.example.com] => {
    "msg": "s2.lab.example.com"
}
ok: [saturn.example.com] => {
    "msg": "saturn.example.com"
}

PLAY RECAP *********************************************************************
db2.example.com            : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
file2.example.com          : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
s1.lab.example.com         : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
s2.lab.example.com         : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
saturn.example.com         : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
srv1.example.com           : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
srv2.example.com           : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

Notice the file2.example.com and db2.example.com hosts in the output of the preceding command. They appear in the list because they are both members of a group called stage, which also begins with the letter "s."

### 12. Test Complex List Pattern

Using a list and wildcard host patterns, list all hosts in the inventory1 inventory in the prod group, those hosts with an IP address beginning with 172, and hosts that contain lab in their name. Run the playbook using the inventory1 inventory file.

```bash
[student@workstation projects-host]$ cat playbook.yml
---
- name: Resolve host patterns
  hosts: 'prod,172*,*lab*'
  gather_facts: false
  tasks:
  - name: Display managed hosts matching the host pattern
    ansible.builtin.debug:
      msg: "{{ inventory_hostname }}"

[student@workstation projects-host]$ ansible-navigator run \
> -m stdout playbook.yml -i inventory1

PLAY [Resolve host patterns] ***************************************************

TASK [Display managed hosts matching the host pattern] *************************
ok: [lb2.lab.example.com] => {
    "msg": "lb2.lab.example.com"
}
ok: [db1.example.com] => {
    "msg": "db1.example.com"
}
ok: [jupiter.lab.example.com] => {
    "msg": "jupiter.lab.example.com"
}
ok: [172.25.252.23] => {
    "msg": "172.25.252.23"
}
ok: [172.25.252.44] => {
    "msg": "172.25.252.44"
}
ok: [172.25.252.32] => {
    "msg": "172.25.252.32"
}
ok: [s1.lab.example.com] => {
    "msg": "s1.lab.example.com"
}
ok: [s2.lab.example.com] => {
    "msg": "s2.lab.example.com"
}
ok: [lb1.lab.example.com] => {
    "msg": "lb1.lab.example.com"
}
ok: [file1.lab.example.com] => {
    "msg": "file1.lab.example.com"
}
ok: [web1.lab.example.com] => {
    "msg": "web1.lab.example.com"
}

PLAY RECAP *********************************************************************
172.25.252.23              : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.25.252.32              : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.25.252.44              : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
db1.example.com            : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
file1.lab.example.com      : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
jupiter.lab.example.com    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
lb1.lab.example.com        : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
lb2.lab.example.com        : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
s1.lab.example.com         : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
s2.lab.example.com         : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
web1.lab.example.com       : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 13. Test AND Logic

List all hosts that belong to both the db and london groups. Run the playbook using the inventory1 inventory file.

```bash
[student@workstation projects-host]$ cat playbook.yml
---
- name: Resolve host patterns
  hosts: db,&london
  gather_facts: false
  tasks:
  - name: Display managed hosts matching the host pattern
    ansible.builtin.debug:
      msg: "{{ inventory_hostname }}"

[student@workstation projects-host]$ ansible-navigator run \
> -m stdout playbook.yml -i inventory1

PLAY [Resolve host patterns] ***************************************************

TASK [Display managed hosts matching the host pattern] *************************
ok: [db2.example.com] => {
    "msg": "db2.example.com"
}
ok: [db3.example.com] => {
    "msg": "db3.example.com"
}

PLAY RECAP *********************************************************************
db2.example.com            : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
db3.example.com            : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 14. Test with Different Inventory (inventory2)

Modify the hosts value in the playbook.yml file so that all servers in the london group are targeted. Run the playbook using the inventory2 inventory file.

```bash
[student@workstation projects-host]$ cat playbook.yml
---
- name: Resolve host patterns
  hosts: london
  gather_facts: false
  tasks:
  - name: Display managed hosts matching the host pattern
    ansible.builtin.debug:
      msg: "{{ inventory_hostname }}"

[student@workstation projects-host]$ ansible-navigator run \
> -m stdout playbook.yml -i inventory2

PLAY [Resolve host patterns] ***************************************************

TASK [Display managed hosts matching the host pattern] *************************
ok: [servera.lab.example.com] => {
    "msg": "servera.lab.example.com"
}

PLAY RECAP *********************************************************************
servera.lab.example.com    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 15. Test Nested Groups

Modify the hosts value in the playbook.yml file so that all servers in the europe nested group are targeted. Run the playbook using the inventory2 inventory file.

```bash
[student@workstation projects-host]$ cat playbook.yml
---
- name: Resolve host patterns
  hosts: europe
  gather_facts: false
  tasks:
  - name: Display managed hosts matching the host pattern
    ansible.builtin.debug:
      msg: "{{ inventory_hostname }}"

[student@workstation projects-host]$ ansible-navigator run \
> -m stdout playbook.yml -i inventory2

PLAY [Resolve host patterns] ***************************************************

TASK [Display managed hosts matching the host pattern] *************************
ok: [servera.lab.example.com] => {
    "msg": "servera.lab.example.com"
}
ok: [serverb.lab.example.com] => {
    "msg": "serverb.lab.example.com"
}

PLAY RECAP *********************************************************************
servera.lab.example.com    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
serverb.lab.example.com    : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 16. Test Ungrouped Hosts

Modify the hosts value in the playbook.yml file so that all servers that do not belong to any group are targeted. Run the playbook using the inventory2 inventory file.

```bash
[student@workstation projects-host]$ cat playbook.yml
---
- name: Resolve host patterns
  hosts: ungrouped
  gather_facts: false
  tasks:
  - name: Display managed hosts matching the host pattern
    ansible.builtin.debug:
      msg: "{{ inventory_hostname }}"

[student@workstation projects-host]$ ansible-navigator run \
> -m stdout playbook.yml -i inventory2

PLAY [Resolve host patterns] ***************************************************

TASK [Display managed hosts matching the host pattern] *************************
ok: [workstation.lab.example.com] => {
    "msg": "workstation.lab.example.com"
}

PLAY RECAP *********************************************************************
workstation.lab.example.com : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 17. Test Non-Existent Group

Modify the hosts value in the playbook.yml file to specify a group that does not exist in the inventory2 inventory file. Run the playbook using the inventory2 inventory file. Note the message in the output that no match for that host pattern was found.

```bash
[student@workstation projects-host]$ cat playbook.yml
---
- name: Resolve host patterns
  hosts: australia
  gather_facts: false
  tasks:
  - name: Display managed hosts matching the host pattern
    ansible.builtin.debug:
      msg: "{{ inventory_hostname }}"

[student@workstation projects-host]$ ansible-navigator run \
> -m stdout playbook.yml -i inventory2

[WARNING]: Could not match supplied host pattern, ignoring: australia

PLAY [Resolve host patterns] ***************************************************
skipping: no hosts matched

PLAY RECAP *********************************************************************
```

## Finish

On the workstation machine, change to the student user home directory and use the lab command to complete this exercise.

This step is important to ensure that resources from previous exercises do not impact upcoming exercises.

```bash
[student@workstation ~]$ lab finish projects-host
```