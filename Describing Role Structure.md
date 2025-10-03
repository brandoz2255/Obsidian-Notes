

## 1️⃣ Core – Quick Reference

|Topic|Key Point|
|---|---|
|**Purpose**|Reusable, self‑contained unit of Ansible logic|
|**Structure**|Standard directory tree (`tasks/`, `handlers/`, `defaults/`, `vars/`, `files/`, `templates/`, `meta/`, `tests/`, `README.md`)|
|**Import vs Include**|`import_role` – static, parsed before run; `include_role` – dynamic, processed during run|
|**Roles Section**|Runs all listed roles _before_ any `tasks` in a play|
|**Variable Precedence**|`vars/` (high) → `defaults/` (low)|
|**Execution Order**|`pre_tasks` → `roles` → `tasks` → `post_tasks` (handlers run when notified)|

---

## 2️⃣ Info – Detailed Overview

### What is an Ansible Role?

A role is a bundle of tasks, variables, files, templates, and handlers that together perform a specific function (e.g., install a web server). By packaging these into a role, you can copy the directory into any project and invoke it with a single line in a playbook. Roles promote **code reuse**, **parallel development**, and **project modularity**.

### Why Use Roles?

- **Shareability** – Roles can be published to `Ansible` Galaxy or shared via Git.
- **Isolation** – Each role has its own namespace; variables and handlers don’t leak unless explicitly exposed.
- **Testing** – The `tests/` directory lets you create a minimal inventory and playbook to validate the role in isolation.
- **Consistency** – A standardized directory layout ensures that every team member knows where to find tasks, defaults, or templates.

### Directory Anatomy

|Directory|Typical Files|Purpose|
|---|---|---|
|`defaults/`|`main.yml`|Low‑precedence variables that can be overridden by the play|
|`vars/`|`main.yml`|High‑precedence internal variables; not meant for external override|
|`tasks/`|`main.yml`|Core task list that defines the role’s behavior|
|`handlers/`|`main.yml`|Handlers that can be notified by tasks|
|`files/`|Static files|Files copied to the target host|
|`templates/`|Jinja2 templates|Templates rendered with role variables|
|`meta/`|`main.yml`|Role metadata (author, dependencies, supported platforms)|
|`tests/`|`inventory`, `test.yml`|Minimal test harness for the role|
|`README.md`|Documentation|Usage instructions and examples|

### Variable Management

- **`defaults/main.yml`** – Lowest precedence; ideal for user‑configurable settings.
- **`vars/main.yml`** – Highest precedence; used for internal logic that should not be overridden.
- **Rule of thumb** – Define a variable in _either_ `defaults` _or_ `vars`, never both.

### Importing vs Including Roles

|Feature|`import_role`|`include_role`|
|---|---|---|
|**When processed**|Parse time (static)|Runtime (dynamic)|
|**Variable visibility**|Exposed to entire play|Scoped to the role|
|**Handlers**|Available throughout play|Scoped to the role|
|**Use case**|When role must be available to all tasks|When role should be conditional or looped|

### Roles Section in a Play

```yaml
---
- name: Deploy web stack
  hosts: webservers
  roles:
    - common          # runs first
    - webserver       # runs after common
```

Roles always run _before_ any tasks defined directly in the play. If you need to run a role conditionally or multiple times, use `import_role`/`include_role` inside the `tasks:` list.

### Execution Order (Illustrated)

```yaml
- name: Order demo
  hosts: all
  pre_tasks:
    - name: Pre‑task
      debug: msg="pre_tasks"
  roles:
    - role1
  tasks:
    - name: Main task
      debug: msg="tasks"
  post_tasks:
    - name: Post‑task
      debug: msg="post_tasks"
  handlers:
    - name: my_handler
      debug: msg="handler"
```

1. `pre_tasks` → 2. Handlers from `pre_tasks` → 3. `roles` → 4. `tasks` → 5. Handlers from roles/tasks → 6. `post_tasks` → 7. Handlers from `post_tasks`.

---

## 3️⃣ Summary – Code Snippets with Inline Comments

### Role Directory Example

```text
user.example/
├── defaults
│   └── main.yml          # default vars (low precedence)
├── files                 # static files to copy
├── handlers
│   └── main.yml          # role handlers
├── meta
│   └── main.yml          # metadata & dependencies
├── README.md             # role docs
├── tasks
│   └── main.yml          # core tasks
├── templates             # Jinja2 templates
├── tests
│   ├── inventory         # test inventory
│   └── test.yml          # test playbook
└── vars
    └── main.yml          # internal vars (high precedence)
```

### Importing a Role as a Task

```yaml
- name: Run role2 as a task
  hosts: remote.example.com
  tasks:
    - name: Normal debug task
      debug:
        msg: 'first task'
    - name: Import role2
      import_role:
        name: role2
```

_Comment:_ `import_role` pulls the entire role into the play at parse time, making its variables and handlers available to all subsequent tasks.

### Importing a Role with Variables

```yaml
- name: Run role2 with custom vars
  hosts: remote.example.com
  tasks:
    - name: Import role2
      import_role:
        name: role2
      vars:
        var1: val1
        var2: val2
```

_Comment:_ The `vars:` block overrides role defaults for this play only; the role’s internal logic sees `var1` and `var2`.

### Including a Role as a Task

```yaml
- name: Run role2 dynamically
  hosts: remote.example.com
  tasks:
    - name: Include role2
      include_role:
        name: role2
```

_Comment:_ `include_role` is evaluated during play execution, so the role runs only when this task is reached. Variables are scoped to the role.

### Roles Section with Variables

```yaml
- name: Deploy with role variables
  hosts: remote.example.com
  roles:
    - role1
    - role2
      var1: val1
      var2: val2
```

_Comment:_ Variables passed in the roles list are applied only to that role and are not visible to other roles or tasks.

### Duplicate Role Prevention

```yaml
roles:
  - { role: role1, service: "httpd" }   # runs once
  - { role: role2, var1: true }
  - { role: role1, service: "httpd" }   # ignored because identical
```

_Comment:_ Ansible de‑duplicates identical role lines; to run the same role twice, change at least one parameter.

---

## 4️⃣ Research – What to Explore Next

|Topic|Why It Matters|Suggested Resources|
|---|---|---|
|**Role Dependencies**|How to declare and manage role dependencies in `meta/main.yml`|Ansible docs: _Role Dependencies_|
|**Galaxy Publishing**|Steps to package and upload a role to Galaxy|Ansible Galaxy guide|
|**Testing Frameworks**|Using Molecule for role testing|Molecule documentation|
|**Variable Precedence**|Deep dive into Ansible’s variable precedence hierarchy|Ansible docs: _Variable precedence_|
|**Galaxy Search & Install**|Finding community roles that fit your needs|Ansible Galaxy website|

---

## 5️⃣ Caveats – Things to Watch Out For

- **Variable Overlap** – Never place the same variable in both `defaults/` and `vars/`; it causes confusion and hard‑to‑debug precedence issues.
- **Secrets in Roles** – Do **not** store passwords, keys, or other secrets inside a role. Keep them in inventory or vault files.
- **Role Re‑execution** – Roles listed in the `roles:` section run only once per play, even if repeated. Use `import_role`/`include_role` for multiple executions.
- **Handler Scope** – Handlers defined in a role are only triggered by tasks within that role unless the role is imported (`import_role`).
- **Dynamic Role Inclusion** – `include_role` cannot be looped or conditioned on a variable that changes during the play; it’s evaluated once when the task is reached.


---


# Describing Role Structure

Describe the purpose of an Ansible Role, its structure, and how roles are used in playbooks.

## Structuring Ansible Playbooks with Roles

As you develop more playbooks, you are likely to discover that you have many opportunities to reuse code from playbooks that you wrote previously. Perhaps, you could repurpose a play to configure a MySQL database for one application to configure a MySQL database for another application, with different hostnames, passwords, and users.

Ansible roles make it easier to reuse Ansible code generically. You can package all the tasks, variables, files, templates, and other resources needed to provision infrastructure or deploy applications in a standardized directory structure. Copy a role from project to project by copying the directory, then call the role within a play.

