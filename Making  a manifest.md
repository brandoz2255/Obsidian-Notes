The proper way to make a Kubernetes manifest is to create a declarative configuration file, typically written in YAML, that clearly defines the desired state of Kubernetes resources such as Pods, Deployments, or Services.

This declarative approach is preferred over imperative commands because it enables:

- **Versioning and Auditing:** Manifests can be stored in source control alongside application code, enabling tracking, rollbacks, and collaboration.
- **Consistency:** Applying the same manifest across different environments (development, staging, production) ensures uniform deployments.
- **Automation:** Manifests integrate well with CI/CD pipelines, allowing automated, repeatable, and safe application updates.
- **Collaboration:** Centralized declarative files reduce risks of conflicts from concurrent imperative commands run by different team members.


**`apiVersion`** — This states the Kubernetes API that the object type you’re creating belongs to. Top-level objects such as Pods currently belong to the v1 API, whereas other built-ins are scoped to more specific APIs

- **`kind`** — This is the type of object that you’re defining, such as Pod or Deployment.
- **`metadata`** — This field contains essential information about the object, including its name and namespace. This is covered in more detail below.
- **`spec`** — Strictly speaking, this isn’t a required field, but it is used by most of the object types that are built into Kubernetes.\

Manifests are structured to make configurations explicit and maintainable, avoiding large monolithic files by logically grouping related resources and separating concerns as appropriate

``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx:latest
```



https://spacelift.io/blog/kubernetes-manifest-file

