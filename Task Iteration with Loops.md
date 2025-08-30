
## Cues

- **Loops** – repeat a task for many items.
- **`loop` keyword** – the modern way to write loops.
- **`with_*` syntax** – older style, still common in existing playbooks.
- **`register`** – capture the output of a looping task.
- **`item` variable** – holds the current value in each iteration.
- **Variables as loop lists** – use a variable that contains a list.
- **Dictionary loops** – loop over a list of dictionaries.
- **Conditional tasks** – use `when` to control when a task runs.

---

## Notes

Loops let you avoid writing the same task many times.  
Instead of two separate tasks that start `postfix` and `dovecot`, you can write one task that runs twice once for each service by looping over a list of service names.

### Modern `loop` syntax

```yaml
- name: Postfix and Dovecot are running
  ansible.builtin.service:
    name: "{{ item }}"
    state: started
  loop:
    - postfix
    - dovecot
```

- `item` is automatically set to each list element.
- The task runs once for `postfix`, once for `dovecot`.

### Using a variable as the loop list

```yaml
vars:
  mail_services:
    - postfix
    - dovecot

tasks:
  - name: Postfix and Dovecot are running
    ansible.builtin.service:
      name: "{{ item }}"
      state: started
    loop: "{{ mail_services }}"
```

This keeps the list in a variable, making the playbook easier to maintain.

### Looping over dictionaries

```yaml
- name: Users exist and are in the correct groups
  user:
    name: "{{ item['name'] }}"
    state: present
    groups: "{{ item['groups'] }}"
  loop:
    - name: jane
      groups: wheel
    - name: joe
      groups: root
```

- Each `item` is a dictionary.
- `item['name']` and `item['groups']` pull the values for that iteration.

### Older `with_*` syntax

Before Ansible 2.5, loops were written with `with_items`, `with_file`, etc.  
Example with `with_items`:

```yaml
vars:
  data:
    - user0
    - user1
    - user2

tasks:
  - name: "with_items"
    ansible.builtin.debug:
      msg: "{{ item }}"
    with_items: "{{ data }}"
```

These older forms are still found in many playbooks, but `loop` is the recommended style.

### Registering loop output

You can capture the result of a looping task and use it later:

```yaml
- name: Looping Echo Task
  ansible.builtin.shell: "echo This is my item: {{ item }}"
  loop:
    - one
    - two
  register: echo_results

- name: Show stdout from the previous task.
  ansible.builtin.debug:
    msg: "STDOUT from previous task: {{ item['stdout'] }}"
  loop: "{{ echo_results['results'] }}"
```

`echo_results` contains a `results` list; each element holds the output of one iteration.  
The second task loops over that list to print each `stdout` value.

---

## Summary (Code Blocks & Commands)

```yaml
# 1. Simple loop over services
- name: Postfix and Dovecot are running
  ansible.builtin.service:
    name: "{{ item }}"
    state: started
  loop:
    - postfix
    - dovecot
```

```yaml
# 2. Loop using a variable
vars:
  mail_services:
    - postfix
    - dovecot

tasks:
  - name: Postfix and Dovecot are running
    ansible.builtin.service:
      name: "{{ item }}"
      state: started
    loop: "{{ mail_services }}"
```

```yaml
# 3. Loop over dictionaries
- name: Users exist and are in the correct groups
  user:
    name: "{{ item['name'] }}"
    state: present
    groups: "{{ item['groups'] }}"
  loop:
    - name: jane
      groups: wheel
    - name: joe
      groups: root
```

```yaml
# 4. Older with_items syntax
vars:
  data:
    - user0
    - user1
    - user2

tasks:
  - name: "with_items"
    ansible.builtin.debug:
      msg: "{{ item }}"
    with_items: "{{ data }}"
```

```bash
# 5. Registering loop output
- name: Looping Echo Task
  ansible.builtin.shell: "echo This is my item: {{ item }}"
  loop:
    - one
    - two
  register: echo_results

- name: Show stdout from the previous task.
  ansible.builtin.debug:
    msg: "STDOUT from previous task: {{ item['stdout'] }}"
  loop: "{{ echo_results['results'] }}"
```




