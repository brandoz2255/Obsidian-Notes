When using `K3s`, you may need to copy the `kubeconfig` file to your user directory to enable easier and non-root access to the `Kubernetes` cluster. Here's a simple explanation:

1. **What is kubeconfig?**  
    The `kubeconfig` file is a configuration file that contains details about your `Kubernetes` cluster, including how to connect to it. For `K3s`, this file is typically located at `/etc/rancher/k3s/k3s.yaml` and is owned by the root user[1](https://docs.k3s.io/cluster-access)[2](https://www.hoelzel.it/hints/2022/01/28/k3s-get-kubeconfig.html)- .
    
- **Why copy it to your user directory?**
    
    - By default, the `kubeconfig` file is stored in a location that requires root permissions to access. If you want to use `kubectl` (the command-line tool for interacting with `Kubernetes`) as a non-root user, you won't have permission to read this file.
    - Copying the `kubeconfig` file to your home directory (e.g., `~/.kube/config`) ensures that you can access it without needing root privileges or using `sudo` commands every time[redit](https://www.reddit.com/r/k3s/comments/ysfh8n/is_it_possible_to_access_k3s_as_non_root_user/)[docs](https://docs.k3s.io/cluster-access)- - .
        
- **How does this help?**
    
    - Once copied, you can use `kubectl` commands directly from your user account to manage the cluster.
    - It simplifies workflows, especially for development or learning purposes, since you don't need elevated permissions.
---

**Steps to copy and set up kubeconfig:**

- Create a `.kube` directory in your home folder if it doesn't exist:

```bash
mkdir -p ~/.kube
```

Copy the `kubeconfig` file:

```bash
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
```

Change ownership of the copied file so your user can access it:

```bash
sudo chown $USER ~/.kube/config
```

Restrict permissions for security:

```bash
chmod 600 ~/.kube/config
```

Optionally, set the `KUBECONFIG` environment variable for convenience:

```bash
export KUBECONFIG=~/.kube/config
```

if that causes errors also update the configs to 

```bash
mkdir -p $HOME/.kube
sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

in shell config add 

```bash
export KUBECONFIG=$HOME/.kube/config
```

