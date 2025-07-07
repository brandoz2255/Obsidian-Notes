### 🛡️ **Container Security Features**

1. **Principle of Least Privilege (PoLP):** Containers are designed to run applications with only the permissions they need, nothing more. By avoiding running containers as root and limiting access rights, we reduce the potential impact of a breach. This means that even if an attacker compromises a container, their ability to affect the host system or other containers is minimized. [Aqua](https://www.aquasec.com/cloud-native-academy/container-security/container-security-best-practices/?utm_source=chatgpt.com)​
2. **Sandboxing:** Containers provide an isolated environment for applications. This sandboxing ensures that processes within a container don't interfere with the host system or other containers. Tools like **gVisor** enhance this isolation by intercepting system calls, adding an extra layer of security. [Wikipedia](https://en.wikipedia.org/wiki/GVisor?utm_source=chatgpt.com)​
3. **Immutable Infrastructure:** Containers are typically built from images that don't change during runtime. This immutability ensures consistency across environments and makes it easier to detect unauthorized changes. If an update is needed, a new container image is deployed rather than modifying the existing one.​
4. **Network Segmentation:** Containers can be configured to communicate only with specific services, reducing the risk of lateral movement by attackers. Implementing network policies ensures that even if one container is compromised, the attacker can't easily access others. ​[Tigera](https://www.tigera.io/learn/guides/container-security-best-practices/?utm_source=chatgpt.com)
5. **Runtime Security Measures:** Tools like **Seccomp** and **AppArmor** can restrict the system calls a container can make, further tightening security. These measures prevent containers from performing potentially harmful operations, even if compromised. [Wikipedia](https://en.wikipedia.org/wiki/Seccomp?utm_source=chatgpt.com)



