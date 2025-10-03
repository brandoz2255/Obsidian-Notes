
# Debugging Playbooks

---

## 1️⃣ Core – Quick Reference

|Feature|What it does|Typical command|
|---|---|---|
|**Run playbook**|Execute a playbook and see results|`ansible-navigator run playbook.yml`|
|**Verbosity**|Show more details (`-v`‑`-vvvv`)|`ansible-navigator run -vvv playbook.yml`|
|**Syntax check**|Validate playbook without running|`ansible-navigator run --syntax-check playbook.yml`|
|**Step mode**|Confirm each task before running|`ansible-navigator run --step playbook.yml`|
|**Start‑at‑task**|Begin at a specific task|`ansible-navigator run --start-at-task "Task name" playbook.yml`|
|**Debug module**|Print variable values|`ansible.builtin.debug: var: my_var`|
|**Lint**|Check style & best‑practice violations|`ansible-lint playbook.yml`|
|**Artifacts**|Store run data in JSON|`ansible-navigator run playbook.yml` → `playbook-artifact-*.json`|
|**Logging**|Write output to a file|`log_path = /var/log/ansible.log` in `ansible.cfg`|

---

## 2️⃣ Info – In‑Depth Understanding

### Playbook Output Structure

- **PLAY header** – Name of the play.
- **TASK headers** – Each task executed on all hosts in the play.
- **Host results** – `ok`, `changed`, `failed`, etc. for each host.
- **PLAY RECAP** – Summary of all hosts and task outcomes.

### Verbosity Levels

| `-v` | Show task output |  
| `-vv` | Show task output + input data |  
| `-vvv` | Add connection info |  
| `-vvvv` | Add remote script details & user info |

### Debug Module

- `msg:` prints a custom message.
- `var:` prints the raw value of a variable.
- `verbosity:` controls when the debug task runs (matches `-v` count).

### Syntax Checking

Runs the playbook parser only, catching YAML or Ansible syntax errors before execution.

### Step Mode

Interactive prompt (`Y/N/C`) lets you skip or continue tasks, useful for troubleshooting complex logic.

### Start‑at‑Task

Allows you to jump to a specific task by name, saving time when a playbook is long.

### Linting

`ansible-lint` enforces coding standards (e.g., use of fully‑qualified module names, no trailing spaces). It can be integrated into CI pipelines.

### Artifacts & Logging

- **Artifacts** – JSON files that record every host’s state, useful for post‑mortem analysis.
- **Logging** – Text logs written to a path defined in `ansible.cfg` or `$ANSIBLE_LOG_PATH`. Configure `logrotate` for long‑term storage.

---

## 3️⃣ Summary – Code & Comments

```yaml
# site.yml – Example playbook
- name: Configure servers with Ansible tools   # Play name shown in output
  hosts: all                                   # Target all hosts in inventory
  tasks:
    - name: Make sure tools are installed       # Task name shown in output
      ansible.builtin.package:                 # Fully‑qualified module name
        name:
          - ansible-doc
          - ansible-navigator
```

```bash
# Syntax check – no playbook run, just validation
ansible-navigator run --syntax-check playbook.yml
```

```bash
# Run with maximum verbosity – shows connection and script details
ansible-navigator run -vvvv playbook.yml
```

```bash
# Step mode – confirm each task
ansible-navigator run --step playbook.yml
```

```bash
# Start at a specific task
ansible-navigator run --start-at-task "Make sure tools are installed" playbook.yml
```

```bash
# Lint the playbook for style issues
ansible-lint playbook.yml
```

```yaml
# ansible-navigator.yml – Disable artifact creation
ansible-navigator:
  playbook-artifact:
    enable: false
```

```ini
# ansible.cfg – Log playbook output to a file
[defaults]
log_path = /var/log/ansible.log
```

---

## 4️⃣ Research – What’s Next

