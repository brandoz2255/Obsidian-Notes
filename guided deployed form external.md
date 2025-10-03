# Guided Exercise: Deploying Roles from External Content Sources

Use the ansible-galaxy command to download and install an Ansible role.

## Outcomes

- Create a requirements file to specify role dependencies for a playbook.
- Install roles specified in a requirements file.
- List downloaded roles by using the ansible-galaxy command.

## Setup

As the student user on the workstation machine, use the lab command to prepare your system for this exercise.

This command prepares your environment and ensures that all required resources are available.

```bash
[student@workstation ~]$ lab start role-galaxy
```

## Instructions

### 1. Navigate to Working Directory

Change into the `/home/student/role-galaxy` directory.

```bash
[student@workstation ~]$ cd ~/role-galaxy
[student@workstation role-galaxy]$
```

### 2. Create Role Requirements File

Create a role requirements file in your project directory that downloads the `student.bash_env` role. This role configures the default initialization files for the Bash shell used for newly created users, the default prompt for the accounts of these users, and the prompt color to use.

Create a file called `requirements.yml` in the roles subdirectory. The URL of the role's Git repository is: `git@workstation.lab.example.com:student/bash_env`.

To see how the role affects the behavior of production hosts, use the main branch of the repository. Set the local name of the role to `student.bash_env`.

Ensure that the `roles/requirements.yml` file contains the following content:

```yaml
---
# requirements.yml

- src: git@workstation.lab.example.com:student/bash_env
  scm: git
  version: main
  name: student.bash_env
```

### 3. Install Role Using ansible-galaxy

Use the ansible-galaxy command to process the new requirements file that installs the `student.bash_env` role.

#### Check Current State

List the contents of the roles subdirectory before the role is installed, so that you can compare its current state to command results.

```bash
[student@workstation role-galaxy]$ ls roles/
requirements.yml
```

#### Install the Role

Use the `ansible-galaxy role install` command to download and install the roles listed in the `roles/requirements.yml` file into the roles subdirectory of your project.

```bash
[student@workstation role-galaxy]$ ansible-galaxy role install \
> -r roles/requirements.yml -p roles
Starting galaxy role install process
- extracting student.bash_env to /home/student/role-galaxy/roles/student.bash_env
- student.bash_env (main) was installed successfully
```

#### Verify Installation

List the contents of the roles subdirectory after the role is installed. Confirm that a new subdirectory called `student.bash_env`, matching the name value specified in the requirements file, is present.

```bash
[student@workstation role-galaxy]$ ls roles/
requirements.yml  student.bash_env
```

### 4. List Installed Roles

Use the `ansible-galaxy role list` command to list the project roles in the roles subdirectory.

```bash
[student@workstation role-galaxy]$ ansible-galaxy role list -p roles
# /home/student/role-galaxy/roles
- student.bash_env, main
# /usr/share/ansible/roles
- linux-system-roles.certificate, (unknown version)
- linux-system-roles.cockpit, (unknown version)
- linux-system-roles.crypto_policies, (unknown version)
- linux-system-roles.firewall, (unknown version)
- linux-system-roles.ha_cluster, (unknown version)
- linux-system-roles.kdump, (unknown version)
- linux-system-roles.kernel_settings, (unknown version)
...output omitted...
[WARNING]: - the configured path /home/student/.ansible/roles does not exist.
```

**Important**: If you do not specify the option `-p roles` to your `ansible-galaxy role list` command, the role that you installed is not listed because the roles subdirectory is not in your default `roles_path`.

```bash
[student@workstation role-galaxy]$ ansible-galaxy role list
# /usr/share/ansible/roles
- linux-system-roles.certificate, (unknown version)
- linux-system-roles.cockpit, (unknown version)
- linux-system-roles.crypto_policies, (unknown version)
- linux-system-roles.firewall, (unknown version)
- linux-system-roles.ha_cluster, (unknown version)
- linux-system-roles.kdump, (unknown version)
- linux-system-roles.kernel_settings, (unknown version)
...output omitted...
[WARNING]: - the configured path /home/student/.ansible/roles does not exist.
```

### 5. Create Test Playbook

Create a playbook named `use-bash_env-role.yml` that uses the `student.bash_env` role. The playbook must have the following contents:

```yaml
---
- name: Use student.bash_env role playbook
  hosts: devservers
  vars:
    default_prompt: '[\u on \h in \W dir]\$ '
  pre_tasks:
    - name: Ensure test user does not exist
      ansible.builtin.user:
        name: student2
        state: absent
        force: true
        remove: true

  roles:
    - student.bash_env

  post_tasks:
    - name: Create the test user
      ansible.builtin.user:
        name: student2
        state: present
        password: "{{ 'redhat' | password_hash }}"
```

You must create a user account to see the effects of the configuration change. The `pre_tasks` and `post_tasks` section of the playbook ensure that the `student2` user account is deleted and created each time the playbook is run.

When you run the `use-bash_env-role.yml` playbook, the `student2` account is created with a password of `redhat`.

**Note**: The `student2` password is generated using a filter. Filters take data and modify it; here, the `redhat` string is modified by passing it to the `password_hash` filter to convert the value into a protected password hash. By default, the hashing algorithm used is sha512.

Filters are an advanced topic not covered in this course.

### 6. Run Initial Playbook

Run the `use-bash_env-role.yml` playbook.

The `student.bash_env` role creates standard template configuration files in `/etc/skel` on the managed host. The files it creates include `.bashrc`, `.bash_profile`, and `.vimrc`.

```bash
[student@workstation role-galaxy]$ ansible-navigator run \
> -m stdout use-bash_env-role.yml

PLAY [Use student.bash_env role playbook] **************************************

TASK [Gathering Facts] *********************************************************
ok: [servera.lab.example.com]

TASK [Ensure test user does not exist] *****************************************
ok: [servera.lab.example.com]

TASK [student.bash_env : put away .bashrc] *************************************
changed: [servera.lab.example.com]

TASK [student.bash_env : put away .bash_profile] *******************************
changed: [servera.lab.example.com]

TASK [student.bash_env : put away .vimrc] **************************************
changed: [servera.lab.example.com]

TASK [Create the test user] ****************************************************
changed: [servera.lab.example.com]

PLAY RECAP *********************************************************************
servera.lab.example.com    : ok=6    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 7. Test Custom Prompt

Use SSH to log in to the servera machine as the `student2` user. Observe the custom prompt for the `student2` user, and then disconnect from the servera machine.

```bash
[student@workstation role-galaxy]$ ssh student2@servera
...output omitted...
[student2 on servera in ~ dir]$ exit
logout
Connection to servera closed.
[student@workstation role-galaxy]$
```

### 8. Use Development Version of Role

Run the playbook using the development version of the `student.bash_env` role.

The development version of the role is located in the `dev` branch of the Git repository. The development version of the role uses a new variable, `prompt_color`.

#### Update Requirements File

Before running the playbook, add the `prompt_color` variable to the vars section of the playbook and set its value to `blue`.

Update the `roles/requirements.yml` file, and set the version value to `dev`. Ensure that the `roles/requirements.yml` file contains the following content:

```yaml
---
# requirements.yml

- src: git@workstation.lab.example.com:student/bash_env
  scm: git
  version: dev
  name: student.bash_env
```

#### Configure ansible.cfg

Modify the `~/role-galaxy/ansible.cfg` and add the `roles_path` setting to the `[defaults]` section of the file. This sets the default roles path and enable you to omit the `-p roles` option when typing ansible-galaxy commands.

When completed, the file contains the following content:

```ini
[defaults]
inventory=inventory
remote_user=devops
roles_path=roles

