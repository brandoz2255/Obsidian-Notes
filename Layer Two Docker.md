
### Docker uses Multiple different types of namespaces.Name at least 3 and explain what each one isolates 

Docker it self uses Six namespaces to achieve isolation 

- `PID` Namespace -> process isolation
- `USER` Namespace -> managing user permissions
- `MNT` namespace -> managing filesystem mount points
- `NET` namespace -> Managing network Interfaces
- `IPC` namespace -> managing access to IPC resources
- `UTS` namespace -> Isolating kernel and version identifiers 

Docker only uses 6 

- `cgroups` namespace -> It controls the CPU RAM and I/O

Three namespaces docker uses is PID MNT USER

- PID isolates the process isolation 
- MNT  mnt filesystem  mount points
- USER Isolates user operation based on user permissions 

[Linux Namespaces](https://www.redhat.com/en/blog/7-linux-namespaces)
[Docker Namespaces](https://hewi.blog/diving-deep-how-docker-achieves-container-isolation-using-the-underlying-os-part-1)


### Mentioned cgroups control resources. What specific resources can cgroups limit give example

- Cgroups also known as control groups can limit resources such as CPU, RAM and I/O 


### What specific differences do Cgroups vs Namespaces do

- Cgroups control how much resources a Container can get Like CPU RAM and I/O
- Namespaces allow the container to be isolated from the machine using namespaces such as PID MNT USR 