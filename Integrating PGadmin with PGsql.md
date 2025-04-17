# Kubernetes PGAdmin + PostgreSQL Integration (Doc 2)

## 🎯 Goal

Connect a deployed `pgAdmin` `UI` to a PostgreSQL `backend` inside the `Kubernetes` cluster, ensuring everything runs locally and securely over `HTTPS` via an `NGINX` reverse proxy.

---

## 🧠 Critcal thinking Flow

This phase is about **linking services within the cluster**:

- PostgreSQL was already running inside a `StatefulSet`.
- `pgAdmin` was deployed behind `NGINX` with self-signed `TLS` via `mkcert`.
- We needed to connect `pgAdmin` `UI` to the PostgreSQL `backend` (`postgres` pod).
- Focus was on internal `DNS` resolution (`service-name.namespace.svc`) and debugging the `502`, `connection refused`, and service wiring.

---

## 🧪 Initial Setup Recap

### PostgreSQL Deployment

- Using `postgres:17` Docker image.
- Exposing port `5432`.
- Set up with environment variables for DB, user, and password from a `Kubernetes` secret.
- Exposed using **two services**:
  - `postgres` → `ClusterIP` service for `pgAdmin` to access.
  - `postgres-headless` → Used by the `StatefulSet`.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: postgres
spec:
  selector:
    app: postgres
  ports:
  - port: 5432
    targetPort: 5432
```


### pgAdmin Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: pgadmin-service
spec:
  selector:
    app: pgadmin
  ports:
  - port: 80
    targetPort: 80
```


`NGINX` → `pgAdmin` → PostgreSQL Data Flow

```bash
Client (browser)
   ↓
HTTPS via mkcert
   ↓
NGINX reverse proxy (port 31090)
   ↓
pgAdmin (via ClusterIP svc)
   ↓
PostgreSQL (via ClusterIP svc)
```

## 🛠️ PostgreSQL Details

- Internal DNS: `postgres.default.svc.cluster.local`
- Pod IP: `10.42.0.116` (Cluster-internal, verified via `kubectl describe pod`)
- Credentials from `postgres-secret`
- PGAdmin Config used:
    - **Host**: `postgres`
    - **Port**: `5432`
    - **Username**: `myuser`
    - **Password**: (from secret)

## 🛠️ PostgreSQL Details

- Internal DNS: `postgres.default.svc.cluster.local`
- Pod IP: `10.42.0.116` (Cluster-internal, verified via `kubectl describe pod`)
- Credentials from `postgres-secret`
- PGAdmin Config used:
    
    - **Host**: `postgres`
    - **Port**: `5432`
    - **Username**: `myuser`
    - **Password**: (from secret)

## 🧪 Debugging Phase

### 🧩 Issue: No connection from pgAdmin

- **Symptoms**: 502 gateway error, no logs in nginx container.
    
- **Suspected causes**:
    
    - TLS misconfig → ✅ verified working.
    - NGINX misrouting → ❌ nginx logs showed no hit.
    - pgAdmin misconfigured → ❌ worked standalone.
    - DNS/internal service issue → ✅ spot on.

| Problem                       | Fix                                                                                 |
| ----------------------------- | ----------------------------------------------------------------------------------- |
| Ingress still binding 31090   | Deleted `ingress-nginx` LoadBalancer                                                |
| NGINX silent                  | Exposed port via `NodePort` (31090)                                                 |
| Service unreachable           | Verified `pgadmin-service` and `postgres` are running and accessible                |
| PostgreSQL connection refused | Updated pgAdmin connection string to use `postgres.default.svc.cluster.local`       |
| Secret missing TLS            | Verified `pgadmin-tls` secret existed and matched mount path                        |
| Ingress interfering           | Full teardown of ingress resources and their SVCs (esp. conflicting port 443/31090) |

## 🔐 Secure TLS Recap

- `TLS` served by `NGINX` on port `443` inside container, `31090` exposed to host.
- Certificates created using `mkcert`:

```bash
mkcert -cert-file cert.pem -key-file key.pem 192.168.4.47
```

Secrets created as:Secrets created as:

```bash
kubectl create secret tls pgadmin-tls \
  --cert=cert.pem \
  --key=key.pem
```

## 🧹 Future Cleanups

- Consider disabling Ingress controller permanently if not in use
- Switch to proper DNS later (e.g. Pi-hole or DuckDNS) → Ingress can then be used.
- Automate TLS with cert-manager + DuckDNS once DNS available.