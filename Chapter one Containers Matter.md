## New Modern Application 

Its a great time to be a Software developer and not in the means of AI doing the simple part it can generate code both front and backend but it cant make containers scale them heal etc .....


The biggest thing to the modern application today is scale

-  we need our application to reach multiple users and handle it 
- in which it needs to reach `millions` or `billions` of users at once 
- and the users can't notice the systems breaking due to hardware issue or software issue 

`Kubernetes` and containerization meet these requirements 

### cloud native 

This is the act in which applications were built to fully take advantage of cloud computing environments 

**Key aspects of cloud native include:**

- Building applications as `microservices` rather than monoliths [1](https://aws.amazon.com/what-is/cloud-native/)
- Using containers and container orchestration (like `Kubernetes`) [1](https://aws.amazon.com/what-is/cloud-native/)[3](https://about.gitlab.com/topics/cloud-native/)
- Adopting `DevOps` practices and continuous delivery/deployment CI/CD  [1](https://aws.amazon.com/what-is/cloud-native/)[3](https://about.gitlab.com/topics/cloud-native/)
- Leveraging cloud-specific capabilities like elasticity and scalability [2](https://cloud.google.com/learn/what-is-cloud-native)


### Modular 

**Modularity**: is key its the practice of breaking down a system or application into discrete independent components. 

- However in Devops this practice is not only in idea of code or organizing code its in the idea of organizing computation 
- each task is in a `sperate` system not sharing the same `filespace`
- it needs *high cohesion* 

**High cohesion** refers to designing components that are self-contained, independent, and with a single, well-defined purpose

- Related code should be close together within a module.
- Elements within a module belong together and contribute to a single task or functionality.
- Changes to one part of the module are less likely to affect other parts.
- It's easier to understand and maintain the code since related elements are grouped together.

**Low coupling** refers to minimizing the dependencies between different modules or components. In `DevOps`, low coupling means:

- Modules should be as independent as possible from other modules.
- Changes to one module should have minimal impact on other modules.
- Modules should communicate with each other through well-defined interfaces rather than direct dependencies.

#### Automation 

Key thing in devops is automation `Kubernetes` , `ansible`,`vagrant
are key tools in automation 

#### Microservices 

The **microservices architecture** refers to breaking down an application into smaller,independent services that communicate with each other

1. Independent deployment: Each microservice can be developed, tested, and deployed separately without affecting other services [1](https://goteleport.com/blog/microservices-containers-kubernetes/).

2. Scalability: Microservices can be scaled independently based on their specific needs [1](https://goteleport.com/blog/microservices-containers-kubernetes/).

3. Flexibility: Teams can choose the best technology stack for each microservice, allowing for more flexibility [1](https://goteleport.com/blog/microservices-containers-kubernetes/).

#### Scalability Reliability Resilience

We need applications with these functionalities these are possible however take to much time in DevOps we use tools to easily provide us with these specifications 

### Scalability

Scalability refers to the ability of a system to handle increased load or expand capacity by adding more resources. In DevOps, scalability is achieved through:

1. **Horizontal scaling**: Adding more instances of a service to handle increased load.
2. **Vertical scaling**: Increasing the power of individual instances.
3. **Cloud elasticity**: Leveraging cloud platforms that can automatically scale resources up or down based on demand.
### Reliability

Reliability in DevOps focuses on building systems that can operate consistently and dependably. This includes:

1. Fault tolerance: Designing systems to continue functioning even when components fail. due to software or hardware 
2. Redundancy: Having backup systems or components ready to take over if primary ones fail.
3. Error correction: Implementing mechanisms to quickly identify and resolve issues.

### Resilience

Resilience in DevOps refers to the ability of a system to recover quickly from failures or disruptions. This involves:

1. **Graceful degradation**: Allowing the system to continue operating with reduced functionality when faced with partial failures.
2. **Rapid recovery**: Implementing quick restoration procedures after incidents.
3. **Self-healing**: Automatically detecting and resolving issues without manual intervention.

`Kubernetes` is the Solution to all these necessities with modern applications 

### Why containers help 

Containers encapsulate applications and their dependencies into isolated,portable units. 

- when a failure occurs these containers can be easily moved to different servers or environments without disrupting end-user experience 
- This approach hides the complexities of hardware or software failures from the end-users.

- **Packaging**: Containers bundle applications and their dependencies, ensuring consistency across environments.
- **Version isolation**: Multiple versions of an application can coexist without conflicts.
- **Fast startup**: Containers can spin up quickly due to their lightweight nature.
- **Low overhead**: Containers share the host OS, reducing resource consumption.

#### How containers help with scalability, reliability, and resilience:

**a. Scalability**:

- Easy horizontal scaling: New containers can be quickly spun up to handle increased load.
- Automatic scaling: Kubernetes can automatically adjust the number of running containers based on demand.
- Load balancing: Traffic can be distributed across multiple containers for optimal performance.

**b. Reliability**:

- Self-healing: Kubernetes can automatically detect and restart failed containers.
- Redundancy: Multiple instances of a service can be run to ensure high availability.
- Rolling updates: New versions of applications can be gradually deployed without downtime.

**c. Resilience**:

- Isolation: Failed containers don't affect other parts of the system.
- Graceful degradation: Applications can continue operating with reduced functionality when faced with partial failures.
- Rapid recovery: Kubernetes can quickly replace failed components and reschedule them across the cluster.


