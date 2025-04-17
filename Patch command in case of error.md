 ## ✅ The Fix: Patch the Ingress Controller Service to `LoadBalancer`

MetalLB **only assigns an external IP** to services of type `LoadBalancer`.

Let’s patch it right now:

```bash
kubectl patch svc ingress-nginx-controller -n ingress-nginx \
  -p '{"spec": {"type": "LoadBalancer"}}'
```

Give it a few seconds, then check again:

```bash
kubectl get svc -n ingress-nginx
```

You should now see something like:

```bash
ingress-nginx-controller   LoadBalancer   10.43.204.211   192.168.4.240   80:xxxx/TCP,443:yyyy/TCP
```