---

Writing Loops And Conditional tasks 

Use loops to write efficient tasks and use conditions to control when to run tasks 

loops makes it possible to avoid writing multiple tasks that use the same module  just like while loops and for loops for regular code 

If we want tasks to iterate tasks over a set of items u can use the loop can configure loops to repeat a task using each item  in a lost , the contents of each of the files in  a list 


A simplle loop iterates for a task over a list of items the `loop` keyword is added to the task and takes a value of list of items which the t ask should iterate thro 

the loop var `item` holds the value used during each iteration

that uses the `ansible.builtin.service` module twice to ensure that two network services are running:


```yaml
- name: Postfix is running
  ansible.builtin.service:
    name: postfix
    state: started

- name: Dovecot is running
  ansible.builtin.service:
    name: dovecot
    state: started
```


These two tasks can be rewritten to use a simple loop so that only one task is needed to ensure that both services are running:


```yaml
- name: Postfix and Dovecot are running
  ansible.builtin.service:
    name: "{{ item }}"
    state: started
  loop:
    - postfix
    - dovecot
```

The loop can use a list provided by a variable.

In the following example, the `mail_services` variable contains the list of services that need to be running.

```yaml
vars:
  mail_services:
    - postfix
    - dovecot

tasks:
  - name: Postfix and Dovecot are running
    ansible.builtin.service:
      name: "{{ item }}"
      state: started
    loop: "{{ mail_services }}"
```

The loop list does not need to be a list of simple values.

 Each dictionary in the example has two keys, `name` and `groups`, and the value of each key in the current `item` loop variable can be retrieved with the `item['name']` and `item['groups']` variables, respectively.

```yaml
- name: Users exist and are in the correct groups
  user:
    name: "{{ item['name'] }}"
    state: present
    groups: "{{ item['groups'] }}"
  loop:
    - name: jane
      groups: wheel
    - name: joe
      groups: root
```


The outcome of the preceding task is that the user `jane` is present and a member of the group `wheel`, and that the user `joe` is present and a member of the group `root`.

Earlier Style loop keywords  before ansible 2.5 most plays were used in a diffrent syntx for the loops 

most loops wer provided which use the `with_`

followed by the ansible look-up plugin 

his syntax for looping is very common in existing playbooks, but will probably be deprecated at some point in the future.

**Table 4.1. Earlier-style Ansible Loops**

| Loop keyword    | Description                                                                                                                                                                                                                                                                                        |
| :-------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `with_items`    | Behaves the same as the `loop` keyword for simple lists, such as a list of strings or a list of dictionaries. Unlike `loop`, if lists of lists are provided to `with_items`, they are flattened into a single-level list. The `item` loop variable holds the list item used during each iteration. |
| `with_file`     | Requires a list of control node file names. The `item` loop variable holds the content of a corresponding file from the file list during each iteration.                                                                                                                                           |
| `with_sequence` | Requires parameters to generate a list of values based on a numeric sequence. The `item` loop variable holds the value of one of the generated items in the generated sequence during each iteration.                                                                                              |



The following playbook shows an example of the `with_items` keyword:

```yaml
  vars:
    data:
      - user0
      - user1
      - user2
  tasks:
    - name: "with_items"
      ansible.builtin.debug:
        msg: "{{ item }}"
      with_items: "{{ data }}"
```

### Important

Since Ansible 2.5, the recommended way to write loops is to use the `loop` keyword.

However, you should still understand the earlier syntax, especially `with_items`, because it is widely used in existing playbooks. You are likely to encounter playbooks and roles that continue to use `with_*` keywords for looping.



#### Using Register Variables with Loops

The `register` keyword can also capture the output of a task that loops. The following snippet shows the structure of the `register` variable from a task that loops:

```bash
[student@workstation loopdemo]$ **`cat loop_register.yml`**
---
- name: Loop Register Test
  gather_facts: false
  hosts: localhost
  tasks:
    - name: Looping Echo Task
      ansible.builtin.shell: "echo This is my item: {{ item }}"
      loop:
        - one
        - two
      register: echo_results![1](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/1.svg)

    - name: Show echo_results variable
      ansible.builtin.debug:
        var: echo_results![2](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/2.svg)
```

```bash
[student@workstation loopdemo]$ **`ansible-navigator run -m stdout loop_register.yml`**

PLAY [Loop Register Test] ******************************************************

TASK [Looping Echo Task] *******************************************************
changed: [localhost] => (item=one)
changed: [localhost] => (item=two)

TASK [Show echo_results variable] **********************************************
ok: [localhost] => {
    "echo_results": {![1](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/1.svg)
        "changed": true,
        "msg": "All items completed",
        "results": [![2](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/2.svg)
            {![3](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/3.svg)
                "ansible_loop_var": "item",
                "changed": true,
                "cmd": "echo This is my item: one",
                "delta": "0:00:00.004519",
                "end": "2022-06-29 17:32:54.065165",
                "failed": false,
                _...output omitted..._
                "item": "one",
                "msg": "",
                "rc": 0,
                "start": "2022-06-29 17:32:54.060646",
                "stderr": "",
                "stderr_lines": [],
                **`"stdout": "This is my item: one",`**
                "stdout_lines": [
                    "This is my item: one"
                ]
            },
            {![4](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/4.svg)
                "ansible_loop_var": "item",
                "changed": true,
                "cmd": "echo This is my item: two",
                "delta": "0:00:00.004175",
                "end": "2022-06-29 17:32:54.296940",
                "failed": false,
                _...output omitted..._
                "item": "two",
                "msg": "",
                "rc": 0,
                "start": "2022-06-29 17:32:54.292765",
                "stderr": "",
                "stderr_lines": [],
                **`"stdout": "This is my item: two",`**
                "stdout_lines": [
                    "This is my item: two"
                ]
            }
        ],![5](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/5.svg)
        "skipped": false
    }
}
_...output omitted..._
```

|                                                                                                                                                                            |                                                                                                                                             |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| [![1](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/1.svg)](https://rha.ole.redhat.com/rha/app/#control-flow-_using_register_variables_with_loops-CO5-1) | The `{` character indicates that the start of the `echo_results` variable is composed of key-value pairs.                                   |
| [![2](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/2.svg)](https://rha.ole.redhat.com/rha/app/#control-flow-_using_register_variables_with_loops-CO5-2) | The `results` key contains the results from the previous task. The `[` character indicates the start of a list.                             |
| [![3](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/3.svg)](https://rha.ole.redhat.com/rha/app/#control-flow-_using_register_variables_with_loops-CO5-3) | The start of task metadata for the first item (indicated by the `item` key). The output of the `echo` command is found in the `stdout` key. |
| [![4](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/4.svg)](https://rha.ole.redhat.com/rha/app/#control-flow-_using_register_variables_with_loops-CO5-4) | The start of task result metadata for the second item.                                                                                      |
| [![5](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/5.svg)](https://rha.ole.redhat.com/rha/app/#control-flow-_using_register_variables_with_loops-CO5-5) | The `]` character indicates the end of the `results` list.                                                                                  |

In the preceding example, the `results` key contains a list. In the next example, the playbook is modified so that the second task iterates over this list:


```bash
[student@workstation loopdemo]$ **`cat new_loop_register.yml`**
---
- name: Loop Register Test
  gather_facts: false
  hosts: localhost
  tasks:
    - name: Looping Echo Task
      ansible.builtin.shell: "echo This is my item: {{ item }}"
      loop:
        - one
        - two
      register: echo_results

    - name: Show stdout from the previous task.
      ansible.builtin.debug:
        msg: "STDOUT from previous task: {{ item['stdout'] }}"
      loop: "{{ echo_results['results'] }}"
```


After running the preceding playbook, you see the following output: