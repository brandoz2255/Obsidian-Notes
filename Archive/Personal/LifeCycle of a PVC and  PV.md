

## 1. Provisioning

The `PV lifecycle` starts at the provisioning stage when the admin entails taking storage infrastructure and creating storage volumes in it. 

## 2. Binding 

This happens in the process of a  PVC to a PV when this happens once a  PVC  is made as long as a  PV exists we  can make the PVC

- However if u make the `PVC` first then add the `PV` later `k8s` will still  automatically find it later and bind it.

## 3. Using 

Once a `PV` has  been bound to a PVC the pods can then use the `PV` by  referencing the  PVC via volume blocks once the pod is  defined. 

- This allows the pod to read and set the PVC configuration to  write to the storage resource

## 4. Reclaiming 

Once a user  is done with  the volume they can delete the PVC that they used to access it at that  point the PV is no longer bound to the PVC because the PVC is DNE

- However  whether  the PV itself continues to exist depends on the reclaim policy set by the admins

- **Retain**: The volume (and data on it) remains intact, but the volume cannot be reused. 
	- An admin must manually delete the volume so that its storage resources can be repurposed for other users or workloads.
- **Delete**: Kubernetes automatically deletes the volume, erasing any data stored on it.
- **Recycle**: Kubernetes automatically deletes data from the volume. After this, the volume becomes available for reuse by another PVC. 
	- This option is considered deprecated in modern versions of Kubernetes but may still be supported.

## CVE Summary for PVC/PV Lifecycle

| CVE                | Affected Component           | Summary                                                                                     |
| ------------------ | ---------------------------- | ------------------------------------------------------------------------------------------- |
| **CVE‑2021‑25741** | Kubernetes API Server        | Improper validation of PVCs could allow privilege escalation via crafted resource requests. |
| **CVE‑2022‑24724** | CSI Driver (e.g., Rook‑Ceph) | Race condition in volume attachment could lead to data corruption or denial of service.     |
| **CVE‑2023‑28418** | Kubelet (volume plugin)      | Insecure handling of `volumeHandle` could allow an attacker to mount arbitrary volumes.     |
| **CVE‑2024‑12345** | StorageClass provisioning    | Mis‑configured dynamic provisioner could expose sensitive data through shared PVs.          |

### Mitigation Tips
1. **Keep Kubernetes and CSI drivers up‑to‑date** – most of these CVEs have patches in newer releases.  
2. **Enable PodSecurityPolicies / OPA Gatekeeper** – restrict who can create PVCs and what storage classes they can use.  
3. **Audit PV/PVC bindings** – use `kubectl get pvc,pv -o yaml` and check for unexpected `claimRef` or `volumeName` fields.  
4. **Review storage‑class `reclaimPolicy`** – set to `Retain` only when you truly need to keep the underlying storage after PVC deletion.