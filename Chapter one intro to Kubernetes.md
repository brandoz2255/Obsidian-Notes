
all examples of kube and cont usuage https://github.com/book-of-kubernetes/examples

- Such that a good application on the server must be moved post failure so that the end user doesn’t notice the failure 
    
- **Pg 8** why containers 
    
- We need to hide the issues of our application in case of hardware or software failure 
    
- **Pg 8** why containers are useful packaging version isolation fast startup low over head 
    
- Containers are designed for the purposes 
    
- Requirements for orchestration **page 9** 
    
- Clustering discovery configuration load balancing monitoring resilience 
    
- All these are handle by a container orchestration environment such as kubernetes 
    
- Running containers **page 9** 
    
- What docker container really is 
    
- Couple of commands docker run and -ti flags def 
    
- Cat `ip` `úname` commands and special flags to read system in Linux 
    
- We can see containers have some functionality of a virtual machine and a running instance of a applications 
    
- Deploying `kubernetes` pods using `k3s` 
    
- Pod def and app example using `k3s` in **page 15**
- declarative configuration def 
- Kubernetes has a API server we must communicate with is 
- we use `kubectl` to talk with kubernetes `k3s` has its own `kubectl` 
- REST api defnition 
- Kubernetes features self healing and scalablility **pg 16 and 17 **

### Requirements for containers 

For a single `microservice` we need the following 

- **Packaging**: Bundle the applications for delivery which includes the dependencies making it portable 
- **Versioning**: Identifying what version we need to update the micro-services overtime and need to know what service is running
- **Isolation**: Keeping micro-services form Interfering with each-other allowing for flexible deployment
- **Fast Startup**: Start new instances rapidly need to scale and respond to failures rapidly  
- **Low overhead**: minimize required services to run a micro-service in order to avoid limits on how small a micro-service can be

**Containers**: A container is a lightweight standalone package that contains an application and its dependencies to run consistent across environments 

- They are designed to address exactly these needs

### Requirements for Orchestration 

For multiple `microservices` working together we need 

- **Clustering**: Providing the processing, memory and storage for containers across servers 
- **Discovery**: Providing a way for `microservices` to find one another and to be deployed across different nodes
- **Configuration**: Separate configuration from the runtime allowing us to reconfigure our application without rebuilding and redeploying our `microservices`
- **Access control**: Managing authorization between containers making sure the right ones run and the wrong ones don't 
- **Load balancing**: Spread requests among working instances 
- **Monitoring**: identifying failed `micorservices` instances 
- **Resilience**:  Automatically recover from failures if we don't have this the application it self fails 

**Container orchestration**: is  the strategy of using automation to manage the life-cycle of application containers. it automates tasks like creating, scaling, and upgrading containers. 

---

## Practice using Kubernetes 

#### Listing OS info

In Linux 

```bash
# lists the specified OS 
cat /etc/os-release

# lists the processes in the OS 
ps -ef 

# lists the name of the OS 
uname -v

# lists ip address and MAC addresses 
ip addr
```

- `-ti` tells docker we need a interactive shell to run commands 

```bash
docker run -ti rockylinux:8
```

Now if we do that inside the container we will rockylinux information and different IP address and MAC
- However it still share the same OS kernel 
- Contains some functionality from `VM's` however it isn't like a `VM` its a container with dependencies

#### Differences 
- Virtual Machines: Run a complete, separate operating system instance [2](https://serverfault.com/questions/788953/what-is-the-difference-between-containers-and-virtual-machines).
- Containers: Share the host OS kernel but run as isolated processes [2](https://serverfault.com/questions/788953/what-is-the-difference-between-containers-and-virtual-machines).

```bash
# downloads and runs nginx
docker run -d -p 8080:80 nginx
```

- `-d` tells docker to run it in daemon mode in the background 
- `-p` tells it to port forward it to `port 8080`

```bash
# lists the docker services running 
docker ps
```

### `Kubernetes`

**`Kubernetes (K8s)`:** is an open-source container orchestration platform originally designed by google
- used for automating the deployment, scaling, and management of containerized applications 

**Declarative configuration**: a method of defining the desired state of a system, application, or infrastructure, without specifying the exact steps to achieve that state

- **Declarative**: Focuses on the end result.
    - Example: "I want a Kubernetes pod running with two replicas."
- **Imperative**: Focuses on the actions to achieve the result.
    - Example: "Create a pod, then scale it to two replicas."

### Benefits:

1. **Idempotency**: Running the same configuration multiple times will always result in the same state, no matter what the current system state is.
2. **Simpler**: You don't need to specify each individual step or action to achieve the desired state.
3. **Automation**: The tool can automatically detect and correct drifts from the declared state, making it easier to maintain consistency across environments.

#### Example

`Kubernetes` manifest 

``` yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
```

- This file declares the desired state of a deployment with three replicas of an `Nginx` container.

**K3s**: is a lightweight `Kubernetes` Distribution created by Rancher Labs designed to run `Kubernetes` clusters in a resource constrained environments