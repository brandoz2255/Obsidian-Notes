## 4. **PostgreSQL Service**

This service exposes PostgreSQL internally so that other containers (and your Pis, if they’re part of the network) can connect using the service name `postgres`.  
**File: `postgres-service.yaml`**

```yaml
apiVersion: v1
kind: Service
metadata:
  name: postgres
  namespace: default
spec:
  selector:
    app: postgres
  ports:
    - protocol: TCP
      port: 5432
      targetPort: 5432
  type: ClusterIP
```


