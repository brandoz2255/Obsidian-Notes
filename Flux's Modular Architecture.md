Flux has a modular Architecture built on the GitOps toolkit which consist of the specialized components. 

- APIs and controllers designed to implement CD in k8s enviroment
-  Allows for users to customize extend and integrate Flux into various use cases


## Key Components of Flux's Modular Architecture:

1. **Source Controller**:
    
    - Monitors sources like Git repositories, Helm charts, or S3-compatible buckets for changes.
    - Triggers updates in the cluster when changes are detected in these sources[1](https://fluxcd.io/flux/components/)[2](https://spacelift.io/blog/fluxcd)[7](https://devtron.ai/blog/gitops-tool-selection-argo-cd-or-flux-cd/).
    
2. **Kustomize Controller**:
    
    - Manages `Kubernetes` manifests using `Kustomize`, enabling customization of resources without modifying the original `YAML` files.
    - Reconciles the cluster's state with the desired configuration defined in Git[1](https://fluxcd.io/flux/components/)[2](https://spacelift.io/blog/fluxcd)[7](https://devtron.ai/blog/gitops-tool-selection-argo-cd-or-flux-cd/).
    
3. **Helm Controller**:
    
    - Manages Helm chart releases declaratively using the `HelmRelease` custom resource.
    - Supports automated deployments and rollbacks for Helm-based applications[1](https://fluxcd.io/flux/components/)[2](https://spacelift.io/blog/fluxcd)[7](https://devtron.ai/blog/gitops-tool-selection-argo-cd-or-flux-cd/).
    
4. **Notification Controller**:
    
    - Sends alerts and notifications (e.g., to Slack or email) about deployment events or system changes.
    - Handles external events like webhooks to trigger reconciliations[1](https://fluxcd.io/flux/components/)[2](https://spacelift.io/blog/fluxcd)[7](https://devtron.ai/blog/gitops-tool-selection-argo-cd-or-flux-cd/).
    
5. **Image Automation Controllers**:
    
    - Automates updates to `Kubernetes` manifests based on container image changes.
    - Includes an **Image Reflector Controller** (monitors registries for new images) and an **Image Automation Controller** (updates manifests with new image tags)[1](https://fluxcd.io/flux/components/)[2](https://spacelift.io/blog/fluxcd)[7](https://devtron.ai/blog/gitops-tool-selection-argo-cd-or-flux-cd/).


