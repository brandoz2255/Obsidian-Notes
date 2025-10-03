# Guided Exercise: Deploying Custom Files with Jinja2 Templates

Create a simple template file that your playbook uses to install a customized Message of the Day file on each managed host.

## Outcomes

- Build a template file.
- Use the template file in a playbook.

## Setup

As the student user on the workstation machine, use the lab command to prepare your system for this exercise.

This command prepares your environment and ensures that all required resources are available.

```bash
[student@workstation ~]$ lab start file-template
```

## Instructions

### 1. Navigate to Working Directory and Review Inventory

On workstation, navigate to the `/home/student/file-template` working directory. Review the inventory file in the current working directory. This file configures two groups: webservers and workstations. The servera.lab.example.com system is in the webservers group, and the workstation.lab.example.com system is in the workstations group.

Navigate to the `/home/student/file-template` working directory:

```bash
[student@workstation ~]$ cd ~/file-template
[student@workstation file-template]$
```

Display the contents of the inventory file:

```ini
[webservers]
servera.lab.example.com

[workstations]
workstation.lab.example.com
```

### 2. Create the Jinja2 Template

Create a template for the Message of the Day file (`/etc/motd`) and save it as the `motd.j2` file in the current working directory. Include the following variables and facts in the template:

- `ansible_facts['fqdn']`, to insert the FQDN of the managed host.
- `ansible_facts['distribution']` and `ansible_facts['distribution_version']`, to provide Linux distribution information.
- For servers in the workstations group, the Message of the Day must include the message: As a workstation user, you need to submit a ticket to receive help with any issues.
- For servers in the webservers group, the Message of the Day must include the message: Please report issues to: {{ system_owner }}. You set the system_owner variable in the motd.yml playbook, which you create in the next step.

#### Step 2a: Create basic template with FQDN and distribution information

Create a Jinja2 template file named `motd.j2` that includes the managed host FQDN and the Linux distribution information:

```jinja2
This is the system {{ ansible_facts['fqdn'] }}.
This is a {{ ansible_facts['distribution'] }} version {{ ansible_facts['distribution_version'] }} system.
```

#### Step 2b: Add condition for workstations group

Add a condition to the `motd.j2` file with the message for the servers in the workstations group:

```jinja2
This is the system {{ ansible_facts['fqdn'] }}.
This is a {{ ansible_facts['distribution'] }} version {{ ansible_facts['distribution_version'] }} system.
{% if ansible_facts['fqdn'] in groups['workstations'] %}
As a workstation user, you need to submit a ticket to receive help with any issues.
{% endif %}
```

#### Step 2c: Add condition for webservers group

Update the condition in the `motd.j2` file with the message for the servers in the webservers group:

```jinja2
This is the system {{ ansible_facts['fqdn'] }}.
This is a {{ ansible_facts['distribution'] }} version {{ ansible_facts['distribution_version'] }} system.
{% if ansible_facts['fqdn'] in groups['workstations'] %}
As a workstation user, you need to submit a ticket to receive help with any issues.
{% elif ansible_facts['fqdn'] in groups['webservers'] %}
Please report issues to: {{ system_owner }}.
{% endif %}
```

### 3. Create the Playbook

Create a playbook file named `motd.yml` in the current working directory. Create a play in that file that defines the `system_owner` variable in its vars section. The play must have a task that uses the `ansible.builtin.template` module to deploy the `motd.j2` Jinja2 template to the remote file `/etc/motd` on the managed hosts. It must set the owner and group of `/etc/motd` to root, and the mode to 0644.

```yaml
---
- name: Configure the message of the day
  hosts: all
  remote_user: devops
  become: true
  vars:
    - system_owner: clyde@example.com
  tasks:
    - name: Configure /etc/motd
      ansible.builtin.template:
        src: motd.j2
        dest: /etc/motd
        owner: root
        group: root
        mode: 0644
```

### 4. Validate and Run the Playbook

Before running the playbook, use the `ansible-navigator run --syntax-check` command to verify its syntax. If it reports any errors, correct them before moving to the next step. You should see output similar to the following:

```bash
[student@workstation file-template]$ ansible-navigator run \
> -m stdout motd.yml --syntax-check
playbook: /home/student/file-template/motd.yml
```

Run the `motd.yml` playbook:

```bash
[student@workstation file-template]$ ansible-navigator run \
> -m stdout motd.yml

PLAY [Configure the message of the day] ****************************************

TASK [Gathering Facts] *********************************************************
ok: [servera.lab.example.com]
ok: [workstation.lab.example.com]

TASK [Configure /etc/motd] *****************************************************
changed: [servera.lab.example.com]
changed: [workstation.lab.example.com]

PLAY RECAP *********************************************************************
servera.lab.example.com    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
workstation.lab.example.com : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 5. Verify the Configuration

Confirm that the `/etc/motd` file has been correctly configured on the webservers and workstations servers.

#### Test on webserver (servera.lab.example.com)

Use the ssh command to log in to servera.lab.example.com as the devops user. Log off when you verify that the Message of the Day is correctly displayed on your terminal:

```bash
[student@workstation file-template]$ ssh devops@servera.lab.example.com
This is the system servera.lab.example.com.
This is a RedHat version 9.0 system.
Please report issues to: clyde@example.com.
...output omitted...
[devops@servera ~]$ exit
logout
Connection to servera.lab.example.com closed.
```

#### Test on workstation (workstation.lab.example.com)

Use the ssh command to log in to workstation.lab.example.com as the devops user. Log off when you verify that the Message of the Day is correctly displayed on your terminal:

```bash
[student@workstation file-template]$ ssh devops@workstation.lab.example.com
This is the system workstation.lab.example.com.
This is a RedHat version 9.0 system.
As a workstation user, you need to submit a ticket to receive help with any issues.
...output omitted...
[devops@workstation ~]$ exit
logout
Connection to workstation.lab.example.com closed.
```

## Finish

On the workstation machine, change to the student user home directory and use the lab command to complete this exercise. This step is important to ensure that resources from previous exercises do not impact upcoming exercises.

```bash
[student@workstation ~]$ lab finish file-template
```

## Summary

This exercise demonstrated how to:

1. Create Jinja2 templates with conditional logic based on group membership
2. Use Ansible facts and variables within templates
3. Deploy templates using the `ansible.builtin.template` module
4. Set appropriate file permissions and ownership
5. Verify template deployment across different host groups

The key concepts covered include:
- Jinja2 template syntax with conditionals (`{% if %}`, `{% elif %}`, `{% endif %}`)
- Accessing Ansible facts (`ansible_facts['fqdn']`, `ansible_facts['distribution']`)
- Group membership testing (`ansible_facts['fqdn'] in groups['groupname']`)
- Template module parameters (src, dest, owner, group, mode)