[privilege_escalation]
become=true
become_method=sudo
become_user=root
become_ask_pass=false
```

#### Remove and Reinstall Role

Remove the existing version of the `student.bash_env` role from the roles subdirectory.

```bash
[student@workstation role-galaxy]$ ansible-galaxy role remove student.bash_env
- successfully removed student.bash_env
```

Use the `ansible-galaxy role install` command to install the role by using the updated requirements file.

```bash
[student@workstation role-galaxy]$ ansible-galaxy role install \
> -r roles/requirements.yml
Starting galaxy role install process
- extracting student.bash_env to /home/student/role-galaxy/roles/student.bash_env
- student.bash_env (dev) was installed successfully
```

#### Update Playbook

Modify the `use-bash_env-role.yml` file. Add the `prompt_color` variable with a value of `blue` to the vars section of the playbook. Ensure that the file contains the following content:

```yaml
---
- name: Use student.bash_env role playbook
  hosts: devservers
  vars:
    prompt_color: blue
    default_prompt: '[\u on \h in \W dir]\$ '
  pre_tasks:
...output omitted...
```

### 9. Run Updated Playbook

Run the `use-bash_env-role.yml` playbook.

```bash
[student@workstation role-galaxy]$ ansible-navigator run \
> -m stdout use-bash_env-role.yml

PLAY [Use student.bash_env role playbook] **************************************

TASK [Gathering Facts] *********************************************************
ok: [servera.lab.example.com]

TASK [Ensure test user does not exist] *****************************************
changed: [servera.lab.example.com]

TASK [student.bash_env : put away .bashrc] *************************************
changed: [servera.lab.example.com]

TASK [student.bash_env : put away .bash_profile] *******************************
ok: [servera.lab.example.com]

TASK [student.bash_env : put away .vimrc] **************************************
ok: [servera.lab.example.com]

TASK [Create the test user] ****************************************************
changed: [servera.lab.example.com]

PLAY RECAP *********************************************************************
servera.lab.example.com    : ok=6    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 10. Test Colored Prompt

Use SSH to log in to the servera machine as the `student2` user. The custom prompt for the `student2` user now displays with blue characters.

```bash
[student@workstation role-galaxy]$ ssh student2@servera
...output omitted...
[student2 on servera in ~ dir]$
```

Log out from servera.

```bash
[student2 on servera in ~ dir]$ exit
logout
Connection to servera closed.
[student@workstation role-galaxy]$
```

## Finish

On the workstation machine, change to the student user home directory and use the lab command to complete this exercise. This step is important to ensure that resources from previous exercises do not impact upcoming exercises.

```bash
[student@workstation ~]$ lab finish role-galaxy
```

## Summary

This exercise demonstrated:

1. **Requirements File Creation**: Creating `roles/requirements.yml` to specify external role dependencies
2. **Role Installation**: Using `ansible-galaxy role install` with requirements files and custom paths
3. **Role Management**: Listing, removing, and reinstalling roles with different versions
4. **Version Control**: Switching between different branches (main vs dev) of a role
5. **Configuration Management**: Setting up `ansible.cfg` to simplify ansible-galaxy commands
6. **Role Variables**: Using variables to customize role behavior (`prompt_color`, `default_prompt`)
7. **Playbook Integration**: Using external roles in playbooks with pre_tasks and post_tasks

### Key Concepts Covered

- **Requirements file format**: Source, SCM, version, and name attributes
- **ansible-galaxy commands**: `install`, `list`, `remove` with various options
- **Role paths**: Using `-p roles` option vs configuring `roles_path` in ansible.cfg
- **Git integration**: Installing roles from Git repositories with specific branches
- **Role versioning**: Managing different versions of the same role
- **Variable passing**: Customizing role behavior through playbook variables
- **User management**: Creating test users to verify role effects
- **SSH testing**: Verifying role functionality through interactive sessions

### Best Practices Demonstrated

- **Version pinning**: Specifying explicit versions in requirements files
- **Project organization**: Keeping roles in project-local directories
- **Configuration management**: Using ansible.cfg for consistent behavior
- **Testing approach**: Using pre_tasks and post_tasks for comprehensive testing
- **Role cleanup**: Removing and reinstalling roles when changing versions