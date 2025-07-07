# Enabling GPU Access in K3s (Kubernetes) on Arch Linux with NVIDIA RTX 3070


## ⚙️ Overview

In this guide, we enabled GPU access for AI workloads on a **K3s Kubernetes cluster running on Arch Linux**, specifically to run **Mistral 7B** and **LLaMA 8B** models accelerated by an **NVIDIA RTX 3070 GPU**.

The GPU integration involved three key components:

1. NVIDIA GPU driver (for hardware access)
2. NVIDIA Container Toolkit (to enable GPU in containers)
3. NVIDIA `Kubernetes` device plugin (to expose `GPUs` to `K3s`)
    

---

## 🏗️ 1. Why GPU Access in Kubernetes Needs Extra Work

Kubernetes itself does **not natively understand GPUs**. By default, it only schedules workloads based on CPU and memory. GPUs are considered “special resources” and require:

- Drivers at the host level 
- Runtime support in the container runtime (`containerd` or `docker`)
- A Kubernetes-compatible plugin to make GPUs available for pod scheduling (`nvidia-device-plugin`)

This makes the setup **multi-layered**. If any layer is missing or misconfigured, Kubernetes won’t be able to assign a pod to use a GPU.

## 📦 2. Installing NVIDIA Drivers on Arch Linux

First, we installed the **NVIDIA kernel module and user-space utilities**, which allow Linux to communicate with the RTX 3070.## 📦 2. Installing NVIDIA Drivers on Arch Linux

First, we installed the **NVIDIA kernel module and user-space utilities**, which allow Linux to communicate with the RTX 3070.

```bash
sudo pacman -Syu nvidia nvidia-utils
```

This makes the GPU accessible to your OS. We verified it with:

```bash
nvidia-smi
```

This command queries the GPU and shows memory usage, running processes, and driver version. Without this, container runtimes cannot use the GPU.

## 🐳 3. Installing NVIDIA Container Runtime

Containers need special support to access GPUs, since they normally run in isolated namespaces. That support is provided by the **NVIDIA Container Toolkit**.

```bash
yay -S nvidia-container-toolkit
```

This toolkit includes:

- `nvidia-container-runtime`: a custom runtime wrapper that injects GPU drivers and libraries into the container
- Hooks for `containerd` or Docker to enable GPU access

After installing, we verified that the runtime binary existed:

```bash
which nvidia-container-runtime
# Should return: /usr/bin/nvidia-container-runtime
```

## 📁 4. Configuring `containerd` to Use the NVIDIA Runtime

K3s uses `containerd` under the hood instead of Docker. We needed to tell containerd to support the **NVIDIA runtime**.

### Step-by-step breakdown:

#### A. Backup and regenerate a clean config file:

```bash
sudo mv /etc/containerd/config.toml /etc/containerd/config.toml.bak
containerd config default | sudo tee /etc/containerd/config.toml > /dev/null
```

This gives us a complete and valid configuration template. Arch doesn’t always generate this automatically, so it’s essential.

#### B. Add GPU runtime config:

We edited `/etc/containerd/config.toml` and added this block under the CRI plugin section:

```toml
[plugins."io.containerd.grpc.v1.cri".containerd]
  snapshotter = "overlayfs"
  default_runtime_name = "runc"

  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
    runtime_type = "io.containerd.runc.v2"

  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia]
    runtime_type = "io.containerd.runc.v2"
    [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia.options]
      BinaryName = "/usr/bin/nvidia-container-runtime"
[plugins."io.containerd.grpc.v1.cri".containerd]
  snapshotter = "overlayfs"
  default_runtime_name = "runc"

  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
    runtime_type = "io.containerd.runc.v2"

  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia]
    runtime_type = "io.containerd.runc.v2"
    [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia.options]
      BinaryName = "/usr/bin/nvidia-container-runtime"
```

### Why this matters:

- It defines a **new runtime** called `nvidia` that containerd can use
- It tells containerd to launch containers using the NVIDIA runtime when `nvidia.com/gpu` is requested
- The `BinaryName` is the actual GPU-aware wrapper

```bash
sudo systemctl daemon-reexec
sudo systemctl restart containerd
sudo systemctl restart k3s
```

This ensures that the new configuration is loaded and Kubernetes can start scheduling GPU workloads.

---

## 📦 5. Deploying the NVIDIA Kubernetes Device Plugin

The final piece is to make Kubernetes itself aware of the GPU — this is done by deploying the **NVIDIA Device Plugin** DaemonSet

```bash
kubectl create -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/v0.14.0/nvidia-device-plugin.yml
```

### What this does:

- Installs a DaemonSet that runs on each node
- Detects NVIDIA GPUs and registers them as `nvidia.com/gpu` resources with the Kubelet
- Enables GPU-aware scheduling in Kubernetes

```bash
kubectl get pods -n kube-system | grep nvidia
```

Then, we checked GPU availability:

```bash
kubectl describe node <node-name> | grep -i nvidia
```


---

## 🧪 6. GPU Test Pod

We validated the entire setup by running a pod that uses `nvidia/cuda:11.8.0-base` and runs `nvidia-smi` inside:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: gpu-test
spec:
  containers:
    - name: cuda-container
      image: nvidia/cuda:11.8.0-base
      command: [ "nvidia-smi" ]
      resources:
        limits:
          nvidia.com/gpu: 1
  restartPolicy: Never
```

- Error GPU test pod failed because of no runtime container class was specified and on arch linux the files for nvidia are different 
- its in lib/ instead of usr/ like RHEL based distros which this manifests was made for
- [[Container run time class]]