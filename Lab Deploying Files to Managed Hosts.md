# Lab: Deploying Files to Managed Hosts

Run a playbook that creates a customized file on your managed hosts by using a Jinja2 template.

## Outcomes

- Build a template file.
- Use the template file in a playbook.

## Setup

As the student user on the workstation machine, use the lab command to prepare your system for this exercise.

This command prepares your environment and ensures that all required resources are available.

```bash
[student@workstation ~]$ lab start file-review
```

**Note:** All files used in this exercise are available on workstation in the `/home/student/file-review/files` directory.

## Instructions

### 1. Review the Inventory File

Review the inventory file in the `/home/student/file-review` directory. This inventory file defines the servers group, which has the `serverb.lab.example.com` managed host associated with it.

### 2. Identify System Facts

Identify the facts on `serverb.lab.example.com` that show its total amount of system memory, and the number of processors it has.

### 3. Create the Jinja2 Template

In the `/home/student/file-review` directory, create the `templates/motd.j2` Jinja2 template file. After you deploy this template, users who log in to `serverb.lab.example.com` should see a message that shows the system's total memory and processor count.

The message can use any text that you want, but the template must use the `ansible_facts['memtotal_mb']` and `ansible_facts['processor_count']` facts to provide the system resource information for the message.

**Example template content:**
```jinja2
Welcome to {{ ansible_facts['fqdn'] }}

System Resources:
- Total Memory: {{ ansible_facts['memtotal_mb'] }} MB
- Processor Count: {{ ansible_facts['processor_count'] }}

Please use this system responsibly.
```

### 4. Create the Playbook

In the `/home/student/file-review` directory, create a playbook file called `motd.yml` that contains a new play that runs on all hosts in the inventory. It must log in using the devops user on the remote host, and use become to enable privilege escalation for the whole play.

The playbook must include the following tasks:

#### Task 1: Deploy Template
The play must have a task that uses the `ansible.builtin.template` module to deploy the `motd.j2` Jinja2 template file to the file `/etc/motd` on the managed hosts. The resulting file must have the root user as its owning user and group, and its permissions must be 0644.

#### Task 2: Verify File Existence
Add an additional task that uses the `ansible.builtin.stat` module to verify that `/etc/motd` exists on the managed hosts and registers its results in a variable. That task must be followed by a task that uses `ansible.builtin.debug` to display the information in that registered variable.

#### Task 3: Copy Files
Add a task that uses the `ansible.builtin.copy` module to place `files/issue` into the `/etc/` directory on the managed host, use the same ownership and permissions as `/etc/motd`.

#### Task 4: Create Symbolic Link
Finally, add a task that uses the `ansible.builtin.file` module to ensure that `/etc/issue.net` is a symbolic link to `/etc/issue` on the managed host.

**Complete playbook example:**
```yaml
---
- name: Deploy files to managed hosts
  hosts: all
  remote_user: devops
  become: true
  tasks:
    - name: Deploy MOTD template
      ansible.builtin.template:
        src: templates/motd.j2
        dest: /etc/motd
        owner: root
        group: root
        mode: '0644'

    - name: Verify /etc/motd exists
      ansible.builtin.stat:
        path: /etc/motd
      register: motd_stat

    - name: Display /etc/motd information
      ansible.builtin.debug:
        var: motd_stat

    - name: Copy issue file
      ansible.builtin.copy:
        src: files/issue
        dest: /etc/issue
        owner: root
        group: root
        mode: '0644'

    - name: Create symbolic link for /etc/issue.net
      ansible.builtin.file:
        src: /etc/issue
        dest: /etc/issue.net
        state: link
```

### 5. Verify Syntax

Verify that your playbook contains no syntax errors.

```bash
[student@workstation file-review]$ ansible-navigator run -m stdout motd.yml --syntax-check
```

### 6. Run the Playbook

Run the `motd.yml` Ansible Playbook.

```bash
[student@workstation file-review]$ ansible-navigator run -m stdout motd.yml
```

### 7. Confirm Success

Confirm that the `motd.yml` playbook has run correctly.

You can verify by:
- Checking that the playbook ran without errors
- SSH to the managed host to see the custom MOTD message
- Verifying that all files were created with correct permissions

```bash
[student@workstation file-review]$ ssh devops@serverb.lab.example.com
# You should see the custom MOTD message with system resources
```

## Evaluation

As the student user on the workstation machine, use the lab command to grade your work. Correct any reported failures and rerun the command until successful.

```bash
[student@workstation ~]$ lab grade file-review
```

## Finish

On the workstation machine, change to the student user home directory and use the lab command to complete this exercise. This step is important to ensure that resources from previous exercises do not impact upcoming exercises.

```bash
[student@workstation ~]$ lab finish file-review
```

## Summary

This lab exercise demonstrated how to:

1. **Create Jinja2 templates** that use Ansible facts to display dynamic system information
2. **Deploy templates** using the `ansible.builtin.template` module with proper file permissions
3. **Verify file deployment** using the `ansible.builtin.stat` module and register variables
4. **Debug registered variables** to display task results
5. **Copy static files** using the `ansible.builtin.copy` module
6. **Create symbolic links** using the `ansible.builtin.file` module

### Key Concepts Covered

- **Jinja2 template deployment**: Using `ansible.builtin.template` to create dynamic files
- **Ansible facts usage**: Accessing system information like `ansible_facts['memtotal_mb']` and `ansible_facts['processor_count']`
- **File operations**: Setting ownership, permissions, and creating symbolic links
- **Variable registration**: Using `register` to capture task results
- **Debugging**: Using `ansible.builtin.debug` to display variable contents
- **File verification**: Using `ansible.builtin.stat` to check file existence and properties

### Files Created in this Lab

- `templates/motd.j2` - Jinja2 template for the Message of the Day
- `motd.yml` - Main playbook containing all deployment tasks
- `/etc/motd` - Deployed template on managed hosts
- `/etc/issue` - Copied static file
- `/etc/issue.net` - Symbolic link to `/etc/issue`