
## 1️⃣ Core – Quick Reference

|Topic|Key Point|Typical Command|
|---|---|---|
|**Install collection**|`ansible-galaxy collection install redhat.rhel_system_roles -p collections`|`ansible-galaxy collection install redhat.rhel_system_roles -p collections`|
|**Requirements file**|List collection under `collections:` in `requirements.yml`|`ansible-galaxy collection install -r collections/requirements.yml -p collections`|
|**Run a role**|`include_role: name: redhat.rhel_system_roles.timesync`|`- include_role: name: redhat.rhel_system_roles.timesync`|
|**Check installed roles**|`ansible-navigator collections`|`ansible-navigator collections`|
|**Reboot‑required flag**|`selinux_reboot_required` set by SELinux role|`when: selinux_reboot_required`|

---

## 2️⃣ Info – Detailed Understanding

System roles are pre‑built Ansible roles that automate common RHEL tasks (time sync, firewall, SELinux, networking, etc.).  
They live in the **`redhat.rhel_system_roles`** collection, which is available through:

- **Automation Hub** (subscription‑based)
- **RPM package** `rhel-system-roles` (RHEL 9 only)

### Why Use System Roles?

- **Consistency** – Same API across RHEL 6‑9, so a single playbook works everywhere.
- **Maintenance** – Red Hat guarantees backward‑compatible variable names and minimal refactoring.
- **Support** – Fully supported roles are stable; Technology Preview roles are tested but may change.

### Role Naming

- **FQCN**: `redhat.rhel_system_roles.<role>` (used in playbooks).
- **Independent name**: `rhel-system-roles.<role>` (works when the RPM’s `/usr/share/ansible/roles` is in `roles_path`).
- **Upstream name**: `linux-system-roles.<role>` (used in the RPM’s legacy role directory).

### Documentation

- `ansible-navigator` (if installed)
- Red Hat Customer Portal – “Administration and configuration tasks using System Roles in RHEL”
- Local docs: `/usr/share/doc/rhel-system-roles/<role>/README.md`

### Example Use‑Case – Time Sync

RHEL 9 prefers `chronyd`; RHEL 6 prefers `ntpd`.  
The `timesync` role automatically selects the correct service and configures NTP servers, eliminating the need to maintain separate config files.

---

## 3️⃣ Summary – Code & Comments

```yaml
# collections/requirements.yml
---
collections:
  - name: redhat.rhel_system_roles
# -------------------------------------------------
# Installs the collection into the project’s
# local 'collections/' directory.
```

```bash
# Install all collections listed in requirements.yml
ansible-galaxy collection install -p collections/ -r collections/requirements.yml
# -------------------------------------------------
# The '-p collections/' flag tells Galaxy to
# put the downloaded collection in ./collections.
```

```yaml
# timesync_playbook.yml
- name: Time Synchronization Play
  hosts: webservers
  vars:
    timesync_ntp_servers:
      - hostname: 0.rhel.pool.ntp.org
        iburst: yes
      - hostname: 1.rhel.pool.ntp.org
        iburst: yes
      - hostname: 2.rhel.pool.ntp.org
        iburst: yes
  roles:
    - redhat.rhel_system_roles.timesync
# -------------------------------------------------
# The play sets the NTP servers in a vars block
# and then calls the timesync role to apply them.
```

```yaml
# group_vars/webservers/timesync.yml
timesync_ntp_servers:
  - hostname: 0.rhel.pool.ntp.org
    iburst: yes
  - hostname: 1.rhel.pool.ntp.org
    iburst: yes
  - hostname: 2.rhel.pool.ntp.org
    iburst: yes
# -------------------------------------------------
# This file keeps the role variables separate
# from the playbook, making the playbook cleaner.
```

```yaml
# SELinux role example with reboot handling
- name: Apply SELinux role
  block:
    - include_role:
        name: redhat.rhel_system_roles.selinux
  rescue:
    - name: Check for non‑reboot failures
      ansible.builtin.fail:
      when: not selinux_reboot_required
    - name: Reboot host
      ansible.builtin.reboot:
    - name: Re‑apply SELinux role
      include_role:
        name: redhat.rhel_system_roles.selinux
# -------------------------------------------------
# The block runs the role; if it fails because a reboot
# is needed, the rescue section reboots the host and
# runs the role again.
```

```bash
# Running a playbook without ansible-navigator
ansible-playbook timesync_playbook.yml
# -------------------------------------------------
# Uses the default ansible‑playbook binary to execute
# the playbook on the control node.
```

---

## 4️⃣ Research – What to Explore Next

|Topic|Why It Matters|Where to Look|
|---|---|---|
|**Content Collections vs. System Roles**|Understand the newer “Content Collections” format and how it differs from classic system roles.|Ansible docs – “Content Collections”|
|**Automation Hub API**|Automate collection downloads and updates programmatically.|Red Hat Automation Hub API docs|
|**Private Automation Hub**|Host internal collections securely and control access.|Red Hat Automation Platform docs|
|**Molecule Testing**|Verify role behavior before deployment.|Molecule docs|
|**ansible‑navigator**|Interactive browsing of collections and documentation.|Ansible‑navigator docs|
|**Semantic Versioning**|Predictable upgrades and rollback.|Ansible docs – “Versioning”|

---

## 5️⃣ Caveats – Things to Watch Out For

1. **No `ansible‑navigator` on RHEL 9 core** – If you’re using the RPM package, you’ll need `ansible-playbook` and the legacy role path.
2. **Reboot control** – Roles that set `selinux_reboot_required` do **not** reboot automatically; you must handle it yourself.
3. **Technology Preview** – These roles are tested but may change; use only after thorough testing.
4. **Collection version mismatch** – A role’s FQCN may differ between Automation Hub and the RPM; use the correct name for your environment.
5. **Limited collections** – When using the RPM, only `ansible.builtin` is available by default; other collections must be installed manually.
6. **Subscription requirement** – Automation Hub and `ansible‑navigator` require an Ansible Automation Platform subscription; otherwise you’re limited to the RPM‑provided collection.












---



# System Roles

System roles are a set of Ansible roles that you can use to configure and manage various components, subsystems, and software packages included with Red Hat Enterprise Linux. System roles provide automation for many common system configuration tasks, including time synchronization, networking, firewall, tuning, and logging.

These roles are intended to provide an automation API that is consistent across multiple major and minor releases of Red Hat Enterprise Linux. The Knowledgebase article at https://access.redhat.com/articles/3050101 documents the versions of Red Hat Enterprise Linux on your managed hosts that specific roles support.

## Simplified Configuration Management

System roles can help you simplify automation across multiple versions of Red Hat Enterprise Linux. For example, the recommended time synchronization service is different in different versions of Red Hat Enterprise Linux.

- **RHEL 9**: The `chronyd` service is preferred
- **RHEL 6**: The `ntpd` service is preferred

In an environment with a mixture of Red Hat Enterprise Linux versions, you must manage the configuration files for both services.

You can use an Ansible Playbook that runs the `redhat.rhel_system_roles.timesync` role to configure time synchronization for managed hosts running either version of Red Hat Enterprise Linux.

**Benefits**: By using system roles, you no longer need to maintain configuration files for both services.

## Support for System Roles

System roles are provided as the Red Hat Certified Ansible Content Collection `redhat.rhel_system_roles` through automation hub for Red Hat Ansible Automation Platform customers, as part of their subscription.

In addition, the roles are provided as an RPM package (`rhel-system-roles`) with Red Hat Enterprise Linux 9 for use with the version of Ansible Core provided by that operating system. These system roles have the same lifecycle support benefits that come with a Red Hat Enterprise Linux subscription.

### Support Levels

#### Fully Supported Roles
- **Stability**: Most system roles are "Fully Supported" and have stable interfaces
- **Compatibility**: Red Hat endeavors to ensure that the names of role variables and how they work are unchanged in future versions
- **Maintenance**: Playbook refactoring due to system role updates should be minimal

#### Technology Preview Roles
- **Status**: Some system roles are in "Technology Preview"
- **Characteristics**: These are tested and stable, but might be subject to future changes that are incompatible with the current state of the role
- **Recommendation**: Integration testing is recommended for playbooks that incorporate any "Technology Preview" role
- **Impact**: Playbooks might require refactoring if role variables change in a future version of the role

### Documentation Access

You can access documentation for the system roles in:
- `ansible-navigator`
- Red Hat Customer Portal at [Administration and configuration tasks using System Roles in RHEL](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/administration_and_configuration_tasks_using_system_roles_in_rhel/index)

## Installing the System Roles Ansible Content Collection

You can install the `redhat.rhel_system_roles` Ansible Content Collection with the `ansible-galaxy collection install` command. An Ansible project can specify this dependency by creating a `collections/requirements.yml` file. The following example assumes that your project is set up to pull Ansible Content Collections from automation hub.

```yaml
---
collections:
  - name: redhat.rhel_system_roles
```

The following command installs any required collections for a given project into the project's `collections/` directory.

```bash
[user@demo demo-project]$ ansible-galaxy collection \
> install -p collections/ -r collections/requirements.yml
...output omitted...
```

**Note**: Upstream development is done through the Linux System Roles project; their development versions of the system roles are provided through Ansible Galaxy as the `fedora.linux_system_roles` Ansible Content Collection. These roles are not supported by Red Hat.

## Example: Time Synchronization Role

Suppose you need to configure NTP time synchronization on your web servers. You could write automation yourself to perform each of the necessary tasks. But the system roles collection includes a role that can perform the configuration, `redhat.rhel_system_roles.timesync`.

The documentation for this role describes all the variables that affect the role's behavior and provides three playbook snippets that illustrate different time synchronization configurations.

### Configuration Variables

To manually configure NTP servers, the role has a variable named `timesync_ntp_servers`. This variable defines a list of NTP servers to use. Each item in the list is made up of one or more attributes. The two key attributes are `hostname` and `iburst`.

| Attribute | Purpose |
|-----------|---------|
| `hostname` | The hostname of an NTP server with which to synchronize. |
| `iburst` | A Boolean that enables or disables fast initial synchronization. Defaults to `no` in the role, but you should normally set this to `yes`. |

### Basic Implementation

Given this information, the following example is a play that uses the `redhat.rhel_system_roles.timesync` role to configure managed hosts to get time from three NTP servers by using fast initial synchronization.

```yaml
- name: Time Synchronization Play
  hosts: webservers
  vars:
    timesync_ntp_servers:
      - hostname: 0.rhel.pool.ntp.org
        iburst: yes
      - hostname: 1.rhel.pool.ntp.org
        iburst: yes
      - hostname: 2.rhel.pool.ntp.org
        iburst: yes

  roles:
    - redhat.rhel_system_roles.timesync
```

This example sets the role variables in a `vars` section of the play, but a better practice might be to configure them as inventory variables for hosts or host groups.

### Improved Project Structure

Consider an example project with the following structure:

```
[user@demo demo-project]$ tree
.
├── ansible.cfg
├── group_vars
│   └── webservers
│       └── timesync.yml          # 1
├── inventory
└── timesync_playbook.yml          # 2
```

#### Configuration Files

1. **`group_vars/webservers/timesync.yml`**: Defines the time synchronization variables overriding the role defaults for hosts in group webservers in the inventory. This file would look something like:

```yaml
timesync_ntp_servers:
  - hostname: 0.rhel.pool.ntp.org
    iburst: yes
  - hostname: 1.rhel.pool.ntp.org
    iburst: yes
  - hostname: 2.rhel.pool.ntp.org
    iburst: yes
```

2. **`timesync_playbook.yml`**: The content of the playbook simplifies to:

```yaml
- name: Time Synchronization Play
  hosts: webservers
  roles:
    - redhat.rhel_system_roles.timesync
```

### Benefits of This Structure

- **Clean Separation**: Cleanly separates the role, the playbook code, and configuration settings
- **Simple Playbook**: The playbook code is simple, easy to read, and should not require complex refactoring
- **Red Hat Support**: The role content is maintained and supported by Red Hat
- **Inventory Management**: All the settings are handled as inventory variables
- **Dynamic Environment**: Supports a dynamic, heterogeneous environment where hosts with new requirements can be placed in new host groups with appropriate variables defined in group_vars or host_vars subdirectories

## Example: SELinux Role

As another example, the `redhat.rhel_system_roles.selinux` role simplifies management of SELinux configuration settings. This role is implemented using the SELinux-related Ansible modules. The advantage of using this role instead of writing your own tasks is that it relieves you from the responsibility of writing those tasks. Instead, you provide variables to the role to configure it, and the maintained code in the role ensures your desired SELinux configuration is applied.

### Role Capabilities

This role can perform the following tasks:

- Set enforcing or permissive mode
- Run restorecon on parts of the file system hierarchy
- Set SELinux Boolean values
- Set SELinux file contexts persistently
- Set SELinux user mappings

### Calling the SELinux Role

Sometimes, the SELinux role must ensure that the managed hosts are rebooted in order to completely apply its changes. However, the role does not ever reboot hosts itself, enabling you to control how the reboot is handled. Therefore, it is a little more complicated than usual to properly use this role in a play.

The role sets a Boolean variable, `selinux_reboot_required`, to `true` and fails if a reboot is needed. You can use a `block/rescue` structure to recover from the failure by failing the play if that variable is not set to `true`, or rebooting the managed host and rerunning the role if it is `true`. The block in your play should look something like this:

```yaml
    - name: Apply SELinux role
      block:
        - include_role:
            name: redhat.rhel_system_roles.selinux
      rescue:
        - name: Check for failure for other reasons than required reboot
          ansible.builtin.fail:
          when: not selinux_reboot_required

        - name: Restart managed host
          ansible.builtin.reboot:

        - name: Reapply SELinux role to complete changes
          include_role:
            name: redhat.rhel_system_roles.selinux
```

### Configuring the SELinux Role

The variables used to configure the `redhat.rhel_system_roles.selinux` role are described in the role's documentation. The following examples show some ways to use this role.

#### SELinux Mode

The `selinux_state` variable sets the mode that SELinux runs in. It can be set to `enforcing`, `permissive`, or `disabled`. If it is not set, the mode is not changed.

```yaml
selinux_state: enforcing
```

#### SELinux Booleans

The `selinux_booleans` variable takes a list of SELinux Boolean values to adjust. Each item in the list is a dictionary of variables: the name of the Boolean, the state (whether it should be on or off), and whether the setting should be persistent across reboots.

This example sets `httpd_enable_homedirs` to `on` persistently:

```yaml
selinux_booleans:
  - name: 'httpd_enable_homedirs'
    state: 'on'
    persistent: 'yes'
```

#### File Contexts

The `selinux_fcontexts` variable takes a list of file contexts to persistently set (or remove), and works much like the `selinux fcontext` command.

The following example ensures the policy has a rule to set the default SELinux type for all files under `/srv/www` to `httpd_sys_content_t`.

```yaml
selinux_fcontexts:
  - target: '/srv/www(/.*)?'
    setype: 'httpd_sys_content_t'
    state: 'present'
```

#### Restore Directories

The `selinux_restore_dirs` variable specifies a list of directories on which to run the `restorecon` command:

```yaml
selinux_restore_dirs:
  - /srv/www
```

#### Port Contexts

