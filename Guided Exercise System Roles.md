
# Guided Exercise: Reusing Content with System Roles

Use one of the system roles in conjunction with tasks to configure time synchronization and the time zone on your managed hosts.

## Outcomes

- Install the system roles for Red Hat Enterprise Linux.
- Find and use the system roles documentation.
- Use the redhat.rhel_system_roles.timesync role in a playbook to configure time synchronization on remote hosts.

## Setup

As the student user on the workstation machine, use the lab command to prepare your system for this exercise.

This command prepares your environment and ensures that all required resources are available.

```bash
[student@workstation ~]$ lab start role-system
```

## Instructions

### 1. Navigate to Working Directory

Change into the `/home/student/role-system` directory.

```bash
[student@workstation ~]$ cd ~/role-system
[student@workstation role-system]$
```

### 2. Install and Verify System Roles

Install the system roles on your control node, `workstation.lab.example.com`. Confirm that the system roles have been installed by using ansible-galaxy.

#### List Currently Installed Collections

Use the `ansible-galaxy collection list` command to list the installed collections.

```bash
[student@workstation role-system]$ ansible-galaxy collection list
```

#### Create Collections Directory

Create the collections directory.

```bash
[student@workstation role-system]$ mkdir -p collections
```

#### Configure Collections Path

The `./collections` directory is not a default search location for collections. Add the `collections_paths` key to the `ansible.cfg` file, so that the `./collections` directory is searched.

```ini
[defaults]
inventory=./inventory
remote_user=devops
collections_paths=./collections:~/.ansible/collections:/usr/share/ansible/collections
```

#### Install System Roles Collection

Use the `ansible-galaxy` command to install the `redhat.rhel_system_roles` collection from the provided tarball.

```bash
[student@workstation role-system]$ ansible-galaxy collection \
> install -p collections/ redhat-rhel_system_roles-1.19.3.tar.gz
Process install dependency map
Starting collection install process
Installing 'redhat.rhel_system_roles:1.19.3' to '/home/student/role-system/collections/ansible_collections/redhat/rhel_system_roles'
redhat.rhel_system_roles:1.19.3 was installed successfully
```

#### Verify Installation

Use the `ansible-galaxy collection list` command to verify that the system roles are now available.

```bash
[student@workstation role-system]$ ansible-galaxy collection list

# /home/student/role-system/collections/ansible_collections
Collection               Version
------------------------ -------
redhat.rhel_system_roles 1.19.3
```

### 3. Create Initial Playbook

Create the `configure_time.yml` playbook with one play that targets the `database_servers` host group and runs the `redhat.rhel_system_roles.timesync` role in its roles section.

```yaml
---
- name: Time Synchronization
  hosts: database_servers

  roles:
    - redhat.rhel_system_roles.timesync
```

### 4. Review Role Documentation and Configure Variables

The role documentation contains a description of each role variable, including the default value for the variable. Determine the role variables that you must override to meet the requirements for time synchronization.

Place role variable values in a file named `timesync.yml`. Because these variable values apply to all hosts in the inventory, place the `timesync.yml` file in the `group_vars/all` subdirectory.

#### Review Role Variables

Review the Role Variables section of the README.md file for the `redhat.rhel_system_roles.timesync` role.

```bash
[student@workstation role-system]$ cat \
> collections/ansible_collections/redhat/rhel_system_roles/roles/timesync/README.md
...output omitted...
Role Variables
--------------
...output omitted...
# List of NTP servers
timesync_ntp_servers:
  - hostname: foo.example.com   # Hostname or address of the server
    minpoll: 4                  # Minimum polling interval (default 6)
    maxpoll: 8                  # Maximum polling interval (default 10)
    iburst: yes                 # Flag enabling fast initial synchronization
                                # (default no)
    pool: no                    # Flag indicating that each resolved address
                                # of the hostname is a separate NTP server
                                # (default no)
...output omitted...
# Name of the package which should be installed and configured for NTP.
# Possible values are "chrony" and "ntp". If not defined, the currently active
# or enabled service will be configured. If no service is active or enabled, a
# package specific to the system and its version will be selected.
timesync_ntp_provider: chrony
...output omitted...
```

#### Create Group Variables Directory

