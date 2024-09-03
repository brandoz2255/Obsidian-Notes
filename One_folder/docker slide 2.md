### **Docker: DSL, Dockerfile, and Architecture**

---

**Docker's Domain-Specific Language (DSL)**

- **Dockerfile**:
    - Text document with commands to assemble a Docker image
    - Defines step-by-step image creation process
    - Essential for developing apps/systems within containers
- **Docker Image**:
    - Created using a Dockerfile
    - Encapsulates the app, dependencies, and environment configuration

---

**Docker Architecture: Client-Server Model**

- **Docker Client**:
    - User interface for interacting with Docker
    - Communicates with the Docker daemon to manage containers
- **Docker Daemon**:
    - Handles the building, running, and distributing of Docker containers
- **Client-Daemon Interaction**:
    - Can run on the same system or connect remotely via REST API over UNIX socket/network