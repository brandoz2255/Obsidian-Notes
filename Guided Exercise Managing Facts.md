
# Guided Exercise: Managing Facts

**Path:** `Guided Exercise Managing Facts.md`

---

## What You’ll Learn

By the end of this exercise you’ll be able to:

1. **Collect facts** from a remote host with Ansible.
2. **Inspect those facts** to see what Ansible learned about the machine.
3. **Use the facts** inside a playbook to make decisions (e.g., install a package, start a service).
4. **Create custom facts** that live on the host and are automatically merged into the normal fact set.

> **Why facts matter**  
> Facts are Ansible’s way of “talking to the host.” They give you a snapshot of the machine’s OS, memory, CPU, network, and more. With that snapshot you can write generic playbooks that adapt to each host instead of hard‑coding values.

---

## 1️⃣ Prepare Your Lab Environment

```bash
[student@workstation ~]$ **`lab start data-facts`**
```

> This command pulls the lab image, mounts the shared folder, and makes sure all the tools you need are ready.

---

## 2️⃣ Gather All Facts

Create a tiny playbook that simply prints the entire fact dictionary.

```yaml
---
- name: Display ansible_facts
  hosts: webserver
  tasks:
    - name: Display facts
      ansible.builtin.debug:
        var: ansible_facts
```

Run it with **ansible‑navigator** and look at the output.  
You’ll see a huge JSON blob that contains everything Ansible discovered – OS name, uptime, CPU count, memory, virtualization details, etc.

```bash
[student@workstation data-facts]$ **`ansible-navigator run \`**
> **`-m stdout display_facts.yml`**
```

> **Tip:** Scroll through the output and pick out a few interesting facts (e.g., `system`, `uptime_seconds`, `virtualization_type`).

---

## 3️⃣ Inspect Specific Facts

Now let’s focus on a handful of facts that are useful for everyday tasks.

Create `display_specific_facts.yml`:

```yaml
---
- name: Display specific ansible_facts
  hosts: webserver
  tasks:
    - name: Display specific facts
      ansible.builtin.debug:
        msg: >-
          Host '{{ ansible_facts["fqdn"] }}' with Python
          version '{{ ansible_facts["python_version"] }}'
          has '{{ ansible_facts["processor_count"] }}'
          processors and '{{ ansible_facts["memtotal_mb"] }}'
          MiB of total system memory.
```

Run it:

```bash
[student@workstation data-facts]$ **`ansible-navigator run \`**
> **`-m stdout display_specific_facts.yml`**
```

You should see a friendly sentence that tells you the host’s fully‑qualified domain name, the Python version, how many CPUs it has, and how much RAM it owns.

---

## 4️⃣ Check a Service Before We Do Anything

Create a quick playbook that asks the host whether the `httpd` service is running.

```yaml
---
- name: Check httpd status
  hosts: webserver
  tasks:
    - name: Check httpd status
      ansible.builtin.command: systemctl status httpd
      register: result

    - name: Display httpd status
      ansible.builtin.debug:
        var: result
```

Run it:

```bash
[student@workstation data-facts]$ **`ansible-navigator run \`**
> **`-m stdout check_httpd.yml`**
```

> You should see a **fatal** error because `httpd` isn’t installed yet – that’s exactly what we want to prove.

---

## 5️⃣ Create a Custom Fact on the Host

Custom facts let you add your own key/value pairs that Ansible will automatically merge into `ansible_facts`.

1. **SSH into the host** and create the facts directory.
    
    ```bash
    [student@workstation data-facts]$ **`ssh servera`**
    [student@servera ~]$ **`sudo mkdir -p /etc/ansible/facts.d`**
    [sudo] password for student: **`student`**
    ```
    
2. **Create the fact file** (`custom.fact`) with the package and service you want to manage.
    
    ```bash
    [student@servera ~]$ **`sudo tee /etc/ansible/facts.d/custom.fact > /dev/null <<'EOF'
    [general]
    package = httpd
    service = httpd
    state = started
    enabled = true
    EOF`**
    ```
    
3. **Return to the workstation**.
    
    ```bash
    [student@servera ~]$ **`exit`**
    logout
    Connection to servera closed.
    [student@workstation data-facts]$
    ```
    

