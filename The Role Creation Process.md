

## 1️⃣ Core – Quick‑Reference Facts

|Item|What It Means|Typical Value|
|---|---|---|
|**Role folder**|Ansible looks for roles inside a `roles/` sub‑directory of the playbook directory.|`roles/motd/`|
|**Skeleton command**|`ansible‑galaxy role init <name>` creates the full directory tree.|`ansible‑galaxy role init motd`|
|**Main task file**|`tasks/main.yml` contains the list of tasks that the role runs.|`- name: deliver motd file …`|
|**Templates**|Jinja2 files live in `templates/`.|`motd.j2`|
|**Defaults**|Low‑precedence variables live in `defaults/main.yml`.|`system_owner: user@host.example.com`|
|**Vars**|High‑precedence variables live in `vars/main.yml`.|–|
|**Handlers**|Optional `handlers/main.yml` for notifications.|–|
|**Meta**|`meta/main.yml` declares author, license, OS support, and role dependencies.|–|
|**README**|Human‑readable description and usage examples.|–|
|**Tests**|Optional `tests/` directory for Molecule or ad‑hoc test playbooks.|–|

---

## 2️⃣ Info – Detailed Process Overview

Creating an Ansible role is a **three‑step workflow** that requires no special IDEs or plugins.

1. **Build the skeleton** – Use the built‑in `ansible‑galaxy` tool to generate the directory tree.
2. **Write the role logic** – Add tasks, templates, defaults, and handlers.
3. **Document & test** – Keep a `README.md`, `meta/main.yml`, and optional test playbooks.

### Directory Anatomy

- **`README.md`** – Quick human‑readable description, examples, and prerequisites.
- **`meta/`** – Holds `main.yml` with author, license, supported Ansible versions, OS list, and role dependencies.
- **`defaults/`** – Low‑precedence variables that can be overridden by inventory, play‑vars, or inline role parameters.
- **`vars/`** – High‑precedence variables that _cannot_ be overridden by inventory or play‑vars.
- **`tasks/`** – Core logic lives in `tasks/main.yml`.
- **`templates/`** – Jinja2 files that the role can deploy.
- **`handlers/`** – Optional handlers triggered by tasks.
- **`files/`** – Static files that the role may copy.
- **`tests/`** – Optional integration tests (e.g., Molecule).

### Role Dependencies

Dependencies are declared in `meta/main.yml` under the `dependencies:` key.

```yaml
dependencies:
  - role: apache
    port: 8080
  - role: postgres
    dbname: serverlist
    admin_user: felix
```

When a role lists dependencies, Ansible automatically runs those roles _before_ the main role.

- **Duplicate prevention** – If the same dependency appears multiple times with identical attributes, it runs only once unless `allow_duplicates: yes` is set.
- **Best practice** – Keep dependencies to a minimum; they make maintenance harder.

---

## 3️⃣ Summary – Code Snippets with Inline Comments

### Skeleton Creation

```bash
# Create the role directory tree
ansible-galaxy role init motd
```

_Comment:_ `ansible-galaxy` scaffolds the standard role layout, giving you a ready‑to‑edit folder structure.

### Main Task File (`tasks/main.yml`)

```yaml
---
# tasks file for motd

- name: deliver motd file
  ansible.builtin.template:
    src: motd.j2          # source template in role's templates/
    dest: /etc/motd       # destination on the target host
    owner: root
    group: root
    mode: 0444            # read‑only for all users
```

_Comment:_ This task uses the `template` module to copy `motd.j2` to `/etc/motd` with the specified ownership and permissions.

### Template (`templates/motd.j2`)

```jinja2
This is the system {{ ansible_facts['hostname'] }}.

Today's date is: {{ ansible_facts['date_time']['date'] }}.

Only use this system with permission.
You can ask {{ system_owner }} for access.
```

_Comment:_ The Jinja2 template pulls in Ansible facts (hostname, date) and a role variable `system_owner` that can be overridden by the playbook.

### Default Variable (`defaults/main.yml`)

