
## 1. Host vs. Group Variables

|Type|Scope|Precedence|
|---|---|---|
|**Host vars**|Specific to a single host|Higher|
|**Group vars**|All hosts in a group|Lower|

> **Tip:** Put host‑specific data in `host_vars/` and group data in `group_vars/`.

## 2. Old‑School INI Style

```ini
[servers]
demo.example.com  ansible_user=joe
```

```ini
[servers]
demo1.example.com
demo2.example.com

[servers:vars]
user=joe
```

```ini
[servers1]
demo1.example.com
demo2.example.com

[servers2]
demo3.example.com
demo4.example.com

[servers:children]
servers1
servers2

[servers:vars]
user=joe
```

### Disadvantages

- Inventory file gets cluttered.
- Mixing host data and variables in one file.
- Uses obsolete syntax.

## 3. Recommended Directory Structure

```
project/
├── ansible.cfg
├── group_vars/
│   ├── datacenters
│   ├── datacenter1
│   └── datacenter2
├── host_vars/
│   ├── demo1.example.com
│   ├── demo2.example.com
│   ├── demo3.example.com
│   └── demo4.example.com
├── inventory
└── playbook.yml
```

- `group_vars/` and `host_vars/` can live **next to the inventory** or **next to the playbook**.
- If both exist, the playbook’s directories have higher precedence.

## 4. Overriding Variables

```bash
ansible-navigator run main.yml -e "package=apache"
```

Variables set in a playbook or via `-e` override those in inventory or group/host files.

## 5. Using Dictionaries for Complex Data

```yaml
# Flat style
user1_first_name: Bob
user1_last_name: Jones
user1_home_dir: /users/bjones
user2_first_name: Anne
user2_last_name: Cook
user2_home_dir: /users/acook
```

```yaml
# Dictionary style
users:
  bjones:
    first_name: Bob
    last_name: Jones
    home_dir: /users/bjones
  acook:
    first_name: Anne
    last_name: Cook
    home_dir: /users/acook
```

### Accessing Dictionary Values

```yaml
# Dot notation
users.bjones.first_name      # → 'Bob'
users.acook.home_dir         # → '/users/acook'

# Bracket notation (avoids method name conflicts)
users['bjones']['first_name']   # → 'Bob'
users['acook']['home_dir']      # → '/users/acook'
```

> **Important:**
> 
> - Dot notation can clash with Python method names (`copy`, `add`, etc.).
> - Use one syntax consistently across your project to simplify debugging.

## 6. Quick Checklist

- ✅ Keep host vars in `host_vars/`, group vars in `group_vars/`.
- ✅ Prefer dictionary style for multi‑field data.
- ✅ Use `-e` for temporary overrides.
- ✅ Stick to a single dictionary access style.
- ✅ Remember that playbook directories override inventory directories.








