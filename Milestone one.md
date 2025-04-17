# 📌 Milestone Step One: Kubernetes Self-Hosted PGAdmin + PostgreSQL + HTTPS

---

## ✅ Goal of Milestone

Create a **local `Kubernetes` development environment** with:

1. PostgreSQL running in a `StatefulSet`
2. `pgAdmin` `UI` to interact with the database
3. NGINX reverse proxy serving `pgAdmin` over **`HTTPS`** with **self-signed certificates**
4. Secure communication without requiring `DNS` for now (access via IP)
5. Future-ready for `DNS` (`DuckDNS` or Pi-hole)

---

## 🧱 Infrastructure Overview

### Architecture Diagram (Conceptual)

```text
                        +------------------+
                        |     Browser      |
                        |  https://IP:443  |
                        +--------+---------+
                                 |
                                 v
                    +---------------------------+
                    |       NGINX Proxy         |
                    | - Listens on 443 (TLS)    |
                    | - NodePort: 31090         |
                    +------------+--------------+
                                 |
                                 v
                         +---------------+
                         |    pgAdmin    |
                         |  Port 80      |
                         +------+--------+
                                |
                                v
                         +-------------+
                         |  PostgreSQL |
                         |  Port 5432  |
                         +-------------+
```


### 🔧 Technologies Used

| Component     | Technology       | Notes                           |
| ------------- | ---------------- | ------------------------------- |
| Orchestrator  | Kubernetes (k3s) | Lightweight, local setup        |
| Reverse Proxy | NGINX (alpine)   | Serves pgAdmin UI               |
| Certs         | mkcert           | Local CA for HTTPS over IP      |
| DB            | PostgreSQL 17    | StatefulSet with PVC            |
| DB Admin UI   | pgAdmin 4.9      | Deployed as Deployment          |
| Networking    | NodePort         | Used due to lack of external LB |

---

## 🏗️ Kubernetes Resource Breakdown

### 1. PostgreSQL Setup

- `StatefulSet` with persistent volume.
- Exposed via two services:
    - `postgres`: `ClusterIP` for `pgAdmin` to connect
    - `postgres-headless`: For internal `DNS` and scaling
- Configured with `env` vars pulled from secret:
    - `POSTGRES_DB`, `POSTGRES_USER`, `POSTGRES_PASSWORD`

### 2. pgAdmin Deployment

- Deployed with `Deployment` and a single replica
- Exposed via `ClusterIP` service internally (`pgadmin-service`)
- Accessible only through `NGINX` for now

### 3. NGINX TLS Reverse Proxy

- Used a `ConfigMap` for custom `nginx.conf`:
    - Listens on 443
    - Forwards to `pgadmin-service:80`


- Created TLS secret via `mkcert` for public IP:

```bash
mkcert -cert-file cert.pem -key-file key.pem 192.168.4.47
kubectl create secret tls pgadmin-tls --cert=cert.pem --key=key.pem
```

⚠️ Challenges and Fixes

![[Pasted image 20250412135249.png]]

---

## ✅ What Worked Well

- Cluster networking once DNS names were correctly used.
- TLS from mkcert + NodePort approach for HTTPS on IP.
- Kubernetes-native services — no external dependencies yet.
- Debug logs for NGINX and pod status gave quick feedback.

---
## 📁 Next Up

Now that Milestone 1 is complete, you're ready for:

- Adding real DNS (DuckDNS / Pi-hole)    
- Switching back to Ingress + cert-manager
- External backups for Postgres
- Automated TLS renewals
- Helm-ifying the stack
- CI/CD integration

(see `docs-3.md` for full list)