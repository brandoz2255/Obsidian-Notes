# Guided Exercise: Including and Importing Files

Include and import playbooks and tasks in a top-level Ansible Playbook.

## Outcomes

- Include task and playbook files in playbooks.

## Setup

As the student user on the workstation machine, use the lab command to prepare your system for this exercise.

This command prepares your environment and ensures that all required resources are available.

```bash
[student@workstation ~]$ lab start projects-file
```

## Instructions

### 1. Navigate to Working Directory

Change into the `/home/student/projects-file` directory.

```bash
[student@workstation ~]$ cd ~/projects-file
[student@workstation projects-file]$
```

### 2. Review Task Files

Review the contents of the three files in the tasks subdirectory.

#### Review tasks/environment.yml

Review the contents of the `tasks/environment.yml` file. The file contains tasks for package installation and service administration.

```yaml
---
  - name: Install the {{ package }} package
    ansible.builtin.dnf:
      name: "{{ package }}"
      state: latest
  - name: Start the {{ service }} service
    ansible.builtin.service:
      name: "{{ service }}"
      enabled: true
      state: started
```

#### Review tasks/firewall.yml

Review the contents of the `tasks/firewall.yml` file. The file contains tasks for installation, administration, and configuration of firewall software.

```yaml
---
  - name: Install the firewall
    ansible.builtin.dnf:
      name: "{{ firewall_pkg }}"
      state: latest

  - name: Start the firewall
    ansible.builtin.service:
      name: "{{ firewall_svc }}"
      enabled: true
      state: started

  - name: Open the port for {{ rule }}
    ansible.posix.firewalld:
      service: "{{ item }}"
      immediate: true
      permanent: true
      state: enabled
    loop: "{{ rule }}"
```

#### Review tasks/placeholder.yml

Review the contents of the `tasks/placeholder.yml` file. This file contains a task for populating a placeholder web content file.

```yaml
---
  - name: Create placeholder file
    ansible.builtin.copy:
      content: "{{ ansible_facts['fqdn'] }} has been customized using Ansible.\n"
      dest: "{{ file }}"
```

### 3. Review Play File

Review the contents of the `test.yml` file in the plays subdirectory. This file contains a play that tests connections to a web service.

```yaml
---
- name: Test web service
  hosts: workstation
  become: false
  tasks:
    - name: connect to internet web server
      ansible.builtin.uri:
        url: "{{ url }}"
        status_code: 200
```

### 4. Create the Main Playbook

Create a playbook named `playbook.yml`. Define the first play with the name Configure web server. The play should execute against the `servera.lab.example.com` managed host defined in the inventory file. The beginning of the file should appear as follows:

```yaml
---
- name: Configure web server
  hosts: servera.lab.example.com
```

### 5. Configure Tasks Section

In the first play of the `playbook.yml` playbook, configure its tasks section with three sets of tasks that are included or imported from tasks files.

The play's first task must include the first set of tasks from the `tasks/environment.yml` tasks file. Define the necessary task variables to install the httpd package and to enable and start the httpd service.

The play's second task must import the second set of tasks from the `tasks/firewall.yml` tasks file. Define the necessary task variables to install the firewalld package to enable and start the firewalld service, and to allow plain text and secure HTTP connections.

The play's third task must import the third set of tasks from the `tasks/placeholder.yml` task file.

Create the tasks section in the first play by adding the following entry to the `playbook.yml` playbook.

```yaml
  tasks:
```

#### Include Environment Tasks

Include the first set of tasks from `tasks/environment.yml` using the include_tasks feature. Set the package and service variables to httpd.

```yaml
    - name: Include the environment task file and set the variables
      include_tasks: tasks/environment.yml
      vars:
        package: httpd
        service: httpd
```

#### Import Firewall Tasks

Import the second set of tasks from `tasks/firewall.yml` using the import_tasks feature. Set the firewall_pkg and firewall_svc variables to firewalld. Set the rule variable to http and https.

```yaml
    - name: Import the firewall task file and set the variables
      import_tasks: tasks/firewall.yml
      vars:
        firewall_pkg: firewalld
        firewall_svc: firewalld
        rule:
          - http
          - https
```

#### Import Placeholder Tasks

