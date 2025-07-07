## 🧾 Kubernetes + NVIDIA GPU on Arch Linux (k3s + containerd) — Implementation Guide

### 🧩 Context

- **System**: Arch Linux with NVIDIA RTX 3070
- **Cluster**: Single-node `k3s`
- **Runtime**: `containerd`
- **Goal**: Enable Kubernetes workloads to access the GPU via the NVIDIA device plugin

```bash
Pod (with runtimeClassName: nvidia)
  │
  ▼
Kubelet
  └── uses containerd runtime class → nvidia-container-runtime
        └── Injects NVIDIA GPU devices, libraries, and env vars
```

## 🔧 Key Fixes That Made It Work

### 1. **Install NVIDIA Drivers and Container Toolkit**

Confirmed the host had working NVIDIA setup:

```bash
nvidia-smi
sudo ctr run --rm --gpus 0 docker.io/nvidia/cuda:11.8.0-devel-ubuntu22.04 test nvidia-smi
```

- Which worked 
- Ran `containerd` and tested  my `containerd` conf with `nvidia` and ran perfectly 
- but `k8s` didn't work which uses `containerd`

### 2. **Configure `containerd` to Use NVIDIA Runtime**

Edited `/etc/rancher/k3s/agent/etc/containerd/config.toml` and added:

```bash
[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia]
  runtime_type = "io.containerd.runc.v2"
  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia.options]
    BinaryName = "/usr/bin/nvidia-container-runtime"
```

Restarted k3s and containerd:

```bash
sudo systemctl restart k3s
```

---

### 3. **Create a `RuntimeClass` in Kubernetes**

Created and applied the following:

```bash
apiVersion: node.k8s.io/v1
kind: RuntimeClass
metadata:
  name: nvidia
handler: nvidia
```

```bash
kubectl apply -f runtimeclass-nvidia.yaml
```



💡 This tells `Kubernetes` to use the NVIDIA runtime when `runtimeClassName`: `nvidia` is specified in a pod or `daemonset`.


### 4. **Deploy NVIDIA Device Plugin DaemonSet with RuntimeClass**

Created a custom DaemonSet with:

```yaml
spec:
  runtimeClassName: nvidia
```

✅ Environment flags:

```yaml
env:
  - name: NVIDIA_DRIVER_CAPABILITIES
    value: "compute,utility"
  - name: NVIDIA_DISABLE_REQUIRE
    value: "true"
```

✅ Correct mounts (Arch-specific path to libnvidia-ml.so.1):

```yaml
volumeMounts:
  - name: libnvidia-ml
    mountPath: /usr/lib/libnvidia-ml.so.1
    readOnly: true
volumes:
  - name: libnvidia-ml
    hostPath:
      path: /usr/lib/libnvidia-ml.so.1
      type: File
```

Also mounted `/dev/nvidia*` devices.

---

5. **Restarted the Plugin Daemon**

```bash
kubectl delete pod -n kube-system -l name=nvidia-device-plugin-ds
```

### ✅ Final Validation

1. **Confirmed working device plugin logs**:

```bash
kubectl logs -n kube-system -l name=nvidia-device-plugin-ds | grep NVML
```

```bash
Detected NVML platform: found NVML library
```

## 🔍 Why This Fix Worked

`Kubernetes` **does not automatically use the NVIDIA runtime** even if `containerd` is configured. The `RuntimeClass` bridges that gap:

| Layer         | Role                                                   |
| ------------- | ------------------------------------------------------ |
| containerd    | Has `nvidia` runtime config pointing to correct binary |
| RuntimeClass  | Maps pod runtime to containerd's `nvidia` handler      |
| DaemonSet Pod | Uses `runtimeClassName: nvidia` to get GPU injection   |

Without `runtimeClassName`, your container is just a normal one  it won’t have `/dev/nvidia*` or the necessary `libnvidia-ml.so` access.


---

## 🧠 Notes for Future

- On Arch, library paths and driver versions are often bleeding-edge. Stick to **tested driver/toolkit combos**.
- Always **restart k3s** if changing runtime configs.
- You can now deploy GPU workloads with:

```bash
resources:
  limits:
    nvidia.com/gpu: 1
```

