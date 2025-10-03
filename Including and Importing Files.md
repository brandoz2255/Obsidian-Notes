


## 1️⃣ Core – Quick Reference

|Feature|Import (`import_*`)|Include (`include_*`)|
|---|---|---|
|**Processing**|Static – parsed before run|Dynamic – processed during run|
|**Conditionals**|Applied to each task|Applied to the include decision|
|**Loops**|❌ Not supported|✅ Supported|
|**`--list-tasks`**|Shows all imported tasks|Shows only the include task|
|**`--start-at-task`**|✅ Supported|❌ Not supported|
|**Handlers**|✅ Handlers can be notified|Limited – only in included files|
|**Variables**|Host/group vars limited|More flexible (vars, loop vars, etc.)|
|**Use‑case**|Fixed, reusable content|Runtime‑dependent content|

> **Tip:** Use `import_*` for static, reusable snippets; use `include_*` when the content depends on runtime data.

---

## 2️⃣ Info – Detailed Explanation

### Managing Large Playbooks

When a playbook grows beyond a few dozen tasks, split it into logical files (e.g., `web.yml`, `db.yml`). A _main_ playbook can import these, keeping the top‑level file concise and readable.

### Import vs Include

- **Import** (`import_playbook`, `import_tasks`) is resolved at _parse time_. The included content becomes part of the playbook’s static structure. This means all variables and conditionals are evaluated after the playbook is fully parsed.
- **Include** (`include_tasks`) is resolved at _runtime_. The playbook can decide whether to include a file based on variables, facts, or other dynamic data.

### Importing Playbooks

```yaml
- name: Prepare the web server
  ansible.builtin.import_playbook: web.yml

- name: Prepare the database server
  ansible.builtin.import_playbook: db.yml
```

_Each `import_playbook` line pulls an entire playbook into the current one. They must appear at the top level and cannot be nested inside a play._

### Importing Task Files

```yaml
- name: Install web server
  hosts: webservers
  tasks:
    - name: Import webserver tasks
      ansible.builtin.import_tasks: webserver_tasks.yml
```

_All tasks from `webserver_tasks.yml` are inserted into the current play at parse time. Conditionals (`when`) apply to each task individually._

### Including Task Files

```yaml
- name: Install web server
  hosts: webservers
  tasks:
    - name: Include webserver tasks
      ansible.builtin.include_tasks: webserver_tasks.yml
```

_The file is read during execution. The `when` clause decides whether the entire file is processed._

### Conditional Behavior

- **Import with `when`** – the condition is evaluated for every task in the file.
- **Include with `when`** – the condition decides if the file is read at all.

### Parameterizing External Files

```yaml
# task.yml (parameterized)
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

```yaml
# playbook.yml
tasks:
  - name: Import task file and set variables
    ansible.builtin.import_tasks: task.yml
    vars:
      package: httpd
      service: httpd
```

_Variables are passed at import time, allowing the same task file to be reused for different services._

### Directory Structure

```
project/
├── playbook.yml
├── tasks/
│   ├── webserver_tasks.yml
│   ├── database_tasks.yml
│   └── security_tasks.yml
└── vars/
    └── main.yml
