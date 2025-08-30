
```bash
[student@workstation ~]$ **`lab start control-flow`**
```

On the `workstation` machine, change to the `/home/student/control-flow` directory.

```bash
[student@workstation ~]$ **`cd ~/control-flow`**
[student@workstation control-flow]$
```


```bash
[student@workstation control-flow]$ cat inventory

[database_dev]
servera.lab.example.com

[database_prod]
serverb.lab.example.com
```

The `lab` command created an Ansible configuration file as well as an inventory file. The inventory file contains the `servera.lab.example.com` server in the `database_dev` host group, and the `serverb.lab.example.com` server in the `database_prod` host group. Review the contents of the file before proceeding.

```bash
[student@workstation control-flow]$ **`cat inventory`**
[database_dev]
servera.lab.example.com

[database_prod]
serverb.lab.example.com
```

Create the `playbook.yml` playbook, which contains a play with two tasks. Use the `database_dev` host group. The first task installs the `MariaDB` required packages, and the second task ensures that the `MariaDB` service is running.


Create the `playbook.yml` playbook and define the `mariadb_packages` variable with two values: `mariadb-server` and `python3-PyMySQL`.

```yaml
---
- name: MariaDB server is running
  hosts: database_dev
  vars:
    mariadb_packages:
      - mariadb-server
      - python3-PyMySQL
```

Define a task that uses the `ansible.builtin.dnf` module and the `mariadb_packages` variable.

```yaml
 tasks:
    - name: MariaDB packages are installed
      ansible.builtin.dnf:
        name: "{{ item }}"
        state: present
      loop: "{{ mariadb_packages }}"
```

### Important

Using `loop` is not the most efficient way to install packages. In the preceding code, the `ansible.builtin.dnf` module runs once for each package in the `mariadb_packages` list.

Normally, you should install all the packages as one transaction, by passing the entire list of packages to the module, rather than passing it one module at a time:

```yaml
- name: MariaDB packages are installed
  ansible.builtin.dnf:
    name: "{{ mariadb_packages }}"
    state: present
```

However, other modules like `ansible.builtin.user` do not allow you to do this; you have to pass that module one user to operate upon at a time. In those cases, `loop` is an invaluable tool.

This example is simply meant as a way for you to see how `loop` works.

Define a second task to start the `mariadb` service. The full playbook should consist of the following content:

```yaml
- name: MariaDB server is running
  hosts: database_dev
  vars:
    mariadb_packages:
      - mariadb-server
      - python3-PyMySQL

  tasks:
    - name: MariaDB packages are installed
      ansible.builtin.dnf:
        name: "{{ item }}"
        state: present
      loop: "{{ mariadb_packages }}"

    - name: Start MariaDB service
      ansible.builtin.service:
        name: mariadb
        state: started
        enabled: true
```

Run the playbook and watch the output of the play.

```bash
1. [student@workstation control-flow]$ **`ansible-navigator run \`**
    > **`-m stdout playbook.yml`**
    
    PLAY [MariaDB server is running] ***********************************************
    
    TASK [Gathering Facts] *********************************************************
    ok: [servera.lab.example.com]
    
    TASK [MariaDB packages are installed] ******************************************
    changed: [servera.lab.example.com] => (item=mariadb-server)
    changed: [servera.lab.example.com] => (item=python3-PyMySQL)
    
    TASK [Start MariaDB service] ***************************************************
    changed: [servera.lab.example.com]
    
    PLAY RECAP *********************************************************************
    servera.lab.example.com    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

Update the first task to only run if the managed host uses Red Hat Enterprise Linux as its operating system. Update the play to use the `database_prod` host group.

```bash
- name: MariaDB server is running
  hosts: **`database_prod`**
  vars:
_...output omitted..._
  tasks:
    - name: MariaDB packages are installed
      ansible.builtin.dnf:
        name: "{{ item }}"
        state: present
      loop: "{{ mariadb_packages }}"
      **`when: ansible_facts['distribution'] == "RedHat"`**
_...output omitted..._
```

Run the playbook again and watch the output of the play.

```bash
[student@workstation control-flow]$ **`ansible-navigator run \`**
> **`-m stdout playbook.yml`**

PLAY [MariaDB server is running] ***********************************************

TASK [Gathering Facts] *********************************************************
ok: [serverb.lab.example.com]

TASK [MariaDB packages are installed] ******************************************
ok: [serverb.lab.example.com] => (item=mariadb-server)
ok: [serverb.lab.example.com] => (item=python3-PyMySQL)

TASK [Start MariaDB service] ***************************************************
ok: [serverb.lab.example.com]

PLAY RECAP *********************************************************************
serverb.lab.example.com    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

```bash
[student@workstation ~]$ **`lab finish control-flow`**
```

