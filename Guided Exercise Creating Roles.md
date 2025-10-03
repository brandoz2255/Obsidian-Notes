


Create an Ansible role that uses variables, files, templates, tasks, and handlers to deploy a network service.

## Outcomes

- Create a role that uses variables and parameters.

The myvhost role installs and configures the Apache service on a host. A template named `vhost.conf.j2` is provided to generate `/etc/httpd/conf.d/vhost.conf`.

## Setup

As the student user on the workstation machine, use the lab command to prepare your system for this exercise.

This command prepares your environment and ensures that all required resources are available.

```bash
[student@workstation ~]$ lab start role-create
```

## Instructions

### 1. Navigate to Working Directory

Change into the `/home/student/role-create` directory.

```bash
[student@workstation ~]$ cd ~/role-create
[student@workstation role-create]$
```

### 2. Create Role Directory Structure

Create the directory structure for a role called `myvhost`. The role includes fixed files, templates, tasks, and handlers. The defaults, vars, and tests directories are not used in this role, so you can delete them.

```bash
[student@workstation role-create]$ mkdir -v roles; cd roles
mkdir: created directory 'roles'
[student@workstation roles]$ ansible-galaxy role init myvhost
- Role myvhost was created successfully
[student@workstation roles]$ rm -rvf myvhost/{defaults,vars,tests}
removed 'myvhost/defaults/main.yml'
removed directory: 'myvhost/defaults'
removed 'myvhost/vars/main.yml'
removed directory: 'myvhost/vars'
removed 'myvhost/tests/inventory'
removed 'myvhost/tests/test.yml'
removed directory: 'myvhost/tests'
[student@workstation roles]$ cd ..
[student@workstation role-create]$
```

### 3. Create Role Tasks

Edit the main.yml file in the tasks subdirectory of the role. The role should perform the following tasks:

- Install the httpd package
- Enable and start the httpd service
- Install the web server configuration file using a template provided by the role

#### Install httpd Package

Edit the `roles/myvhost/tasks/main.yml` file. Include code to use the `ansible.builtin.dnf` module to install the httpd package. Ensure that the file contains the following content:

```yaml
---
# tasks file for myvhost

- name: Ensure httpd is installed
  ansible.builtin.dnf:
    name: httpd
    state: latest
```

#### Start and Enable httpd Service

Add additional code to the `roles/myvhost/tasks/main.yml` file to use the `ansible.builtin.service` module to start and enable the httpd service.

```yaml
- name: Ensure httpd is started and enabled
  ansible.builtin.service:
    name: httpd
    state: started
    enabled: true
```

#### Deploy Virtual Host Configuration

Add another stanza to use the `ansible.builtin.template` module to create `/etc/httpd/conf.d/vhost.conf` on the managed host. The module calls a handler to restart the httpd daemon when this file is updated.

```yaml
- name: vhost file is installed
  ansible.builtin.template:
    src: vhost.conf.j2
    dest: /etc/httpd/conf.d/vhost.conf
    owner: root
    group: root
    mode: 0644
  notify:
    - restart httpd
```

Save your changes and exit the `roles/myvhost/tasks/main.yml` file.

### 4. Create Role Handler

Create the handler for restarting the httpd service. Edit the `roles/myvhost/handlers/main.yml` file and include code to use the `ansible.builtin.service` module, then save and exit. Ensure that the file contains the following content:

```yaml
---
# handlers file for myvhost

- name: restart httpd
  ansible.builtin.service:
    name: httpd
    state: restarted
```

### 5. Setup Template File

The `vhost.conf.j2` file is a template that is used to configure the Apache web server by using variables:

```apache
# {{ ansible_managed }}

<VirtualHost *:80>
    ServerAdmin webmaster@{{ ansible_fqdn }}
    ServerName {{ ansible_fqdn }}
    ErrorLog logs/{{ ansible_hostname }}-error.log
    CustomLog logs/{{ ansible_hostname }}-common.log common
    DocumentRoot /var/www/vhosts/{{ ansible_hostname }}/

    <Directory /var/www/vhosts/{{ ansible_hostname }}/>
    Options +Indexes +FollowSymlinks +Includes
    Order allow,deny
    Allow from all
    </Directory>
</VirtualHost>
```

Move the `vhost.conf.j2` template from the project directory to the role's templates subdirectory.

```bash
[student@workstation role-create]$ mv -v vhost.conf.j2 roles/myvhost/templates/
renamed 'vhost.conf.j2' -> 'roles/myvhost/templates/vhost.conf.j2'
```

### 6. Create HTML Content

Create the HTML content to be served by the web server.

#### Create files directory

Create the `files/html/` directory to store the content in.

```bash
[student@workstation role-create]$ mkdir -pv files/html
mkdir: created directory 'files'
mkdir: created directory 'files/html'
```

#### Create index.html

Create an `index.html` file below that directory with the contents: simple index.

```bash
[student@workstation role-create]$ echo 'simple index' > files/html/index.html
```

