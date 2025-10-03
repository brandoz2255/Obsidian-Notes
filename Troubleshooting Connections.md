
# Core – Quick Reference

|Topic|Key Point|Typical Command|
|---|---|---|
|**Connection**|Verify `remote_user` & SSH keys|`ansible-navigator run -m stdout playbook.yml`|
|**Authentication**|Test with `ansible.builtin.ping`|`ansible host -m ansible.builtin.ping`|
|**Python**|Ensure a Python interpreter exists|`ansible host -m ansible.builtin.command -a 'python --version'`|
|**Check Mode**|Dry‑run a playbook|`ansible-navigator run --check playbook.yml`|
|**Ad‑hoc**|Quick one‑off tasks|`ansible host -m ansible.builtin.command -a 'df'`|

---

# Info – In‑Depth Understanding

## Connection & Authentication

Ansible connects to a host via SSH (or WinRM for Windows). The `remote_user` setting tells Ansible which account to use. If the SSH key for that user is missing or the key is not in the host’s `authorized_keys`, you’ll see a _Permission denied_ error.  
Use `-vvv` or `-vvvv` to see the exact SSH command and authentication attempts.

## Python Interpreter

All Ansible modules run on the remote host under a Python interpreter. Ansible automatically searches for a suitable interpreter (e.g., `/usr/bin/python3`). If none is found, the playbook fails with a _not found_ message. Install Python or set `ansible_python_interpreter` in the inventory.

## Check Mode

`--check` runs the playbook without making changes. Modules that support check mode report what would change; others simply skip the action. Conditionals that depend on earlier tasks may not evaluate correctly in check mode, so test with `--check` only when the playbook is stable.

## Ad‑hoc Commands

Ad‑hoc commands run directly from the command line and do **not** use an execution environment. They are great for quick tests (e.g., `ping`, `df`, `free -m`). They require the `ansible-core` package and only provide modules from the `ansible.builtin` collection unless you install others.

---

# Summary – Code & Comments

```yaml
# playbook.yml – Quick connectivity test
- name: Test SSH and Python on all hosts
  hosts: all
  gather_facts: false
  tasks:
    - name: Ping the host
      ansible.builtin.ping:          # Sends a simple ping module request
      register: ping_result

    - name: Check Python interpreter
      ansible.builtin.command:       # Runs a shell command on the host
        cmd: python --version
      register: python_version
```

```bash
# Run the playbook with maximum verbosity
ansible-navigator run -vvvv playbook.yml
```

```bash
# Ad‑hoc ping to a single host
ansible host1 -m ansible.builtin.ping
```

```bash
# Ad‑hoc disk‑space check
ansible host1 -m ansible.builtin.command -a 'df -h'
```

```bash
# Dry‑run the playbook (check mode)
ansible-navigator run --check playbook.yml
```

```bash
# Dry‑run with diff output
ansible-navigator run --check --diff playbook.yml
```

```yaml
# Example of a task that always runs in check mode
- name: Always check mode
  ansible.builtin.shell: uname -a
  check_mode: true
```

```yaml
# Example of a task that always runs normally, even in check mode
- name: Always run normally
  ansible.builtin.shell: uname -a
  check_mode: false
```

---

# Research – What’s Next

|Topic|Why It Matters|Where to Learn|
|---|---|---|
|**Automation Hub API**|Automate collection downloads|Red Hat Automation Hub docs|
|**Content Collections**|New packaging format for roles|Ansible docs – “Content Collections”|
|**Private Automation Hub**|Host internal collections|Red Hat Automation Platform docs|
|**Molecule**|Test roles locally|Molecule docs|
|**ansible‑navigator lint**|Run lint inside the execution environment|`ansible-navigator --help`|
|**Playbook Artifacts API**|Programmatically read JSON artifacts|`ansible-navigator replay --help`|

---

# Caveats – Things to Watch Out For

