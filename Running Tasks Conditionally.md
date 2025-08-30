

---

## Core – Quick Reference

- **`when`**: The keyword that makes a task run only if a condition is true.
- **Variables**: Playbook vars, registered vars, and facts can be tested.
- **Common tests**
    - Boolean values (`true`/`false`)
    - Variable existence (`is defined` / `is not defined`)
    - Equality, inequality, comparison operators (`==`, `!=`, `<`, `>`, `<=`, `>=`)
    - Membership (`in`)
    - Logical operators (`and`, `or`) and grouping with parentheses.
- **Indentation**: `when` must be at the top level of the task (same level as `name` and the module).
- **Boolean strings**: From Ansible 2.12 onward, any non‑empty string is treated as `true` unless filtered with `| bool`.

---

## Info – Processed Details

### How does Ansible decide whether to run a task?

Ansible evaluates the expression after `when`.  
If the expression resolves to a Boolean `true`, the task runs; otherwise it is skipped.

### What can be tested with `when`?

- **Facts** gathered during the play (e.g., memory, CPU count, OS distribution).
- **Registered variables** from previous tasks (e.g., command return codes).
- **Playbook variables** defined in `vars:` or `vars_files`.
- **Variable existence** (`is defined` / `is not defined`).

### Why use conditionals?

- **Targeted configuration**: Only install a service on hosts that meet resource requirements.
- **Safety**: Skip tasks that would fail or cause errors (e.g., insufficient disk space).
- **Role assignment**: Different hosts can be given different roles based on facts.

### Common “how‑to” patterns

|Pattern|How to write it|Why it works|
|---|---|---|
|Boolean var|`when: run_my_task`|Directly checks the Boolean value.|
|Boolean string|`when: run_my_task|bool`|
|Variable defined|`when: my_service is defined`|Ensures the variable exists before using it.|
|Variable not defined|`when: my_service is not defined`|Skips the task if the variable is missing.|
|Membership|`when: ansible_facts['distribution'] in supported_distros`|Runs only on supported OSes.|
|Multiple conditions|`when: ansible_facts['distribution'] == "RedHat" and ansible_facts['kernel'] == "5.14.0-70.13.1.el9_0.x86_64"`|Both must be true.|
|OR logic|`when: ansible_facts['distribution'] == "RedHat" or ansible_facts['distribution'] == "Fedora"`|Runs if either OS matches.|
|List of conditions|`when:\n - ansible_facts['distribution_version'] == "9.0"\n - ansible_facts['kernel'] == "5.14.0-70.13.1.el9_0.x86_64"`|Readable AND‑combination.|
|Grouped with parentheses|`when: >\n (ansible_facts['distribution'] == "RedHat" and ansible_facts['distribution_major_version'] == "9") or\n (ansible_facts['distribution'] == "Fedora" and ansible_facts['distribution_major_version'] == "34")`|Clarifies evaluation order.|
|Loop + when|`loop: "{{ ansible_facts['mounts'] }}"\n when: item['mount'] == "/" and item['size_available'] > 300000000`|Checks each mount point; installs MariaDB only if root has enough space.|
|Register + when|`register: result`\n `when: result.rc == 0`|Restarts httpd only if postfix is active.|

---

## Main – Code & Explanations

### 1. Simple Boolean Task

```yaml
---
- name: Simple Boolean Task Demo
  hosts: all
  vars:
    run_my_task: true          # Boolean flag that controls the task
  tasks:
    - name: Install httpd package
      ansible.builtin.dnf:
        name: httpd
      when: run_my_task        # Runs only if run_my_task is true
```

### 2. Boolean Variable as a String

```yaml
---
- name: Boolean string handling
  hosts: all
  vars:
    run_my_task: "false"       # This is a string, not a Boolean
  tasks:
    - name: Install httpd
      ansible.builtin.dnf:
        name: httpd
      when: run_my_task | bool   # Convert string to Boolean before checking
```