|Topic|Why it matters|Where to learn|
|---|---|---|
|**Automation Hub API**|Automate collection downloads|Red Hat Automation Hub docs|
|**Content Collections**|Newer packaging format|Ansible docs – “Content Collections”|
|**Private Automation Hub**|Host internal collections|Red Hat Automation Platform docs|
|**Molecule**|Test roles locally|Molecule docs|
|**ansible‑navigator lint**|Run lint inside the execution environment|`ansible-navigator --help`|
|**Playbook Artifacts API**|Programmatically read JSON artifacts|`ansible-navigator replay --help`|

---

## 5️⃣ Caveats – Things to Watch Out For

1. **`ansible‑navigator` vs. `ansible-playbook`** – Some tools (e.g., `ansible‑navigator lint`) only work inside the execution environment.
2. **`ansible-lint` version** – The bundled version assumes Ansible 2.13; older playbooks may need a newer lint version.
3. **Artifact privacy** – Artifacts contain host names and variable values; disable if sensitive data is a concern.
4. **Step mode input** – Requires interactive terminal; not suitable for automated runs.
5. **Verbosity impact** – Higher verbosity (`-vvvv`) can expose private keys or passwords if not careful.# Debugging Playbooks

---

## 1️⃣ Core – Quick Reference

|Feature|What it does|Typical command|
|---|---|---|
|**Run playbook**|Execute a playbook and see results|`ansible-navigator run playbook.yml`|
|**Verbosity**|Show more details (`-v`‑`-vvvv`)|`ansible-navigator run -vvv playbook.yml`|
|**Syntax check**|Validate playbook without running|`ansible-navigator run --syntax-check playbook.yml`|
|**Step mode**|Confirm each task before running|`ansible-navigator run --step playbook.yml`|
|**Start‑at‑task**|Begin at a specific task|`ansible-navigator run --start-at-task "Task name" playbook.yml`|
|**Debug module**|Print variable values|`ansible.builtin.debug: var: my_var`|
|**Lint**|Check style & best‑practice violations|`ansible-lint playbook.yml`|
|**Artifacts**|Store run data in JSON|`ansible-navigator run playbook.yml` → `playbook-artifact-*.json`|
|**Logging**|Write output to a file|`log_path = /var/log/ansible.log` in `ansible.cfg`|

---

## 2️⃣ Info – In‑Depth Understanding

### Playbook Output Structure

- **PLAY header** – Name of the play.
- **TASK headers** – Each task executed on all hosts in the play.
- **Host results** – `ok`, `changed`, `failed`, etc. for each host.
- **PLAY RECAP** – Summary of all hosts and task outcomes.

### Verbosity Levels

| `-v` | Show task output |  
| `-vv` | Show task output + input data |  
| `-vvv` | Add connection info |  
| `-vvvv` | Add remote script details & user info |

### Debug Module

- `msg:` prints a custom message.
- `var:` prints the raw value of a variable.
- `verbosity:` controls when the debug task runs (matches `-v` count).

### Syntax Checking

Runs the playbook parser only, catching YAML or Ansible syntax errors before execution.

### Step Mode

Interactive prompt (`Y/N/C`) lets you skip or continue tasks, useful for troubleshooting complex logic.

### Start‑at‑Task

Allows you to jump to a specific task by name, saving time when a playbook is long.

### Linting

`ansible-lint` enforces coding standards (e.g., use of fully‑qualified module names, no trailing spaces). It can be integrated into CI pipelines.

### Artifacts & Logging

- **Artifacts** – JSON files that record every host’s state, useful for post‑mortem analysis.
- **Logging** – Text logs written to a path defined in `ansible.cfg` or `$ANSIBLE_LOG_PATH`. Configure `logrotate` for long‑term storage.

---

## 3️⃣ Summary – Code & Comments

```yaml
# site.yml – Example playbook
- name: Configure servers with Ansible tools   # Play name shown in output
  hosts: all                                   # Target all hosts in inventory
  tasks:
    - name: Make sure tools are installed       # Task name shown in output
      ansible.builtin.package:                 # Fully‑qualified module name
        name:
          - ansible-doc
          - ansible-navigator
```

```bash
# Syntax check – no playbook run, just validation
ansible-navigator run --syntax-check playbook.yml
```

```bash
# Run with maximum verbosity – shows connection and script details
ansible-navigator run -vvvv playbook.yml
```

```bash
# Step mode – confirm each task
ansible-navigator run --step playbook.yml
```

```bash
# Start at a specific task
ansible-navigator run --start-at-task "Make sure tools are installed" playbook.yml
```

```bash
# Lint the playbook for style issues
ansible-lint playbook.yml
```

```yaml
# ansible-navigator.yml – Disable artifact creation
ansible-navigator:
  playbook-artifact:
    enable: false
```

```ini
# ansible.cfg – Log playbook output to a file
[defaults]
log_path = /var/log/ansible.log
```

---

## 4️⃣ Research – What’s Next

|Topic|Why it matters|Where to learn|
|---|---|---|
|**Automation Hub API**|Automate collection downloads|Red Hat Automation Hub docs|
|**Content Collections**|Newer packaging format|Ansible docs – “Content Collections”|
|**Private Automation Hub**|Host internal collections|Red Hat Automation Platform docs|
|**Molecule**|Test roles locally|Molecule docs|
|**ansible‑navigator lint**|Run lint inside the execution environment|`ansible-navigator --help`|
|**Playbook Artifacts API**|Programmatically read JSON artifacts|`ansible-navigator replay --help`|

---

## 5️⃣ Caveats – Things to Watch Out For

1. **`ansible‑navigator` vs. `ansible-playbook`** – Some tools (e.g., `ansible‑navigator lint`) only work inside the execution environment.
2. **`ansible-lint` version** – The bundled version assumes Ansible 2.13; older playbooks may need a newer lint version.
3. **Artifact privacy** – Artifacts contain host names and variable values; disable if sensitive data is a concern.
4. **Step mode input** – Requires interactive terminal; not suitable for automated runs.
5. **Verbosity impact** – Higher verbosity (`-vvvv`) can expose private keys or passwords if not careful.




---

# Debugging Playbooks

The output provided by the `ansible-navigator run` command is a good starting point for troubleshooting issues with your plays and the hosts on which they run.

## Understanding Playbook Output

Consider the following output from a playbook run:

```
PLAY [Service Deployment] ***************************************************
...output omitted...
TASK: [Install a service] ***************************************************
ok: [demoservera] => {
    "msg": "demoservera"
}
ok: [demoserverb] => {
    "msg": "demoserverb"
}

PLAY RECAP *********************************************************************
demoservera    : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
demoserverb    : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### Output Structure

The output shows:

1. **PLAY header**: Shows the name of the play being run
2. **TASK headers**: Represents each task in the play, run on all managed hosts specified by the play's `hosts` parameter
3. **Host results**: Each managed host displays under the TASK header with task results
4. **PLAY RECAP**: Displays the number of tasks run for each managed host, by task result

### Task Result Types

Task results can be:
- **`ok`**: Task completed successfully without changes
- **`changed`**: Task completed successfully and made changes
- **`failed`**: Task failed to complete
- **`skipped`**: Task was skipped due to conditions
- **`unreachable`**: Host was unreachable
- **`rescued`**: Task failed but was handled by rescue block
- **`ignored`**: Task failed but failure was ignored

## Verbosity Options

You can increase the verbosity of the output from `ansible-navigator run` by adding one or more `-v` options. The `ansible-navigator run -v` command provides additional debugging information, with up to four total levels.

| Option | Description |
|--------|-------------|
| `-v` | The output data is displayed. |
| `-vv` | Both the output and input data are displayed. |
| `-vvv` | Includes information about connections to managed hosts. |
| `-vvvv` | Includes additional information, such as the scripts that are executed on each remote host, and the user that is executing each script. |

## Examining Values of Variables with the Debug Module

You can use the `ansible.builtin.debug` module to provide insight into what is happening in the play. You can create a task that uses this module to display the value for a given variable at a specific point in the play. This can help you to debug tasks that use variables to communicate with each other.

### Debug Module Examples

#### Displaying Variable Values in Messages

This example displays the value at run time of the `ansible_facts['memfree_mb']` fact as part of a message printed to the output of `ansible-navigator run`.

```yaml
- name: Display free memory
  ansible.builtin.debug:
    msg: "Free memory for this system is {{ ansible_facts['memfree_mb'] }}"
```

#### Displaying Variable Contents

This example displays the value of the `output` variable.

```yaml
- name: Display the "output" variable
  ansible.builtin.debug:
    var: output
    verbosity: 2
```

### Verbosity Parameter

The `verbosity` parameter controls when the `ansible.builtin.debug` module is executed. The value correlates to the number of `-v` options that are specified when the playbook is run. For example, if `-vv` is specified, and `verbosity` is set to 2 for a task, then that task is included in the debug output. The default value of the `verbosity` parameter is 0.

## Reviewing Playbooks for Errors

Several issues can occur during a playbook run, many related to the syntax of either the playbook or any of the templates it uses, or due to connectivity issues with the managed hosts.

A number of tools are available that you can use to review your playbook for syntax errors and other problems before you run it.

### Checking Playbook Syntax for Problems

The `ansible-navigator run` command accepts the `--syntax-check` option, which tests your playbook for syntax errors instead of actually running it.

It is a good practice to validate the syntax of your playbook before using it or if you are having problems with it.

```bash
[student@demo ~]$ ansible-navigator run \
> -m stdout playbook.yml --syntax-check
```

### Checking a Given Task in a Playbook

#### Step Through Mode

You can use the `ansible-navigator run` command with the `--step` option to step through a playbook, one task at a time.

The `ansible-navigator run --step` command interactively prompts for confirmation that you want each task to run:
- Press **Y** to confirm that you want the task to run
- Press **N** to skip the task
- Press **C** to continue running the remaining tasks

```bash
[student@demo ~]$ ansible-navigator run \
> -m stdout playbook.yml --step --pae false

PLAY [Managing errors playbook] **********************************************
Perform task: TASK: Gathering Facts (N)o/(y)es/(c)ontinue:
```

**Important**: Because Ansible prompts you for input when you use the `--step` option, you must disable playbook artifacts and use standard output mode.

#### Start at Specific Task

You can also start running a playbook from a specific task by using the `--start-at-task` option. Provide the name of a task as an argument to the `ansible-navigator run --start-at-task` command.

For example, suppose that your playbook contains a task named `Ensure {{ web_service }} is started`. Use the following command to run the playbook starting at that task:

```bash
[student@demo ~]$ ansible-navigator run \
> -m stdout playbook.yml --start-at-task "Ensure {{ web_service }} is started"
```

#### List Tasks

You can use the `ansible-navigator run --list-tasks` command to list the task names in your playbook.

```bash
[student@demo ~]$ ansible-navigator run \
> -m stdout playbook.yml --list-tasks
```

## Checking Playbooks for Issues and Following Good Practices

One of the best ways to make it easier for you to debug playbooks is for you to follow good practices when writing them in the first place.

### Recommended Practices for Playbook Development

1. **Descriptive Names**: Use a concise description of the play's or task's purpose to name plays and tasks. The play name or task name is displayed when the playbook is executed.

2. **Comments**: Use comments to add additional inline documentation about tasks.

3. **Vertical White Space**: Make effective use of vertical white space. Organize task attributes vertically to make them easier to read.

4. **Consistent Indentation**: Consistent horizontal indentation is critical. Use spaces, not tabs, to avoid indentation errors. Set up your text editor to insert spaces when you press the Tab key.

5. **Simplicity**: Try to keep the playbook as simple as possible. Only use the features that you need.

**Note**: Some Ansible practitioners at Red Hat have been working on an unofficial set of recommended practices for creating Ansible automation content. See [Good Practices for Ansible](https://redhat-cop.github.io/automation-good-practices/).

### Using ansible-lint

Red Hat Ansible Automation Platform 2 provides a tool, `ansible-lint`, that uses a set of predefined rules to look for possible issues with your playbook. Not all the issues that it reports break your playbook, but a reported issue might indicate the presence of a more serious error.

**Important**: The `ansible-lint` command is a Technology Preview in Red Hat Ansible Automation Platform 2.2. Red Hat does not yet fully support this tool.

#### Example ansible-lint Usage

Assume you have the following playbook, `site.yml`:

```yaml
- name: Configure servers with Ansible tools
  hosts: all

  tasks:
    - name: Make sure tools are installed
      package:
        name:
          - ansible-doc
          - ansible-navigator