> **Why this matters** – When you run `setup` again, Ansible will read `custom.fact` and add those values to `ansible_facts['ansible_local']['custom']['general']`.

---

## 6️⃣ Write a Playbook That Uses the Facts

Create `playbook.yml` with the following header:

```yaml
---
- name: Install Apache and start the service
  hosts: webserver
```

Add the first task that pulls the custom fact into a shorter variable called `custom`.

```yaml
 tasks:
    - name: Set custom variable
      ansible.builtin.set_fact:
        custom: "{{ ansible_facts['ansible_local']['custom']['general'] }}"
```

> **Why `set_fact`?**  
> It lets us store the custom fact in a local variable so we can reference it with a short name (`custom['package']`) instead of the long, nested path.

Now add the tasks that actually install the package and start the service, using the custom variables you just defined.

```yaml
    - name: Install the required package
      ansible.builtin.dnf:
        name: "{{ custom['package'] }}"
        state: latest

    - name: Start the service
      ansible.builtin.service:
        name: "{{ custom['service'] }}"
        state: "{{ custom['state'] }}"
        enabled: "{{ custom['enabled'] }}"
```

> **Quick recap of the variables**
> 
> - `custom['package']` – the name of the package to install (`httpd`).
> - `custom['state']` – whether the service should be `started` or `stopped`.
> - `custom['enabled']` – whether the service should start on boot.

---

## 7️⃣ Verify Syntax

Before running the playbook, make sure Ansible can parse it.

```bash
[student@workstation data-facts]$ **`ansible-navigator run \`**
> **`-m stdout playbook.yml --syntax-check`**
```

> Fix any syntax errors that appear. The output should look like:

```bash
playbook: /home/student/data-facts/playbook.yml
```

---

## 8️⃣ Run the Playbook

```bash
[student@workstation data-facts]$ **`ansible-navigator run \`**
> **`-m stdout playbook.yml`**
```

You should see the following:

```
TASK [Install the required package] ... changed
TASK [Start the service] ... changed
```

> **What happened?**  
> Ansible installed `httpd` and started the service on `servera`.

---

## 9️⃣ Confirm the Service Is Running

Run the check playbook again to make sure `httpd` is now active.

```bash
[student@workstation data-facts]$ **`ansible-navigator run \`**
> **`-m stdout check_httpd.yml`**
```

You should see output similar to:

```
"Active: `active (running)` since Tue 2024-04-23 18:18:18 EDT; 18s ago"
```

> **Congratulations!** The service is running.

---

## 10️⃣ Wrap Up

Return to your home directory and tell the lab system you’re done. This cleans up any temporary files and ensures the next exercise starts fresh.

```bash
[student@workstation ~]$ **`lab finish data-facts`**
```

---

## 🎓 Take‑away Summary

- **Facts** give you a live snapshot of a host.
- **Custom facts** let you add your own data that Ansible treats like any other fact.
- By **using facts** in your playbooks you can write one play that works on many different machines.
- **ansible‑navigator** is your friend for running, checking syntax, and debugging.

---

## Guided Exercise: Managing Facts

Gather Ansible facts from a managed host and use them in plays.

**Outcomes**

You should be able to:

- Gather facts from a host.
- Create tasks that use the gathered facts.

As the `student` user on the `workstation` machine, use the `lab` command to prepare your system for this exercise.

This command prepares your environment and ensures that all required resources are available.

```bash
[student@workstation ~]$ **`lab start data-facts`**
```

```yaml
---
- name: Display ansible_facts
  hosts: webserver
  tasks:
    - name: Display facts
      ansible.builtin.debug:
        var: ansible_facts
```

Use the `ansible-navigator` command to run the `display_facts.yml` playbook. Review the output and observe the values of some variables it displays.