### 7. Test the Role

Test the `myvhost` role to make sure that it works properly.

#### Create Test Playbook

Write a playbook that uses the role, called `use-vhost-role.yml`. Include a task to copy the HTML content from the `files/html/` directory. Use the `ansible.builtin.copy` module and include a trailing slash (/) after the source directory name. Ensure that the file contains the following content:

```yaml
---
- name: Use myvhost role playbook
  hosts: webservers
  pre_tasks:
    - name: pre_tasks message
      ansible.builtin.debug:
        msg: 'Ensure web server configuration.'

  roles:
    - myvhost

  post_tasks:
    - name: HTML content is installed
      ansible.builtin.copy:
        src: files/html/
        dest: "/var/www/vhosts/{{ ansible_hostname }}"

    - name: post_tasks message
      ansible.builtin.debug:
        msg: 'Web server is configured.'
```

**Note**: The trailing slash causes the source directory and all of its contents to be copied to the managed host.

### 8. Verify Syntax and Run Playbook

Before running the `use-vhost-role.yml` playbook, verify that its syntax is correct by running the ansible-navigator command with the `--syntax-check` option. If it reports any errors, correct them before moving to the next step. You should see output similar to the following:

```bash
[student@workstation role-create]$ ansible-navigator run \
> -m stdout use-vhost-role.yml --syntax-check
playbook: /home/student/role-create/use-vhost-role.yml
```

#### Run the Playbook

Run the `use-vhost-role.yml` playbook. Review the output to confirm that Ansible performed the actions on the servera web server.

```bash
[student@workstation role-create]$ ansible-navigator run \
> -m stdout use-vhost-role.yml

PLAY [Use myvhost role playbook] *********************************************

TASK [Gathering Facts] *******************************************************
ok: [servera.lab.example.com]

TASK [pre_tasks message] *****************************************************
ok: [servera.lab.example.com] => {
    "msg": "Ensure web server configuration."
}

TASK [myvhost : Ensure httpd is installed] ***********************************
changed: [servera.lab.example.com]

TASK [myvhost : Ensure httpd is started and enabled] *************************
changed: [servera.lab.example.com]

TASK [myvhost : vhost file is installed] *************************************
changed: [servera.lab.example.com]

RUNNING HANDLER [myvhost : restart httpd] ************************************
changed: [servera.lab.example.com]

TASK [HTML content is installed] *********************************************
changed: [servera.lab.example.com]

TASK [post_tasks message] ****************************************************
ok: [servera.lab.example.com] => {
    "msg": "Web server is configured."
}

PLAY RECAP *******************************************************************
servera.lab.example.com    : ok=8    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 9. Verification Tests

#### Verify httpd Service

Run the `verify-httpd.yml` playbook to confirm that the role worked. The httpd package should be installed and the httpd service should be enabled and running.

```bash
[student@workstation role-create]$ ansible-navigator run \
> -m stdout verify-httpd.yml

PLAY [Verify the httpd service] **********************************************

TASK [Gathering Facts] *******************************************************
ok: [servera.lab.example.com]

TASK [Verify the httpd service is installed] *********************************
changed: [servera.lab.example.com]

TASK [Is the httpd service installed] ****************************************
ok: [servera.lab.example.com] => {
    "msg": "{'changed': True, 'stdout': 'httpd-2.4.51-7.el9_0.x86_64', 'stderr': '', 'rc': 0, 'cmd': ['rpm', '-q', 'httpd'], 'start': '2022-07-18 15:56:40.412987', 'end': '2022-07-18 15:56:40.429762', 'delta': '0:00:00.016775', 'msg': '', 'stdout_lines': ['httpd-2.4.51-7.el9_0.x86_64'], 'stderr_lines': [], 'failed': False}.stdout"
}

TASK [Verify the httpd service is started] ***********************************
changed: [servera.lab.example.com]

TASK [Is the httpd service started] ******************************************
ok: [servera.lab.example.com] => {
    "msg": "{'changed': True, 'stdout': 'active', 'stderr': '', 'rc': 0, 'cmd': ['systemctl', 'is-active', 'httpd'], 'start': '2022-07-18 15:56:40.853778', 'end': '2022-07-18 15:56:40.863193', 'delta': '0:00:00.009415', 'msg': '', 'stdout_lines': ['active'], 'stderr_lines': [], 'failed': False}.stdout"
}

TASK [Verify the httpd service is enabled] ***********************************
changed: [servera.lab.example.com]

TASK [Is the httpd service enabled] ******************************************
ok: [servera.lab.example.com] => {
    "msg": "{'changed': True, 'stdout': 'enabled', 'stderr': '', 'rc': 0, 'cmd': ['systemctl', 'is-enabled', 'httpd'], 'start': '2022-07-18 15:56:41.282211', 'end': '2022-07-18 15:56:41.291881', 'delta': '0:00:00.009670', 'msg': '', 'stdout_lines': ['enabled'], 'stderr_lines': [], 'failed': False}.stdout"
}

