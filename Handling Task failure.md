


## 1️⃣ Core – Quick Reference

|Feature|What it does|When to use|
|---|---|---|
|`ignore_errors: true`|Continues playbook execution even if the task fails|When a failure is expected and you want to keep going|
|`force_handlers: true`|Runs all notified handlers even if a later task fails|When you need a cleanup or restart after a failure|
|`failed_when`|Custom logic that declares a task failed|When the default return‑code logic isn’t enough|
|`changed_when`|Custom logic that declares a task changed|When you want to control when handlers fire|
|`block / rescue / always`|Structured error handling|When you need a try‑catch‑finally style flow|

---

## 2️⃣ Info – Processed Details


## 📚 Information – What the Note Tells Us

- **Ignoring a task failure** – Add `ignore_errors: true` to a task.  
    The task will still report `failed`, but the play continues to run.
    
- **Forcing handlers** – Set `force_handlers: true` on a play.  
    Any handler that has already been notified will run even if a later task fails.
    
- **Custom failure logic** – Use `failed_when` to write a Boolean expression that decides whether a task has failed.  
    This lets you treat a non‑zero exit code as success (or vice‑versa).
    
- **Custom changed logic** – Use `changed_when` to override the default “changed” detection.  
    Handlers are only notified when a task reports `changed`, so this controls when they fire.
    
- **Block / rescue / always** – Structured error handling that mimics a try‑catch‑finally flow:
    
    - `block` – main tasks.
    - `rescue` – runs if any task in the block fails.
    - `always` – runs regardless of success or failure.

### How do you ignore a task failure?

Use `ignore_errors: true` on the task.  
The task will report `failed`, but the play will keep running.

### What does `force_handlers` do?

When set on a play, any handler that has already been notified will run **even if a later task fails**.  
Without it, a failure aborts the play before any handler runs.

### Why use `failed_when`?

Sometimes a command returns a non‑zero exit code but you want to treat it as success, or vice‑versa.  
`failed_when` lets you write a Boolean expression that decides failure.

### How does `changed_when` affect handlers?

Handlers are only notified when a task reports `changed`.  
`changed_when` lets you override the default “changed” detection, so you can trigger a handler only when a specific condition is met.

### What is the purpose of `block / rescue / always`?

- **block** – the main set of tasks.
- **rescue** – runs if any task in the block fails.
- **always** – runs regardless of success or failure.  
    This mimics a try‑catch‑finally structure.

### Further research questions

|Question|Why it matters|
|---|---|
|How does `meta: flush_handlers` differ from `force_handlers`?|It forces handlers to run _immediately_ instead of at the end of the play.|
|Can `ignore_errors` be combined with `failed_when`?|Yes, but the logic can become confusing; test carefully.|
|What happens if a handler itself fails?|The play aborts unless `ignore_errors` or `force_handlers` is used.|
|How do `changed_when` and `failed_when` interact?|`changed_when` only affects handler notification; `failed_when` can still abort the play.|

---

## 3️⃣ Main – Code & Explanations

```yaml
# 1. Ignore a known failure
- name: Install a package that may not exist
  ansible.builtin.dnf:
    name: notapkg
    state: latest
  ignore_errors: true   # <--- keeps the play running even if the package is missing
```

```yaml
# 2. Force handlers even after a failure
---
- hosts: all
  force_handlers: true   # <--- run notified handlers even if later tasks fail
  tasks:
    - name: Notify handler (always succeeds)
      ansible.builtin.command: /bin/true
      notify: restart database

    - name: Deliberate failure
      ansible.builtin.dnf:
        name: notapkg
        state: latest

  handlers:
    - name: restart database
      ansible.builtin.service:
        name: mariadb
        state: restarted
```

```yaml
# 3. Custom failure logic with failed_when
- name: Run user creation script
  ansible.builtin.shell: /usr/local/bin/create_users.sh
  register: command_result
  failed_when: "'Password missing' in command_result.stdout"
  # <--- task fails only if the output contains the error string
```

```yaml
# 4. Explicit failure with ansible.builtin.fail
- name: Run user creation script
  ansible.builtin.shell: /usr/local/bin/create_users.sh
  register: command_result
  ignore_errors: true   # <--- let the script run even if it fails

- name: Report script failure
  ansible.builtin.fail:
    msg: "The password is missing in the output"
  when: "'Password missing' in command_result.stdout"
  # <--- forces a clear failure message
```

```yaml
# 5. Control when a task reports “changed”
- name: Validate httpd configuration
  ansible.builtin.command: httpd -t
  changed_when: false   # <--- never report changed; no handler will run
  register: httpd_config_status
```

```yaml
# 6. Block / rescue / always – structured error handling
- name: Upgrade database with fallback
  block:
    - name: Upgrade the database
      ansible.builtin.shell: /usr/local/lib/upgrade-database
  rescue:
    - name: Revert the database upgrade
      ansible.builtin.shell: /usr/local/lib/revert-database
  always:
    - name: Always restart the database
      ansible.builtin.service:
        name: mariadb
        state: restarted
  # <--- rescue runs only if the block fails; always runs in any case
```

---

## 4️⃣ Research – What’s Next

1. **`meta: flush_handlers`** – learn how to trigger handlers _mid‑play_ instead of at the end.
2. **Conditional blocks** – use `when:` inside a block to run different rescue logic per host.
3. **Check mode testing** – run `ansible-playbook --check` to see which tasks would change or fail.
4. **Debugging** – add `-vvv` to see handler notifications and failure reasons.
5. **Idempotency audit** – verify that `changed_when` and `failed_when` do not break repeatability.

---

## 5️⃣ Caveats

|Caveat|Why it matters|
|---|---|
|`ignore_errors` hides real problems|You may miss critical failures that should stop the play.|
|`force_handlers` can run handlers on a partially failed system|The system state may be inconsistent, leading to unpredictable results.|
|`failed_when` overrides default logic|A mis‑typed expression can cause a task to never fail, masking issues.|
|`changed_when` can mislead idempotency|If you always report `changed`, handlers may run unnecessarily.|
|Handlers only notify on `changed`|A task that reports `ok` or `failed` will never trigger its handler, even if you set `changed_when`.|
|`block / rescue / always` order|Rescue runs **only** on failure; `always` runs regardless. Mixing them incorrectly can produce confusing flows.|

---

> **Bottom line:**  
> Use these error‑handling tools sparingly and test your playbooks in a safe environment. They give you powerful control, but they also give you a lot of leeway to hide or misinterpret failures.

---

- Control what happens when a task fails, and what conditions cause a task to fail.

### Managing Task Errors in Plays

Ansible evaluates the return code of each task to determine whether the task succeeded or failed

However, sometimes you might want to have play execution continue even if a task fails.

For example, you might expect that a particular task could fail, and you might want to recover by conditionally running some other task.

#### Ignoring Task Failure

 by ignoring failed tasks. You can use the `ignore_errors` keyword in a task to accomplish this.

how to use `ignore_errors` in a task to continue playbook execution on the host even if the task fails

if the `notapkg` package does not exist then the `ansible.builtin.dnf` module fails, but having `ignore_errors` set to `true` allows execution to continue.

```yaml
- name: Latest version of notapkg is installed
  ansible.builtin.dnf:
    name: notapkg
    state: latest
  `ignore_errors: true`
```

#### Forcing Execution of Handlers After Task Failure

If you set the `force_handlers: true` keyword on the play, then notified handlers are called even if the play aborted because a later task failed.

### Important

If you have `ignore_errors: true` set on a task or for the task's play, if that task fails the failure is ignored. In that case, the play keeps running and handlers still run, even if you have `force_handlers: false` set, unless some other error causes the play to fail.

 how to use the `force_handlers` keyword in a play to force execution of the notified handler even if a subsequent task fails:

```yaml
---
- hosts: all
  `force_handlers: true`
  tasks:
    - name: a task which always notifies its handler
      ansible.builtin.command: /bin/true
      notify: restart the database

    - name: a task which fails because the package doesn't exist
      ansible.builtin.dnf:
        name: notapkg
        state: latest

  handlers:
    - name: restart the database
      ansible.builtin.service:
        name: mariadb
        state: restarted
```

### Important

