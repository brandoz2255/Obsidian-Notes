## What are Ansible variables?

- **Variables** store data that can be reused throughout a playbook.
- They are similar to INI files but work for the whole project.
- Using variables makes a project easier to create, maintain, and less error‑prone.

## Naming rules

- Only letters, numbers, and underscores (`_`) are allowed.
- No spaces, dots, or special characters.

|Invalid variable names|Valid variable names|
|---|---|
|`web server`|`web_server`|
|`remote.file`|`remote_file`|
|`1st file`|`file_1`  <br>`file1`|
|`remoteserver$1`|`remote_server_1`  <br>`remote_server1`|

> **Tip:** Pick a unique, descriptive name so you don’t accidentally override it later.

## Where can you set a variable?

|Precedence (low → high)|Where to set it|
|---|---|
|Group variables in the inventory|`group_vars/`|
|Host variables in the inventory|`host_vars/`|
|Host facts (auto‑discovered)|–|
|Playbook variables (`vars`, `vars_files`)|In the playbook or external YAML files|
|Task variables|Inside a specific task|
|Extra vars on the command line|`ansible-navigator run -e "var=value"`|

> A variable set for **all hosts** can be overridden by a variable with the same name set for a **single host**.

## Defining variables

### In the playbook

```yaml
- hosts: all
  vars:
    user: joe
    home: /home/joe
```

### In an external file

```yaml
# vars/users.yml
user: joe
home: /home/joe
```

```yaml
- hosts: all
  vars_files:
    - vars/users.yml
```

## Using variables in tasks

```yaml
tasks:
  - name: Creates the user {{ user }}
    user:
      name: "{{ user }}"
```

> **Important:**  
> When a variable is the _first_ thing in a value, wrap it in quotes.  
> Without quotes, Ansible may think you’re starting a YAML dictionary.

```yaml
# ❌ Wrong
with_items:
  - {{ foo }}

# ✅ Correct
with_items:
  - "{{ foo }}"
```

## Quick checklist

- ✅ Use only letters, numbers, and underscores in names.
- ✅ Quote variables that start a value.
- ✅ Keep variable names unique to avoid precedence surprises.
- ✅ Store common variables in `group_vars/` or `host_vars/`.
- ✅ Use `vars_files` for large sets of variables.
- ✅ Override with `-e` or `--extra-vars` only when necessary.

- [[Where should i put a Variable]] [ansible](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable)