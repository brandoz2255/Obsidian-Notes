### Packet path (ClusterIP Service, inside the cluster)

1. Client Pod asks CoreDNS → gets **ClusterIP**.
2. Packet to ClusterIP hits node’s dataplane rules (from **kube-proxy**).
3. Rule picks a **Pod IP** from the Service’s **EndpointSlice** → **DNAT** to that Pod IP.
4. **CNI** provides the routes/encapsulation to deliver to that Pod (same node: direct; other node: via overlay/VXLAN/WireGuard/etc).
5. Reply packets get reverse-NAT’ed back.