PLAY RECAP *******************************************************************
servera.lab.example.com    : ok=7    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

#### Verify Configuration

Run the `verify-config.yml` playbook to confirm that the Apache configuration file is deployed and that all the variables in the template expanded correctly.

```bash
[student@workstation role-create]$ ansible-navigator run \
> -m stdout verify-config.yml

PLAY [Verify the httpd config] ***********************************************

TASK [Gathering Facts] *******************************************************
ok: [servera.lab.example.com]

TASK [Verify the httpd config file is in place] ******************************
changed: [servera.lab.example.com]

TASK [What does the httpd config file contain] *******************************
ok: [servera.lab.example.com] => {
    "msg": "{'changed': True, 'stdout': '# Ansible managed\\n\\n<VirtualHost \*:80>\\n    ServerAdmin webmaster@servera.lab.example.com\\n    ServerName servera.lab.example.com\\n    ErrorLog logs/servera-error.log\\n    CustomLog logs/servera-common.log common\\n    DocumentRoot /var/www/vhosts/servera/\\n\\n    <Directory /var/www/vhosts/servera/>\\n\\tOptions +Indexes +FollowSymlinks +Includes\\n\\tOrder allow,deny\\n\\tAllow from all\\n    </Directory>\\n</VirtualHost>', 'stderr': '', 'rc': 0, 'cmd': ['cat', '/etc/httpd/conf.d/vhost.conf'], 'start': '2022-07-18 16:15:11.441593', 'end': '2022-07-18 16:15:11.445100', 'delta': '0:00:00.003507', 'msg': '', 'stdout_lines': ['# Ansible managed', '', '<VirtualHost *:80>', '    ServerAdmin webmaster@servera.lab.example.com', '    ServerName servera.lab.example.com', '    ErrorLog logs/servera-error.log', '    CustomLog logs/servera-common.log common', '    DocumentRoot /var/www/vhosts/servera/', '', '    <Directory /var/www/vhosts/servera/>', '\\tOptions +Indexes +FollowSymlinks +Includes', '\\tOrder allow,deny', '\\tAllow from all', '    </Directory>', '</VirtualHost>'], 'stderr_lines': [], 'failed': False}.stdout_lines"
}

PLAY RECAP *******************************************************************
servera.lab.example.com    : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

#### Verify Content

The HTML content is served from a directory called `/var/www/vhosts/servera`. Run the `verify-content.yml` playbook to confirm that the `index.html` file in that directory contains the string "simple index".

```bash
[student@workstation role-create]$ ansible-navigator run \
> -m stdout verify-content.yml

PLAY [Verify the index.html file] ********************************************

TASK [Gathering Facts] *******************************************************
ok: [servera.lab.example.com]

TASK [Verify the index.html file is in place] ********************************
changed: [servera.lab.example.com]

TASK [What does the index.html config file contain] **************************
ok: [servera.lab.example.com] => {
    "msg": "{'changed': True, 'stdout': 'simple index', 'stderr': '', 'rc': 0, 'cmd': ['cat', '/var/www/vhosts/servera/index.html'], 'start': '2022-07-18 16:24:54.665447', 'end': '2022-07-18 16:24:54.669959', 'delta': '0:00:00.004512', 'msg': '', 'stdout_lines': ['simple index'], 'stderr_lines': [], 'failed': False}.stdout_lines"
}

PLAY RECAP *******************************************************************
servera.lab.example.com    : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### 10. Final Verification

Confirm that the web server content is available.

```bash
[student@workstation role-create]$ curl http://servera.lab.example.com
simple index
```

## Finish

On the workstation machine, change to the student user home directory and use the lab command to complete this exercise. This step is important to ensure that resources from previous exercises do not impact upcoming exercises.

```bash
[student@workstation ~]$ lab finish role-create
```

## Summary

This exercise demonstrated:

1. **Role Creation**: Using `ansible-galaxy role init` to create a standardized role structure
2. **Task Definition**: Creating tasks that install packages, manage services, and deploy templates
3. **Handler Usage**: Creating handlers to restart services when configuration changes
4. **Template Deployment**: Using Jinja2 templates with Ansible facts and variables
5. **File Management**: Organizing static files and templates within role structure
6. **Role Testing**: Creating comprehensive test playbooks to verify role functionality
7. **Play Structure**: Using pre_tasks, roles, and post_tasks sections effectively

### Key Concepts Covered

- **ansible-galaxy role init**: Automated role skeleton creation
- **Template variables**: Using `{{ ansible_facts['hostname'] }}`, `{{ ansible_fqdn }}`, etc.
- **Handler notification**: Using `notify` to trigger handlers when tasks change state
- **File organization**: Proper placement of templates, files, tasks, and handlers
- **Role testing**: Comprehensive verification of package installation, service state, configuration files, and web content
- **Copy module with directories**: Using trailing slash to copy directory contents