1. **`ansible-navigator` runs as root** inside its container, so SSH keys come from the user who launched it. This can confuse debugging of `remote_user` and `become`.
2. **Ad‑hoc commands do not use an execution environment**; they rely on the host’s installed Ansible collections. Install missing collections manually.
3. **Check mode may fail on modules that don’t support it** or on tasks that rely on earlier changes.
4. **`ansible_check_mode` is a boolean**; use it to guard logic that should only run when not in check mode.
5. **Privilege escalation errors** often stem from missing sudoers entries or missing password prompts. Verify `/etc/sudoers` on the host.
6. **Python interpreter discovery** can be overridden with `ansible_python_interpreter`; otherwise Ansible may pick an incompatible version.

---

# Troubleshooting Ansible Managed Hosts

Troubleshoot failures on managed hosts when running a playbook.

## Troubleshooting Connections

Many common problems when using Ansible to manage hosts are associated with connections to the host and with configuration problems around the remote user and privilege escalation.

### Problems Authenticating to Managed Hosts

If you are having problems authenticating to a managed host, make sure that you have `remote_user` set correctly in your configuration file or in your play.

#### Wrong Remote User Configuration

For example, you might see the following output when running a playbook that is designed to connect to the remote root user account:

```bash
[student@controlnode ~]$ ansible-navigator run \
> -m stdout playbook.yml

PLAY [Install a samba server] **************************************************

TASK [Gathering Facts] *********************************************************
fatal: [host.lab.example.com]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh: developer@host: Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password).", "unreachable": true}

PLAY RECAP *********************************************************************
host.lab.example.com    : ok=0    changed=0    unreachable=1    failed=0    skipped=0    rescued=0    ignored=0
Please review the log for errors.
```

In this case, `ansible-navigator` is trying to connect as the `developer` user account, according to the preceding output. One reason this might happen is if `ansible.cfg` has been configured in the project to set the `remote_user` to the `developer` user instead of the `root` user.

#### Missing or Incorrect SSH Keys

Another reason you could see a "permission denied" error like this is if you do not have the correct SSH keys set up, or did not provide the correct password for that user.

```bash
[root@controlnode ~]# ansible-navigator run \
> -m stdout playbook.yml

TASK [Gathering Facts] *********************************************************
fatal: [host.lab.example.com]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh: root@host: Permission denied (publickey,gssapi-keyex,gssapi-with-mic).", "unreachable": true}

PLAY RECAP *********************************************************************
host    : ok=0    changed=0    unreachable=1    failed=0    skipped=0    rescued=0    ignored=0

Please review the log for errors.
```

In the preceding example, the playbook is attempting to connect to the host machine as the `root` user but the SSH key for the `root` user on the `controlnode` machine has not been added to the `authorized_keys` file for the `root` user on the host machine.

#### Summary of Permission Denied Scenarios

You could see similar "permission denied" errors in the following situations:

- You try to connect as the wrong `remote_user` for your authentication credentials
- You connect as the correct `remote_user` but the authentication credentials are missing or incorrect

### Problems with Name or Address Resolution

A more subtle problem has to do with inventory settings. For a complex server with multiple network addresses, you might need to use a particular address or DNS name when connecting to that system. You might not want to use that address as the machine's inventory name for better readability.

#### Using ansible_host Variable

You can set a host inventory variable, `ansible_host`, that overrides the inventory name with a different name or IP address and be used by Ansible to connect to that host. This variable could be set in the `host_vars` file or directory for that host, or could be set in the inventory file itself.

For example, the following inventory entry configures Ansible to connect to `192.0.2.4` when processing the `web4.phx.example.com` host:

```ini
web4.phx.example.com ansible_host=192.0.2.4
```

This is a useful way to control how Ansible connects to managed hosts. However, it can also cause problems if the value of `ansible_host` is incorrect.

### Problems with Privilege Escalation

If your playbook connects as a `remote_user` and then uses privilege escalation to become the root user (or some other user), make sure that `become` is set properly, and that you are using the correct value for the `become_user` directive. The setting for `become_user` is `root` by default.

#### Missing sudo Password

If the remote user needs to provide a sudo password, you should confirm that you are providing the correct sudo password, and that sudo on the managed host is configured correctly.