A well-written role can take variables passed from the playbook. These variables can adjust the behavior of the role, setting all the site-specific hostnames, IP addresses, usernames, secrets, or other locally-specific details.

## Benefits of Ansible Roles

Ansible roles have the following benefits:

- **Code Sharing**: Roles group content together, enabling easy sharing of code with others
- **System Definitions**: Roles can define the essential elements of a system type, such as a web server, database server, or Git repository
- **Project Management**: Roles make larger projects more manageable
- **Parallel Development**: Roles can be developed in parallel by different users
- **External Sources**: Obtain roles from distribution packages, Red Hat automation hub, private automation hubs, and Ansible Galaxy

Red Hat Enterprise Linux includes some roles in the `rhel-system-roles` package.

## Ansible Role Structure

An Ansible role is defined by a standardized structure of subdirectories and files. The top-level directory defines the name of the role itself.

### Example Role Directory Structure

```
user.example/
├── defaults
│   └── main.yml
├── files
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── README.md
├── tasks
│   └── main.yml
├── templates
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    └── main.yml
```

### Role Subdirectories

| Subdirectory | Function |
|--------------|----------|
| `defaults` | Contains default values of role variables that can be overwritten. These variables have low precedence and are intended to be changed and customized in plays. |
| `files` | Contains static files that are referenced by role tasks. |
| `handlers` | Contains the role's handler definitions in `main.yml`. |
| `meta` | Contains information about the role in `main.yml`, including author, license, platforms, and optional role dependencies. |
| `tasks` | Contains the role's task definitions in `main.yml`. |
| `templates` | Contains Jinja2 templates that are referenced by role tasks. |
| `tests` | Can contain an inventory and `test.yml` playbook that can be used to test the role. |
| `vars` | Defines the role's variable values in `main.yml`. Often used for internal purposes within the role. These variables have high precedence and are not intended to be changed when used in a playbook. |

**Note**: Not every role has all of these directories.

## Defining Variables and Defaults

### Role Variables (`vars/main.yml`)

- Defined by creating a `vars/main.yml` file with key-value pairs
- Referenced in role task files like any other variable: `{{ VAR_NAME }}`
- Have **high precedence** and cannot be overridden by inventory variables
- Used for internal functioning of the role

### Default Variables (`defaults/main.yml`)

- Enable you to set default values for variables that can be used in a play
- Defined by creating a `defaults/main.yml` file with key-value pairs
- Have the **lowest precedence** of any available variables
- Can be overridden by any other variable, including inventory variables
- Intended to provide customization and control options

### Variable Definition Rules

- Define a specific variable in **either** `vars/main.yml` **or** `defaults/main.yml`, but not both
- Use default variables when you intend that the variable values might be overridden
- **Do not** include site-specific data, secrets, passwords, or private keys in roles
- Roles should be generic, reusable, and freely shareable

## Using Ansible Roles in a Play

There are two primary methods to call roles in a play:

1. **Include or import** them like a task in your tasks list
2. **Create a roles list** that runs specific roles before your play's tasks

### Including and Importing Roles as Tasks

#### Using `ansible.builtin.import_role`

```yaml
- name: Run a role as a task
  hosts: remote.example.com
  tasks:
    - name: A normal task
      ansible.builtin.debug:
        msg: 'first task'
    - name: A task to import role2 here
      ansible.builtin.import_role:
        name: role2
```

**Characteristics of `import_role`:**
- **Static import** - parsed during initial playbook processing
- Role's handlers, default variables, and role variables are exposed to all tasks and roles in the play
- Can be accessed by tasks and roles that precede it in the play

#### Setting Variables with Import Role

```yaml
- name: Run a role as a task
  hosts: remote.example.com
  tasks:
    - name: A task to include role2 here
      ansible.builtin.import_role:
        name: role2
      vars:
        var1: val1
        var2: val2
```

#### Using `ansible.builtin.include_role`

```yaml
- name: Run a role as a task
  hosts: remote.example.com
  tasks:
    - name: A task to include role2 here
      ansible.builtin.include_role:
        name: role2
```

