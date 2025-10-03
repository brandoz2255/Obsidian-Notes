







---

# Lab: Simplifying Playbooks with Roles and Ansible Content Collections

Create Ansible roles that use variables, files, templates, tasks, and handlers.

## Outcomes

- Create Ansible roles that use variables, files, templates, tasks, and handlers to configure a development web server.
- In a playbook, use a role that is hosted in a remote repository.
- Use a system role for Red Hat Enterprise Linux in a playbook.

## Setup

As the student user on the workstation machine, use the lab command to prepare your system for this exercise.

This command prepares your environment and ensures that all required resources are available.

```bash
[student@workstation ~]$ lab start role-review
```

## Lab Requirements

Your organization must provide a single web server to host development code for all its web developers. You are tasked with writing a playbook to configure this development web server.

### Development Server Requirements

The development web server must satisfy several requirements:

1. **Production Configuration Match**: The development server configuration matches the production server configuration. The production server is configured by using an Ansible role, developed by the organization's infrastructure team.

2. **Developer Directories**: Each developer is given a directory on the development server to host code and content. Each developer's content is accessed by using an assigned, nonstandard port.

3. **SELinux Configuration**: SELinux is set to enforcing mode and is using the targeted policy.

### Playbook Requirements

Your playbook must:

1. **Custom Role**: Use a role to configure directories and ports for each developer on the web server. You must write this role.

2. **Role Dependencies**: This role has a dependency on a role to configure Apache that was written by your organization. You should define the dependency, specifying version v1.4 of the role. The URL of the dependency's Git repository is: `git@workstation.lab.example.com:infra/apache`

3. **System Role**: Use the `redhat.rhel_system_roles.selinux` role to configure SELinux to allow external hosts to access the nonstandard HTTP ports used by your web server. You are provided with an `selinux.yml` variable file that you can use in the group_vars directory to pass the correct settings to the role.

## Instructions

### Step 1: Setup Working Environment

Change into the `/home/student/role-review` directory.

```bash
[student@workstation ~]$ cd ~/role-review
[student@workstation role-review]$
```

### Step 2: Install System Roles Collection

Use the `ansible-galaxy collection install` command to install the `redhat.rhel_system_roles` collection from the provided tar archive file, then verify that it was installed correctly.

```bash
[student@workstation role-review]$ ansible-galaxy collection install \
> redhat-rhel_system_roles-1.19.3.tar.gz -p collections
```

Verify the installation:

```bash
[student@workstation role-review]$ ansible-galaxy collection list -p collections
```

### Step 3: Create Initial Playbook

Create a playbook named `web_dev_server.yml` with a single play named `Configure Dev Web Server`. Configure the play to target the `dev_webserver` host group. Do not add any roles or tasks to the play yet.

Ensure that the play forces handlers to execute, because you might encounter an error when developing the playbook.

```yaml
---
- name: Configure Dev Web Server
  hosts: dev_webserver
  force_handlers: true
```

### Step 4: Verify Initial Playbook

Verify the syntax of the playbook, then run the playbook. The syntax check should pass and the playbook should run successfully. The play only gathers facts because it has no roles or tasks yet.

```bash
[student@workstation role-review]$ ansible-navigator run \
> -m stdout web_dev_server.yml --syntax-check

[student@workstation role-review]$ ansible-navigator run \
> -m stdout web_dev_server.yml
```

### Step 5: Install Role Dependencies

Make sure to install any roles that are dependencies of roles in your playbook.

For example, the `apache.developer_configs` role that you write later in this lab depends on the `infra.apache` role.

#### Create Requirements File

Create a `roles/requirements.yml` file. This file installs the role from the Git repository at `git@workstation.lab.example.com:infra/apache`, use version v1.4, and name it `infra.apache` locally.

```bash
[student@workstation role-review]$ mkdir -p roles
```

Create `roles/requirements.yml`:

