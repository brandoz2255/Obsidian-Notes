## 2. **Persistent Volume Claim**

This PVC ensures your PostgreSQL data is stored persistently.  
**File: `postgres-pvc.yaml`**

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgres-pvc
  namespace: default
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
```