```yaml
---
system_owner: user@host.example.com
```

_Comment:_ Provides a fallback value for `system_owner` that can be overridden by inventory, play‑vars, or inline role parameters.

### Role Usage – Inline Parameters

```yaml
---
- name: Configure systems with MOTD
  hosts: all
  become: true
  roles:
    - role: motd
      system_owner: admin@company.com
```

_Comment:_ The `system_owner` value supplied here replaces the default defined in the role, demonstrating high‑precedence inline role parameters.

### Role Usage – Play‑Vars Override

```yaml
---
- name: Configure systems with MOTD
  hosts: all
  become: true
  vars:
    system_owner: admin@company.com
  roles:
    - motd
```

_Comment:_ Play‑vars also override the role’s defaults, but cannot override variables defined in `vars/`.

### Dependency Declaration (`meta/main.yml`)

```yaml
---
galaxy_info:
  author: "Your Name"
  description: "Installs and configures a web server."
  license: "MIT"
  min_ansible_version: 2.9
  platforms:
    - name: EL
      versions: [7, 8]
dependencies:
  - role: apache
    port: 8080
  - role: postgres
    dbname: serverlist
    admin_user: felix
```

_Comment:_ `galaxy_info` documents the role; `dependencies` list other roles that must run first. The `allow_duplicates` flag can be set to `yes` if the same dependency needs to run multiple times.

---

## 4️⃣ Research – What to Explore Next

