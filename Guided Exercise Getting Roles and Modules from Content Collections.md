# Guided Exercise: Getting Roles and Modules from Content Collections

Install an Ansible Content Collection and use a role or module from that content collection in a playbook.

## Outcomes

- Use the ansible-galaxy command to install an Ansible Content Collection.
- Use a requirements.yml file to install multiple Ansible Content Collections.
- Run playbooks that use roles and modules from Ansible Content Collections.

## Setup

As the student user on the workstation machine, use the lab command to prepare your system for this exercise.

This command prepares your environment and ensures that all required resources are available.

```bash
[student@workstation ~]$ lab start role-collections
```

## Instructions

### Part 1: Install and Inspect the gls.utils Collection

#### 1. Navigate to Working Directory

Change to the `/home/student/role-collections` directory.

```bash
[student@workstation ~]$ cd ~/role-collections
[student@workstation role-collections]$
```

#### 2. Install Collection from Archive

Use the `gls-utils-0.0.1.tar.gz` archive file in your project directory to install the `gls.utils` collection in the collections directory.

```bash
[student@workstation role-collections]$ ansible-galaxy collection \
> install gls-utils-0.0.1.tar.gz -p collections
...output omitted...
gls.utils:0.0.1 was installed successfully
```

**Important**: When used for collections, the `ansible-galaxy` command uses the directories defined by the `collections_paths` variable. You can either define a different set of directories by setting the `collections_paths` variable in the `[defaults]` section of your Ansible configuration file, or you can use the `-p` option to specify a directory from the command line.

By default, the `ansible-navigator` command looks for collections installed in the project collections directory and the `/usr/share/ansible/collections` directory in the automation execution environment.

#### 3. List Installed Collections

Use the `ansible-navigator collections` command to start the interactive text-based user interface (TUI) and list the installed collections.

```bash
[student@workstation role-collections]$ ansible-navigator collections
```

#### 4. Explore the gls.utils Collection

Identify the `gls.utils` collection in the list of installed collections.

```
   Name                 Version Shadowed Type          Path
 0│amazon.aws           3.2.0   False    contained  /usr/share/ansible/collections/ansible_collections/amazon/aws
 1│ansible.builtin      2.13.3  False    contained  /usr/lib/python3.9/site-packages/ansible
 ...output omitted...
17│gls.utils            0.0.1   False    bind_mount /home/student/role-collections/collections/ansible_collections/gls/utils
...output omitted...
```

Type `:17` and then press Enter. Notice that the `gls.utils` collection provides two roles: backup and restore.

```
  Gls.utils Type   Added         Deprecated  Description
0│backup    role   Unknown    Unknown     Curriculum Developer
1│newping   module historical False       Try to connect to host, verify a usable python and return C(pong) on success
2│restore   role   Unknown    Unknown     Curriculum Developer
```

#### 5. Examine the backup Role

Press `0` to read the documentation for the `gls.utils.backup` role and then identify the variables accepted by the role.

```
Image: gls.utils.backup
Description: Curriculum Developer
...output omitted...
24│  backup
25│  ======
26│
27│  This role backups up the files and directories provided using the `backup_files` variable.
28│  The backup is identified with a given name (`backup_id`) and can be restored using the `gls.utils.restore` role.
29│
30│  If a backup with the same name already exists, then the role immediately returns.
31│
...output omitted...
38│
39│  Role Variables
40│  --------------
41│
42│  The role accepts the following variables:
43│
44│  * `backup_id`: The name (or ID) for the backup. This can be any string you want (without spaces). This name is used to identify the backup when you call the `restore` role.
45│    By default, `backup_id` is set to `test`.
46│  * `backup_files`: The list of files and directories to backup. You can use globs (`*`) in those path names. Files and directories that do not exist on the system are silently skipped.
47│    `/etc` by default.
...output omitted...
```

#### 6. Examine the newping Module

Press Esc to return to the preceding screen. Notice that the `gls.utils` collection provides the `newping` module.