Create the `group_vars/all` subdirectory.

```bash
[student@workstation role-system]$ mkdir -pv group_vars/all
mkdir: created directory 'group_vars'
mkdir: created directory 'group_vars/all'
```

#### Configure Time Synchronization Variables

Create a `group_vars/all/timesync.yml` file, adding variable definitions to satisfy the time synchronization requirements. The file now contains:

```yaml
---
#redhat.rhel_system_roles.timesync variables for all hosts

timesync_ntp_provider: chrony

timesync_ntp_servers:
  - hostname: classroom.example.com
    iburst: yes
```

### 5. Add Time Zone Configuration Tasks

Add two tasks to the `configure_time.yml` file to get and conditionally set the time zone for each host. Ensure that both tasks run after the `redhat.rhel_system_roles.timesync` role.

Because hosts do not belong to the same time zone, use a variable (`host_timezone`) for the time zone name.

#### Add Post Tasks Section

Create a `post_tasks` section in the `configure_time.yml` playbook, then add the first task.

```yaml
  post_tasks:
    - name: Get time zone
      ansible.builtin.command: timedatectl show
      register: current_timezone
      changed_when: false
```

#### Add Time Zone Setting Task

Add a second task to set the time zone, but only when the time zone is incorrect. Because system logging and other services use the system time zone, reboot each host when the time zone is modified. Add a `notify` keyword to the task, with an associated value of `reboot host`. The `post_tasks` section of the play should now read:

```yaml
    - name: Set time zone
      ansible.builtin.command: "timedatectl set-timezone {{ host_timezone }}"
      when: host_timezone not in current_timezone.stdout
      notify: reboot host
```

#### Add Reboot Handler

Add the `reboot host` handler to the Time Synchronization play. The complete playbook now contains:

```yaml
---
- name: Time Synchronization
  hosts: database_servers

  roles:
    - redhat.rhel_system_roles.timesync

  post_tasks:
    - name: Get time zone
      ansible.builtin.command: timedatectl show
      register: current_timezone
      changed_when: false

    - name: Set time zone
      ansible.builtin.command: "timedatectl set-timezone {{ host_timezone }}"
      when: host_timezone not in current_timezone.stdout
      notify: reboot host

  handlers:
    - name: reboot host
      ansible.builtin.reboot:
```

### 6. Configure Data Center-Specific Time Zones

For each data center, create a file named `timezone.yml` that contains an appropriate value for the `host_timezone` variable. Use the `timedatectl list-timezones` command to find the valid time zone string for each data center.

#### Create Group Variables Directories

Create the `group_vars` subdirectories for the `na_datacenter` and `europe_datacenter` host groups.

```bash
[student@workstation role-system]$ mkdir -pv \
> group_vars/{na_datacenter,europe_datacenter}
mkdir: created directory 'group_vars/na_datacenter'
mkdir: created directory 'group_vars/europe_datacenter'
```

#### Determine Time Zones

Use the `timedatectl list-timezones` command to determine the time zone for both the US and European data centers:

```bash
[student@workstation role-system]$ timedatectl list-timezones | grep Chicago
America/Chicago
[student@workstation role-system]$ timedatectl list-timezones | grep Helsinki
Europe/Helsinki
```

#### Create Time Zone Configuration Files

Create the `timezone.yml` for both data centers:

```bash
[student@workstation role-system]$ echo "host_timezone: America/Chicago" > \
> group_vars/na_datacenter/timezone.yml
[student@workstation role-system]$ echo "host_timezone: Europe/Helsinki" > \
> group_vars/europe_datacenter/timezone.yml
```

### 7. Run the Playbook

#### Validate Syntax

Use the `ansible-navigator run --syntax-check` command to validate the playbook syntax.

```bash
[student@workstation role-system]$ ansible-navigator run \
> -m stdout configure_time.yml --syntax-check
playbook: /home/student/role-system/configure_time.yml
```

#### Execute the Playbook

Run the `configure_time.yml` playbook.