```bash
[user@controlnode ~]$ ansible-navigator run \
> -m stdout playbook.yml

TASK [Gathering Facts] *********************************************************
fatal: [host]: FAILED! => {"msg": "Missing sudo password"}

PLAY RECAP *********************************************************************
host             : ok=0    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0

Please review the log for errors.
```

In the preceding example, the playbook is attempting to run sudo on the host machine but it fails. The `remote_user` is not set up to run sudo commands without a password on the host machine. Either sudo on the host machine is not properly configured, or it is supposed to require a sudo password and you neglected to provide one when running the playbook.

#### Important Note About ansible-navigator

**Important**: Normally, `ansible-navigator` runs as root inside its automation execution environment. However, the root user in the container has access to SSH keys provided by the user that ran `ansible-navigator` on the workstation. This can be slightly confusing when you are trying to debug `remote_user` and `become` directives, especially if you are used to the earlier `ansible-playbook` command that runs as the user on the workstation.

### Problems with Python on Managed Hosts

For normal operation, Ansible requires a Python interpreter to be installed on managed hosts running Linux. Ansible attempts to locate a Python interpreter on each Linux managed host the first time a module is run on that host.

#### Missing Python Interpreter

```bash
[user@controlnode ~]$ ansible-navigator run \
> -m stdout playbook.yml

TASK [Gathering Facts] *********************************************************
fatal: [host]: FAILED! => {"ansible_facts": {}, "changed": false, "failed_modules": {"ansible.legacy.setup": {"ansible_facts": {"discovered_interpreter_python": "/usr/bin/python"}, "failed": true, "module_stderr": "Shared connection to host closed.\r\n", "module_stdout": "/bin/sh: 1: /usr/bin/python: not found\r\n", "msg": "The module failed to execute correctly, you probably need to set the interpreter.\nSee stdout/stderr for the exact error", "rc": 127, "warnings": ["No python interpreters found for host host (tried ['python3.10', 'python3.9', 'python3.8', 'python3.7', 'python3.6', 'python3.5', '/usr/bin/python3', '/usr/libexec/platform-python', 'python2.7', 'python2.6', '/usr/bin/python', 'python'])"]}}, "msg": "The following modules failed to execute: ansible.legacy.setup\n"}

PLAY RECAP *********************************************************************
host    : ok=0    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0
Please review the log for errors.
```

In the preceding example, the playbook fails because Ansible is unable to find a suitable Python interpreter on the host machine.

## Using Check Mode as a Testing Tool

You can use the `ansible-navigator run --check` command to run "smoke tests" on a playbook. This option runs the playbook, connecting to the managed hosts normally but without making changes to them.

### Basic Check Mode Usage

```bash
[student@demo ~]$ ansible-navigator run \
> -m stdout playbook.yml --check
```

If a module used within the playbook supports "check mode", then the changes that would have been made to the managed hosts are displayed but not performed. If check mode is not supported by a module, then `ansible-navigator` does not display the predicted changes, but the module still takes no action.

### Check Mode Limitations

**Important**: The `ansible-navigator run --check` command might not work properly if your tasks use conditionals. One reason for this might be that the conditionals depend on some preceding task in the play actually running so that the condition evaluates correctly.

### Controlling Check Mode Behavior

You can force tasks to always run in check mode or to always run normally with the `check_mode` setting:

#### Always Run in Check Mode

If a task has `check_mode: true` set, it always runs in its check mode and does not perform any action, even if you do not pass the `--check` option to `ansible-navigator`.

```yaml
  tasks:
    - name: task always in check mode
      ansible.builtin.shell: uname -a
      check_mode: true
```

#### Always Run Normally

If a task has `check_mode: false` set, it always runs normally, even if you pass `--check` to `ansible-navigator`.

```yaml
  tasks:
    - name: task always runs even in check mode
      ansible.builtin.shell: uname -a
      check_mode: false
```

### Use Cases for Check Mode Controls

This can be useful because you can:

- Run most of a playbook normally and test individual tasks with `check_mode: true`
- Use `check_mode: false` on tasks that gather facts or set variables but do not otherwise change the managed node
- Enable the play to proceed further when using `--check` mode for conditional tasks that might fail if facts or variables are undefined

### Testing for Check Mode

