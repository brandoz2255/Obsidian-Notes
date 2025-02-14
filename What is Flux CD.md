`FluxCD` is an open source `continuous delivery` (**CD**) and `GitOps` tools designed to automate application deployments and infrastructure management in `Kubernetes`   

## Key  Features of Flux 

- GitOps Workflow 
	- Flux uses Git as a single source of truth for managing k8s resources including Applications, configurations, and infrastructure
	- Changes made to Git repositiories are automatically reconciled with the k8s cluster 

**Declarative and Automated**:

- Users define the desired state of their system (e.g., apps, infrastructure) in declarative YAML files stored in Git.
- Flux continuously monitors these repositories for changes and applies updates automatically[2](https://fluxcd.io)[7](https://www.cncf.io/blog/2023/09/15/what-is-flux-cd/).

**Modular Architecture**:

- Flux is built using the **GitOps Toolkit**, which includes several specialized controllers:
    
    - **Source Controller**: Monitors Git repositories or other sources for changes.
    - **Kustomize Controller**: Manages Kubernetes manifests with customizations.
    - **Helm Controller**: Handles Helm chart releases declaratively.
    - **Notification Controller**: Integrates with external systems for alerts.
    - **Image Automation Controllers**: Automates updates to container images[1](https://spacelift.io/blog/fluxcd)[4](https://fluxcd.io/flux/components/).