### 3. Variable Existence Check

```yaml
---
- name: Test Variable is Defined Demo
  hosts: all
  vars:
    my_service: httpd          # Name of the package to install
  tasks:
    - name: "{{ my_service }} package is installed"
      ansible.builtin.dnf:
        name: "{{ my_service }}"   # Uses the variable value as the package name
      when: my_service is defined   # Only runs if my_service is set
```

### 4. Membership Test (`in`)

```yaml
---
- name: Demonstrate the "in" keyword
  hosts: all
  gather_facts: true
  vars:
    supported_distros:
      - RedHat
      - Fedora
  tasks:
    - name: Install httpd only on supported OSes
      ansible.builtin.dnf:
        name: http
        state: present
      when: ansible_facts['distribution'] in supported_distros   # Checks OS against list
```

### 5. Multiple Conditions with `and`

```yaml
---
- name: Multiple AND conditions
  hosts: all
  gather_facts: true
  tasks:
    - name: Install httpd on RHEL 9.0 with specific kernel
      ansible.builtin.dnf:
        name: httpd
        state: present
      when: >
        ansible_facts['distribution_version'] == "9.0" and
        ansible_facts['kernel'] == "5.14.0-70.13.1.el9_0.x86_64"
```

### 6. Multiple Conditions with `or`

```yaml
---
- name: Multiple OR conditions
  hosts: all
  gather_facts: true
  tasks:
    - name: Install httpd on RHEL 9 or Fedora 34
      ansible.builtin.dnf:
        name: httpd
        state: present
      when: >
        (ansible_facts['distribution'] == "RedHat" and
         ansible_facts['distribution_major_version'] == "9") or
        (ansible_facts['distribution'] == "Fedora" and
         ansible_facts['distribution_major_version'] == "34")
```

### 7. List of Conditions (AND by default)

```yaml
---
- name: List of conditions (AND)
  hosts: all
  gather_facts: true
  tasks:
    - name: Install httpd only if both conditions are true
      ansible.builtin.dnf:
        name: httpd
        state: present
      when:
        - ansible_facts['distribution_version'] == "9.0"
        - ansible_facts['kernel'] == "5.14.0-70.13.1.el9_0.x86_64"
```

### 8. Loop + Conditional

```yaml
---
- name: Install mariadb-server if root has enough space
  hosts: all
  tasks:
    - name: Install mariadb-server
      ansible.builtin.dnf:
        name: mariadb-server
        state: latest
      loop: "{{ ansible_facts['mounts'] }}"   # Iterate over each mount fact
      when: item['mount'] == "/" and item['size_available'] > 300000000
      # Runs only for the root mount with >300 MiB free
```

### 9. Register + Conditional

```yaml
---
- name: Restart HTTPD if Postfix is Running
  hosts: all
  tasks:
    - name: Get Postfix status
      ansible.builtin.command: /usr/bin/systemctl is-active postfix
      register: result          # Stores command output and return code

    - name: Restart httpd based on Postfix status
      ansible.builtin.service:
        name: httpd
        state: restarted
      when: result.rc == 0      # rc 0 means postfix is active
```

---

**Key Takeaways**

- Use `when` to guard tasks; it can be a single expression or a list of expressions.
- Always indent `when` at the task level (same level as `name` and the module).
- Convert string booleans to real Booleans with `| bool` to avoid accidental truthy strings.
- Combine `loop` and `when` to run a task only for specific items in a list.
- Register a command’s result and use its `rc` (return code) in a `when` to react to success or failure.

These patterns let you write playbooks that adapt to the environment of each host, making your automation smarter and safer.












---

ansible it self can use conditionals to run tasks or plays when certain conditions are met like for example we an use a conditionals to determine available memory on a managed host ebfore ansible installs or configures a service 

these conditionals are made to help differentiated between managed hosts and assign them to funcitonal roles based on the conditions 