```
  Gls.utils Type   Added         Deprecated  Description
0│backup    role   Unknown    Unknown     Curriculum Developer
1│newping   module historical False       Try to connect to host, verify a usable python and return C(pong) on success
2│restore   role   Unknown    Unknown     Curriculum Developer
```

Press `1` to read the documentation for the `newping` module.

```
Image: gls.utils.myping
...output omitted...
21│doc:
22│  author:
23│  - Ansible Core Team
24│  description:
25│  - A trivial test module, this module always returns C(pong) on successful contact.
26│    It does not make sense in playbooks, but it is useful from C(/usr/bin/ansible)
27│    to verify the ability to login and that a usable Python is configured.
28│  - This is NOT ICMP ping, this is just a trivial test module that requires Python
29│    on the remote-node.
30│  - For Windows targets, use the M(ansible.windows.win_ping) module instead.
31│  - For Network targets, use the M(ansible.netcommon.net_ping) module instead.
32│  module: newping
33│  options:
34│    data:
35│     default: pong
36│     description:
37│     - Data to return for the C(ping) return value.
38│     - If this parameter is set to C(crash), the module will cause an exception.
39│     type: str
...output omitted...
```

**Note**: You can also run `ansible-navigator doc gls.utils.newping` from the command line to display the module documentation.

Type `:q` and then press Enter to exit.

### Part 2: Create and Run a Playbook Using Collection Content

#### 7. Complete the Backup Playbook

Complete and then run the `/home/student/role-collections/bck.yml` playbook. That playbook uses the `gls.utils.newping` module and the `gls.utils.backup` role.

Edit the `bck.yml` playbook. In the first task, use the `gls.utils.newping` module.

```yaml
...output omitted...
  tasks:
    - name: Ensure the machine is up
      gls.utils.newping:
        data: pong
...output omitted...
```

In the second task, include the `gls.utils.backup` role. When you finish editing the file, save and close it.

```yaml
...output omitted...
    - name: Ensure configuration files are saved
      ansible.builtin.include_role:
        name: gls.utils.backup
      vars:
        backup_id: backup_etc
        backup_files:
          - /etc/sysconfig
          - /etc/yum.repos.d
```

#### 8. Complete Playbook Content

The resulting file must contain the following contents:

```yaml
---
- name: Backup the system configuration
  hosts: servera.lab.example.com
  become: true
  gather_facts: false

  tasks:
    - name: Ensure the machine is up
      gls.utils.newping:
        data: pong

    - name: Ensure configuration files are saved
      ansible.builtin.include_role:
        name: gls.utils.backup
      vars:
        backup_id: backup_etc
        backup_files:
          - /etc/sysconfig
          - /etc/yum.repos.d
```

#### 9. Verify and Run the Playbook

Verify the syntax of the `bck.yml` playbook. If you get any errors, compare your playbook to the preceding example.

```bash
[student@workstation role-collections]$ ansible-navigator run \
> -m stdout bck.yml --syntax-check
playbook: /home/student/role-collections/bck.yml
```

Run the playbook.

```bash
[student@workstation role-collections]$ ansible-navigator run \
> -m stdout bck.yml

PLAY [Backup the system configuration] *****************************************

TASK [Ensure the machine is up] ************************************************
ok: [servera.lab.example.com]

TASK [Ensure configuration files are saved] ************************************

TASK [gls.utils.backup : Ensure the backup directory exists] *******************
changed: [servera.lab.example.com]

TASK [gls.utils.backup : Ensure the backup exists] *****************************
changed: [servera.lab.example.com]

PLAY RECAP *********************************************************************
servera.lab.example.com    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### Part 3: Install Collections Using Requirements File

In the second part of this exercise, install the Ansible Content Collections specified by the Ansible project's `requirements.yml` file.

To test your work, run the `new_system.yml` playbook. That playbook uses the `redhat.insights.insights_client` and `redhat.rhel_system_roles.selinux` roles to configure Red Hat Insights and SELinux on the `servera.lab.example.com` machine.

#### 10. Review Requirements File

Review the `requirements.yml` file. The file lists three Ansible Content Collections to install from tar archive files in your Ansible project directory. The `redhat.insights` collection currently requires the unsupported `community.general.ini_file` module.

The lab start script downloads these tar archive files to your project directory from Red Hat automation hub at https://console.redhat.com/ansible/automation-hub.

```yaml
---
collections:
  - name: /home/student/role-collections/redhat-insights-1.0.7.tar.gz
  - name: /home/student/role-collections/redhat-rhel_system_roles-1.19.3.tar.gz
  - name: /home/student/role-collections/community-general-5.5.0.tar.gz