```yaml
---
- src: git@workstation.lab.example.com:infra/apache
  scm: git
  version: v1.4
  name: infra.apache
```

#### Install the Role

You can assume that your SSH keys are configured to allow you to get roles from this repository automatically. Install the role with the ansible-galaxy command.

```bash
[student@workstation role-review]$ ansible-galaxy role install \
> -r roles/requirements.yml -p roles
```

### Step 6: Create Custom Role

#### Initialize Role

Initialize a new role named `apache.developer_configs` in the roles subdirectory.

```bash
[student@workstation role-review]$ cd roles
[student@workstation roles]$ ansible-galaxy role init apache.developer_configs
[student@workstation roles]$ cd ..
```

#### Add Role Dependencies

Add the `infra.apache` role as a dependency for the new role, using the same information for name, source, version, and version control system as the `roles/requirements.yml` file.

Edit `roles/apache.developer_configs/meta/main.yml`:

```yaml
---
dependencies:
  - src: git@workstation.lab.example.com:infra/apache
    scm: git
    version: v1.4
    name: infra.apache
```

### Step 7: Configure Role Content

#### Move Task File

The `developer_tasks.yml` file in the project directory contains tasks for the role. Move this file to the correct location in the role directory hierarchy for a tasks file that is used by this role, replacing the existing file in that location.

```bash
[student@workstation role-review]$ mv developer_tasks.yml \
> roles/apache.developer_configs/tasks/main.yml
```

#### Move Template File

The `developer.conf.j2` file in the project directory is a Jinja2 template that is used by the tasks file. Move this file to the correct location for template files that are used by this role.

```bash
[student@workstation role-review]$ mv developer.conf.j2 \
> roles/apache.developer_configs/templates/
```

### Step 8: Configure Variables

The `apache.developer_configs` role creates a user account and configures a web server instance for the list of users defined in the variable named `web_developers`.

The `web_developers.yml` file in the project directory defines the `web_developers` variable, which is the list of users for the role.

Review this file and put it in the correct location to define the `web_developers` variable for the development web server host group from your inventory.

```bash
[student@workstation role-review]$ mkdir -p group_vars/dev_webserver
[student@workstation role-review]$ mv web_developers.yml \
> group_vars/dev_webserver/
```

### Step 9: Add Role to Playbook

Add the `apache.developer_configs` role to the play in the `web_dev_server.yml` playbook.

```yaml
---
- name: Configure Dev Web Server
  hosts: dev_webserver
  force_handlers: true

  roles:
    - apache.developer_configs
```

### Step 10: Test Playbook (Expected to Fail)

Verify the syntax of the playbook, and then run the playbook. The syntax check should pass, but the playbook should fail when the `infra.apache` role attempts to restart Apache HTTPD.

```bash
[student@workstation role-review]$ ansible-navigator run \
> -m stdout web_dev_server.yml --syntax-check

[student@workstation role-review]$ ansible-navigator run \
> -m stdout web_dev_server.yml
```

**Expected Result**: Apache HTTPD failed to restart because the network ports it uses for your developers are labeled with the wrong SELinux contexts.

### Step 11: Fix SELinux Configuration

Apache HTTPD failed to restart in the preceding step because the network ports it uses for your developers are labeled with the wrong SELinux contexts.

You can use the provided variable file, `selinux.yml`, with the `redhat.rhel_system_roles.selinux` role to fix the issue.

#### Create Pre-tasks Section

Create a `pre_tasks` section for your play in the `web_dev_server.yml` playbook. In that section, use a task to include the `redhat.rhel_system_roles.selinux` role in a block/rescue structure, so that it is properly applied.

```yaml
---
- name: Configure Dev Web Server
  hosts: dev_webserver
  force_handlers: true

  pre_tasks:
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

  roles:
    - apache.developer_configs
```

#### Move SELinux Variables

Move the `selinux.yml` file to the correct location so that its variables are set for the `dev_webserver` host group.

