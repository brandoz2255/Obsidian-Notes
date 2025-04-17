### How It Works

1. **Secrets:**
    
    - The `postgres-secret.yaml` file secures your DB password. Other containers can connect to PostgreSQL by referencing this service, and you keep your credentials safe.
2. **PVC:**
    
    - The `postgres-pvc.yaml` file ensures that your PostgreSQL data is persistent, meaning your data survives pod restarts.
3. **Deployment:**
    
    - The `postgres-deployment.yaml` file runs the container with the proper environment variables and mounts the PVC so data is stored in the persistent volume.
4. **Service:**
    
    - The `postgres-service.yaml` file exposes your PostgreSQL database within the cluster, allowing your other apps or remote nodes to connect using the service name.