```

Run the `ansible-lint site.yml` command to validate it. You might get the following output:

```
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml
WARNING  Listing 4 violation(s) that are fatal
yaml: trailing spaces (trailing-spaces)                    # 1
site.yml:2

fqcn-builtins: Use FQCN for builtin actions.              # 2
site.yml:5 Task/Handler: Make sure tools are installed

yaml: trailing spaces (trailing-spaces)                    # 3
site.yml:7

yaml: too many blank lines (1 > 0) (empty-lines)          # 4
site.yml:10

You can skip specific rules or tags by adding them to your configuration file:
# .config/ansible-lint.yml
warn_list:  # or 'skip_list' to silence them completely
  - fqcn-builtins  # Use FQCN for builtin actions.
  - yaml  # Violations reported by yamllint.

Finished with 4 failure(s), 0 warning(s) on 1 files.
```

#### ansible-lint Issues Explained

This run of `ansible-lint` found four style issues:

1. **Trailing spaces**: Line 2 of the playbook (`hosts: all`) has trailing white space, detected by the `yaml` rule.

2. **FQCN requirement**: Line 5 (`package:`) does not use a FQCN for the module name. It should be `ansible.builtin.package:` instead, detected by the `fqcn-builtins` rule.

3. **More trailing spaces**: Line 7 also has trailing white space.

4. **Extra blank lines**: The playbook ends with one or more blank lines, detected by the `yaml` rule.

#### Configuring ansible-lint

The `ansible-lint` tool uses a local configuration file, which is either the `.ansible-lint` or `.config/ansible-lint.yml` file in the current directory. You can edit this configuration file to:

- **Convert rule failures to warnings**: Add them as a list to the `warn_list` directive
- **Skip checks entirely**: Add them as a list to the `skip_list` directive

Example configuration:

```yaml
# .config/ansible-lint.yml
warn_list:  # or 'skip_list' to silence them completely
  - fqcn-builtins  # Use FQCN for builtin actions.
  - yaml  # Violations reported by yamllint.
```

#### Successful ansible-lint Run

After correcting the style issues, the `ansible-lint site.yml` report shows:

```
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml
```

The lack of other output indicates that `ansible-lint` did not detect any other style issues.

### ansible-lint Limitations

**Important**: 
- The `ansible-lint` command evaluates your playbook based on the software on your workstation. It does not use the automation execution environment container that is used by `ansible-navigator`.
- The `ansible-navigator` command has an experimental `lint` option that runs `ansible-lint` in your automation execution environment, but the `ansible-lint` tool needs to be installed inside the automation execution environment's container image for the option to work.
- The version of `ansible-lint` provided with Red Hat Ansible Automation Platform 2.2 assumes that your playbooks are using Ansible Core 2.13. It does not support earlier Ansible 2.9 playbooks.

For more information on `ansible-lint`, see https://docs.ansible.com/lint.html and the `ansible-lint --help` command.

## Reviewing Playbook Artifacts and Log Files

Red Hat Ansible Automation Platform can log the output of playbook runs that you make from the command line in a number of different ways:

- `ansible-navigator` can produce playbook artifacts that store information about runs of playbooks in JSON format
- You can log information about playbook runs to a text file in a location on the system to which you can write

### Playbook Artifacts from Automation Content Navigator

The `ansible-navigator` command produces playbook artifact files by default each time you use it to run a playbook. These files record information about the playbook run, and can be used to:

- Review the results of the run when it completes
- Troubleshoot issues
- Be kept for compliance purposes

#### Artifact File Naming

Each playbook artifact file is named based on:
- The name of the playbook you ran
- Followed by the word "artifact"
- Then the time stamp of when the playbook was run
- Ending with the `.json` file extension

**Example**: If you run the command `ansible-navigator run site.yml` at 20:00 UTC on July 22, 2022, the resulting file name could be:

```
site-artifact-2022-07-22T20:00:04.019343+00:00.json
```

#### Reviewing Artifacts

You can review the contents of these files with the `ansible-navigator replay` command:

- **With `-m stdout` option**: The output of the playbook run is printed to your terminal as if it had just run
- **Without the option**: You can examine the results of the run interactively

#### Example Troubleshooting Scenario

Consider this playbook, `site.yml`, that fails:

```yaml
- name: Configure servers with Ansible tools
  hosts: all

  tasks:
    - name: Make sure tools are installed
      ansible.builtin.package:
        name:
          - ansible-doc
          - ansible-navigator
