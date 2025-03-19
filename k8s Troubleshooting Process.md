
##### Check if any pods are missing

- We will use this command to get the status of the pods 

```bash
k3s kubectl get pods
```

- Alternatively using `minikube` we can just run it without `k3s` options

#### Checking the pods info

- If its not working properly we can see its instructions via 

```bash
k3s kubectl describe pod nameOfPod
```

- This would explain why the pod isn't working properly 

#### If the pod still looks fine ? 

- Here maybe the containers are the issue and not the pod itself 

```bash
k3s kubectl logs nameOfPods
```

This gives out crucial information such as:

- **“I can’t find the database!”** → Oops, a connection issue!
- **“I don’t have permissions!”** → Uh-oh, access problems.

#### Here maybe the deployment or ReplicaSet is making mistakes 

```bash 
k3s kubectl get deployments
k3s kubectl describe deployment deployment-name
```

- This will let you know the event actions 

#### Networking issues 

```bash
k3s kubectl get services
```

-  this shows if maybe a port is wrong or the service isn't exposing it

```bash
kubectl exec -it <pod-name> -- nslookup service-name
```

- Execute inside the pod to check the DNS
#### Checking resources 

```bash
kubectl get nodes
kubectl describe node <node-name>
```

- IF the node is `NotReady`, then `k8s` might be out of resources or something crashed

#### Executing Shell inside k8s pod

```bash
kubectl exec -it <pod-name> -- /bin/sh
```

Fixing `Kubernetes` is like fixing a `LEGO` city:  
1️⃣ **Are the pieces (pods) there?** → `kubectl get pods`  
2️⃣ **Are they built correctly?** → `kubectl describe pod`  
3️⃣ **Are the workers (containers) working?** → `kubectl logs`  
4️⃣ **Is the boss (deployment) confused?** → `kubectl get deployments`  
5️⃣ **Are the roads (network) broken?** → `kubectl get services`  
6️⃣ **Is the land (nodes) shaking?** → `kubectl get nodes`

