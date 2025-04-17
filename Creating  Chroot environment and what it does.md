## **3. `chroot` ("Change Root")**

## What It Does

Isolates a process to a `subdirectory`, preventing access to the wider `filesystem`.  
Commonly used for:

- Secure testing environments
- Legacy software containment

```bash
# Create a minimal environment
mkdir -p /jail/{bin,lib64}
cp /bin/bash /jail/bin/
cp $(ldd /bin/bash | awk '/=>/ {print $3}') /jail/lib64/
```

- **`awk` command:** Extracts library paths needed by `bash` to run in the jail.

## **4. Beyond File Permissions: OS Hardening**

## Privilege Escalation Prevention

- **Kernel protections:** Address Space Layout Randomization (ASLR), SELinux/AppArmor.
- **SUID/SGID restrictions:** Remove unnecessary `setuid`/`setgid` flags (e.g., `chmod u-s /bin/old_tool`).
- **Log monitoring:** Tools like `auditd` track suspicious activity (e.g., failed `sudo` attempts in `auth.log`[1](https://betterstack.com/community/guides/logging/monitoring-linux-auth-logs/)[2](https://www.libertycenterone.com/blog/linux-security-logs/)).


