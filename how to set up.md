### Load order for Prometheus 

- **Deploy Order**: Apply manifests in this order:
    
    1. `namespace.yaml`
        
    2. `cluster-role.yaml` (with ServiceAccount)
    3. `Prometheus-pvc.yaml` 
        
    3. `config-map.yaml`
        
    4. `deployment.yaml`
        
    5. `service.yaml`

All this must be done within  the Ubuntu VM  make sure to configure Ansible in this order to apply the manifests 

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

```


---

- [[k8s promethues]]