A task can determine if the playbook is running in check mode by testing the value of the magic variable `ansible_check_mode`. This Boolean variable is set to `true` if the playbook is running in check mode.

### Security Warning

**Warning**: Tasks that have `check_mode: false` set run even when the playbook is run with `ansible-navigator run --check`. Therefore, you cannot trust that the `--check` option makes no changes to managed hosts, without inspecting the playbook and any roles or tasks associated with it.

### Legacy Compatibility

**Note**: If you have older playbooks that use `always_run: true` to force tasks to run normally even in check mode, you need to replace that code with `check_mode: false` in Ansible 2.6 and later.

### Diff Mode

The `ansible-navigator` command also provides a `--diff` option. This option reports the changes made to the template files on managed hosts. If used with the `--check` option, those changes are displayed in the command's output but not actually made.

```bash
[student@demo ~]$ ansible-navigator run \
> -m stdout playbook.yml --check --diff
```

## Testing with Modules

Some modules can provide additional information about the status of a managed host. The following list includes some Ansible modules that can be used to test and debug issues on managed hosts.

### URI Module for API Testing

The `ansible.builtin.uri` module provides a way to verify that a RESTful API is returning the required content.

```yaml
  tasks:
    - ansible.builtin.uri:
        url: http://api.myapp.example.com
        return_content: true
      register: apiresponse

    - ansible.builtin.fail:
        msg: 'version was not provided'
      when: "'version' not in apiresponse.content"
```

### Script Module for Custom Tests

The `ansible.builtin.script` module runs a script on managed hosts, and fails if the return code for that script is nonzero. The script must exist in the Ansible project and is transferred to and run on the managed hosts.

```yaml
  tasks:
    - ansible.builtin.script: scripts/check_free_memory --min 2G
```

### Stat Module for File Information

The `ansible.builtin.stat` module gathers facts for a file much like the `stat` command. You can use it to register a variable and then test to determine if the file exists or to get other information about the file. If the file does not exist, the `ansible.builtin.stat` task does not fail, but its registered variable reports `false` for `['stat']['exists']`.

In this example, an application is still running if `/var/run/app.lock` exists, in which case the play should abort.

```yaml
  tasks:
    - name: Check if /var/run/app.lock exists
      ansible.builtin.stat:
        path: /var/run/app.lock
      register: lock

    - name: Fail if the application is running
      ansible.builtin.fail:
      when: lock['stat']['exists']
```

### Assert Module for Multiple Conditions

The `ansible.builtin.assert` module is an alternative to the `ansible.builtin.fail` module. The `ansible.builtin.assert` module supports a `that` option that takes a list of conditionals. If any of those conditionals are false, the task fails. You can use the `success_msg` and `fail_msg` options to customize the message it prints if it reports success or failure.

The following example repeats the preceding one, but uses `ansible.builtin.assert` instead of the `ansible.builtin.fail` module:

```yaml
  tasks:
    - name: Check if /var/run/app.lock exists
      ansible.builtin.stat:
        path: /var/run/app.lock
      register: lock

    - name: Fail if the application is running
      ansible.builtin.assert:
        that:
          - not lock['stat']['exists']
```

## Running Ad Hoc Commands with Ansible

An ad hoc command is a way of executing a single Ansible task quickly, one that you do not need to save to run again later. They are simple, online operations that can be run without writing a playbook.

### Important Limitations of Ad Hoc Commands

**Important**: Ad hoc commands do not run inside an automation execution environment container. Instead, they run using Ansible software, roles, and collections installed directly on your workstation. To use ad hoc Ansible Core 2.13 commands, you need to install the `ansible-core` RPM package on your workstation.

The `ansible-core` RPM package provides only the modules in the `ansible.builtin` Ansible Content Collection. If you need modules from other collections, you need to install those on your workstation separately.

### Use Cases for Ad Hoc Commands

Ad hoc commands are useful for:
- Quick tests and troubleshooting
- Making sure that hosts are reachable using the `ansible.builtin.ping` module
- Viewing resource usage on a group of hosts using the `ansible.builtin.command` module

Ad hoc commands do have their limits, and in general you want to use Ansible Playbooks to realize the full power of Ansible.

