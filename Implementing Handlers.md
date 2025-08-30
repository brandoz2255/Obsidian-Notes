
## Core – Quick Reference

|Concept|What it is|Why it matters|
|---|---|---|
|**Handler**|A special task that runs only when _notified_ by another task that changed the system|Keeps services in sync with configuration changes without running every time|
|**`notify`**|Statement in a task that names one or more handlers|Triggers the handler only when the task reports a change|
|**`changed`**|Result flag returned by a task|Handlers fire **only** when a task actually changes something|
|**`handlers:`**|Keyword that starts the handler list|Marks the end of normal tasks and the start of “inactive” tasks|
|**Unique names**|Each handler must have a unique name within a play|Prevents accidental double‑execution or missing restarts|
|**Execution order**|Handlers run **once** after all normal tasks finish, in the order listed under `handlers:`|Guarantees that all changes are applied before the service restarts|

---

## Info – Processed Details

### How do handlers work?

1. A task runs normally.
2. If the task reports `changed`, it _notifies_ one or more handlers by name.
3. After **all** tasks in the play finish, Ansible scans the `handlers:` section.
4. Each notified handler runs **once** (even if many tasks notified it).
5. Handlers run in the order they appear under `handlers:`, not the order they were notified.

### What are handlers used for?

- Reloading or restarting services after a configuration file changes.
- Performing cleanup or additional steps that should only happen when a change occurs.
- Keeping playbooks idempotent: normal tasks keep the system in the desired state; handlers react to those changes.

### Why not use handlers as regular tasks?

- Handlers are “inactive” until triggered; they’re not executed on every run.
- Using them as normal tasks would break idempotency and make the playbook harder to read.
- Handlers keep the playbook clean: configuration changes stay in `tasks:`, restarts stay in `handlers:`.

### Common Questions

|Question|Answer|
|---|---|
|**How do I notify multiple handlers?**|Use a list under `notify:` – Ansible iterates over the names.|
|**What happens if two handlers share a name?**|Only the first one runs; the second is ignored.|
|**When does a handler run?**|After all tasks finish, if at least one task changed something.|
|**Can a handler run more than once?**|No – it runs a single time per play, regardless of how many tasks notified it.|

---

## Main – Code & Explanations

### 1. Basic Example – Restart Apache After Template Change

```yaml
---
# Normal tasks that copy a configuration file
tasks:
  - name: copy demo.example.conf configuration template
    ansible.builtin.template:
      src: /var/lib/templates/demo.example.conf.template
      dest: /etc/httpd/conf.d/demo.example.conf
    # Notify the handler only if the file was actually changed
    notify: restart apache

# Handlers section – inactive tasks that run only when notified
handlers:
  - name: restart apache
    ansible.builtin.service:
      name: httpd
      state: restarted
```

_What this does:_

- The `template` task updates `/etc/httpd/conf.d/demo.example.conf`.
- If the file changed, Ansible marks the task as `changed` and sends a notification to the handler named **restart apache**.
- After all tasks finish, the handler runs once, restarting the `httpd` service so the new config takes effect.

---

### 2. Multiple Handlers from One Task

```yaml
---
tasks:
  - name: copy demo.example.conf configuration template
    ansible.builtin.template:
      src: /var/lib/templates/demo.example.conf.template
      dest: /etc/httpd/conf.d/demo.example.conf
    # Notify two handlers – both will be queued
    notify:
      - restart mysql
      - restart apache

handlers:
  - name: restart mysql
    ansible.builtin.service:
      name: mariadb
      state: restarted

  - name: restart apache
    ansible.builtin.service:
      name: httpd
      state: restarted
```

_What this does:_

- The same task can trigger **both** `restart mysql` and `restart apache`.
- Ansible treats the `notify:` list as an array and queues each handler.
- After all tasks finish, both handlers run once each, in the order they appear under `handlers:`.

---

### 3. Handler Execution Order

```yaml
---
# Normal tasks
tasks:
  - name: install package
    ansible.builtin.yum:
      name: httpd
      state: present
    notify: restart apache

  - name: configure service
    ansible.builtin.template:
      src: httpd.conf.j2
      dest: /etc/httpd/conf/httpd.conf
    notify: restart apache

# Handlers – order matters here
handlers:
  - name: restart apache
    ansible.builtin.service:
      name: httpd
      state: restarted

  - name: reload nginx
    ansible.builtin.service:
      name: nginx
      state: reloaded
```

_What this does:_

- Even though both tasks notify `restart apache`, the handler runs **once** after all tasks finish.
- Handlers run in the order listed under `handlers:`, not the order they were notified.

---

### 4. When Handlers Do Not Run

```yaml
---
tasks:
  - name: ensure httpd is installed
    ansible.builtin.yum:
      name: httpd
      state: present
    # If httpd is already installed, the task reports `ok` (no change)
    notify: restart apache

handlers:
  - name: restart apache
    ansible.builtin.service:
      name: httpd
      state: restarted
```

_What this does:_

- The task reports `ok` because the package is already present.
- Since no change occurred, the handler is **not** notified, so `httpd` is not restarted.

---

## Info – Processed Details

### How do handlers improve automation?

- **Idempotency**: Normal tasks keep the system in the desired state without unnecessary changes.
- **Efficiency**: Handlers run only when needed, avoiding repeated restarts or reloads.
- **Clarity**: Separating “change” logic (tasks) from “reaction” logic (handlers) makes playbooks easier to read.

### What are the key rules to remember?

1. **Unique names** – Two handlers with the same name conflict; only one runs.
2. **Per‑play namespace** – Handler names are local to each play.
3. **Single execution** – Even if many tasks notify a handler, it runs once.
4. **Change‑only notification** – Handlers fire only when a task reports `changed`.
5. **Post‑task execution** – Handlers run after all tasks in the play finish.

### Why not use handlers as regular tasks?

- Handlers are designed for _reactive_ actions (e.g., restarting a service after a config change).
- Using them as normal tasks would break idempotency and make the playbook harder to understand.

### Further Exploration Questions

|Question|Answer|
|---|---|
|**How can I debug which handlers ran?**|Use `-vvv` or `--check` to see handler execution in the output.|
|**What happens if a handler fails?**|The play stops unless you use `ignore_errors: yes` on the handler.|
|**Can I run a handler immediately?**|No – handlers always run after all tasks finish, but you can use `meta: flush_handlers` to force them earlier.|

---

## Research – What’s Next?

1. **Explore `meta: flush_handlers`** – Learn how to trigger handlers mid‑play.
2. **Study handler priorities** – Understand how to control the order of multiple handlers.
3. **Read the official Ansible docs** – [Handlers: running operations on change](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_handlers.html).
4. **Practice with real services** – Create a playbook that updates Nginx or MySQL configs and uses handlers to reload them.

By mastering handlers, you’ll write playbooks that are both efficient and reliable, ensuring services only restart when truly necessary.





---
Ansible modules are designed to be `idempotent` which means if we run one play multiple times the result is always the same we can run plays and their tasks multiple times but managed host are only changed if those  chagnes are required to get the managed host to the desired state 

However, sometimes when a task does make a change to the system, a further task might need to be run.

example, a change to a service's configuration file might then require that the service be reloaded so that the changed configuration takes effect.

_Handlers_ are tasks that respond to a notification triggered by other tasks

 Tasks only notify their handlers when the task changes something on a managed host.

Each handler is triggered by its name after the play's block of tasks.

If no task notifies the handler by name then the handler does not run

If one or more tasks notify the handler, the handler runs once after all other tasks in the play

### Important

Always use unique names for your handlers. You might have unexpected results if more than one handler uses the same name.

Handlers can be considered as _inactive_ tasks that only get triggered when explicitly invoked using a `notify` statement.

 how the Apache server is only restarted by the `restart apache` handler when a configuration file is updated and notifies it:

```yaml
tasks:
  - name: copy demo.example.conf configuration template![1](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/1.svg)
    ansible.builtin.template:
      src: /var/lib/templates/demo.example.conf.template
      dest: /etc/httpd/conf.d/demo.example.conf
    notify:![2](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/2.svg)
      - restart apache![3](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/3.svg)

handlers:![4](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/4.svg)
  - name: restart apache![5](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/5.svg)
    ansible.builtin.service:![6](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/6.svg)
      name: httpd
      state: restarted
```

|   |   |
|---|---|
|[![1](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/1.svg)](https://rha.ole.redhat.com/rha/app/#control-handlers-_ansible_handlers-CO7-1)|The task that notifies the handler.|
|[![2](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/2.svg)](https://rha.ole.redhat.com/rha/app/#control-handlers-_ansible_handlers-CO7-2)|The `notify` statement indicates the task needs to trigger a handler.|
|[![3](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/3.svg)](https://rha.ole.redhat.com/rha/app/#control-handlers-_ansible_handlers-CO7-3)|The name of the handler to run.|
|[![4](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/4.svg)](https://rha.ole.redhat.com/rha/app/#control-handlers-_ansible_handlers-CO7-4)|The `handlers` keyword indicates the start of the list of handler tasks.|
|[![5](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/5.svg)](https://rha.ole.redhat.com/rha/app/#control-handlers-_ansible_handlers-CO7-5)|The name of the handler invoked by tasks.|
|[![6](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/6.svg)](https://rha.ole.redhat.com/rha/app/#control-handlers-_ansible_handlers-CO7-6)|The module to use for the handler.|

the `restart apache` handler is triggered when notified by the `template` task that a change happened.

might call more than one handler in its `notify` section. `Ansible` treats the `notify` statement as an array and iterates over the handler names:

```yaml
tasks:
  - name: copy demo.example.conf configuration template
    ansible.builtin.template:
      src: /var/lib/templates/demo.example.conf.template
      dest: /etc/httpd/conf.d/demo.example.conf
    notify:
      - restart mysql
      - restart apache

handlers:
  - name: restart mysql
    ansible.builtin.service:
      name: mariadb
      state: restarted

  - name: restart apache
    ansible.builtin.service:
      name: httpd
      state: restarted
```

- Handlers always run in the order specified by the `handlers` section of the play. They do not run in the order in which they are listed by `notify` statements in a task, or in the order in which tasks notify them.

- Handlers normally run after all other tasks in the play complete. A handler called by a task in the `tasks` part of the playbook does not run until _all_ tasks under `tasks` have been processed. (Some minor exceptions to this exist.)


- Handler names exist in a per-play namespace. If two handlers are incorrectly given the same name, only one of them runs.

- Even if more than one task notifies a handler, the handler runs one time. If no tasks notify it, the handler does not run.

- If a task that includes a `notify` statement does not report a `changed` result (for example, a package is already installed and the task reports `ok`), the handler is not notified. Ansible notifies handlers only if the task reports the `changed` status.


### Important

Handlers are meant to perform an extra action when a task makes a change to a managed host. They should not be used as a replacement for normal tasks.

### References

[Handlers: running operations on change — Ansible Documentation](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_handlers.html)