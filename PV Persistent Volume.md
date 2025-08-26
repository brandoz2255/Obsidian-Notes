
**Main Idea**: In `Kubernetes` a `PV` aka Persistent Volume  is piece of storage in the cluster provisioned by the admin in order to add dynamically  storage classes. 
- A resource inside the cluster  independent from anything else in the cluster
- Allowing data  to be stored persistently beyond pod termination 
- `PVs` Allow for  the underlying storage  implementation which  could  be local storage 
- Has defined  capacities, access modes, and reclaim policies 

### Can PV make a PVC persistent post pod death?

- The underlying PV's reclaim policy governs what happens when the PVC is deleted:
    
    - **Retain**: volume and data remain after PVC deletion (manual intervention needed)
    - **Delete**: PV and actual storage are deleted when associated PVC is deleted
    - **Recycle** (deprecated): volume data is wiped and then reused automatically


#source

[groundcover](https://www.groundcover.com/blog/kubernetes-pvc)
[Refine](https://refine.dev/blog/kubernetes-persistent-volumes/#conceptual-overview-of-persistent-volumes-and-claims)

