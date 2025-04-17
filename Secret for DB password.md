- How to set up the secrets file 

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: postgres-secret
  namespace: default
type: Opaque
data:
  # base64 of "supersecretpass" is "c3VwZXJzZWNyZXRwYXNz"
  postgres-password: c3VwZXJzZWNyZXRwYXNz
```


