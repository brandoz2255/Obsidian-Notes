
## 1. What are Ansible variables?

- Store data that can be reused across a playbook.
- Make projects easier to create, maintain, and less error‑prone.
- Can be set in many places: inventory, playbook, command line, etc.

## 2. Naming rules

| Invalid          | Valid                                 |
| ---------------- | ------------------------------------- |
| `web server`     | `web_server`                          |
| `remote.file`    | `remote_file`                         |
| `1st file`       | `file_1` or `file1`                   |
| `remoteserver$1` | `remote_server_1` or `remote_server1` |

> **Tip:** Pick a unique, descriptive name so you don’t accidentally override it later.

## 3. Variable scopes

| Scope      | Where it lives                               | Typical use                                |
| ---------- | -------------------------------------------- | ------------------------------------------ |
| **Global** | `ansible.cfg`, environment vars, CLI options | Settings that apply to all hosts           |
| **Play**   | `vars`, `vars_files`, role defaults          | Settings that apply to all hosts in a play |
| **Host**   | `host_vars`, inventory host vars, facts      | Settings that apply to a single host       |

## 4. Precedence (low → high)

1. Command‑line options (e.g., `-u my_user`) – _not_ variables
2. Role defaults (`roles/<role>/defaults/main.yml`)
3. Inventory group vars (`group_vars/all`, `group_vars/<group>`)
4. Playbook group vars (`group_vars/all`, `group_vars/<group>`)
5. Inventory host vars (`host_vars/<host>`)
6. Playbook host vars (`host_vars/<host>`)
7. Host facts & cached facts (`set_facts`, `gather_facts`)
8. Play vars (`vars`, `vars_prompt`, `vars_files`)
9. Role vars (`roles/<role>/vars/main.yml`)
10. Block vars (inside a `block`)
11. Task vars (inside a single task)
12. `include_vars`
13. Registered vars & `set_facts`
14. Role parameters (`role: <role>`, `vars:`)
15. Include parameters (`include_role`, `import_role`)
16. **Extra vars** (`-e user=joe`) – _always wins_

> **Rule of thumb:** The more specific the source, the higher the precedence.

## 5. Setting variables

### In a playbook

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

### In a role (defaults)

```yaml
# roles/web/defaults/main.yml
http_port: 80
```

### On the command line

```bash
ansible-playbook site.yml -e "user=alice"
```

### Overriding a host

```yaml
# host_vars/xyz.boston.example.com
ntp_server: override.example.com
```

## 6. Example: Multiple role instances

```yaml
- hosts: all
  roles:
    - role: app_user
      vars:
        myname: Ian
    - role: app_user
      vars:
        myname: Terry
    - role: app_user
      vars:
        myname: Graham
    - role: app_user
      vars:
        myname: John
```

Each role instance receives its own `myname` value, overriding the role’s default.

## 7. Quick checklist

- ✅ Use only letters, numbers, and underscores in names.
- ✅ Quote variables that start a value.
- ✅ Keep variable names unique to avoid precedence surprises.
- ✅ Store common defaults in `group_vars/all`.
- ✅ Override with `-e` or `--extra-vars` only when necessary.
- ✅ Understand the precedence order to predict which value wins.