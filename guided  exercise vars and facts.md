

# Guided Exercise: Managing Variables in Ansible

**Goal:**

- Define variables in a playbook.
- Create tasks that use those variables.

---

## 1️⃣ Prepare the Lab Environment

```bash
# On the workstation machine
lab start data-variables
```

> This command pulls the required resources and sets up the workspace.

---

## 2️⃣ Navigate to the Exercise Folder

```bash
cd /home/student/data-variables
```

---

## 3️⃣ Create the Playbook

Create a file named **`playbook.yml`** and add the following content.  
The playbook contains two plays:

1. **Deploy and start Apache HTTPD service** – runs on the `webserver` group.
2. **Verify the Apache service** – runs on the `workstation` host.

```yaml
---
- name: Deploy and start Apache HTTPD service
  hosts: webserver
  vars:
    web_pkg: httpd
    firewall_pkg: firewalld
    web_service: httpd
    firewall_service: firewalld
    rule: http

  tasks:
    - name: Required packages are installed and up to date
      ansible.builtin.dnf:
        name:
          - "{{ web_pkg }}"
          - "{{ firewall_pkg }}"
        state: latest

    - name: The {{ firewall_service }} service is started and enabled
      ansible.builtin.service:
        name: "{{ firewall_service }}"
        enabled: true
        state: started

    - name: The {{ web_service }} service is started and enabled
      ansible.builtin.service:
        name: "{{ web_service }}"
        enabled: true
        state: started

    - name: Web content is in place
      ansible.builtin.copy:
        content: "Example web content"
        dest: /var/www/html/index.html

    - name: The firewall port for {{ rule }} is open
      ansible.posix.firewalld:
        service: "{{ rule }}"
        permanent: true
        immediate: true
        state: enabled

- name: Verify the Apache service
  hosts: workstation
  become: false
  tasks:
    - name: Ensure the webserver is reachable
      ansible.builtin.uri:
        url: http://servera.lab.example.com
        status_code: 200
```

### Why These Variables?

| Variable           | What it represents            | Where it’s used  |
| ------------------ | ----------------------------- | ---------------- |
| `web_pkg`          | Apache package name           | `dnf` task       |
| `firewall_pkg`     | Firewall package name         | `dnf` task       |
| `web_service`      | Service to manage (httpd)     | `service` task   |
| `firewall_service` | Service to manage (firewalld) | `service` task   |
| `rule`             | Firewall service name to open | `firewalld` task |

> **Tip:** Using `{{ variable }}` inside double quotes tells Ansible to replace the placeholder with the actual value.

---

## 4️⃣ Verify Syntax Before Running

```bash
ansible-navigator run -m stdout playbook.yml --syntax-check
```

_If you see any errors, fix them before proceeding._

---

## 5️⃣ Run the Playbook

```bash
ansible-navigator run -m stdout playbook.yml
```

Watch the output. You should see something like:

```
PLAY [Deploy and start Apache HTTPD service] **************

TASK [Gathering Facts] **************
ok: [servera.lab.example.com]

TASK [Required packages are installed and up to date] **************
changed: [servera.lab.example.com]

TASK [The firewalld service is started and enabled] **************
ok: [servera.lab.example.com]

TASK [The httpd service is started and enabled] **************
changed: [servera.lab.example.com]

TASK [Web content is in place] **************
changed: [servera.lab.example.com]

TASK [The firewall port for http is open] **************
changed: [servera.lab.example.com]

PLAY [Verify the Apache service] **************

TASK [Gathering Facts] **************
ok: [workstation]

TASK [Ensure the webserver is reachable] **************
ok: [workstation]

PLAY RECAP **************
servera.lab.example.com    : ok=6    changed=4
workstation                : ok=2    changed=0
```

> All tasks should finish with `ok` or `changed` – no failures.

---

## 6️⃣ Finish the Lab

```bash
lab finish data-variables
```

> This cleans up any temporary files so they don’t interfere with future exercises.

---

## 📚 Quick Reference – Modules Used

| Module                    | Purpose                  | Key Parameters                               |
| ------------------------- | ------------------------ | -------------------------------------------- |
| `ansible.builtin.dnf`     | Install/upgrade packages | `name`, `state`                              |
| `ansible.builtin.service` | Manage services          | `name`, `enabled`, `state`                   |
| `ansible.builtin.copy`    | Copy files or content    | `content`, `dest`                            |
| `ansible.posix.firewalld` | Configure firewalld      | `service`, `permanent`, `immediate`, `state` |
| `ansible.builtin.uri`     | Test HTTP endpoints      | `url`, `status_code`                         |

---

## ✅ Checklist

- [ ] Lab environment started (`lab start data-variables`).
- [ ] Changed to `/home/student/data-variables`.
- [ ] Created `playbook.yml` with two plays.
- [ ] Variables defined in the `vars` section.
- [ ] Tasks use those variables (`{{ var }}`).
- [ ] Syntax‑check passed (`ansible-navigator run --syntax-check`).
- [ ] Playbook ran successfully (`ansible-navigator run`).
- [ ] Lab finished (`lab finish data-variables`).