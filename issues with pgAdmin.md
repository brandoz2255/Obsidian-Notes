# Kubernetes + NGINX + PGAdmin TLS Deployment (Doc 1)

## 🎯 Goal

Deploy `pgAdmin` securely via a custom `NGINX` pod using `TLS` (via `mkcert`), without Ingress or external `DNS`, accessible over local IP.

---

## 🧠 Engineering Overview

In this design, we:

- **Avoided Ingress** due to IP `hostname` restrictions & Let's Encrypt limitations.
- **Used mkcert** to generate a self-signed certificate for `HTTPS` without `DNS` validation.
- **Configured a standalone NGINX** container as a reverse proxy to `pgAdmin`, exposing `TLS` on port `443`.
- **Exposed NGINX using a NodePort or LoadBalancer** service (`MetalLB`) on port `31090`.
- **Structured deployment with reusable YAML** components: Deployment, Service, `ConfigMap`, Secret.

---

## 🗂 File Breakdown

### 1. `pgadmin-deployment.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pgadmin
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pgadmin
  template:
    metadata:
      labels:
        app: pgadmin
    spec:
      containers:
      - name: pgadmin
        image: dpage/pgadmin4:9.2
        env:
        - name: PGADMIN_DEFAULT_EMAIL
          value: admin@domain.com
        - name: PGADMIN_DEFAULT_PASSWORD
          value: admin123
        ports:
        - containerPort: 80
        volumeMounts:
        - mountPath: /var/lib/pgadmin
          name: pgadmin-storage
      volumes:
      - name: pgadmin-storage
        persistentVolumeClaim:
          claimName: pgadmin-pvc
```

---

### 2. `nginx-configmap.yaml`

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
data:
  default.conf: |
    server {
        listen 443 ssl;
        ssl_certificate /etc/nginx/certs/cert.pem;
        ssl_certificate_key /etc/nginx/certs/key.pem;

        location / {
            proxy_pass http://pgadmin-service:80;
        }
    }
```



### 3. `nginx-deployment.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-pgadmin
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-pgadmin
  template:
    metadata:
      labels:
        app: nginx-pgadmin
    spec:
      containers:
      - name: nginx
        image: nginx:alpine
        ports:
        - containerPort: 443
        volumeMounts:
        - name: nginx-config
          mountPath: /etc/nginx
        - name: tls
          mountPath: /etc/nginx/certs
          readOnly: true
      volumes:
      - name: nginx-config
        configMap:
          name: nginx-config
      - name: tls
        secret:
          secretName: pgadmin-tls
```

#### 4. `nginx-service.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-pgadmin-service
spec:
  selector:
    app: nginx-pgadmin
  ports:
  - protocol: TCP
    port: 443
    targetPort: 443
    nodePort: 31090
  type: LoadBalancer
```

#### 5. `pgadmin-tls Secret`

```bash
mkcert -cert-file cert.pem -key-file key.pem 192.168.4.47

kubectl create secret tls pgadmin-tls \
  --cert=cert.pem \
  --key=key.pem
```


## ⚙️ Access Info

- 📍 **Access URL:** `https://192.168.4.47:31090`\
- 🧠 Trust `mkcert` CA if needed (`mkcert -install`)
- 🗂 `pgAdmin` exposed behind `TLS-terminating` `NGINX`

#### 🧪 Troubleshooting Log

| Issue                   | Diagnosis                               | Fix                                             |
| ----------------------- | --------------------------------------- | ----------------------------------------------- |
| Ingress blocks NodePort | Ingress controller was binding port 443 | Deleted Ingress SVC                             |
| No connection on 31090  | Port already in use by Ingress          | Reclaimed port after disabling Ingress          |
| SSL errors              | TLS certs missing or secret misnamed    | Verified `pgadmin-tls` secret mounted correctly |
| 502 Bad Gateway         | NGINX couldn’t reach pgAdmin            | Ensured correct `proxy_pass` in config          |
| Pod stuck Pending       | TLS secret missing                      | Created secret with correct name & key          |
