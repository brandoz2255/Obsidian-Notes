### What is docker 

Docker is a containerization software it bundles applications into containers, A container allows the app to be isolation from the main operating system. Meaning the application running in a docker container does not interfere with other applications running on that machine especially of those other applications are also running within a container

### Why

This makes Docker portable across environments for dev this allows everyone in the dev team to be on the same environment and for DevOps and sysadmins this allows the team to move that dev environment easily into a prod ready environment without any issues fixing the issue of it works on my machine 
### What is  a image vs container 

And image is a the  downloadable instance and config of a container or inactive instance of a container where the container it self is the running instance of an image it self where the image is the blueprint and a container is a live running instance created from the image. 

### How does docker achieve isolation 

it achieves isolation via Namespaces and Cgroups 

docker uses kernel features such as Cgroups also known as Control groups to keep resource management tight within the container 

they also allow control of I/O to groups of processes 

- What is Linux Namespaces 
- A Linux Namespace one  in short is how a Linux were to partition system resources making a group of resources similar to how those work inside docker container 

### How one could see said processes 


- `proc/` is the linux directory a treasure trove of running processes They also hold PIDs of Linux processes 
- `PID` Processes ID 

command to see Cgroups and PIDs 

``` bash
ls -l proc/$$/ns/
```

```output
total 0
lrwxrwxrwx 1 dulc3 dulc3 0 Oct  1 16:57 cgroup -> 'cgroup:[4026531835]'
lrwxrwxrwx 1 dulc3 dulc3 0 Oct  1 16:57 ipc -> 'ipc:[4026531839]'
lrwxrwxrwx 1 dulc3 dulc3 0 Oct  1 16:57 mnt -> 'mnt:[4026531841]'
lrwxrwxrwx 1 dulc3 dulc3 0 Oct  1 16:57 net -> 'net:[4026531840]'
lrwxrwxrwx 1 dulc3 dulc3 0 Oct  1 16:57 pid -> 'pid:[4026531836]'
lrwxrwxrwx 1 dulc3 dulc3 0 Oct  1 16:57 pid_for_children -> 'pid:[4026531836]'
lrwxrwxrwx 1 dulc3 dulc3 0 Oct  1 16:57 time -> 'time:[4026531834]'
lrwxrwxrwx 1 dulc3 dulc3 0 Oct  1 16:57 time_for_children -> 'time:[4026531834]'
lrwxrwxrwx 1 dulc3 dulc3 0 Oct  1 16:57 user -> 'user:[4026531837]'
lrwxrwxrwx 1 dulc3 dulc3 0 Oct  1 16:57 uts -> 'uts:[4026531838]'

```


What is the output saying 

The numbers in the brackets are unique identifiers for each namespace instance 

All the processes on the host will share the same namespace inode numers for the uts until a new namepsace is created for a process. 

Now to look at the cgroups of your current shell 

```bash
cat /proc/$$/cgroup
```

```output
0::/user.slice/user-1000.slice/user@1000.service/tmux-spawn-b2647dbd-dffa-45db-84aa-f06560c25969.scope
```


We can see that our shell is apart of `systemd` user slice and the session scope for our instance we see the session scope of `tmux`

Cool little lab we can see from here

```bash
docker run -it --name namespace-demo --rm debian:latest bash
```

 - Here we are running a docker container using debian image 
 - -i flag stands for interactive and -t flag stands for starting a tty terminal session since we are going to start it in bash shell 

After running that docker tty open a new terminal session 

```bash
PID=$(docker inspect -f '{{.State.Pid}}') namespace-demo}
echo "Container PID: $PID"
```

**Compare namespaces:**  
Now, list the namespaces of the container's main process. Compare the inode numbers to your host shell.

```bash
sudo ls -l /proc/$PID/ns/
```

``` bash
sudo nsenter -t $PID -n ip a
```

- Using this command one could enter the namespace of a container using the namespace 

Then we can see the cgroups of the pid as well

```bash
cat /proc/$$/cgroup
```

we should see it with the container id 
