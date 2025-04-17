- To `installl` `k3s` via `ansible` use the playbook provided on `github` or `gitlab` but download the script via `curl`

```bash
curl https://get.k3s.io -o install_k3s.sh
```

```bash
 chmod +x install_k3s.sh
```

```yaml
---
- name: Install k3s on target nodes
  hosts: rocky_vms
  become: true
  tasks:
    - name: Install k3s via official install script
      shell: curl -sfL https://get.k3s.io | sh -
```

- use this instead 