### Ad Hoc Command Syntax

Use the `ansible` command to run ad hoc commands:

```bash
[user@controlnode ~]$ ansible host-pattern -m module [-a 'module arguments'] \
> [-i inventory]
```

#### Command Components

- **`host-pattern`**: Specifies the managed hosts against which the ad hoc command should be run
- **`-i`**: Specifies a different inventory location to use from the default in the current Ansible configuration file
- **`-m`**: Specifies the module that Ansible should run on the targeted hosts
- **`-a`**: Takes a list of arguments for the module as a quoted string

#### Default Module Behavior

**Note**: If you use the `ansible` command but do not specify a module with the `-m` option, the `ansible.builtin.command` module is used by default. It is always best to specify the module you intend to use, even if you intend to use the `ansible.builtin.command` module.

### Best Practices for Ad Hoc Commands

Ansible ad hoc commands can be useful, but should be kept to troubleshooting and one-time use cases. For example, if you are aware of multiple pending network changes, it is more efficient to create a playbook with an `ansible.builtin.ping` task that you can run multiple times, compared to typing out a one-time use ad hoc command multiple times.

## Testing Managed Hosts Using Ad Hoc Commands

The following examples illustrate some tests that can be made on a managed host using ad hoc commands.

### Testing Connectivity with Ping Module

You have used the `ansible.builtin.ping` module to test whether you can connect to managed hosts. Depending on the options that you pass, you can also use it to test whether privilege escalation and credentials are correctly configured.

#### Basic Ping Test

```bash
[student@demo ~]$ ansible demohost -m ansible.builtin.ping
demohost | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

#### Testing Privilege Escalation

```bash
[student@demo ~]$ ansible demohost -m ansible.builtin.ping --become
demohost | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "module_stderr": "sudo: a password is required\n",
    "module_stdout": "",
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error",
    "rc": 1
}
```

### Testing Disk Space

This example returns the current available space on the disks configured on the `demohost` managed host. That can be useful to confirm that the file system on the managed host is not full.

```bash
[student@demo ~]$ ansible demohost -m ansible.builtin.command -a 'df'
```

### Testing Memory Usage

This example returns the current available free memory on the `demohost` managed host.

```bash
[student@demo ~]$ ansible demohost -m ansible.builtin.command -a 'free -m'
```

## Troubleshooting Best Practices

### Connection Issues
1. **Verify remote_user settings** in configuration files and plays
2. **Check SSH key authentication** and ensure keys are properly distributed
3. **Test with different verbosity levels** using `-v`, `-vv`, `-vvv`, or `-vvvv`
4. **Verify inventory host variables** like `ansible_host` for correct addressing

### Authentication Problems
1. **Use ad hoc ping commands** to test basic connectivity
2. **Test privilege escalation** separately with `--become` option
3. **Check sudo configuration** on managed hosts
4. **Verify password requirements** and provide them when needed

### Python Interpreter Issues
1. **Install Python on managed hosts** before running playbooks
2. **Specify interpreter paths** explicitly if auto-discovery fails
3. **Check Python version compatibility** with your modules
4. **Use appropriate package managers** to install Python

### Check Mode Testing
1. **Use check mode regularly** during development and testing
2. **Understand module check mode support** before relying on it
3. **Test conditionals carefully** as they may not work properly in check mode
4. **Use diff mode** to see what changes would be made

### Debugging Workflow
1. **Start with syntax check** to eliminate basic errors
2. **Use check mode** to verify intended changes
3. **Test with ad hoc commands** for quick verification
4. **Increase verbosity** progressively for more detailed output
5. **Use debug modules** strategically in playbooks
6. **Test authentication and connectivity** separately from complex logic

### Module Selection for Testing
- **`ansible.builtin.ping`**: Basic connectivity and authentication
- **`ansible.builtin.uri`**: Web service and API testing
- **`ansible.builtin.stat`**: File and directory verification
- **`ansible.builtin.script`**: Custom test script execution
- **`ansible.builtin.assert`**: Multiple condition testing
- **`ansible.builtin.command`**: System resource checking