Remember that handlers are notified when a task reports a `changed` result but are not notified when it reports an `ok` or `failed` result.

If you set `force_handlers: true` on the play, then any handlers that have been notified are run even if a later task failure causes the play to fail. Otherwise, handlers are not run at all when a play fails.

Setting `force_handlers: true` on a play does not cause handlers to be notified for tasks that report `ok` or `failed`; it only causes the handlers to run that have already been notified before the point at which the play failed.


use the `failed_when` keyword on a task to specify which conditions indicate that the task has failed. 

example, you can run a script that outputs an error message and then use that message to define the failed state for the task. 

use the `failed_when` keyword in a task:

```yaml
tasks:
  - name: Run user creation script
    ansible.builtin.shell: /usr/local/bin/create_users.sh
    register: command_result
    failed_when: "'Password missing' in command_result.stdout"
```

the `ansible.builtin.fail` module can also be used to force a task failure.

```yaml
tasks:
  - name: Run user creation script
    ansible.builtin.shell: /usr/local/bin/create_users.sh
    register: command_result
    ignore_errors: true

  - name: Report script failure
    ansible.builtin.fail:
      msg: "The password is missing in the output"
    when: "'Password missing' in command_result.stdout"
```

use the `ansible.builtin.fail` module to provide a clear failure message for the task.

#### Specifying When a Task Reports "Changed" Results

When a task makes a change to a managed host, it reports the `changed` state and notifies handlers.

When a task does not need to make a change, it reports `ok` and does not notify handlers.

Use the `changed_when` keyword to control how a task reports that it has changed something on the managed host

example, the `ansible.builtin.command` module in the next example validates the `httpd` configuration

Subsequent tasks can use the value of the `httpd_config_status` variable.

```yaml
  - name: Validate httpd configuration
    ansible.builtin.command: httpd -t
    changed_when: false
    register: httpd_config_status
```

 example uses the `ansible.builtin.shell` module and only reports `changed` if the string "Success" is found in the output

it does report `changed`, then it notifies the handler.

```yaml
tasks:
  - ansible.builtin.shell:
      cmd: /usr/local/bin/upgrade-database
    register: command_result
    changed_when: "'Success' in command_result.stdout"
    notify:
      - restart_database

handlers:
  - name: restart_database
     ansible.builtin.service:
       name: mariadb
       state: restarted
```

#### Ansible Blocks and Error Handling

```yaml
- name: block example
  hosts: all
  tasks:
    - name: installing and configuring DNF versionlock plugin
      block:
      - name: package needed by dnf
        ansible.builtin.dnf:
          name: python3-dnf-plugin-versionlock
          state: present
      - name: lock version of tzdata
        ansible.builtin.lineinfile:
          dest: /etc/yum/pluginconf.d/versionlock.list
          line: tzdata-2016j-1
          state: present
      when: ansible_distribution == "RedHat"
```

Blocks also allow for error handling in combination with the `rescue` and `always` statements.

If any task in a `block` fails, then `rescue` tasks are executed to recover.

tasks in the `block` clause run, as well as the tasks in the `rescue` clause if there was a failure, then tasks in the `always` clause run.

To summarize:

- `block`: Defines the main tasks to run.
    
- `rescue`: Defines the tasks to run if the tasks defined in the `block` clause fail.
    
- `always`: Defines the tasks that always run independently of the success or failure of tasks defined in the `block` and `rescue` clauses.

The following example shows how to implement a block in a playbook.

```yaml
  tasks:
    - name: Upgrade DB
      block:
        - name: upgrade the database
          ansible.builtin.shell:
            cmd: /usr/local/lib/upgrade-database
      rescue:
        - name: revert the database upgrade
          ansible.builtin.shell:
            cmd: /usr/local/lib/revert-database
      always:
        - name: always restart the database
          ansible.builtin.service:
            name: mariadb
            state: restarted
```

### References

[Error Handling in Playbooks — Ansible Documentation](https://docs.ansible.com/ansible/latest/user_guide/playbooks_error_handling.html)

[Error Handling — Blocks — Ansible Documentation](https://docs.ansible.com/ansible/latest/user_guide/playbooks_blocks.html#blocks-error-handling)