```

_Organizing files this way keeps the project tidy and makes collaboration easier._

### Deprecated Module

`ansible.builtin.include` is deprecated. Use the specific modules (`import_playbook`, `import_tasks`, `include_tasks`) instead.

---

## 3️⃣ Main – Code Snippets with Explanations

|#|Code|Explanation|
|---|---|---|
|1|`yaml<br>- name: Import web server playbook<br> ansible.builtin.import_playbook: web.yml<br>`|Pulls the entire `web.yml` playbook into the current one at parse time.|
|2|`yaml<br>- name: Import tasks file<br> ansible.builtin.import_tasks: webserver_tasks.yml<br>`|Inserts all tasks from `webserver_tasks.yml` into the current play.|
|3|`yaml<br>- name: Include tasks file<br> ansible.builtin.include_tasks: webserver_tasks.yml<br>`|Reads `webserver_tasks.yml` during execution; useful when the decision to run depends on runtime data.|
|4|`yaml<br>- name: Import with condition<br> ansible.builtin.import_tasks: webserver_tasks.yml<br> when: ansible_facts['os_family'] == "RedHat"<br>`|Applies the `when` to each task in the file.|
|5|`yaml<br>- name: Include with condition<br> ansible.builtin.include_tasks: webserver_tasks.yml<br> when: ansible_facts['os_family'] == "RedHat"<br>`|Decides whether to read the file at all.|
|6|`yaml<br>- name: Import with variables<br> ansible.builtin.import_tasks: task.yml<br> vars:<br> package: httpd<br> service: httpd<br>`|Passes variables to the imported task file, enabling reuse.|

---

## 4️⃣ Research – What to Explore Next

- **Dynamic inventory**: How imports/ includes interact with host variables.
- **Role structure**: Using `tasks/main.yml` vs. separate task files inside roles.
- **Performance**: Benchmarking static vs. dynamic inclusion for large playbooks.
- **Error handling**: How failures in imported vs. included files propagate.
- **Testing**: Using Molecule to test imported task files in isolation.

---

## 5️⃣ Caveats – Things to Watch Out For

- **Import scope**: Imported tasks cannot reference variables defined _after_ the import line.
- **Include loops**: Loops (`loop`, `with_items`) work only with `include_tasks`, not `import_tasks`.
- **Handler notifications**: `notify` works with imported tasks but is limited with included tasks.
- **`--start-at-task`**: Only works with imports; included tasks cannot be targeted.
- **Deprecated module**: Avoid `ansible.builtin.include`; it will be removed in future Ansible releases.

---

# Including and Importing Files

Manage large playbooks by importing or including other playbooks or tasks from external files, either unconditionally or based on a conditional test.

## Managing Large Playbooks

When a playbook gets long or complex, you can divide it up into smaller files to make it easier to manage. You can combine multiple playbooks into a main playbook, or insert lists of tasks from a file into a play. This can make it easier to reuse plays or sequences of tasks in different projects.

## Including vs Importing Files

Ansible supports two operations for bringing content into a playbook:

- **Include content**: Dynamic operation - Ansible processes included content during the run of the playbook, as content is reached
- **Import content**: Static operation - Ansible preprocesses imported content when the playbook is initially parsed, before the run starts

## Importing Playbooks

Use the `ansible.builtin.import_playbook` module to import external files containing lists of plays into a playbook. You can have a main playbook that imports one or more additional playbooks.

### Basic Import Example

```yaml
- name: Prepare the web server
  ansible.builtin.import_playbook: web.yml

- name: Prepare the database server
  ansible.builtin.import_playbook: db.yml
```

### Interleaving Plays with Imports

```yaml
---
- name: Play 1
  hosts: localhost
  tasks:
    - name: Display a message
      ansible.builtin.debug:
        msg: Play 1

- name: Import Playbook
  ansible.builtin.import_playbook: play2.yml
```

**Important**: `ansible.builtin.import_playbook` can only be used at the top level of a playbook and cannot be used inside a play.

## Importing and Including Tasks

You can import or include a list of tasks from a task file into a play. A task file contains a flat list of tasks:

### Example Task File

```yaml
# webserver_tasks.yml
---
- name: Install the httpd package
  ansible.builtin.dnf:
    name: httpd
    state: latest

- name: Start the httpd service
  ansible.builtin.service:
    name: httpd
    state: started
```

## Importing Task Files

Use `ansible.builtin.import_tasks` to statically import a task file. Tasks are directly inserted when the playbook is parsed.

```yaml
---
- name: Install web server
  hosts: webservers
  tasks:
    - name: Import webserver tasks
      ansible.builtin.import_tasks: webserver_tasks.yml
```

### Import Tasks Considerations

- Conditional statements (`when`) are applied to **each** imported task
- **Cannot** use loops with `ansible.builtin.import_tasks`
- Cannot use host or group inventory variables to specify the file name
- Tasks appear in `--list-tasks` output
- Can use `--start-at-task` with imported tasks

## Including Task Files

Use `ansible.builtin.include_tasks` to dynamically include a task file. Content is processed during playbook execution.

```yaml
---
- name: Install web server
  hosts: webservers
  tasks:
    - name: Include webserver tasks
      ansible.builtin.include_tasks: webserver_tasks.yml
```

### Include Tasks Considerations

- Conditional statements (`when`) determine whether the include happens **at all**
- Can use loops with `ansible.builtin.include_tasks`
- Tasks **do not** appear in `--list-tasks` output
- **Cannot** use `--start-at-task` with included tasks
- **Cannot** use `notify` to trigger handlers in included files

## Conditionals with Import vs Include

### Import with Conditionals
```yaml
- name: Import tasks with condition
  ansible.builtin.import_tasks: webserver_tasks.yml
  when: ansible_facts['os_family'] == "RedHat"
```
**Result**: The `when` condition is applied to **every task** in `webserver_tasks.yml`

### Include with Conditionals
```yaml
- name: Include tasks with condition
  ansible.builtin.include_tasks: webserver_tasks.yml
  when: ansible_facts['os_family'] == "RedHat"
```
**Result**: The `when` condition determines whether to include the file. If included, **all tasks** run normally.

## Use Cases for Task Files

- **Server configuration sets**: Users, packages, services, privileges, file systems, hardening, updates, monitoring
- **Team collaboration**: Different teams maintain separate task files (developers, sysadmins, DBAs)
- **Conditional configurations**: Include tasks based on specific criteria
- **Group-specific tasks**: Run tasks only for specific host groups

## Managing Task Files

Create a dedicated directory structure:

```
project/
├── playbook.yml
├── tasks/
│   ├── webserver_tasks.yml
│   ├── database_tasks.yml
│   └── security_tasks.yml
└── vars/
    └── main.yml
```

## Parameterizing External Files

### Non-parameterized Task File
```yaml
---
- name: Install the httpd package
  ansible.builtin.dnf:
    name: httpd
    state: latest

- name: Start the httpd service
  ansible.builtin.service:
    name: httpd
    enabled: true
    state: started
```

### Parameterized Task File
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

### Using Variables with Tasks
```yaml
tasks:
  - name: Import task file and set variables
    ansible.builtin.import_tasks: task.yml
    vars:
      package: httpd
      service: httpd
```

### Using Variables with Playbooks
```yaml
- name: Import play file and set the variable
  ansible.builtin.import_playbook: play.yml
  vars:
    package: mariadb
```

## Import vs Include Summary

| Feature | Import | Include |
|---------|--------|---------|
| Processing | Static (parse time) | Dynamic (runtime) |
| Conditionals | Applied to each task | Applied to include decision |
| Loops | Not supported | Supported |
| --list-tasks | Shows individual tasks | Shows include task only |
| --start-at-task | Supported | Not supported |
| notify handlers | Supported | Limited support |
| Variables | Host/group vars limited | More flexible |

## Deprecated: ansible.builtin.include

**Important**: The `ansible.builtin.include` module is deprecated. Use the specific modules instead:

- `ansible.builtin.import_playbook` - for playbooks
- `ansible.builtin.import_tasks` - for static task inclusion  
- `ansible.builtin.include_tasks` - for dynamic task inclusion

## Best Practices

1. **Use import for static content** that doesn't change based on runtime conditions
2. **Use include for dynamic content** that depends on runtime variables or conditions
3. **Parameterize task files** with variables for maximum reusability
4. **Organize files** in logical directory structures
5. **Document dependencies** between playbooks and task files
6. **Test both imported and included content** thoroughly