The `selinux_ports` variable takes a list of ports that should have a specific SELinux type.

```yaml
selinux_ports:
  - ports: '82'
    setype: 'http_port_t'
    proto: 'tcp'
    state: 'present'
```

**Note**: There are other variables and options for this role. See the role documentation for more information.

## Using System Roles with Ansible Core Only

**Note**: This section is relevant if you plan to use system roles without a Red Hat Ansible Automation Platform subscription, by using the version of Ansible Core that is provided with Red Hat Enterprise Linux 9.

If you do not have a subscription to Red Hat Ansible Automation Platform, but you do have Red Hat Enterprise Linux systems, you can use system roles with the version of Ansible Core provided with RHEL.

### Limitations and Requirements

- **Support Scope**: That version of Ansible Core is only supported for use with system roles and other automation code provided by Red Hat
- **No ansible-navigator**: It does not include ansible-navigator, so you have to use tools like `ansible-playbook` that treat your control node as the execution environment to run your automation
- **Limited Collections**: Because `ansible-playbook` does not use execution environments, the only Ansible Content Collection that you have available by default is `ansible.builtin` collection. Other packages included with Red Hat Enterprise Linux might add additional Ansible Content Collections to the control node.

### Installing the System Roles RPM Package

Make sure that your control node is registered with Red Hat Subscription Manager and has a Red Hat Enterprise Linux subscription. You should also install the `ansible-core` RPM package.

To install the `rhel-system-roles` RPM package, make sure that the AppStream package repository is enabled. For Red Hat Enterprise Linux 9 on the x86_64 processor architecture, this is the `rhel-9-for-x86_64-appstream-rpms` repository. Then, you can install the package.

```bash
[user@controlnode ~]$ sudo dnf install rhel-system-roles
```

**Important**: If you use Ansible Core from a basic Red Hat Enterprise Linux installation for your control node, and do not have a Red Hat Ansible Automation Platform subscription on that node, then your control node should be a fully updated installation of the most recent version of Red Hat Enterprise Linux. You should also use the most recent version of the `ansible-core` and `rhel-system-roles` packages.

### Installation Locations

After installation, the collection is installed in the `/usr/share/ansible/collections/ansible_collections/redhat/rhel_system_roles` directory on your control node. The individual roles are also installed in the `/usr/share/ansible/roles` directory for backward compatibility:

```bash
[user@controlnode ~]$ ls -1F /usr/share/ansible/roles/
linux-system-roles.certificate@
linux-system-roles.cockpit@
linux-system-roles.crypto_policies@
linux-system-roles.firewall@
linux-system-roles.ha_cluster@
linux-system-roles.kdump@
linux-system-roles.kernel_settings@
linux-system-roles.logging@
linux-system-roles.metrics@
linux-system-roles.nbde_client@
linux-system-roles.nbde_server@
linux-system-roles.network@
linux-system-roles.postfix@
linux-system-roles.selinux@
linux-system-roles.ssh@
linux-system-roles.sshd@
linux-system-roles.storage@
linux-system-roles.timesync@
linux-system-roles.tlog@
linux-system-roles.vpn@
rhel-system-roles.certificate/
rhel-system-roles.cockpit/
rhel-system-roles.crypto_policies/
rhel-system-roles.firewall/
rhel-system-roles.ha_cluster/
rhel-system-roles.kdump/
rhel-system-roles.kernel_settings/
rhel-system-roles.logging/
rhel-system-roles.metrics/
rhel-system-roles.nbde_client/
rhel-system-roles.nbde_server/
rhel-system-roles.network/
rhel-system-roles.postfix/
rhel-system-roles.selinux/
rhel-system-roles.ssh/
rhel-system-roles.sshd/
rhel-system-roles.storage/
rhel-system-roles.timesync/
rhel-system-roles.tlog/
rhel-system-roles.vpn/
```

The corresponding upstream name of each role is linked to the system role. This enables individual roles to be referenced in a playbook by either name.

