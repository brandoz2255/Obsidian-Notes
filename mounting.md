what to check 


---

## 🧨 Potential Bug Classes to Hunt in NVIDIA Container Toolkit

### 1. 🔁 **Race Conditions & TOCTOU Variants**

- **CVE-2024-0132** is a classic TOCTOU — but look for:
    
    - Race between `nvidia-container-runtime` checking mount paths and image unpacking.
    - Race between unpacking + runtime validation → mount hijack.4
    - Exploit `overlayfs` + writable layers to remap host paths into view after validation.

💡 Tip: Mount `/etc/shadow`, `/proc/1/root/`, or even `/var/lib/docker/overlay2` if the runtime unsafely follows symlinks or re-validates late.

### What to learn

- `nvidia container runtime`
- `TOCTOU` 
- `overlayfs`

---
## Second area to  check

### 2. 🔗 **Symlink or Bind Mount Abuse**

If `nvidia-container-runtime` or its helpers:

- Follow `user-controlled symlinks`,
- Use `filepath.EvalSymlinks()` naively,
- Or trust paths in `OCI` `JSON` descriptors...

➡ You may be able to get access to arbitrary host paths (esp. if combined with `--mount` in Docker/K8s).

### What to learn

- Symlink 
- Binding
- user-controlled symlink
- filepath.EvalSymlinks()

---

### Stage one 
Mounting in important file and what it can do such as `/proc/1/root` or even `/var/lib/docker/overlay2` and the passwords file `/etc/shadow`

### Stage two
Symlink bind abuse using the user-controlled symlinks or filepath.EvalSymlinks() and trusting any OCI and JSON Descriptors

- Plan of attack
- Test one 
- Test Two
- Test Three