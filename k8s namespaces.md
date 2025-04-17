## **Kubernetes Namespaces vs Linux Namespaces**

## Kubernetes Namespaces:

- Logical construct used to organize and isolate resources (e.g., pods, services) within a cluster.
- Provides access control via Role-Based Access Control (`RBAC`).
- Operates at the API level; resources are scoped using `ETCD` (key-value store).

## Similarities:

- Both provide isolation mechanisms.
- `Kubernetes` namespaces use Linux namespaces under the hood when running containers.

