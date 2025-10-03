**Outcomes**

- Retrieve files from managed hosts, by hostname, and store them locally.
    
- Create playbooks that use common file management modules from the `ansible.builtin` Ansible Content Collection such as `copy`, `fetch`, `file`, `lineinfile`, and `blockinfile`.
    

As the `student` user on the `workstation` machine, use the `lab` command to prepare your system for this exercise.

This command prepares your environment and ensures that all required resources are available.

```bash
[student@workstation ~]$ **`lab start file-manage`**
```

**Instructions**

1. The `lab` command created the `/home/student/file-manage` directory with an `ansible.cfg` configuration file and an inventory file named `inventory`. Review the contents of both files before proceeding.
    
    1. Change to the `/home/student/file-manage` directory.

```bash
[student@workstation ~]$ **`cd ~/file-manage`**
[student@workstation file-manage]$
```

Review the content of the `ansible.cfg` file. Verify that privilege escalation is enabled and it is using `sudo` as the privilege escalation method for the `devops` remote user.

```bash
[defaults]
inventory=inventory
remote_user=devops

[privilege_escalation]
become=true
become_method=sudo
become_user=root
become_ask_pass=false
```

Review the content of the `inventory` file. The `servera.lab.example.com` and `serverb.lab.example.com` servers belong to the `servers` group.

```bash
[servers]
servera.lab.example.com
serverb.lab.example.com
```

Create a playbook named `file_management.yml`.

- Add a task to retrieve the `/var/log/secure` log file from each of the managed hosts in the `servers` group and store the files on the control node.
    
- Add a task to create a directory named `files` on the `devops` home directory of the managed hosts.
    
- Ensure that the `files` directory has the `samba_share_t` SELinux context type attribute.
    
- Add a task to append the `This line was added by the lineinfile module` line to the `files/users.txt` file on the managed hosts.
    

1. Create the `file_management.yml` playbook with a play named `Preparing servers`. Target the `servers` host group and add a `tasks` section to the play.

```yaml
---
- name: Preparing servers
  hosts: servers
  tasks:
```

The first task should create the `secure-backups` directory with subdirectories named after the hostname of each managed host, and store the backup files in their respective subdirectories. Use the `ansible.builtin.fetch` module to copy the `/var/log/secure` files to the local system. The value of the `dest` parameter creates the `secure-backups` directory if it does not exist.

```yaml
_...output omitted..._
    - name: Fetch the /var/log/secure log file from managed hosts
      ansible.builtin.fetch:
        src: /var/log/secure
        dest: secure-backups
```

Add a task to the play that uses the `ansible.builtin.file` module to create the `/home/devops/files` directory on all managed hosts. Ensure that the directory is owned by the `devops` user and group, has permissions of `0775`, and has an SELinux type of `samba_share_t`.


```yaml
_...output omitted..._

    - name: Ensure the /home/devops/files directory exists
      ansible.builtin.file:
        path: /home/devops/files
        state: directory
        owner: devops
        group: devops
        mode: 0775
        setype: samba_share_t
```

Add a task to the play that uses the `ansible.builtin.lineinfile` module to append the given line to the `/home/devops/files/users.txt` file. Ensure that the file is owned by the `devops` user and group and has permissions of `0664`.

```yaml
Add a task to the play that uses the `ansible.builtin.lineinfile` module to append the given line to the `/home/devops/files/users.txt` file. Ensure that the file is owned by the `devops` user and group and has permissions of `0664`.

_...output omitted..._

    - name: Add a single line of text to a file
      ansible.builtin.lineinfile:
        path: /home/devops/files/users.txt
        line: This line was added by the lineinfile module
        state: present
        create: true
        owner: devops
        group: devops
        mode: 0664
```

When completed, the playbook must contain the following content. Review the playbook for accuracy.

```yaml
---
- name: Preparing servers
  hosts: servers
  tasks:
    - name: Fetch the /var/log/secure log file from managed hosts
      ansible.builtin.fetch:
        src: /var/log/secure
        dest: secure-backups

    - name: Ensure the /home/devops/files directory exists
      ansible.builtin.file:
        path: /home/devops/files
        state: directory
        owner: devops
        group: devops
        mode: 0775
        setype: samba_share_t

    - name: Add a single line of text to a file
      ansible.builtin.lineinfile:
        path: /home/devops/files/users.txt
        line: This line was added by the lineinfile module
        state: present
        create: true
        owner: devops
        group: devops
        mode: 0664
```

