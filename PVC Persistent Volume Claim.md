**Persistent Volume Claim PVC**: This in contrast to `PV` is a request to `k8s` made by a pod for storage for that pod. 
- meaning pods don't access `PV` at all but instead use `PVCs` to specify their storage requirements 
- Such as size read/writes Then  matches the available  PVC
- `PVCs` are trigger either in the use of statically provisioned `PVs` or Dynamic volume via storage classes  

### What this  means 

When a `PV` is set up it means you made the storage object however pods can't  access `PVs` so we must use a  `PVC` to use that storage

- A `PVC` is a request for a pod to access a persistent volume. Which then  can be configured with vars such as how  much storage the pod can use. 
- Importantly a PVC doesn't specify which `PV` to use they decide  with `PV` meets their condition.


## Static vs Dynamic


| Provisioning type | How it works                                                                                                  | When to use                                                                                                                                                          |
| ----------------- | ------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Static            | Admins manually provision persistent volumes.                                                                 | For simple workloads whose storage needs are persistent and predictable.                                                                                             |
| Dynamic           | Admins define a storage class, which Kubernetes then uses to provision storage volumes dynamically as needed. | When storage requirements are not known ahead of time or change frequently. Also useful for optimizing storage cost by avoiding creating volumes that aren't needed. |

**Example**: Static is like an array  for storage use cases with `PVs` and `PVCs` whereas Dynamic is like  a Vector 

**Static provisioning**: Static provisioning means that admins manually provision storage resources by selecting a storage system to host data

**Dynamic provisioning**: Dynamic provisioning allows Kubernetes to create persistent volumes automatically, in response to PVC requests