```bash
[student@workstation data-facts]$ **`ansible-navigator run \`**
> **`-m stdout display_facts.yml`**
_...output omitted..._
        "system": "Linux",
        "system_capabilities": [],
        "system_capabilities_enforced": "False",
        "system_vendor": "Red Hat",
        "uptime_seconds": 6775,
        "user_dir": "/root",
        "user_gecos": "root",
        "user_gid": 0,
        "user_id": "root",
        "user_shell": "/bin/bash",
        "user_uid": 0,
        "userspace_architecture": "x86_64",
        "userspace_bits": "64",
        "virtualization_role": "guest",
        "virtualization_tech_guest": [
            "openstack"
        ],
        "virtualization_tech_host": [
            "kvm"
        ],
        "virtualization_type": "openstack"
    }
}

PLAY RECAP *********************************************************************
servera.lab.example.com    : ok=2    changed=0    unreachable=0    failed=0  ...
```

Use the `ansible.builtin.debug` module to view specific facts. Create and run a playbook called `display_specific_facts.yml` that contains a play that displays specific facts for the `webserver` host.

```yaml
---
- name: Display specific ansible_facts
  hosts: webserver
  tasks:
    - name: Display specific facts
      ansible.builtin.debug:
        msg: >-
          Host '{{ ansible_facts["fqdn"] }}' with Python
          version '{{ ansible_facts["python_version"] }}'
          has '{{ ansible_facts["processor_count"] }}'
          processors and '{{ ansible_facts["memtotal_mb"] }}'
          MiB of total system memory.
```

```bash
[student@workstation data-facts]$ **`ansible-navigator run \`**
> **`-m stdout display_specific_facts.yml`**

PLAY [Display specific ansible_facts] ******************************************

TASK [Gathering Facts] *********************************************************
ok: [servera.lab.example.com]

TASK [Display specific facts] **************************************************
ok: [servera.lab.example.com] => {
    "msg": `"Host 'servera.lab.example.com' with Python version '3.9.10' has '1' processors and '960' MiB of total system memory."`
}

PLAY RECAP *********************************************************************
servera.lab.example.com    : ok=2    changed=0    unreachable=0    failed=0  ...
```

```yaml
---
- name: Display specific ansible_facts
  hosts: webserver
  tasks:
    - name: Display specific facts
      ansible.builtin.debug:
        msg: >-
          Host '{{ ansible_facts["fqdn"] }}' with Python
          version '{{ ansible_facts["python_version"] }}'
          has '{{ ansible_facts["processor_count"] }}'
          processors and '{{ ansible_facts["memtotal_mb"] }}'
          MiB of total system memory.

    - name: Display ansible_local variable
      ansible.builtin.debug:
        msg: >-
          The ansible_local variable is set to
          '{{ ansible_facts["ansible_local"] }}'
```

```yaml
[student@workstation data-facts]$ **`ansible-navigator run \`**
> **`-m stdout display_specific_facts.yml`**

_...output omitted..._

TASK [Display ansible_local variable] ******************************************
ok: [servera.lab.example.com] => {
    "msg": `"The ansible_local variable is set to '{}'"`
}

PLAY RECAP *********************************************************************
servera.lab.example.com    : ok=3    changed=0    unreachable=0    failed=0  ...
```


Create the `/etc/ansible/facts.d` directory on `servera`, and then create the `custom.fact` file in that directory. The fact file defines the package to install and the service to start on `servera`.

1. Create the `/etc/ansible/facts.d` directory on `servera`.

```bash
[student@workstation data-facts]$ **`ssh servera`**
[student@servera ~]$ **`sudo mkdir -p /etc/ansible/facts.d`**
[sudo] password for student: **`student`**
```


Create the `custom.fact` file in the `/etc/ansible/facts.d` directory on `servera`. You need elevated privileges to create a file in that directory.

The contents of the file should read as follows:

```bash
[general]
package = httpd
service = httpd
state = started
enabled = true
```


Return to the `workstation` machine.

```bash
[student@servera ~]$ **`exit`**
logout
Connection to servera closed.
[student@workstation data-facts]$
```

Create a play in the `playbook.yml` playbook with the following name and `hosts` directive

```yaml
---
- name: Install Apache and start the service
  hosts: webserver
```

Create the first task for that play. To minimize typing in the play, use the `ansible.builtin.set_fact` module to define a new variable nam

```yaml
 tasks:
    - name: Set custom variable
      ansible.builtin.set_fact:
        custom: "{{ ansible_facts['ansible_local']['custom']['general'] }}"
```

