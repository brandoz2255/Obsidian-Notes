```bash
# optional: back it up
cp -r ~/minecraft-data ~/minecraft-data-backup

# or rsync it to your K8s node (if different machine)
rsync -avz ~/minecraft-data/ your-k8s-node:~/minecraft-data

```

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: minecraft-data
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
```


### ✅ 3. **Create a Deployment for the Server**

Make a file called `minecraft-deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mc-server
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mc-server
  template:
    metadata:
      labels:
        app: mc-server
    spec:
      containers:
      - name: minecraft
        image: itzg/minecraft-server
        ports:
        - containerPort: 25565
        env:
        - name: EULA
          value: "TRUE"
        - name: VERSION
          value: "1.21.5"
        volumeMounts:
        - mountPath: /data
          name: mc-volume
      volumes:
      - name: mc-volume
        persistentVolumeClaim:
          claimName: minecraft-data
```

### ✅ 4. **Create a Service**

Make a file called `minecraft-service.yaml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mc-service
spec:
  type: NodePort
  selector:
    app: mc-server
  ports:
  - port: 25565
    targetPort: 25565
    nodePort: 32565
apiVersion: v1
kind: Service
metadata:
  name: mc-service
spec:
  type: NodePort
  selector:
    app: mc-server
  ports:
  - port: 25565
    targetPort: 25565
    nodePort: 32565
```

Then players can connect with:Then players can connect with:

```bash
[your-node-ip]:32565
```


Only issue I wan't anyone  can reach it with my VPN  they connect to my VPN and in minecraft type minecraft.dulc3.tech which my nginx will proxy the dns for minecraft server 

II already made nginx dont worry about that only thing we need to worry about is minecraft 