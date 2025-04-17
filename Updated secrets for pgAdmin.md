## 🔐 Step 1: Create Kubernetes Secret for pgAdmin Login

Replace with your own values:

```bash
kubectl create secret generic pgadmin-secret \
  --from-literal=PGADMIN_DEFAULT_EMAIL=your.email@example.com \
  --from-literal=PGADMIN_DEFAULT_PASSWORD=yourSecurePassword
```

## 📝 Step 2: Patch the `pgadmin` Deployment to Use the Secret

Patch your existing `pgadmin` deployment to use the secret:

```yaml
kubectl patch deployment pgadmin \
  -n default \
  --type='json' \
  -p='[
    {
      "op": "add",
      "path": "/spec/template/spec/containers/0/envFrom",
      "value": [
        {
          "secretRef": {
            "name": "pgadmin-secret"
          }
        }
      ]
    }
  ]'
```



This injects both variables (PGADMIN_DEFAULT_EMAIL & PGADMIN_DEFAULT_PASSWORD) from the secret.


Zer0/565371;