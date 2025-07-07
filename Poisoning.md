### 5. 📦 **Poisoning the Runtime Environment**

You can manipulate:

- `/etc/nvidia-container-runtime/config.toml`
- GPU plugin configmap in GPU Operator (K8s)
- `Env` vars like `LD_PRELOAD`, `PATH`, `HOME` if the hook process runs `unsanitized` code

Use malicious images + crafted `OCI` configs.