Import the last task set from `tasks/placeholder.yml` using the import_tasks feature. Set the file variable to `/var/www/html/index.html`.

```yaml
    - name: Import the placeholder task file and set the variable
      import_tasks: tasks/placeholder.yml
      vars:
        file: /var/www/html/index.html
```

### 6. Add Second Play

Add a second play to the `playbook.yml` playbook, importing the contents of the `plays/test.yml` playbook.

Add a second play to the `playbook.yml` playbook to validate the web server installation. Import the play from `plays/test.yml`. Set the url variable to `http://servera.lab.example.com` as a play variable.

```yaml
- name: Import test play file and set the variable
  import_playbook: plays/test.yml
  vars:
    url: 'http://servera.lab.example.com'
```

### 7. Complete Playbook

The finished playbook should consist of the following content:

```yaml
---
- name: Configure web server
  hosts: servera.lab.example.com

  tasks:
    - name: Include the environment task file and set the variables
      include_tasks: tasks/environment.yml
      vars:
        package: httpd
        service: httpd

    - name: Import the firewall task file and set the variables
      import_tasks: tasks/firewall.yml
      vars:
        firewall_pkg: firewalld
        firewall_svc: firewalld
        rule:
          - http
          - https

    - name: Import the placeholder task file and set the variable
      import_tasks: tasks/placeholder.yml
      vars:
        file: /var/www/html/index.html

- name: Import test play file and set the variable
  import_playbook: plays/test.yml
  vars:
    url: 'http://servera.lab.example.com'
```

Save the changes to the `playbook.yml` playbook.

### 8. Verify Syntax

Before running the playbook, verify that its syntax is correct by running `ansible-navigator run -m stdout playbook.yml --syntax-check`. Correct any reported errors before moving to the next step.

```bash
[student@workstation projects-file]$ ansible-navigator run \
> -m stdout playbook.yml --syntax-check
playbook: /home/student/projects-file/playbook.yml
```

### 9. Run the Playbook

Run the `playbook.yml` playbook. The output of ansible-navigator shows the tasks and plays that are imported and the task file that is included.

```bash
[student@workstation projects-file]$ ansible-navigator run \
> -m stdout playbook.yml

PLAY [Configure web server] ***********************************************

TASK [Gathering Facts] ****************************************************
ok: [servera.lab.example.com]

TASK [Include the environment task file and set the variables] ************
included: /home/student/projects-file/tasks/environment.yml for servera.lab.example.com

TASK [Install the httpd package] ******************************************
changed: [servera.lab.example.com]

TASK [Start the httpd service] ********************************************
changed: [servera.lab.example.com]

TASK [Install the firewall] ***********************************************
ok: [servera.lab.example.com]

TASK [Start the firewall] *************************************************
ok: [servera.lab.example.com]

TASK [Open the port for ['http', 'https']] ********************************
changed: [servera.lab.example.com] => (item=http)
changed: [servera.lab.example.com] => (item=https)

TASK [Create placeholder file] ********************************************
changed: [servera.lab.example.com]

PLAY [Test web service] ***************************************************

TASK [Gathering Facts] ****************************************************
ok: [workstation]

TASK [connect to internet web server] *************************************
ok: [workstation]

PLAY RECAP ****************************************************************
servera.lab.example.com    : ok=8    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
workstation                : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

## Finish

On the workstation machine, change to the student user home directory and use the lab command to complete this exercise. This step is important to ensure that resources from previous exercises do not impact upcoming exercises.

```bash
[student@workstation ~]$ lab finish projects-file
```

## Summary

This exercise demonstrated:

1. **Task File Organization**: How to structure reusable task files with parameterized variables
2. **Including vs Importing**: Practical differences between `include_tasks` and `import_tasks`
3. **Variable Passing**: How to pass variables to included/imported files using the `vars` section
4. **Playbook Import**: Using `import_playbook` to incorporate entire playbooks
5. **Modular Design**: Creating maintainable, reusable Ansible code through file separation

### Key Concepts Covered

- **include_tasks**: Dynamic inclusion of task files at runtime
- **import_tasks**: Static import of task files at parse time
- **import_playbook**: Import complete playbooks with variables
- **Variable parameterization**: Making task files reusable across different scenarios
- **File organization**: Logical separation of tasks, plays, and variables