```bash
[student@workstation role-review]$ mv selinux.yml \
> group_vars/dev_webserver/
```

### Step 12: Final Testing

#### Verify Final Playbook

Verify the final `web_dev_server.yml` playbook and run a syntax check. The syntax check should pass.

**Note**: The `ansible-navigator run` command runs the play's tasks in the correct order, regardless of whether `pre_tasks` is at the end of the play or in the "correct" position of execution order in the playbook file. It still runs the play's tasks in the correct order.

```bash
[student@workstation role-review]$ ansible-navigator run \
> -m stdout web_dev_server.yml --syntax-check
```

#### Run Final Playbook

Run the `web_dev_server.yml` playbook. It should succeed.

```bash
[student@workstation role-review]$ ansible-navigator run \
> -m stdout web_dev_server.yml
```

#### Test Web Server Configuration

Test the configuration of the development web server. Verify that all endpoints are accessible and serving each developer's content.

```bash
# Test each developer's endpoint
[student@workstation role-review]$ curl http://servera.lab.example.com:9001
[student@workstation role-review]$ curl http://servera.lab.example.com:9002
[student@workstation role-review]$ curl http://servera.lab.example.com:9003
```

## Evaluation

As the student user on the workstation machine, use the lab command to grade your work. Correct any reported failures and rerun the command until successful.

```bash
[student@workstation ~]$ lab grade role-review
```

## Finish

On the workstation machine, change to the student user home directory and use the lab command to complete this exercise. This step is important to ensure that resources from previous exercises do not impact upcoming exercises.

```bash
[student@workstation ~]$ lab finish role-review
```

## Summary

This lab demonstrated:

1. **Complex Role Architecture**: Creating roles with dependencies and integrating multiple role types
2. **Content Collections**: Installing and using system roles from Red Hat collections
3. **Role Dependencies**: Defining and managing role dependencies through meta/main.yml
4. **Variable Organization**: Using group_vars for different aspects of configuration
5. **Advanced Playbook Structure**: Using pre_tasks with block/rescue for complex role interactions
6. **SELinux Management**: Handling SELinux configuration for custom port assignments
7. **Template Usage**: Moving and using Jinja2 templates within role structure
8. **Real-world Integration**: Combining custom roles, dependency roles, and system roles

### Key Concepts Covered

- **Role Creation**: Using `ansible-galaxy role init` and structuring role directories
- **Role Dependencies**: Defining dependencies in `meta/main.yml` with specific versions
- **Content Collections**: Installing and using `redhat.rhel_system_roles.selinux`
- **Variable Scope**: Organizing variables in `group_vars/dev_webserver/`
- **Advanced Error Handling**: Using block/rescue with system roles that may require reboots
- **Force Handlers**: Using `force_handlers: true` to ensure cleanup on failures
- **Template Management**: Proper placement of Jinja2 templates in role structure
- **Port Configuration**: Managing non-standard HTTP ports with SELinux
- **Integration Testing**: Verifying multi-component configurations work together

### Best Practices Demonstrated

- **Modular Design**: Separating concerns between different roles
- **Version Control**: Pinning dependency versions for reproducible deployments
- **Error Resilience**: Using block/rescue for robust error handling
- **Security Configuration**: Properly configuring SELinux for custom services
- **Testing Strategy**: Comprehensive testing of all configured endpoints
- **Documentation**: Clear role and variable organization
- **Dependency Management**: Explicit dependency declaration and installation

### Final Project Structure

```
role-review/
├── ansible.cfg
├── inventory
├── web_dev_server.yml
├── collections/
│   └── ansible_collections/
│       └── redhat/
│           └── rhel_system_roles/
├── group_vars/
│   └── dev_webserver/
│       ├── web_developers.yml
│       └── selinux.yml
└── roles/
    ├── requirements.yml
    ├── infra.apache/
    └── apache.developer_configs/
        ├── meta/main.yml
        ├── tasks/main.yml
        └── templates/developer.conf.j2
```