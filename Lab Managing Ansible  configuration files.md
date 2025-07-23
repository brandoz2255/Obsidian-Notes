### Lab 2: Managing Ansible Configuration Files

This lab guides you through customizing your Ansible environment with configuration files.

```bash
lab start playbook-manage
```

**Navigate to the Directory**:

- Change into the correct directory:

```bash
cd /home/student/playbook-manage
```

**Configure `ansible-navigator`**:

- Create a file named
    
    `ansible-navigator.yml` in the current directory.

```yaml
---
ansible-navigator:
  execution-environment:
    image: utility-lab.example.com/ee-supported-rhel8:latest
    pull:
      policy: missing
  playbook-artifact:
    enable: false
```

Verify the execution environment images are available:

```bash
ansible-navigator images
```

**Create the `ansible.cfg` File**:

- Create a new file named
    
    `ansible.cfg` in the same directory (`/home/student/playbook-manage`).

```toml
[defaults]
inventory = inventory
```

**Create the Inventory File**:

- Create a new inventory file named
    
    `inventory` in the same directory.

This inventory will have four host groups:

`myself`, `intranetweb`, `internetweb`, and a group of groups called `web`.


```toml
[myself]
workstation.lab.example.com

[intranetweb]
servera.lab.example.com

[internetweb]
serverb.lab.example.com

[web:children]
intranetweb
internetweb
```

**Test the Configuration**:

- Run the provided playbooks to test the host groups you just configured.

For the

`myself` group:

```bash
ansible-navigator run --stdout ping-myself.yml
```

- For the
    
    `intranetweb` group

```bash
ansible-navigator run --stdout ping-intranetweb.yml
```


For the

`internetweb` group:

```bash
ansible-navigator run --stdout ping-internetweb.yml
```

**Update `ansible.cfg` for Privilege Escalation**:

- Open the
    
    `ansible.cfg` file again.

Modify it to connect as the

`student` user, use `sudo` for privilege escalation, and prompt for the sudo password. The final file should look like this:

```toml
[defaults]
inventory = inventory
remote_user = student

[privilege_escalation]
become = true
become_method = sudo
become_user = root
become_ask_pass = true
```

**Verify the Final Configuration**:

- Run the playbook for the `intranetweb` group again. This time, you should be prompted for a password. Enter

`student` when prompted.

```bash
ansible-navigator run --stdout ping-intranetweb.yml
```


**Finish the Lab**:

- To complete the exercise, run the finish command:

```bash
lab finish playbook-manage
```

