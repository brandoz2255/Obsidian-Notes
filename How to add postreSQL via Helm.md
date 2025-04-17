Let’s deploy the **Bitnami PostgreSQL chart** — it’s stable, well-documented, and production-ready.

### 🛒 Add Bitnami repo:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

📦 Install PostgreSQL:

```bash
helm install my-postgres bitnami/postgresql \
  --set auth.postgresPassword=myStrongPassword \
  --set primary.persistence.enabled=true \
  --set primary.persistence.size=8Gi
```

