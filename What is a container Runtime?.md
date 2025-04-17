## **What is a Container Runtime?**

A container runtime is software responsible for running containers on a host system. It handles tasks such as:

- Pulling container images from registries.
- Unpacking and starting containers.
- Managing the container lifecycle (e.g., monitoring, restarting, or cleaning up resources).

Container runtimes interact with the host operating system using **Linux namespaces** and **cgroups** to isolate and manage resources for containers. Examples include **containerd**, **CRI-O**, and **Docker** (which itself uses `containerd` internally)

## **How Docker Uses Containerd**

Docker uses **containerd** as its core runtime for managing containers. Here's how it works:

1. **High-Level API:** Docker provides a user-friendly interface for developers to manage containers.
2. **Delegation to Containerd:** Docker delegates container management tasks (e.g., creating, starting, stopping) to containerd.
3. **Low-Level Execution:** Containerd uses **runc** (a low-level runtime adhering to OCI standards) to execute containers.

In essence, Docker acts as a higher-level tool, while containerd handles the actual container lifecycle