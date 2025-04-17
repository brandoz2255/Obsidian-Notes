### 🧩 Step 1: Deploy ingress-nginx

Run this:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/baremetal/deploy.yaml
```

This installs:

- The **Ingress Controller Deployment**
- Its **Service (type: LoadBalancer)** — this is where `MetalLB` assigns an external IP
- `RBAC`, roles, and the controller logic

### 🧩 Step 2: Wait for it to start

Watch the pods:

```bash
kubectl get pods -n ingress-nginx -w
```

You should see something like:

```bash
ingress-nginx-controller-xxxxxx   Running   1/1   Ready
```

### 🧩 Step 3: Confirm Service IP from MetalLB

Run:

```bash
kubectl get svc -n ingress-nginx
```

You should see 

```bash
NAME                      TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)
ingress-nginx-controller  LoadBalancer   10.x.x.x       192.168.4.240    80:xxxx/TCP, 443:yyyy/TC
```

**This `EXTERNAL-IP` is what you point DuckDNS to.**


---

### 🧩 Step 4: Re-check Ingress and Cert

After the controller is up:

- Your `pgadmin-ingress.yaml` will be picked up automatically.
- cert-manager will detect it and issue the cert if it hasn’t yet.

Check:

```bash
kubectl get ingress
kubectl describe ingress pgadmin-ingress
kubectl describe certificate pgadmin-tls
```

## 🔁 Update DuckDNS

Make sure your DuckDNS domain (`pgadmin123.duckdns.org`) is pointing to the MetalLB IP:

### ✅ Final Test

Open in browser:

```bash
https://pgadmin123.duckdns.org
```
 
Should be:

- Valid HTTPS cert 🔐
- pgAdmin login screen 🧠
- No port, no nginx pod, just clean K8s-native routing

- [[Patch command in case of error]]