|Topic|Why It Matters|Suggested Resources|
|---|---|---|
|**Molecule Testing**|Learn how to write integration tests that spin up VMs or containers.|Molecule docs: [https://molecule.readthedocs.io/](https://molecule.readthedocs.io/)|
|**Ansible Vault**|Securely store sensitive variables that roles might use.|Ansible docs: _Vault_|
|**Role Versioning**|Understand semantic versioning for roles on Galaxy.|Ansible Galaxy guide|
|**Best‑Practice Playbooks**|Study real‑world playbooks that use many roles.|Red Hat COP Good Practices|
|**Ansible Lint**|Static analysis tool to catch common mistakes.|Ansible‑Lint docs|

---

## 5️⃣ Caveats – Things to Watch Out For

1. **Variable Precedence Confusion** – Remember that `vars/main.yml` has higher precedence than `defaults/main.yml`, but both can be overridden by inline role parameters.
2. **Sensitive Data** – Never hard‑code passwords or SSH keys inside a role. Pass them in from inventory or a vault file.
3. **Duplicate Dependencies** – If two roles depend on the same role with identical parameters, Ansible runs it only once unless `allow_duplicates: yes` is set.
4. **Empty Sub‑directories** – An empty `files/`, `templates/`, or other folder is ignored; you can delete it entirely.
5. **Large Dependency Trees** – Excessive role dependencies make the role fragile and harder to maintain. Keep them minimal.
6. **Testing Is Optional** – Roles that are never tested may silently break downstream playbooks.
7. **Documentation Is Key** – A missing or outdated `README.md` or `meta/main.yml` can make a role unusable for others.



---
# The Role Creation Process

Creating roles in Ansible does not require any special development tools.

Creating and using a role is a three-step process:

1. Create the role directory structure
2. Define the role content
3. Use the role in a playbook

## Creating the Role Directory Structure

Ansible looks for roles in a subdirectory called `roles` in the directory containing your Ansible Playbook. Each role has its own directory with a standardized directory structure. This structure allows you to store roles with the playbook and other supporting files.

### Example Role Directory Structure

```
[user@host ~]$ tree roles/
roles/
└── motd
    ├── defaults
    │   └── main.yml
    ├── files
    ├── handlers
    ├── meta
    │   └── main.yml
    ├── README.md
    ├── tasks
    │   └── main.yml
    └── templates
        └── motd.j2
```

### Directory Components

- **`README.md`**: Provides a basic human-readable description of the role, documentation, examples of how to use it, and any non-Ansible role requirements
- **`meta`**: Contains a `main.yml` file that specifies information about the author, license, compatibility, and dependencies for the module
- **`files`**: Contains fixed content files
- **`templates`**: Contains templates that the role can deploy
- **Other subdirectories**: Can contain `main.yml` files that define default variable values, handlers, tasks, role metadata, or variables

**Note**: If a subdirectory exists but is empty, it is ignored. You can omit the subdirectory altogether if the role does not use a feature.

## Creating a Role Skeleton

You can create all the subdirectories and files needed for a new role by using standard Linux commands. Alternatively, command-line utilities exist to automate the process of new role creation.

### Using ansible-galaxy

The `ansible-galaxy` command-line tool is used to manage Ansible roles, including the creation of new roles. You can run `ansible-galaxy role init` to create the directory structure for a new role.

```bash
[user@host playbook-project]$ cd roles
[user@host roles]$ ansible-galaxy role init my_new_role
- Role my_new_role was created successfully
[user@host roles]$ ls my_new_role/
defaults  files  handlers  meta  README.md  tasks  templates  tests  vars
```

## Defining the Role Content

After creating the directory structure, you must write the content of the role. A good place to start is the `ROLENAME/tasks/main.yml` task file, the main list of tasks that the role runs.

### Example: tasks/main.yml

The following `tasks/main.yml` file manages the `/etc/motd` file on managed hosts. It uses the template module to deploy the template named `motd.j2` to the managed host.

```yaml
[user@host ~]$ cat roles/motd/tasks/main.yml
---
# tasks file for motd

- name: deliver motd file
  ansible.builtin.template:
    src: motd.j2
    dest: /etc/motd
    owner: root
    group: root
    mode: 0444
```

### Example: templates/motd.j2

The following command displays the contents of the `motd.j2` template of the motd role. It references Ansible facts and a `system_owner` variable.

```jinja2
[user@host ~]$ cat roles/motd/templates/motd.j2
This is the system {{ ansible_facts['hostname'] }}.

Today's date is: {{ ansible_facts['date_time']['date'] }}.

Only use this system with permission.
You can ask {{ system_owner }} for access.
```

### Example: defaults/main.yml

The role defines a default value for the `system_owner` variable. The `defaults/main.yml` file in the role's directory structure is where this value is set.

```yaml
[user@host ~]$ cat roles/motd/defaults/main.yml
---
system_owner: user@host.example.com
```

This email address is written in the `/etc/motd` file of managed hosts when this role is applied.

## Recommended Practices for Role Content Development

Roles allow you to break down playbooks into multiple files, resulting in reusable code. To maximize the effectiveness of newly developed roles, consider implementing the following recommended practices:

### Development Best Practices

1. **Version Control**: Maintain each role in its own version control repository. Ansible works well with Git-based repositories.

2. **Use Variables**: Use variables to configure roles so that you can reuse the role to perform similar tasks in similar circumstances.

3. **Avoid Sensitive Information**: Avoid storing sensitive information in a role, such as passwords or SSH keys. Configure role variables that are used to contain sensitive values when called in a play with default values that are not sensitive.

4. **Use ansible-galaxy**: Use the `ansible-galaxy role init` command to start your role, and then remove any unnecessary files and directories.

5. **Documentation**: Create and maintain `README.md` and `meta/main.yml` files to document the role's purpose, author, and usage.

6. **Single Purpose**: Keep your role focused on a specific purpose or function. Instead of making one role do many things, write more than one role.

7. **Reuse**: Reuse roles often.

8. **Refactor vs Create**: Resist creating new roles for edge configurations. If an existing role accomplishes most of the required configuration, refactor the existing role to integrate the new configuration scenario.

9. **Testing**: Use integration and regression testing techniques to ensure that the role provides the required new functionality and does not cause problems for existing playbooks.

**Note**: A longer unofficial list of good practices to follow when you write a role is available from [Ansible Good Practices](https://redhat-cop.github.io/automation-good-practices/#_roles_good_practices_for_ansible).

## Changing a Role's Behavior with Variables

A well-written role uses default variables to alter the role's behavior to match a related configuration scenario. Roles that use variables are more generic and reusable in a variety of contexts.

### Variable Override Precedence

The value of any variable defined in a role's defaults directory is overwritten if that same variable is defined:

- In an inventory file, either as a host variable or a group variable
- In a YAML file under the `group_vars` or `host_vars` directories of a playbook project
- As a variable nested in the `vars` keyword of a play
- As a variable when including the role in `roles` keyword of a play

### Example: Using Variables in Play vars

```yaml
[user@host ~]$ cat use-motd-role.yml
---
- name: use motd role playbook
  hosts: remote.example.com
  remote_user: devops
  become: true
  vars:
    system_owner: someone@host.example.com
  roles:
    - role: motd
```

When defined in this way, the `system_owner` variable replaces the value of the default variable of the same name. Any variable definitions nested within the `vars` keyword do not replace the value of the same variable if defined in a role's `vars` directory.

### Example: Using Variables as Role Parameters

```yaml
[user@host ~]$ cat use-motd-role.yml
---
- name: use motd role playbook
  hosts: remote.example.com
  remote_user: devops
  become: true
  roles:
    - role: motd
      system_owner: someone@host.example.com
```

The value specified, `someone@host.example.com`, replaces the variable reference regardless of being defined in the role's `vars` or `defaults` directory.

## Variable Precedence with Roles

Variable precedence can be confusing when working with role variables in a play.

### Default Variables (defaults/main.yml)
**Lower Precedence** - Most other variables override a role's default variables:
- Inventory variables
- Play vars
- Inline role parameters
- And many others

### Role Variables (vars/main.yml)
**Higher Precedence** - Fewer variables can override variables defined in a role's `vars` directory:
- Facts
- Variables loaded with `include_vars`
- Registered variables
- Role parameters
- **Cannot be overridden by**: Inventory variables and play vars

### Role Parameters
**Very High Precedence** - Variables declared inline as role parameters:
- Can override variables defined in a role's `vars` directory
- Override variables set in play vars, role's vars, inventory, or playbook variables

## Defining Role Dependencies

Role dependencies allow a role to include other roles as dependencies. For example, a role that defines a documentation server might depend upon another role that installs and configures a web server.

### Dependencies Configuration

Dependencies are defined in the `meta/main.yml` file in the role directory hierarchy.

```yaml
---
dependencies:
  - role: apache
    port: 8080
  - role: postgres
    dbname: serverlist
    admin_user: felix
```

### Additional meta/main.yml Content

A `meta/main.yml` file might also have a top-level `galaxy_info` key that has a dictionary of other attributes that specify:
- Author
- Purpose
- License
- Versions of Ansible Core that the role supports
- Operating systems that the role supports

### Dependency Execution Rules

- **Default behavior**: If multiple roles have a dependency on a role, and that role is called by different roles in the play multiple times with the same attributes, then the role only runs the first time it appears
- **Override behavior**: This behavior can be overridden by setting the `allow_duplicates` variable to `yes` in your role's `meta/main.yml` file

### Dependency Best Practice

**Important**: Limit your role's dependencies on other roles. Dependencies make it harder to maintain your role, especially if it has many complex dependencies.

## Role Creation Workflow Summary

1. **Initialize**: Use `ansible-galaxy role init ROLENAME` to create the directory structure
2. **Define Tasks**: Write the main task logic in `tasks/main.yml`
3. **Create Templates**: Add any Jinja2 templates to the `templates/` directory
4. **Set Defaults**: Define default variables in `defaults/main.yml`
5. **Add Handlers**: Create handlers in `handlers/main.yml` if needed
6. **Document**: Update `README.md` and `meta/main.yml` with role information
7. **Test**: Create test playbooks in the `tests/` directory
8. **Use**: Include the role in your playbooks

## Example Complete Role Usage

```yaml
---
- name: Configure systems with MOTD
  hosts: all
  become: true
  roles:
    - role: motd
      system_owner: admin@company.com
```

This workflow ensures your roles are well-structured, documented, and reusable across different projects and environments.