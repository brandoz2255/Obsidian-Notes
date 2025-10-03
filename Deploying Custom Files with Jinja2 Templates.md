 
[Deploying Custom Files with Jinja2 Templates](obsidian://open?file=Deploying%20Custom%20Files%20with%20Jinja2%20Templates.md)

## Core – Quick Reference

|Topic|Key Point|Example|
|---|---|---|
|**Template module**|Renders a Jinja2 file on the control node and copies it to the target|`ansible.builtin.template: src=templates/ssh.j2 dest=/etc/ssh/sshd_config`|
|**Delimiters**|`{{ expr }}` for values, `{% stmt %}` for logic, `{# comment #}` for non‑output comments|`{{ ansible_facts['hostname'] }}`|
|**Loop variable**|`loop.index` starts at 1, increments each iteration|`{% for user in users %}{{ user }}{% endfor %}`|
|**Conditional**|`{% if condition %}…{% endif %}`|`{% if finished %}{{ result }}{% endif %}`|
|**Filters**|Convert data to JSON/YAML, pretty‑print, or parse back|`{{ data|

---

## Information – Detailed Notes

Ansible’s `ansible.builtin.template` module is the preferred way to manage configuration files that need host‑specific values. It uses Jinja2, a powerful templating engine, to replace variables and execute logic before the file is transferred.

### Why use templates?

- **Consistency** – One source of truth for all hosts.
- **Automation** – No manual edits; changes propagate automatically.
- **Safety** – `ansible_managed` comment warns admins not to edit the file.

### How does Jinja2 work?

- Variables are wrapped in `{{ }}`.
- Control structures (`for`, `if`) are wrapped in `{% %}`.
- Comments are wrapped in `{# #}` and are stripped from the output.

### What are the common delimiters?

- `{{ expr }}` → value substitution.
- `{% stmt %}` → logic (loops, conditionals).
- `{# comment #}` → non‑output comment.

### What is `ansible_managed`?

A special string that can be set in `ansible.cfg` and inserted into templates to mark files as Ansible‑managed.

### What filters are useful?

- `to_json`, `to_yaml` – serialize data.
- `to_nice_json`, `to_nice_yaml` – pretty‑print.
- `from_json`, `from_yaml` – parse strings back into data structures.

---

## Information Subsection – How/What/Why Deep Dive

|Question|Answer|
|---|---|
|**How do loops reduce repetitive typing?**|By iterating over a list (e.g., `users`) and outputting each item, you avoid writing the same line multiple times.|
|**What is the purpose of `loop.index`?**|It provides the current iteration number (starting at 1), useful for numbering or conditional logic inside the loop.|
|**Why use `{% if finished %}` instead of a plain variable?**|It allows conditional inclusion of lines only when a specific condition is true, preventing unwanted configuration entries.|
|**How does the `validate` option help?**|It runs a command (e.g., `visudo -c`) before writing the file, ensuring syntax correctness and preventing misconfigurations.|
|**Why should templates have a `.j2` extension?**|It signals that the file is a Jinja2 template, improving readability and tooling support, though it’s not required.|

---

## Main – Code Snippets with Explanations

```yaml
# Deploy a Jinja2 template to /etc/ssh/sshd_config
- name: Render SSH config
  ansible.builtin.template:
    src: templates/ssh_config.j2   # Path to local Jinja2 file
    dest: /etc/ssh/sshd_config    # Destination on target host
    owner: root                   # File ownership
    group: root                   # File group
    mode: '0644'                  # File permissions
    validate: /usr/sbin/sshd -t -f %s   # Check syntax before writing
```

```jinja2
# templates/ssh_config.j2
# {{ ansible_managed }}  # Auto‑generated comment

Port {{ ssh_port }}  # SSH port from inventory/group_vars
ListenAddress {{ ansible_facts['default_ipv4']['address'] }}  # Host IP

# Conditional root login
{% if root_allowed %}
PermitRootLogin yes
{% else %}
PermitRootLogin no
{% endif %}

# Loop over allowed groups
{% for group in groups_allowed %}
AllowGroups {{ group }}
{% endfor %}
```

```jinja2
# templates/hosts.j2 – Generate /etc/hosts from all hosts
{% for host in groups['all'] %}
{{ hostvars[host]['ansible_facts']['default_ipv4']['address'] }}
  {{ hostvars[host]['ansible_facts']['fqdn'] }}
  {{ hostvars[host]['ansible_facts']['hostname'] }}
{% endfor %}
```

```jinja2
# Example of using a filter to pretty‑print JSON
{{ my_data | to_nice_json }}
```

---

## Research – What to Explore Next

- **Advanced Jinja2 filters**: `selectattr`, `rejectattr`, `sort`, `unique`.
- **Dynamic inventory**: Using host variables to drive template content.
- **Ansible Vault**: Encrypting sensitive variables used in templates.
- **Testing templates**: Using `ansible-playbook --check` and `--diff`.
- **SELinux context**: Setting `seuser`, `serole`, `setype` in the template module.

---

## Caveats – Things to Watch Out For

- **Variable precedence**: Inventory > group_vars > host_vars > playbook > defaults.
- **Template syntax errors**: A missing `{% endif %}` or typo in a variable name will cause the play to fail.
- **File permissions**: Ensure the target directory is writable by the user running the playbook.
- **Idempotence**: Templates are idempotent only if the rendered content is identical; otherwise, the file will be replaced.
- **Performance**: Rendering large templates on many hosts can increase playbook runtime.

- [[What is jinja2 and why its used in ansible]]

 ---
 
 `ansible.builtin` Ansible Content Collection provides a number of modules that can be used to modify existing files.

 include `lineinfile` and `blockinfile`, among others. However, they are not always easy to use effectively and correctly.

more powerful way to manage files is to _template_ them.

this method, you can write a template configuration file that is automatically customized for the managed host when the file is deployed, using Ansible variables and facts.

Ansible uses the Jinja2 templating system for template files. Ansible also uses Jinja2 syntax to reference variables in playbooks, so you already know a little about how to use it.

#### Using Delimiters

Variables and logic expressions are placed between tags, or _delimiters_. When a Jinja2 template is evaluated, the expression ``{{ _`EXPR`_ }}`` is replaced with the results of that expression

Jinja2 templates can also use ``{% _`EXPR`_ %}`` for special control structures or logic that loops over Jinja2 code or perform tests

use the ``{# _`COMMENT`_ #}`` syntax to enclose comments that should not appear in the final file.

The variable references in the second line are replaced with the values of the system facts being referenced.

```bash
{# /etc/hosts line #}
{{ ansible_facts['default_ipv4']['address'] }}    {{ ansible_facts['hostname'] }}
```

### Building a Jinja2 Template

A Jinja2 template is composed of multiple elements: data, variables, and expressions. Those variables and expressions are replaced with their values when the Jinja2 template is rendered.

### Note

A file containing a Jinja2 template does not need to have any specific file extension (for example, `.j2`). However, providing such a file extension might make it easier for you to remember that it is a template file.### Note

A file containing a Jinja2 template does not need to have any specific file extension (for example, `.j2`). However, providing such a file extension might make it easier for you to remember that it is a template file.

 template for `/etc/ssh/sshd_config` with variables and facts retrieved by Ansible from managed hosts.

```bash
# {{ ansible_managed }}
# DO NOT MAKE LOCAL MODIFICATIONS TO THIS FILE BECAUSE THEY WILL BE LOST

Port {{ ssh_port }}
ListenAddress {{ ansible_facts['default_ipv4']['address'] }}

HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key

SyslogFacility AUTHPRIV

PermitRootLogin {{ root_allowed }}
AllowGroups {{ groups_allowed }}

AuthorizedKeysFile /etc/.rht_authorized_keys .ssh/authorized_keys

PasswordAuthentication {{ passwords_allowed }}

ChallengeResponseAuthentication no

GSSAPIAuthentication yes
GSSAPICleanupCredentials no

UsePAM yes

X11Forwarding yes
UsePrivilegeSeparation sandbox

AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE
AcceptEnv XMODIFIERS

Subsystem sftp	/usr/libexec/openssh/sftp-server
```

### Deploying Jinja2 Templates

Jinja2 templates are a powerful tool that you can use to customize configuration files to be deployed on managed hosts.

 it can be deployed to managed hosts by using the `ansible.builtin.template` module, which supports the transfer of a local file on the control node to the managed hosts.

use the `ansible.builtin.template` module, use the following syntax. The value associated with the `src` key specifies the source Jinja2 template, and the value associated with the `dest` key specifies the file to be created on the destination hosts.

```yaml
tasks:
  - name: template render
    ansible.builtin.template:
      src: /tmp/j2-template.j2
      dest: /tmp/dest-config-file.txt
```

### Note

The `ansible.builtin.template` module also allows you to specify the owner (the user that owns the file), group, permissions, and SELinux context of the deployed file, just like the `ansible.builtin.file` module. It can also take a `validate` option to run an arbitrary command (such as `visudo` `-c`) to check the syntax of a file for correctness before templating it into place.

For more details, see `ansible-navigator doc ansible.builtin.template`.

### Managing Templated Files

To avoid having other system administrators modify files that are managed by Ansible, it is a good practice to include a comment at the top of the template to indicate that the file should not be manually edited.

 "Ansible managed" string set by the `ansible_managed` directive. This is not a normal variable but can be used as one in a template. You can set the value for `ansible_managed` in an `ansible.cfg` file:

```bash
ansible_managed = Ansible managed
```

To include the `ansible_managed` string inside a Jinja2 template, use the following syntax:

```bash
{{ ansible_managed }}
```

You can use Jinja2 control structures in template files to reduce repetitive typing, to enter entries for each host in a play dynamically, or conditionally insert text into a file.

#### Using Loops

Jinja2 uses the `for` statement to provide looping functionality. In the following example, the `users` variable has a list of values. The `user` variable is replaced with all the values in the `users` variable, one value per line.

```jinja2
{% for user in users %}
      {{ user }}
{% endfor %}
```

`loop.index` variable expands to the index number that the loop is currently on. It has a value of 1 the first time the loop executes, and it increments by 1 through each iteration.

`loop.index` variable expands to the index number that the loop is currently on. It has a value of 1 the first time the loop executes, and it increments by 1 through each iteration.


```jinja2
{% for myhost in groups['myhosts'] %}
{{ myhost }}
{% endfor %}
```

For a more practical example, you can use this example to generate an `/etc/hosts` file from host facts dynamically. Assume that you have the following playbook:

```yaml
- name: /etc/hosts is up to date
  hosts: all
  gather_facts: true
  tasks:
    - name: Deploy /etc/hosts
      ansible.builtin.template:
        src: templates/hosts.j2
        dest: /etc/hosts
```

 three-line `templates/hosts.j2` template constructs the file from all hosts in the group `all`.

```jinja2
{% for host in groups['all'] %}
{{ hostvars[host]['ansible_facts']['default_ipv4']['address'] }} {{ hostvars[host]['ansible_facts']['fqdn'] }} {{ hostvars[host]['ansible_facts']['hostname'] }}
{% endfor %}
```

Jinja2 uses the `if` statement to provide conditional control. This allows you to put a line in a deployed file if certain conditions are met.Jinja2 uses the `if` statement to provide conditional control. This allows you to put a line in a deployed file if certain conditions are met.

```jinja2
{% if finished %}
{{ result }}
{% endif %}
```

### Important

You can use Jinja2 loops and conditionals in Ansible templates, but not in Ansible Playbooks.

### Variable Filters

Jinja2 provides filters which change the output format for template expressions, essentially converting the data in a variable to some other format in the file that results from the template.

such as YAML and JSON. The `to_json` filter formats the expression output using JSON, and the `to_yaml` filter formats the expression output using YAML.

```jinja2
{{ _`output`_ | to_json }}
{{ _`output`_ | to_yaml }}
```

 such as the `to_nice_json` and `to_nice_yaml` filters, which format the expression output in either JSON or YAML human-readable format.

```jinja2
{{ _`output`_ | to_nice_json }}
{{ _`output`_ | to_nice_yaml }}
```

Both the `from_json` and `from_yaml` filters expect strings in either JSON or YAML format, respectively.

```jinja2
{{ _`output`_ | from_json }}
{{ _`output`_ | from_yaml }}
```