**Characteristics of `include_role`:**
- **Dynamic inclusion** - processed when the playbook is running
- Role variables and default variables are not exposed to the rest of the play

### Key Differences: Import vs Include

| Feature | `import_role` | `include_role` |
|---------|---------------|----------------|
| Processing | Static (parse time) | Dynamic (runtime) |
| Variable exposure | Variables exposed to entire play | Variables contained within role |
| Conditionals/Loops | Applied to each imported task | Applied to include decision |
| Handler access | Handlers available throughout play | Handlers contained within role |

## Using a Roles Section in a Play

### Basic Roles Section

```yaml
---
- name: A play that only has roles
  hosts: remote.example.com
  roles:
    - role: role1
    - role: role2
```

### Roles with Variables

```yaml
---
- name: A play that runs the second role with variables
  hosts: remote.example.com
  roles:
    - role: role1
    - role: role2
      var1: val1
      var2: val2
```

**Alternative syntax:**

```yaml
---
- name: A play that runs the second role with variables
  hosts: remote.example.com
  roles:
    - role: role1
    - { role: role2, var1: val1, var2: val2 }
```

### Important Role Execution Rules

1. **Roles run first** - before any tasks defined in the play
2. **Duplicate prevention** - Ansible looks for duplicate role lines; roles with exactly the same parameters only run once
3. **Order independence** - Position of roles section doesn't affect execution order

#### Duplicate Role Example

```yaml
# This only runs role1 once
roles:
  - { role: role1, service: "httpd" }
  - { role: role2, var1: true }
  - { role: role1, service: "httpd" }

# To run the same role twice, use different parameters
roles:
  - { role: role1, service: "httpd" }
  - { role: role2, var1: true }
  - { role: role1, service: "postfix" }
```

## Special Task Sections

### Complete Execution Order Example

```yaml
- name: Play to illustrate order of execution
  hosts: remote.example.com
  pre_tasks:
    - name: This task runs first
      ansible.builtin.debug:
        msg: This task is in pre_tasks
      notify: my handler
      changed_when: true
  roles:
    - role: role1
  tasks:
    - name: This task runs after the roles
      ansible.builtin.debug:
        msg: This task is in tasks
      notify: my handler
      changed_when: true
  post_tasks:
    - name: This task runs last
      ansible.builtin.debug:
        msg: This task is in post_tasks
      notify: my handler
      changed_when: true
  handlers:
    - name: my handler
      ansible.builtin.debug:
        msg: Running my handler
```

### Execution Order

1. **`pre_tasks`** - Run before any roles
2. **Handlers from pre_tasks** - Run if notified
3. **`roles`** - All roles run in order
4. **`tasks`** - Regular tasks run after roles
5. **Handlers from roles/tasks** - Run if notified
6. **`post_tasks`** - Run after everything else
7. **Handlers from post_tasks** - Run if notified

### Task Section Definitions

- **`pre_tasks`**: List of tasks that run before any roles
- **`roles`**: List of roles that run before regular tasks
- **`tasks`**: Regular tasks that run after roles
- **`post_tasks`**: Tasks that run after everything else
- **`handlers`**: Run when notified by other tasks

## Best Practices

1. **Avoid mixing roles and tasks** - Use either roles section or import/include tasks, not both
2. **Keep roles generic** - Don't hardcode site-specific information
3. **Use variables appropriately** - `defaults` for customization, `vars` for internal logic
4. **Consider multiple plays** - Instead of complex pre_tasks/post_tasks combinations
5. **Test roles independently** - Use the `tests` directory for role validation

## Common Patterns

### Simple Role Usage
```yaml
---
- name: Configure web servers
  hosts: webservers
  roles:
    - common
    - webserver
```

### Mixed Task and Role Usage
```yaml
---
- name: Deploy application
  hosts: appservers
  tasks:
    - name: Prepare system
      ansible.builtin.debug:
        msg: "Preparing system"
    
    - name: Apply base configuration
      ansible.builtin.import_role:
        name: common
    
    - name: Deploy application
      ansible.builtin.import_role:
        name: app_deploy
      vars:
        app_version: "{{ version | default('latest') }}"
```