Verify the syntax of the playbook, and then run it and verify that it runs correctly.

1. Use the `ansible-navigator run --syntax-check` command to verify the syntax of the playbook. Correct any errors before moving to the next step.

```bash
[student@workstation file-manage]$ **`ansible-navigator run \`**
> **`-m stdout file_management.yml --syntax-check`**
playbook: /home/student/file-manage/file_management.yml
```

Use the `ansible-navigator run` command to run the playbook:

```bash
[student@workstation file-manage]$ **`ansible-navigator run \`**
> **`-m stdout file_management.yml`**

PLAY [Preparing servers] **************************************************

TASK [Gathering Facts] ****************************************************
ok: [serverb.lab.example.com]
ok: [servera.lab.example.com]

TASK [Fetch the /var/log/secure log file from managed hosts] **************
changed: [serverb.lab.example.com]
changed: [servera.lab.example.com]

TASK [Ensure the /home/devops/files directory exists] *********************
changed: [serverb.lab.example.com]
changed: [servera.lab.example.com]

TASK [Add a single line of text to a file] ********************************
changed: [serverb.lab.example.com]
changed: [servera.lab.example.com]

PLAY RECAP ****************************************************************
servera.lab.example.com    : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
serverb.lab.example.com    : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

Confirm that the playbook retrieved the `/var/log/secure` files from the managed hosts.

```bash
[student@workstation file-manage]$ **`tree -F secure-backups`**
secure-backups
├── servera.lab.example.com/
│   └── var/
│       └── log/
│           └── secure
└── serverb.lab.example.com/
    └── var/
        └── log/
            └── secure
```

Use the `ls -Z` command as the `devops` user on the `servera` machine to verify the SELinux attributes of the `files` directory on the managed hosts.

```bash
[student@workstation file-manage]$ **`ssh devops@servera 'ls -Z'`**
unconfined_u:object_r:`samba_share_t`:s0 `files`
```

Use the `cat` command as the `devops` user on the `servera` machine to verify the content of the `files/users.txt` file on the managed hosts.

```bash
[student@workstation file-manage]$ **`ssh devops@servera 'cat files/users.txt'`**
This line was added by the lineinfile module
```

After running the playbook, you decide to make some additional changes.

- Change the SELinux type context for the `files` directory so that it uses the context set by the default SELinux policy.
    
- Add a task to the `Preparing servers` play that copies the `system` file from the project directory to the `/home/devops/files` directory on the managed hosts.
    
- Ensure that the file mode is set to `0664` and that the file is owned by the `devops` user and group.
    
- Add another task to append the following block of text to the `/home/devops/files/users.txt` file on all managed hosts:

Edit the `file_management.yml` playbook. Update the `setype` parameter in the second task so that the `/home/devops/files` directory uses the default SELinux type context.


```yaml
_...output omitted..._

    - name: Ensure the /home/devops/files directory exists
      ansible.builtin.file:
        path: /home/devops/files
        state: directory
        owner: devops
        group: devops
        mode: 0775
        `setype: _default`

_...output omitted..._
```

Add a task that uses the `ansible.builtin.copy` module to copy the `system` local file to the `/home/devops/files` directory on all managed hosts.


```yaml
_...output omitted..._

    - name: Copy a file to managed hosts and set ownership and permissions
      ansible.builtin.copy:
        src: system
        dest: /home/devops/files/
        owner: devops
        group: devops
        mode: 0664
```

Add a task that uses the `ansible.builtin.blockinfile` module to append the given block of text to the `/home/devops/files/users.txt` file on all managed hosts.

```yaml
_...output omitted..._

    - name: Add a block of text to an existing file
      ansible.builtin.blockinfile:
        path: /home/devops/files/users.txt
        block: |
          This block of text consists of two lines.
          They have been added by the blockinfile module.
        state: present
```

When complete, the modified playbook must consist of the following content:When complete, the modified playbook must consist of the following content:


```yaml
---
- name: Preparing servers
  hosts: servers
  tasks:
    - name: Fetch the /var/log/secure log file from managed hosts
      ansible.builtin.fetch:
        src: /var/log/secure
        dest: secure-backups

    - name: Ensure the /home/devops/files directory exists
      ansible.builtin.file:
        path: /home/devops/files
        state: directory
        owner: devops
        group: devops
        mode: 0775
        setype: _default

    - name: Add a single line of text to a file
      ansible.builtin.lineinfile:
        path: /home/devops/files/users.txt
        line: This line was added by the lineinfile module
        state: present
        create: true
        owner: devops
        group: devops
        mode: 0664

    - name: Copy a file to managed hosts and set ownership and permissions
      ansible.builtin.copy:
        src: system
        dest: /home/devops/files/
        owner: devops
        group: devops
        mode: 0664

    - name: Add a block of text to an existing file
      ansible.builtin.blockinfile:
        path: /home/devops/files/users.txt
        block: |
          This block of text consists of two lines.
          They have been added by the blockinfile module.
        state: present
```

Verify the syntax of the playbook, and then run it and verify that it runs correctly.

1. Use the `ansible-navigator run --syntax-check` command to verify the syntax of the `file_management.yml` playbook.

```bash
[student@workstation file-manage]$ **`ansible-navigator run \`**
> **`-m stdout file_management.yml --syntax-check`**
playbook: /home/student/file-manage/file_management.yml
```

Use the `ansible-navigator run` command to run the playbook:

```bash
1. [student@workstation file-manage]$ **`ansible-navigator run \`**
    > **`-m stdout file_management.yml`**
    
    PLAY [Preparing servers] **************************************************
    
    TASK [Gathering Facts] ****************************************************
    ok: [servera.lab.example.com]
    ok: [serverb.lab.example.com]
    
    TASK [Fetch the /var/log/secure log file from managed hosts] **************
    changed: [servera.lab.example.com]
    changed: [serverb.lab.example.com]
    
    TASK [Ensure the /home/devops/files directory exists] *********************
    changed: [servera.lab.example.com]
    changed: [serverb.lab.example.com]
    
    TASK [Add a single line of text to a file] ********************************
    ok: [servera.lab.example.com]
    ok: [serverb.lab.example.com]
    
    TASK [Copy a file to managed hosts and set ownership and permissions] *****
    changed: [servera.lab.example.com]
    changed: [serverb.lab.example.com]
    
    TASK [Add a block of text to an existing file] ****************************
    changed: [servera.lab.example.com]
    changed: [serverb.lab.example.com]
    
    PLAY RECAP ****************************************************************
    servera.lab.example.com    : ok=6    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
    serverb.lab.example.com    : ok=6    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

Use the `ls -Z` command as the `devops` user on the `servera` machine to verify the SELinux attributes of the `files` directory on the managed hosts.

```bash
[student@workstation file-manage]$ **`ssh devops@servera 'ls -Z'`**
unconfined_u:object_r:`user_home_t`:s0 `files`
```


Use the `ls` command as the `devops` user on the `servera` machine to verify the existence of the `files/system` file on the managed hosts.

```bash
[student@workstation file-manage]$ **`ssh devops@servera 'ls files/system'`**
files/system
```

Use the `cat` command as the `devops` user on the `servera` machine to verify the content of the `files/users.txt` file on the managed hosts.

```bash
[student@workstation file-manage]$ **`ssh devops@servera 'cat files/users.txt'`**
This line was added by the lineinfile module
# BEGIN ANSIBLE MANAGED BLOCK
This block of text consists of two lines.
They have been added by the blockinfile module.
# END ANSIBLE MANAGED BLOCK
```

Create a playbook named `remove_dir.yml` in the current working directory. Configure a play in the playbook to use the `ansible.builtin.file` module to remove the `/home/devops/files` directory from all managed hosts.

1. Create the `remove_dir.yml` playbook with the following content:

```yaml
---
- name: Use the file module to remove a directory
  hosts: servers
  tasks:
    - name: Remove a directory from managed hosts
      ansible.builtin.file:
        path: /home/devops/files
        state: absent
```

Run the playbook:


```yaml
[student@workstation file-manage]$ **`ansible-navigator run \`**
> **`-m stdout remove_dir.yml`**

PLAY [Use the file module to remove a directory] **************************

TASK [Gathering Facts] ****************************************************
ok: [serverb.lab.example.com]
ok: [servera.lab.example.com]

TASK [Remove a directory from managed hosts] ******************************
changed: [serverb.lab.example.com]
changed: [servera.lab.example.com]

PLAY RECAP ****************************************************************
servera.lab.example.com    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
serverb.lab.example.com    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

Use the `ls -l` command as the `devops` user on the `servera` machine to confirm that the `files` directory no longer exists on the managed hosts.

```yaml
[student@workstation file-manage]$ **`ssh devops@servera 'ls -l /home/devops/files'`**
ls: cannot access '/home/devops/files': No such file or directory
```

```bash
[student@workstation ~]$ **`lab finish file-manage`**
```

