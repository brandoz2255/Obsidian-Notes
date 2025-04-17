## 2. **Modify the pgAdmin Deployment to Use the Secret**

Next, update your **`pgadmin-deployment.yaml`** to reference these secret values rather than `hardcoding` them. Adjust the `env` section like so:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pgadmin
  namespace: default
  labels:
    app: pgadmin
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
          image: dpage/pgadmin4:latest
          ports:
            - containerPort: 80
          env:
            - name: PGADMIN_DEFAULT_EMAIL
              valueFrom:
                secretKeyRef:
                  name: pgadmin-secret
                  key: pgadmin-email
            - name: PGADMIN_DEFAULT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: pgadmin-secret
                  key: pgadmin-password
```

