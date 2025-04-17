## 1. **Secret Configuration: `postgres-secret.yaml`**

**Purpose:**  
Safely stores sensitive data, such as the PostgreSQL password, ensuring it's not hard-coded into the deployment manifests.​

**Breakdown:**

- **`apiVersion: v1` & `kind: Secret`:**  
    Defines this resource as a Secret, a `Kubernetes` object designed to hold confidential data.​[Earthly Lunar](https://earthly.dev/blog/kubernetes-secrets/?utm_source=chatgpt.com)
    
- **`metadata`:**
    
    - **`name: postgres-secret`:**  
        Names the Secret `postgres-secret` for reference in other configurations.
        
    - **`namespace: default`:**  
        Specifies that the Secret resides in the `default` namespace.
        
- **`type: Opaque`:**  
    Indicates a generic Secret type suitable for arbitrary data.​[Medium+1Earthly Lunar+1](https://medium.com/%40nguruben/step-by-step-guide-installing-postgresql-on-kubernetes-a15a8f434d6c?utm_source=chatgpt.com)
    
- **`data`:**
    
    - **`postgres-password`:**  
        Holds the `base64`-encoded password. For instance, encoding `supersecretpass` yields `c3VwZXJzZWNyZXRwYXNz`.

**How It Works:**  
This Secret allows the PostgreSQL Deployment to access the database password securely without exposing it in `plaintext` within the Deployment manifest.​[Medium](https://medium.com/%40nguruben/step-by-step-guide-installing-postgresql-on-kubernetes-a15a8f434d6c?utm_source=chatgpt.com)

---

## 2. **Persistent Volume Claim: `postgres-pvc.yaml`**

**Purpose:**  
Requests persistent storage from `Kubernetes` to ensure database data persists across pod restarts or rescheduling.​[DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-deploy-postgres-to-kubernetes-cluster?utm_source=chatgpt.com)

**Breakdown:**

- **`apiVersion: v1` & `kind: PersistentVolumeClaim`:**  
    Defines this resource as a `PersistentVolumeClaim` (`PVC`), which requests storage resources.​
    
- **`metadata`:**
    
    - **`name: postgres-pvc`:**  
        Names the PVC `postgres-pvc` for reference in the Deployment.
        
    - **`namespace: default`:**  
        Places the PVC in the `default` namespace.
        
- **`spec`:**
    
    - **`accessModes`:**
        
        - **`ReadWriteOnce`:**  
            Specifies that the volume can be mounted as read-write by a single node.
            
    - **`resources`:**
        
        - **`requests`:**
            
            - **`storage: 5Gi`:**  
                Requests 5 `GiB` of storage capacity.

**How It Works:**  
The PVC binds to an available `PersistentVolume` (`PV`) that meets its criteria, providing stable storage for PostgreSQL data.

---

## 3. **Deployment Configuration: `postgres-deployment.yaml`**

**Purpose:**  
Manages the creation and scaling of the PostgreSQL pod, ensuring the desired state is maintained.​

**Breakdown:**

- **`apiVersion: apps/v1` & `kind: Deployment`:**  
    Specifies this resource as a Deployment, which manages `ReplicaSets` and provides declarative updates to applications.​[Medium](https://medium.com/%40howdyservices9/postgres-on-kubernetes-k8s-bf555289831a?utm_source=chatgpt.com)
    
- **`metadata`:**
    
    - **`name: postgres`:**  
        Names the Deployment `postgres`.
        
    - **`namespace: default`:**  
        Assigns the Deployment to the `default` namespace.
        
- **`spec`:**
    
    - **`replicas: 1`:**  
        Ensures a single instance of the PostgreSQL pod is running.
        
    - **`selector`:**
        
        - **`matchLabels`:**
            
            - **`app: postgres`:**  
                Matches pods with the label `app: postgres` to this Deployment.
                
    - **`template`:**
        
        - **`metadata`:**
            
            - **`labels`:**
                
                - **`app: postgres`:**  
                    Labels the pod for identification and selection.
                    
        - **`spec`:**
            
            - **`containers`:**
                
                - **`name: postgres`:**  
                    Names the container `postgres`.
                    
                - **`image: postgres:15`:**  
                    Uses the PostgreSQL version 15 image.
                    
                - **`ports`:**
                    
                    - **`containerPort: 5432`:**  
                        Exposes port 5432, the default PostgreSQL port.
                        
                - **`env`:**
                    
                    - **`name: POSTGRES_DB` & `value: myappdb`:**  
                        Sets the default database name to `myappdb`.
                        
                    - **`name: POSTGRES_USER` & `value: myuser`:**  
                        Sets the database username to `myuser`.
                        
                    - **`name: POSTGRES_PASSWORD`:**  
                        Retrieves the password from the `postgres-secret`.
                        
                - **`volumeMounts`:**
                    
                    - **`mountPath: /var/lib/postgresql/data` & `name: postgres-storage`:**  
                        Mounts the persistent storage at the specified path.
                        
            - **`volumes`:**
                
                - **`name: postgres-storage`:**  
                    Defines the volume using the `postgres-pvc`.
                    

**How It Works:**  
The Deployment ensures that a `PostgreSQL` pod is running with the specified configurations, utilizing the Secret for credentials and the `PVC` for persistent storage.​

---

## 4. **Service Configuration: `postgres-service.yaml`**

**Purpose:**  
Exposes the PostgreSQL pod within the Kubernetes cluster, enabling other services and applications to communicate with it.​

**Breakdown:**

- **`apiVersion: v1` & `kind: Service`:**  
    Defines this resource as a Service, which exposes a set of pods as a network service.​
    
- **`metadata`:**
    
    - **`name: postgres`:**  
        Names the Service `postgres`.
        
    - **`namespace: default`:**  
        Places the Service in the `default` namespace.