```

#### 11. Install Collections from Requirements File

Use the `ansible-galaxy` command with the `requirements.yml` file to install the collections.

```bash
[student@workstation role-collections]$ ansible-galaxy collection install \
> -r requirements.yml -p collections
...output omitted...
redhat.insights:1.0.7 was installed successfully
...output omitted...
redhat.rhel_system_roles:1.19.3 was installed successfully
...output omitted...
community.general:5.5.0 was installed successfully
```

#### 12. Verify Collection Installation

Use the `ansible-galaxy collection list` command to verify that the collections are installed.

```bash
[student@workstation role-collections]$ ansible-galaxy collection list \
> -p collections
...output omitted...
# /home/student/role-collections/collections/ansible_collections
Collection               Version
------------------------ -------
community.general        5.5.0
gls.utils                0.0.1
redhat.insights          1.0.7
redhat.rhel_system_roles 1.19.3
```

There may be other collections installed under `/usr/share/ansible/collections/ansible_collections`.

### Part 4: Explore Red Hat Collections

#### 13. List Collections in TUI

Use the `ansible-navigator collections` command to start the interactive TUI and list the installed collections.

```bash
[student@workstation role-collections]$ ansible-navigator collections
```

#### 14. Examine redhat.insights Collection

Identify the `redhat.insights` collection in the list of installed collections.

```bash
[student@workstation role-collections]$ ansible-navigator collections
   Name                 Version Shadowed Type          Path
 0│amazon.aws           3.2.0   False    contained  /usr/share/ansible/collections/ansible_collections/amazon/aws
 1│ansible.builtin      2.13.3  False    contained  /usr/lib/python3.9/site-packages/ansible
 ...output omitted...
23│redhat.insights      1.0.7   False    bind_mount /home/student/role-collections/collections/ansible_collections/redhat/insights
...output omitted...
```

Type `:23` and then press Enter. Notice that the `redhat.insights` collection provides the `insights_client` role.

```
  Redhat.insights   Type      Added      Deprecated Description
0│compliance        role      Unknown Unknown    Install and configure Red Hat Insights Client
1│insights          inventory None    False      insights inventory source
2│insights_client   role      Unknown Unknown    Install and configure Red Hat Insights Client
3│insights_config   module    None    False      This module handles initial configuration of the insights client on install
4│insights_register module    None    False      This module registers the insights client
```

#### 15. Review insights_client Role Documentation

Press `2` to review the documentation for the `insights_client` role.

```
Image: redhat.insights.insights_client
Description: Install and configure Red Hat Insights Client
  0│---
  1│argument_specs: {}
  2│argument_specs_path: ''
  3│defaults: {}
  4│defaults_path: ''
  5│full_name: redhat.insights.insights_client
  6│info:
  7│  galaxy_info:
  8│    author: Red Hat, Inc
  9│    categories:
 10│    - packaging
 11│    - system
 12│    company: Red Hat, Inc.
 13│    dependencies: []
 14│    description: Install and configure Red Hat Insights Client