### Note

Because you defined the `custom` variable, you can use the shorter `custom['package']` variable in your play rather than the longer `ansible_facts['ansible_local']['custom']['general']['package']` variable.


```yaml
- name: Install the required package
      ansible.builtin.dnf:
        name: "{{ custom['package'] }}"
        state: latest
```

That task must also use the `custom['state']` variable to determine whether or not to start or stop the service, and the `custom['enabled']` variable to control whether or not it is started when the system boots.

```yaml
- name: Start the service
      ansible.builtin.service:
        name: "{{ custom['service'] }}"
        state: "{{ custom['state'] }}"
        enabled: "{{ custom['enabled'] }}"
```

```yaml
---
- name: Install Apache and start the service
  hosts: webserver
  tasks:
    - name: Set custom variable
      ansible.builtin.set_fact:
        custom: "{{ ansible_facts['ansible_local']['custom']['general'] }}"

    - name: Install the required package
      ansible.builtin.dnf:
        name: "{{ custom['package'] }}"
        state: latest

    - name: Start the service
      ansible.builtin.service:
        name: "{{ custom['service'] }}"
        state: "{{ custom['state'] }}"
        enabled: "{{ custom['enabled'] }}"
```

Verify the syntax of the `playbook.yml` playbook by running the `ansible-navigator run --syntax-check` command. Correct any reported errors before moving to the next step. You should see output similar to the following example:

```bash
[student@workstation data-facts]$ **`ansible-navigator run \`**
> **`-m stdout playbook.yml --syntax-check`**
playbook: /home/student/data-facts/playbook.yml
```

Create and run a playbook called `check_httpd.yml` with the following contents:

```yaml
---
- name: Check httpd status
  hosts: webserver
  tasks:
    - name: Check httpd status
      ansible.builtin.command: systemctl status httpd
      register: result

    - name: Display httpd status
      ansible.builtin.debug:
        var: result
```

Run the `check_httpd.yml` playbook and verify that the `httpd` service is not currently running on the `servera` machine.

```bash
[student@workstation data-facts]$ **`ansible-navigator run \`**
> **`-m stdout check_httpd.yml`**

_...output omitted..._

TASK [Check httpd status] ******************************************************
fatal: [`servera.lab.example.com`]: FAILED! => {"changed": true, "cmd": ["systemctl", "status", "httpd"], "delta": "0:00:00.011462", "end": "2024-04-23 18:11:58.279525", "msg": "non-zero return code", "rc": 4, "start": "2024-04-23 18:11:58.268063", "stderr": `"Unit httpd.service could not be found."`, "stderr_lines": ["Unit httpd.service could not be found."], "stdout": "", "stdout_lines": []}

PLAY RECAP *********************************************************************
servera.lab.example.com    : ok=1    changed=0    unreachable=0    failed=1  ...
Please review the log for errors.
```

```bash
[student@workstation data-facts]$ **`ansible-navigator run \`**
> **`-m stdout playbook.yml`**

PLAY [Install Apache and start the service] ************************************

TASK [Gathering Facts] *********************************************************
ok: [servera.lab.example.com]

TASK [Set custom variable] *****************************************************
ok: [servera.lab.example.com]

TASK [Install the required package] ********************************************
changed: [servera.lab.example.com]

TASK [Start the service] *******************************************************
changed: [servera.lab.example.com]

PLAY RECAP *********************************************************************
servera.lab.example.com    : ok=4    changed=2    unreachable=0    failed=0  ...
```

```bash
[student@workstation data-facts]$ **`ansible-navigator run \`**
> **`-m stdout check_httpd.yml`**
_...output omitted..._
        "stdout_lines": [
            "● httpd.service - The Apache HTTP Server",
            "     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)",
            "     Active: `active (running)` since Tue 2024-04-23 18:18:18 EDT; 18s ago",
_...output omitted..._
```

**Finish**

On the workstation machine, change to the `student` user home directory and use the `lab` command to complete this exercise. This step is important to ensure that resources from previous exercises do not impact upcoming exercises.

```bash
[student@workstation ~]$ **`lab finish data-facts`**
```