```bash
[student@workstation role-system]$ ansible-navigator run \
> -m stdout configure_time.yml

PLAY [Time Synchronization] **************************************************

TASK [Gathering Facts] *******************************************************
ok: [serverb.lab.example.com]
ok: [servera.lab.example.com]

TASK [redhat.rhel_system_roles.timesync : Set version specific variables] ****
...output omitted...

TASK [redhat.rhel_system_roles.timesync : Enable timemaster] *****************
skipping: [servera.lab.example.com]
skipping: [serverb.lab.example.com]

RUNNING HANDLER [redhat.rhel_system_roles.timesync : restart chronyd] ********
changed: [servera.lab.example.com]
changed: [serverb.lab.example.com]

TASK [Get time zone] *********************************************************
ok: [servera.lab.example.com]
ok: [serverb.lab.example.com]

TASK [Set time zone] *********************************************************
changed: [serverb.lab.example.com]
changed: [servera.lab.example.com]

RUNNING HANDLER [reboot host] ************************************************
changed: [serverb.lab.example.com]
changed: [servera.lab.example.com]

PLAY RECAP *******************************************************************
servera.lab.example.com    : ok=18   changed=6    unreachable=0    failed=0    skipped=25   rescued=0    ignored=0
serverb.lab.example.com    : ok=18   changed=6    unreachable=0    failed=0    skipped=25   rescued=0    ignored=0
```

### 8. Verify Configuration

Verify the time zone settings of each server. Use the following commands to see the output of the `date` command on the servera and serverb machines.

**Note**: The actual time zones listed might vary depending on the time of year, and whether daylight savings is active.

```bash
[student@workstation role-system]$ ssh servera date
Tue Aug 16 07:43:33 PM CDT 2022
[student@workstation role-system]$ ssh serverb date
Wed Aug 17 03:43:41 AM EEST 2022
```

Each server has a time zone setting based on its geographic location.

## Finish

On the workstation machine, change to the student user home directory and use the lab command to complete this exercise. This step is important to ensure that resources from previous exercises do not impact upcoming exercises.

```bash
[student@workstation ~]$ lab finish role-system
```

## Summary

This exercise demonstrated:

1. **System Roles Installation**: Installing the `redhat.rhel_system_roles` collection from a tarball and configuring collections paths
2. **Documentation Review**: Reading system role documentation to understand available variables and configuration options
3. **Variable Management**: Using `group_vars` at different levels (all, specific groups) to configure role behavior
4. **Role Integration**: Combining system roles with custom tasks using `post_tasks` section
5. **Conditional Logic**: Using `when` conditions to make changes only when necessary
6. **Handler Usage**: Creating handlers to manage system reboots when configuration changes require them
7. **Geographic Configuration**: Setting different time zones for different data center locations

### Key Concepts Covered

- **Collections Path Configuration**: Setting `collections_paths` in `ansible.cfg` to include local collections directory
- **System Role Variables**: Understanding and configuring `timesync_ntp_provider` and `timesync_ntp_servers`
- **Group Variables Hierarchy**: Using `group_vars/all`, `group_vars/na_datacenter`, and `group_vars/europe_datacenter`
- **Task Registration**: Using `register` to capture command output for conditional logic
- **Change Detection**: Using `changed_when: false` to prevent tasks from showing as changed unnecessarily
- **Conditional Execution**: Using `when` with string matching to conditionally execute tasks
- **Handler Notification**: Using `notify` to trigger handlers only when changes occur
- **System Management**: Using `timedatectl` for time zone management and system reboots

### Best Practices Demonstrated

- **Documentation First**: Always review role documentation before implementation
- **Variable Organization**: Organizing variables by scope (all hosts vs. specific groups)
- **Idempotency**: Using conditions to ensure tasks only run when changes are needed
- **Change Control**: Using handlers to manage system changes that require reboots
- **Geographic Awareness**: Configuring location-specific settings through group variables
- **Syntax Validation**: Always checking playbook syntax before execution
- **Verification**: Testing configuration changes to ensure they work as expected

### Project Structure Used

```
role-system/
├── ansible.cfg
├── inventory
├── configure_time.yml
├── collections/
│   └── ansible_collections/
│       └── redhat/
│           └── rhel_system_roles/
└── group_vars/
    ├── all/
    │   └── timesync.yml
    ├── na_datacenter/
    │   └── timezone.yml
    └── europe_datacenter/
        └── timezone.yml
```