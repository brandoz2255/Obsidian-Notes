### Deployment Steps

1. **Apply the Secret:**

```bash
kubectl apply -f postgres-secret.yaml
```

2. **Apply the PVC:**

```bash
kubectl apply -f postgres-pvc.yaml
```

3. **Deploy PostgreSQL:**

```bash
kubectl apply -f postgres-deployment.yaml
```

4. **Create the Service:**

```bash
kubectl apply -f postgres-service.yaml
```

