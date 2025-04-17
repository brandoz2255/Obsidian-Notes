## 🌐 4. Point DuckDNS to your MetalLB IP

Get your MetalLB IP:

```bash
kubectl get svc -n ingress-nginx
```


Look for something like:

```bash
ingress-nginx-controller   LoadBalancer   192.168.4.240   ...
```

Go to your DuckDNS dashboard and set:

```bash
pgadmin123.duckdns.org → 192.168.4.240
```

