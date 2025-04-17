First, create a Kubernetes Secret to store your PostgreSQL credentials securely. Replace `'YourPostgresPassword'` with a strong password of your choice:

```bash
kubectl create secret generic postgres-credentials \
  --from-literal=postgres-password='YourPostgresPassword'
```