...output omitted...
```

Type `:q` and then press Enter to exit the `ansible-navigator` TUI.

### Part 5: Test Collection Usage

#### 16. Review System Configuration Playbook

Review the `new_system.yml` playbook. This playbook uses roles from the `redhat.insights` and `redhat.rhel_system_roles` collections.

```yaml
---
- name: Configure the system
  hosts: servera.lab.example.com
  become: true
  gather_facts: true

  tasks:
    - name: Ensure the system is registered with Insights
      ansible.builtin.include_role:
        name: redhat.insights.insights_client
      vars:
        auto_config: false
        insights_proxy: http://proxy.example.com:8080

    - name: Ensure SELinux mode is Enforcing
      ansible.builtin.include_role:
        name: redhat.rhel_system_roles.selinux
      vars:
        selinux_state: enforcing
```

#### 17. Run Playbook in Check Mode

Run the `new_system.yml` playbook in check mode to confirm that you correctly installed the required collections.

```bash
[student@workstation role-collections]$ ansible-navigator run \
> -m stdout new_system.yml --check

...output omitted...

TASK [redhat.insights.insights_client : Set Insights Configuration Values] ***
changed: [servera.lab.example.com]

TASK [redhat.insights.insights_client : Register Insights Client] ************
ok: [servera.lab.example.com]

TASK [redhat.insights.insights_client : Change permissions of Insights Config directory so that Insights System ID can be read] ***************************
ok: [servera.lab.example.com]

TASK [redhat.insights.insights_client : Change permissions of machine_id file so that Insights System ID can be read] ****************************************
ok: [servera.lab.example.com]

TASK [redhat.insights.insights_client : Create directory for ansible custom facts]
changed: [servera.lab.example.com]

TASK [redhat.insights.insights_client : Install custom insights fact] *******
changed: [servera.lab.example.com]

...output omitted...

TASK [redhat.rhel_system_roles.selinux : Install SELinux python3 tools] *****
ok: [servera.lab.example.com]

TASK [redhat.rhel_system_roles.selinux : refresh facts] *********************
ok: [servera.lab.example.com]

TASK [redhat.rhel_system_roles.selinux : Install SELinux tool semanage] *****
ok: [servera.lab.example.com]

...output omitted...
```

**Important**: Because the classroom systems are not registered with Red Hat Subscription Management and might not have internet access, the `new_system.yml` playbook cannot complete successfully. However, to confirm that you correctly installed the required collections, you can still run the playbook in check mode.

## Finish

On the workstation machine, change to the student user home directory and use the lab command to complete this exercise. This step is important to ensure that resources from previous exercises do not impact upcoming exercises.

```bash
[student@workstation ~]$ lab finish role-collections
```

## Summary

This exercise demonstrated:

1. **Collection Installation**: Installing Ansible Content Collections from local tar archives using `ansible-galaxy collection install`
2. **Interactive Exploration**: Using `ansible-navigator collections` to explore collection contents and documentation
3. **Module Usage**: Using modules from collections with Fully Qualified Collection Names (FQCN)
4. **Role Usage**: Including roles from collections using `ansible.builtin.include_role`
5. **Requirements Files**: Installing multiple collections using `collections/requirements.yml`
6. **Collection Management**: Listing and verifying installed collections
7. **Real-world Usage**: Working with Red Hat-supported collections for system configuration

### Key Concepts Covered

- **FQCN Usage**: Using Fully Qualified Collection Names like `gls.utils.newping` and `redhat.insights.insights_client`
- **Collection Paths**: Understanding how `-p collections` installs collections in project directories
- **Requirements Files**: Format and structure for `collections/requirements.yml`
- **Collection Documentation**: Accessing documentation through `ansible-navigator` TUI and command-line tools
- **Role Variables**: Passing variables to collection roles using the `vars` section
- **Check Mode**: Testing playbooks with collection content using `--check` mode
- **Multiple Sources**: Installing collections from local archives, requirements files, and different sources

### Best Practices Demonstrated

- **Local Installation**: Using `-p collections` to install collections in project directories
- **Requirements Management**: Using requirements files for dependency management
- **Version Specification**: Including specific versions in requirements files
- **Documentation Review**: Exploring collection documentation before usage
- **Testing Approach**: Using check mode to validate collection functionality
- **Project Organization**: Organizing collections within project structure
- **FQCN Usage**: Always using Fully Qualified Collection Names for clarity and compatibility