### Role Naming Conventions

**Important**: If you are using `ansible-playbook` to run your playbook, and your playbook refers to a system role that was installed using the RPM package's FQCN, you must use the `redhat.rhel_system_roles` version of its name. For example, you could refer to the firewall role as:

- `redhat.rhel_system_roles.firewall` (its FQCN in the collection)
- `rhel-system-roles.firewall` (its name as an independent role)
- `linux-system-roles.firewall` (its name as the upstream independent role)

**Note**: You cannot use `fedora.linux_system_roles.firewall` because the `fedora.linux_system_roles` collection is not installed on the system.

In addition, the independent role names only work if `/usr/share/ansible/roles` is in your `roles_path` setting.

## Accessing Documentation for System Roles

If you are working with system roles in Red Hat Enterprise Linux and do not have `ansible-navigator` available to you, there are other ways to get documentation about system roles.

### Documentation Sources

1. **Official Documentation**: The official documentation for system roles is located at [Administration and configuration tasks using System Roles in RHEL](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/administration_and_configuration_tasks_using_system_roles_in_rhel/index)

2. **Local Documentation**: If you installed the system roles from the RPM package, documentation is also available under the `/usr/share/doc/rhel-system-roles/` directory.

```bash
[user@controlnode ~]$ ls -1 /usr/share/doc/rhel-system-roles/
certificate
cockpit
collection
crypto_policies
firewall
ha_cluster
kdump
kernel_settings
logging
metrics
nbde_client
nbde_server
network
postfix
selinux
ssh
sshd
storage
timesync
tlog
vpn
```

### Documentation Structure

Each role's documentation directory contains a `README.md` file. The `README.md` file contains:

- A description of the role
- Information on how to use it
- Description of role variables that affect the behavior of the role
- Often contains a playbook snippet that demonstrates variable settings for a common configuration scenario

Some role documentation directories contain example playbooks. When using a role for the first time, review any additional example playbooks in the documentation directory.

## Running Playbooks Without Automation Content Navigator

You can use the `ansible-playbook` command to run a playbook that uses system roles in Red Hat Enterprise Linux when you do not have Red Hat Ansible Automation Platform or `ansible-navigator`.

The syntax of `ansible-playbook` is very similar to `ansible-navigator run -m stdout`, and takes many of the same options.

```bash
[user@controlnode ~]$ ansible-playbook playbook.yml
```

## Best Practices

### Project Organization
- **Separate configuration**: Keep role variables in inventory files (group_vars/host_vars) rather than in playbooks
- **Simple playbooks**: Keep playbook code simple and focused on role execution
- **Version control**: Use collections/requirements.yml for dependency management

### Variable Management
- **Inventory variables**: Use group_vars and host_vars for role configuration
- **Documentation**: Always review role documentation before implementation
- **Testing**: Test role changes in non-production environments first

### Support Considerations
- **Fully Supported roles**: Prefer these for production environments
- **Technology Preview**: Use with caution and comprehensive testing
- **Version compatibility**: Ensure system role versions match your RHEL versions

### Reboot Handling
- **SELinux role**: Use proper block/rescue structure for roles that may require reboots
- **Control**: Maintain control over when and how systems are rebooted
- **Verification**: Always verify role completion after reboots

## Available System Roles

Common system roles include:

- **`timesync`**: Time synchronization configuration
- **`selinux`**: SELinux policy and configuration management
- **`firewall`**: Firewall configuration
- **`network`**: Network interface configuration
- **`storage`**: Storage and filesystem management
- **`logging`**: System logging configuration
- **`ssh/sshd`**: SSH client and server configuration
- **`certificate`**: Certificate management
- **`cockpit`**: Cockpit web console configuration
- **`postfix`**: Email server configuration
- **`ha_cluster`**: High availability cluster configuration

Each role provides a consistent interface across RHEL versions while handling the underlying differences in implementation.