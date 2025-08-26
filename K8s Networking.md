### The mental model (short & sharp)

- **CoreDNS**: turns `my-svc.my-namespace.svc.cluster.local` into the **Service VIP** (the `ClusterIP`).

- **kube-proxy** (runs on every node): **watches** Services + `EndpointSlices` and **programs dataplane rules** so packets to the Service VIP get **NAT’ed to a Pod IP**.
    - Modes:
        - **iptables**: creates chains like `KUBE-SVC…` → DNAT to a selected Pod IP.
        - **ipvs**: uses Linux IPVS for per-service virtual servers (view with `ipvsadm -Ln`).
    - **Conntrack** pins a flow to one backend.
    - Honors **readiness**: only Ready pods become endpoints.
    - Handles **sessionAffinity** if you turn it on.

- **CNI plugin**: creates the **Pod network** (interfaces, routes, overlays/encap if needed) so packets can actually reach remote Pod IPs across nodes. (CNI ≠ Services; it’s about **reachability/routing**, not load-balancing.)
    
- **MetalLB** (for `type: LoadBalancer` on bare metal): announces/exposes a Service externally by handing out an IP and advertising it (L2 ARP/NDP or BGP). Behind the scenes, traffic still lands on nodes and hits kube-proxy’s rules to reach pods.
  
  ---