Playbook variables, registered variables, and Ansible facts can all be tested with conditionals.

These following sceanrios describe everything 

- Define a hard limit in a variable (for example, `min_memory`) and compare it against the available memory on a managed host.
    
- Capture the output of a command and evaluate it to determine whether a task completed before taking further action. For example, if a program fails, then a batch is skipped.
    
- Use Ansible facts to determine the managed host network configuration and decide which template file to send (for example, network bonding or trunking).
    
- Evaluate the number of CPUs to determine how to properly tune a web server.
    
- Compare a registered variable with a predefined variable to determine if a service changed. For example, test the MD5 checksum of a service configuration file to see if the service is changed.

the `when` statement is used to run a task conditionally 

One of the simplest conditions that can be tested whether a boolean var is true or false 


```yaml
---
- name: Simple Boolean Task Demo
  hosts: all
  vars:
    run_my_task: true

  tasks:
    - name: httpd package is installed
      ansible.builtin.dnf:
        name: httpd
      when: run_my_task
```

### Note

Boolean variables can have the value `true` or `false`.

In Ansible content, you can express those values in other ways: `True`, `yes`, or `1` are also accepted for `true`; and `False`, `no`, or `0` are also accepted for `false`. You might see `true` and `yes`, or `false` and `no` used interchangeably to express Boolean values in existing Ansible content.

Ansible YAML files are based on the YAML 1.1 standard, but the YAML 1.2 standard specifies that you can only use `true` or `false` to set Boolean values. For this reason, you might see gradual standardization toward using only `true` or `false` for Boolean values in playbooks and other Ansible files, even though the equivalent ways to express those values are still valid. Whether Ansible should eventually use only those ways of expressing Boolean values is an open question and an ongoing discussion in the Ansible community.


### Important

When using true/false conditions such as in the preceding example, you must be very careful to make sure that your variable is treated by Ansible as a Boolean and not a string.

Starting with Ansible Core 2.12, strings are always treated by `when` conditionals as `true` Booleans if they contain any content. (The default automation execution environment in Ansible Automation Platform 2.2 uses Ansible Core 2.13.)

Therefore, if the `run_my_task` variable in the preceding example were written as shown in the following example then it would be treated as a string with content and have the Boolean value `true`, and the task would run. This is probably not the behavior that you want.

```yaml
run_my_task: "false"
```

```yaml
run_my_task: false
```

```yaml
when: run_my_task | bool
```

the next example is a bit more sophisticated, and tests whether the `my_service` variable has a value.

value of `my_service` is used as the name of the package to install. If the `my_service` variable is not defined,

```yaml
---
- name: Test Variable is Defined Demo
  hosts: all
  vars:
    my_service: httpd

  tasks:
    - name: "{{ my_service }} package is installed"
      ansible.builtin.dnf:
        name: "{{ my_service }}"
```

The following table shows some operations that you can use when working with conditionals:

**Table 4.2. Example Conditionals**

|Operation|Example|
|:--|:--|
|Equal (value is a string)|`ansible_facts['machine'] == "x86_64"`|
|Equal (value is numeric)|`max_memory == 512`|
|Less than|`min_memory < 128`|
|Greater than|`min_memory > 256`|
|Less than or equal to|`min_memory <= 256`|
|Greater than or equal to|`min_memory >= 512`|
|Not equal to|`min_memory != 512`|
|Variable exists|`min_memory is defined`|
|Variable does not exist|`min_memory is not defined`|
|Boolean variable is `true`. The values of `1`, `True`, or `yes` evaluate to `true`.|`memory_available`|
|Boolean variable is `false`. The values of `0`, `False`, or `no` evaluate to `false`.|`not memory_available`|
|First variable's value is present as a value in second variable's list|`ansible_facts['distribution'] in supported_distros`|

example, the `ansible_facts['distribution']` variable is a fact determined during the `Gathering Facts` task, and identifies the managed host's operating system distribution.

The `supported_distros` variable was created by the playbook author, and contains a list of operating system distributions that the playbook supports. 

If 
the value of `ansible_facts['distribution']` is in the `supported_distros` list, the conditional passes and the task runs.

```yaml
---
- name: Demonstrate the "in" keyword
  hosts: all
  gather_facts: true
  vars:
    supported_distros:
      - RedHat
      - Fedora
  tasks:
    - name: Install httpd using dnf, where supported
      ansible.builtin.dnf:
        name: http
        state: present
      when: ansible_facts['distribution'] in supported_distros

### Important
```

### Important

Observe the indentation of the `when` statement. Because the `when` statement is not a module variable, it must be placed outside the module by being indented at the top level of the task.

A task is a YAML dictionary, and the `when` statement is one more key in the task, just like the task's name and the module it uses. A common convention places any `when` keyword that might be present after the task's name and the module (and module arguments).

Testing Multiple conditions One `when` statement can be used to evaluate multiple conditionals doing so can  be combined with either `and` or `or ` keywords grouped with parenthesis 

If a conditional statement should be met when either condition is true, then use the `or` statement. For example, the following condition is met if the machine is running either Red Hat Enterprise Linux or Fedora:

```
- when: ansible_facts['distribution'] == "RedHat" or ansible_facts['distribution'] == "Fedora"
```

With the `and` operation, both conditions have to be true for the entire conditional statement to be met. For example, the following condition is met if the remote host is a Red Hat Enterprise Linux 9.0 host, and the installed kernel is the specified version:

```
when: ansible_facts['distribution_version'] == "9.0" and ansible_facts['kernel'] == "5.14.0-70.13.1.el9_0.x86_64"
```

The `when` keyword also supports using a list to describe a list of conditions. When a list is provided to the `when` keyword, all the conditionals are combined using the `and` operation.

```yaml
when:
  - ansible_facts['distribution_version'] == "9.0"
  - ansible_facts['kernel'] == "5.14.0-70.13.1.el9_0.x86_64"
```

This format improves readability, a key goal of well-written Ansible Playbooks.

You can express more complex conditional statements by grouping conditions with parentheses. This ensures that they are correctly interpreted.

ollowing conditional statement is met if the machine is running either Red Hat Enterprise Linux 9 or Fedora 34. This example uses the greater-than character (>)

```yaml
when: >
    ( ansible_facts['distribution'] == "RedHat" and
      ansible_facts['distribution_major_version'] == "9" )
    or
    ( ansible_facts['distribution'] == "Fedora" and
    ansible_facts['distribution_major_version'] == "34" )
```


You can combine loops and conditionals.

 example, the `ansible.builtin.dnf` module installs the `mariadb-server` package if there is a file system mounted on `/` with more than 300 MiB free

The `ansible_facts['mounts']` fact is a list of dictionaries, each one representing facts about one mounted file system.

 loop iterates over each dictionary in the list,

 the conditional statement is not met unless a dictionary is found that represents a mounted file system where both conditions are true.

```yaml
- name: install mariadb-server if enough space on root
  ansible.builtin.dnf:
    name: mariadb-server
    state: latest
  loop: "{{ ansible_facts['mounts'] }}"
  when: item['mount'] == "/" and item['size_available'] > 300000000
```

### Important

When you use `when` with `loop` for a task, the `when` statement is checked for each item.

example also combines conditionals and `register` variables.

This playbook restarts the `httpd` service only if the `postfix` service is running:

```yaml
---
- name: Restart HTTPD if Postfix is Running
  hosts: all
  tasks:
    - name: Get Postfix server status
      ansible.builtin.command: /usr/bin/systemctl is-active postfix ![1](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/1.svg)
      register: result![2](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/2.svg)

    - name: Restart Apache HTTPD based on Postfix status
      ansible.builtin.service:
        name: httpd
        state: restarted
      when: result.rc == 0![3](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/3.svg)
```

