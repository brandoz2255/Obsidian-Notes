### **Flag 1: Basic Docker Commands** (Difficulty: 1)

- **Challenge:** List all running Docker containers.
- **Hint:** This flag is hidden in the names of the containers.
- **Objective:** Run the basic `docker ps` command to find the flag in container names or labels.

[[Flag 1 ]]
### **Flag 2: Dockerfile Inspection** (Difficulty: 2)

- **Challenge:** Identify a vulnerability in a given Dockerfile.
- **Hint:** Look for insecure practices, such as running as root or using an outdated base image.
- **Objective:** Examine the Dockerfile, recognize the issue, and extract the flag embedded in a comment.

### **Flag 3: Exposed Ports** (Difficulty: 3)

- **Challenge:** Find an open port that exposes a service running inside a Docker container.
- **Hint:** Use `docker port` to list all port mappings and find the one exposing a vulnerable service.
- **Objective:** Identify the service, connect to it, and retrieve the flag.

### **Flag 4: Environment Variables** (Difficulty: 4)

- **Challenge:** Retrieve sensitive information from environment variables set inside a Docker container.
- **Hint:** Use `docker inspect` to view the environment variables of a running container.
- **Objective:** Extract the flag from the environment variable.

### **Flag 5: Privileged Mode Exploitation** (Difficulty: 5)

- **Challenge:** Exploit a container running in privileged mode to access the host system.
- **Hint:** The container is running with `--privileged`. Look for ways to escalate privileges.
- **Objective:** Gain access to the host and retrieve the flag stored in a file.

### **Flag 6: Docker Volume Misconfiguration** (Difficulty: 6)

- **Challenge:** Exploit a misconfigured Docker volume to access sensitive data on the host.
- **Hint:** The container has a mounted volume pointing to a sensitive directory.
- **Objective:** Access the mounted volume, find the sensitive data, and retrieve the flag.

### **Flag 7: Container Escape** (Difficulty: 8)

- **Challenge:** Escape from a Docker container to the host system.
- **Hint:** There’s a known vulnerability in the container’s environment that allows escape.
- **Objective:** Use the vulnerability to escape the container and retrieve the flag from the host.

### **Flag 8: Docker Swarm Misconfiguration** (Difficulty: 10b - Expert)

- **Challenge:** Exploit a Docker Swarm misconfiguration to take over the entire cluster.
- **Hint:** Look for weakly configured Swarm secrets, poorly managed services, or improper network isolation.
- **Objective:** Gain control of the Swarm manager and retrieve the final flag stored in a secret.