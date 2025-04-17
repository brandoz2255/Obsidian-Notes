## 4. **Deploying Your Configuration**

Apply the Secret first, then the Deployment and Service:

```bash
kubectl apply -f k8s/apps/pgadmin/pgadmin-secret.yaml
kubectl apply -f k8s/apps/pgadmin/pgadmin-deployment.yaml
kubectl apply -f k8s/apps/pgadmin/pgadmin-service.yaml
```

