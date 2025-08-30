
[Facts injected as vars](obsidian://open?file=Facts%20injected%20as%20vars.md)

**What does “facts injected as vars” mean?**

- Before Ansible 2.5, each fact was turned into a separate variable that started with `ansible_`.
- Example: the fact `ansible_facts['distribution']` became the variable `ansible_distribution`.
- Modern playbooks use the `ansible_facts.*` namespace, but the old style still works for backward compatibility.

---

## 1. Why the old style is discouraged

|Issue|Impact|
|---|---|
|**Name collisions**|A custom variable named `ansible_hostname` could overwrite the real fact.|
|**Harder to read**|Mixing two naming schemes can confuse readers.|
|**Future‑proofing**|Newer Ansible versions may drop support for the old style.|

---

## 2. Fact‑name comparison

|New syntax (`ansible_facts.*`)|Old syntax (`ansible_*`)|
|---|---|
|`ansible_facts['hostname']`|`ansible_hostname`|
|`ansible_facts['fqdn']`|`ansible_fqdn`|
|`ansible_facts['default_ipv4']['address']`|`ansible_default_ipv4['address']`|
|`ansible_facts['interfaces']`|`ansible_interfaces`|
|`ansible_facts['devices']['vda']['partitions']['vda1']['size']`|`ansible_devices['vda']['partitions']['vda1']['size']`|
|`ansible_facts['dns']['nameservers']`|`ansible_dns['nameservers']`|
|`ansible_facts['kernel']`|`ansible_kernel`|

---

## 3. Turning off the old style

```ini
# ansible.cfg
[defaults]
inject_facts_as_vars = false
```

- When set to `false`, only `ansible_facts.*` works; `ansible_*` references raise an error.
- Default is `true` (both styles available).

---

## 4. Disabling fact gathering

```yaml
- name: Play that skips automatic fact collection
  hosts: large_datacenter
  gather_facts: false
```

- Useful when you don’t need facts or the host can’t run `setup`.
- You can still collect facts later with a manual task:

```yaml
- name: Manually gather facts
  ansible.builtin.setup:
```

---

## 5. Selecting a subset of facts

```yaml
- name: Only hardware facts
  ansible.builtin.setup:
    gather_subset:
      - hardware
```

- Exclude a subset: `- "!hardware"` (quotes required in YAML).

---

## 6. Custom facts

|Type|Where it lives|How it’s used|
|---|---|---|
|**Static**|`/etc/ansible/facts.d/*.fact` (INI or JSON)|Loaded automatically by `setup`.|
|**Dynamic**|Executable script in `/etc/ansible/facts.d/` that prints JSON|Runs during `setup`.|

**Example INI custom fact**

```
[packages]
web_package = httpd
db_package = mariadb-server

[users]
user1 = joe
user2 = jane
```

**Equivalent JSON**

```json
{
  "packages": {
    "web_package": "httpd",
    "db_package": "mariadb-server"
  },
  "users": {
    "user1": "joe",
    "user2": "jane"
  }
}
```

- Custom facts appear under `ansible_facts['ansible_local']`.
- Example access: `ansible_facts['ansible_local']['custom']['packages']['web_package']`.

---

## 7. Quick cheat sheet

|What you want|Syntax|
|---|---|
|Hostname|`ansible_facts['hostname']`|
|Default IPv4|`ansible_facts['default_ipv4']['address']`|
|Custom fact (web package)|`ansible_facts['ansible_local']['custom']['packages']['web_package']`|
|Disable old style|`inject_facts_as_vars = false`|
|Skip fact gathering|`gather_facts: false`|

---

**Bottom line:**  
Use the `ansible_facts.*` namespace for clarity and future‑compatibility.  
Turn off the old `ansible_*` style if you’re not maintaining legacy playbooks.  
Custom facts let you add host‑specific data that behaves just like built‑in facts.

---

Ansible facts can be injected as vars 
since facts were always injected as individual variables prefixed with the string `ansible_` instead of the `ansible_facts` 

ariable. For example, the `ansible_facts['distribution']` fact was called `ansible_distribution`.

Many vars playbooks still use facts injected as vars instead of new syntax which use `ansible_facts` namespace

One reason why the ansible community discourage injecting facts as vavrs since it risks unexpected collision between facts and vars 


**Table 3.4. Comparison of Selected Ansible Fact Names**

|ansible_facts.* name|ansible_* name|
|:--|:--|
|`ansible_facts['hostname']`|`ansible_hostname`|
|`ansible_facts['fqdn']`|`ansible_fqdn`|
|`ansible_facts['default_ipv4']['address']`|`ansible_default_ipv4['address']`|
|`ansible_facts['interfaces']`|`ansible_interfaces`|
|`ansible_facts['devices']['vda']['partitions']['vda1']['size']`|`ansible_devices['vda']['partitions']['vda1']['size']`|
|`ansible_facts['dns']['nameservers']`|`ansible_dns['nameservers']`|
|`ansible_facts['kernel']`|`ansible_kernel`|


### Important

Currently, Ansible recognizes both the new fact-naming system (using `ansible_facts`) and the earlier, pre-2.5 "facts injected as separate variables" naming system.

You can disable the `ansible_` naming system by setting the `inject_facts_as_vars` parameter in the `[defaults]` section of the Ansible configuration file to `false`. The default setting is currently `true`.

If it is set to `false`, you can only reference Ansible facts using the new `ansible_facts.*` naming system. In that case, attempts to reference facts through the `ansible_*` namespace results in an error.


### Turning off Fact Gathering

Sometimes, you do not want to gather facts for your play. This might be for several reasons:

- You might not be using any facts and want to speed up the play, or reduce load caused by the play on the managed hosts.
    
- The managed hosts perhaps cannot run the `ansible.builtin.setup` module for some reason, or you need to install some prerequisite software before gathering facts.

To disable fact gathering for a play, set the `gather_facts` keyword to `false`:

```yaml
---
- name: This play does not automatically gather any facts
  hosts: large_datacenter
  gather_facts: false
```

Even if `gather_facts: false` is set for a play, you can manually gather facts at any time by running a task that uses the `ansible.builtin.setup` module:

```yaml
tasks:
    - name: Manually gather facts
      ansible.builtin.setup:
```


### Gathering a Subset of Facts

All facts are gathered by default. You can configure the `ansible.builtin.setup` module to only gather a subset of facts, instead of all facts. For example, to only gather hardware facts, set `gather_subset` to `hardware`:


```yaml
- name: Collect only hardware facts
  ansible.builtin.setup:
    gather_subset:
      - hardware
```

you want to gather all facts except a certain subset, add an exclamation point (!) in front of the subset name. Add quotes around the string because in YAML the exclamation point cannot be used at the start of an unquoted string.

```yaml
- name: Collect all facts except for hardware facts
  ansible.builtin.setup:
    gather_subset:
      - "!hardware"
```

### Creating Custom Facts

You can use _custom facts_ to define certain values for managed hosts. Plays can use custom facts to populate configuration files or conditionally run tasks.

Custom facts are stored locally on each managed host. These facts are integrated into the list of standard facts gathered by the `ansible.builtin.setup` module when it runs on the managed host.

You can statically define custom facts in an INI or JSON file, or you can generate them dynamically when you run a play. Dynamic custom facts are gathered via executable scripts, which generate JSON output.

By default, the `ansible.builtin.setup` module loads custom facts from files and scripts in the `etc/ansible/facts.d` directory of each managed host. The name of each file or script must end in `.fact` for it to be used. Dynamic custom fact scripts must output JSON-formatted facts and must be executable.

The following example static custom facts file is written in INI format. An INI-formatted custom facts file contains a top level defined by a section, followed by the key-value pairs of the facts to define:

```yaml
[packages]
web_package = httpd
db_package = mariadb-server

[users]
user1 = joe
user2 = jane
```

ou can provide the same facts in JSON format. The following JSON facts are equivalent to the facts specified by the INI format in the preceding example. The JSON data could be stored in a static text file or printed to standard output by an executable script:

```json
{
  "packages": {
    "web_package": "httpd",
    "db_package": "mariadb-server"
  },
  "users": {
    "user1": "joe",
    "user2": "jane"
  }
}
```

### Note

Custom fact files cannot be in YAML format like a playbook. JSON format is the closest equivalent.

When and why would i ever  need to make a Fact instead of a playbook? 

The `ansible.builtin.setup` module stores custom facts in the `ansible_facts['ansible_local']` variable. Facts are organized based on the name of the file that defined them. For example, assume that the `/etc/ansible/facts.d/custom.fact` file on the managed host produces the preceding custom facts. In that case, the value of 
`ansible_facts['ansible_local']['custom']['users']['user1']` is `joe`.


You can inspect the structure of your custom facts by gathering facts and using the `ansible.builtin.debug` module to display the contents of the `ansible_local` variable with a play similar to the following example:


```yaml
- name: Custom fact testing
  hosts: demo1.example.com
  gather_facts: true

  tasks:
    - name: Display all facts in ansible_local
      ansible.builtin.debug:
        var: ansible_local
```

When you run the play, you might see output similar to the following example:

```json
...output omitted..._
TASK [Display all facts in ansible_local] *********************************
ok: [demo1.example.com] => {
    "ansible_local": {
        "custom": {
            "packages": {
                "db_package": "mariadb-server",
                "web_package": "httpd"
            },
            "users": {
                "user1": "joe",
                "user2": "jane"
            }
        }
    }
}
_...output omitted..._
```

You can use custom facts the same way as default facts in playbooks:

```bash
[user@demo ~]$ **`cat playbook.yml`**
---
- hosts: all
  tasks:
  - name: Prints various Ansible facts
    ansible.builtin.debug:
      msg: >
           The package to install on {{ ansible_facts['fqdn'] }}
           is {{ ansible_facts['ansible_local']['custom']['packages']['web_package'] }}

[user@demo ~]$ **`ansible-navigator run -m stdout playbook.yml`**
PLAY [all] ***********************************************************************

TASK [Gathering Facts] *****************************************************
ok: [demo1.example.com]

TASK [Prints various Ansible facts] ****************************************
ok: [demo1.example.com] => {
    "msg": "The package to install on demo1.example.com is httpd"
}

PLAY RECAP *****************************************************************
demo1.example.com    : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

