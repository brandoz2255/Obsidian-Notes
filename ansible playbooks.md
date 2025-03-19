
### Deploy the k8s playbook

```yaml
---
- name: Deploy Kubernetes Manifests to VMs
  hosts: ubuntu_vms
  become: true
  tasks:
    - name: Create directory for Kubernetes manifests
      file:
        path: /tmp/k8s-manifests/prometheus
        state: directory
        mode: "0755"

    - name: Copy Kubernetes manifests to target node
      copy:
        src: "{{ item.src }}"
        dest: "{{ item.dest }}"
        mode: "0644"
      loop: # cluster-role.yaml config-map.yaml deployment.yaml namespace.yaml prometheus-pvc.yaml service.yaml
        - { src: "/home/dulc3/Documents/GitHub/DevSecOps/homelab/k8s/prometheus/cluster-role.yaml", dest: "/tmp/k8s-manifests/prometheus/cluster-role.yaml" }
        - { src: "/home/dulc3/Documents/GitHub/DevSecOps/homelab/k8s/prometheus/config-map.yaml", dest: "/tmp/k8s-manifests/prometheus/config-map.yaml" }
        - { src: "/home/dulc3/Documents/GitHub/DevSecOps/homelab/k8s/prometheus/deployment.yaml", dest: "/tmp/k8s-manifests/prometheus/deployment.yaml" }
        - { src: "/home/dulc3/Documents/GitHub/DevSecOps/homelab/k8s/prometheus/namespace.yaml", dest: "/tmp/k8s-manifests/prometheus/namespace.yaml" }
        - { src: "/home/dulc3/Documents/GitHub/DevSecOps/homelab/k8s/prometheus/prometheus-pvc.yaml", dest: "/tmp/k8s-manifests/prometheus/prometheus-pvc.yaml" }
        - { src: "/home/dulc3/Documents/GitHub/DevSecOps/homelab/k8s/prometheus/service.yaml", dest: "/tmp/k8s-manifests/prometheus/service.yaml" }

    - name: Create the monitoring namespace
      shell: |
        k3s kubectl create namespace monitoring || echo "Namespace monitoring already exists"
      args:
        executable: /bin/bash

    - name: Check if kubectl is installed
      command: kubectl version --client
      register: kubectl_check
      failed_when: kubectl_check.rc != 0

    - name: Apply Kubernetes manifests
      shell: |
        k3s kubectl apply -f /tmp/k8s-manifests/prometheus/namespace.yaml
        k3s kubectl apply -f /tmp/k8s-manifests/prometheus/cluster-role.yaml
        k3s kubectl apply -f /tmp/k8s-manifests/prometheus/prometheus-pvc.yaml
        k3s kubectl apply -f /tmp/k8s-manifests/prometheus/config-map.yaml
        k3s kubectl apply -f /tmp/k8s-manifests/prometheus/deployment.yaml
        k3s kubectl apply -f /tmp/k8s-manifests/prometheus/service.yaml

      args:
        executable: /bin/bash 
```


### Ubuntu VM provision 

- The main playbook to use first 

```yaml
---
- name: Setup Ubuntu VMs
  hosts: ubuntu_vms
  become: true
  vars:
    user_name: DevOps
    shell: /bin/bash
    user_password: "{{ 'DevSecOps' | password_hash('sha512') }}"
    user_group: engineers
    docker_packages:
      - apt-transport-https
      - ca-certificates
      - curl
      - software-properties-common

  tasks:
    - name: Ensure group 'engineers' exists
      group:
        name: "{{ user_group }}"
        state: present

    - name: Ensure user 'DevOps' exists
      user:
        name: "{{ user_name }}"
        password: "{{ user_password }}"
        shell: "{{ shell }}"
        groups: "{{ user_group }}"
        append: yes
        state: present

    - name: Add DevOps user to sudoers
      copy:
        dest: /etc/sudoers.d/{{ user_name }}
        content: "{{ user_name }} ALL=(ALL) NOPASSWD:ALL"
        mode: '0440'
        validate: '/usr/sbin/visudo -cf %s'

    - name: Install prerequisite packages for Docker
      apt:
        name: "{{ docker_packages }}"
        state: present
        update_cache: yes

    - name: Add Docker GPG key
      apt_key:
        url: https://download.docker.com/linux/ubuntu/gpg
        state: present

    - name: Add Docker repository
      apt_repository:
        repo: deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable
        state: present

    - name: Install Docker
      apt:
        name: docker-ce
        state: present
        update_cache: yes

    - name: Start and enable Docker service
      systemd:
        name: docker
        enabled: yes
        state: started
```

### Installs k3s 

- For `Kubernetes`

```yaml
---
- name: Install k3s on target nodes
  hosts: ubuntu_vms
  become: yes
  tasks:
    - name: Run k3s installation script
      ansible.builtin.script: ./install_k3s.sh
```

- Requires the k3s install script 

### Inventory

```yaml
[ubuntu_vms]
ubuntu-vm1 ansible_host=127.0.0.1 ansible_port=2222 ansible_user=vagrant ansible_ssh_private_key_file=/home/dulc3/Documents/GitHub/DevSecOps/homelab/.vagrant/machines/ubuntu-vm1/virtualbox/private_key ansible_ssh_common_args='-F ./vagrant_ssh_config'
ubuntu-vm2 ansible_host=127.0.0.1 ansible_port=2200 ansible_user=vagrant ansible_ssh_private_key_file=/home/dulc3/Documents/GitHub/DevSecOps/homelab/.vagrant/machines/ubuntu-vm2/virtualbox/private_key ansible_ssh_common_args='-F ./vagrant_ssh_config'

```

- This is the inventory it tells ansible what ssh keys to use for getting into  the VMs to configure it 
- The vagrant ssh config is needed to be in the same directory as the inventory file