```

To troubleshoot, you run `ansible-navigator replay` in interactive mode on the resulting artifact file. The interactive interface allows you to:

1. **View play overview**: See all hosts and their overall status
2. **Examine specific tasks**: Look at individual task failures
3. **Review host details**: See detailed error messages for specific hosts
4. **Access fact data**: View all gathered facts from successful Gathering Facts tasks

This can help you debug issues involving Ansible facts without adding a task to the play that uses the `ansible.builtin.debug` module to print out fact values.

#### Disabling Playbook Artifacts

You might not want to save playbook artifacts for several reasons:

- Concerns about sensitive information being saved in the log file
- Need to provide interactive input, such as a password, to `ansible-navigator`
- Don't want the files to clutter up the project directory

You can keep the files from being generated by creating an `ansible-navigator.yml` file in the project directory that disables the playbook artifacts:

```yaml
ansible-navigator:
  playbook-artifact:
    enable: false
```

### Logging Output to a Text File

Ansible provides a built-in logging infrastructure that can be configured through:

- The `log_path` parameter in the `[defaults]` section of the `ansible.cfg` configuration file
- The `$ANSIBLE_LOG_PATH` environment variable (takes precedence over the configuration file)

If a logging path is configured, then Ansible stores output from `ansible-navigator` commands as text in the specified file. This mechanism also works with earlier tools such as `ansible-playbook`.

#### Configuration Example

```ini
# ansible.cfg
[defaults]
log_path = /var/log/ansible.log
```

Or using environment variable:

```bash
export ANSIBLE_LOG_PATH=/var/log/ansible.log
```

**Recommendation**: If you configure Ansible to write log files to the `/var/log` directory, then Red Hat recommends that you configure `logrotate` to manage them.

## Debugging Best Practices

### During Development
1. **Use syntax checking** regularly during development
2. **Add debug tasks** strategically to examine variable values
3. **Follow coding standards** to prevent common issues
4. **Use step mode** for complex playbooks during testing

### During Troubleshooting
1. **Start with syntax check** to eliminate basic errors
2. **Increase verbosity** to get more information about failures
3. **Use playbook artifacts** to examine detailed failure information
4. **Isolate issues** by starting at specific tasks or using step mode

### For Production
1. **Enable logging** to capture playbook execution history
2. **Keep artifacts** for compliance and troubleshooting
3. **Use lint tools** as part of your CI/CD pipeline
4. **Monitor log files** and set up log rotation

### Common Debugging Scenarios

#### Variable Issues
- Use `ansible.builtin.debug` with `var` parameter
- Check variable precedence and scope
- Verify variable file locations and syntax

#### Template Problems
- Use `ansible.builtin.debug` to show rendered template content
- Check Jinja2 syntax and logic
- Verify variable availability in template context

#### Connection Problems
- Use `-vvv` to see connection details
- Check inventory file accuracy
- Verify SSH keys and authentication

#### Module Failures
- Use `-vv` to see module input/output
- Check module documentation for requirements
- Verify required packages and permissions on target hosts

#### Conditional Logic
- Use `ansible.builtin.debug` to show condition evaluation
- Check fact availability and formatting
- Test conditions with different host configurations