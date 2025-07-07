### 3. ⚙️ **Capability Escalation / Missed Seccomp Filters**

The NVIDIA runtime _modifies container specs_ to allow GPU access, often modifying `seccomp`/`apparmor`/profile options.

Look for:

- Capabilities (like `CAP_SYS_ADMIN`, `CAP_MKNOD`) added when they shouldn't be
- `--privileged` flags used implicitly for GPU access
- `AppArmor` unconfined for certain GPU ops

### What to learn 

- Capabilities of `Nvidia` container runtime
- privileged flags 
- `AppArmor` 

---
### 4. 🧱 **Poor Input Sanitization in GPU Runtime Hooks**

The NVIDIA container runtime uses **Go-based hooks** injected into OCI flows (e.g., `prestart`, `poststart`).

Look for:

- Untrusted environment variable parsing (`NVIDIA_VISIBLE_DEVICES`)
- Arbitrary path or regex injection in `nvidia-container-cli`
- Path traversal in custom mount points

Hook source: [https://github.com/NVIDIA/nvidia-container-runtime/](https://github.com/NVIDIA/nvidia-container-runtime/)

- Hooks
- GO-based books
- OCI 
- OCI Flows Prestart and poststart
- env var parsing 
- regex injection uing cli
- Path traversal custom mounts



----

- Plan of Attack
- Test One
- Test Two
- Test Three