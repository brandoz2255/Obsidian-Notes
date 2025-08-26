### 1. Provision a persistent volume

The first step is to provision a persistent volume. To provision statically, write a YAML file that describes the claim.

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: your-pv
spec:
  capacity:
	storage: 1Gi
  accessModes:
	- ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
	path: /mnt/pv1
```

To provision dynamically, you'd write YAML that defines a storage class, rather than a PV. For example:

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: standard
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2                      	
  fsType: ext4                    	
reclaimPolicy: Retain             	
volumeBindingMode: WaitForFirstConsume
```

This sets up dynamic provisioning using [aws-ebs](https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi-migration-faq.html) as the dynamic provisioner.

### 2. Create a PVC

Next, create a persistent volume claim. Here again, you use YAML to do this. For example:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: your-pvc
spec:
  accessModes:
	- ReadWriteOnce
  storageClassName: manual
  resources:
	requests:
  	storage: 1Gi
```


This creates a PVC that matches the 1-gigabyte, ReadWriteOnce PV volume that we set up in the previous step.


Then Check 

```bash
kubectl get pv your-pv
kubectl get pvc your-pvc
```

### 4. Use the PVC in a pod

To use the PVC in a pod, write a pod specification that references the PVC in the volumes section. For example:

```yaml
# pod-using-pvc.yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-using-pvc
spec:
  containers:
  - name: your-container
	image: nginx
	volumeMounts:
	- mountPath: "/usr/share/nginx/html"
  	name: storage
  volumes:
  - name: storage
	persistentVolumeClaim:
  	  claimName: your-pvc
```

This pod mounts the PVC at the path /usr/share/nginx/html, where it can read from and write to the persistent volume.


If you don't see problems here, the next step is to check the events log of the pod that is trying to use the PVC. You can do this by running:

```bash
kubectl events --for pod/pod-id
```

- **FailedAttachVolume**: This typically happens in cases where the underlying storage infrastructure is unavailable. It may also happen due to bugs in the PV provisioner, if you're using a dynamic provisioner.
- **FaliedMount**: This error typically coincides with FailedAttachVolume, and the root causes are the same.
- **CrashLoopBackOff**: CrashLoopBackOff means the pod has repeatedly failed to start due to recurring [Kubernetes health check](https://www.groundcover.com/kubernetes-monitoring/kubernetes-health-check) failures. This causes the pod never to succeed in using a PVC. Usually, CrashLoopBackOff errors stem from issues with the pod and are unrelated to PV or PVC settings. (For details, check out our [guide to CrashLoopBackOff troubleshooting](https://www.groundcover.com/kubernetes-troubleshooting/crashloopbackoff).)
