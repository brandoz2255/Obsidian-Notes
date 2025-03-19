- Containerization is the process in which we store web applications in isolated environments 
- In order to have the web application and its needed libraries to function a lot better in a lightweight environment 
- Its essentially like a VM but for any application or program we have created this allows for better portability of the program and allows it to run independently from the host system

Think of like someone going on a trip(app/program) this person would need to plan accordingly to the trip(code,libraries) we can't just throw everything into the trunk and hope for the best. 

- Doing this would end up damaging our code in the mess of things without having it organized 
- So that is what a container is for a suitcase(Container) it holds the libraries and code and other essentials to run the program. 

## Dockers  
As we have mentioned before the Containerization is the overall concept of containing programs in own separate environment. 

- When it comes to Dockers this is a open source platform that gives us the tools to do this 
We can instal the Docker engine by using this bash script

**Code: bash**

```bash
#!/bin/bash

# Preparation
sudo apt update -y
sudo apt install ca-certificates curl gnupg lsb-release -y
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt update -y
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Add user htb-student to the Docker group
sudo usermod -aG docker htb-student
echo '[!] You need to log out and log back in for the group changes to take effect.'

# Test Docker installation
docker run hello-world
```

### Docker engine 
- The **docker engine** is the core part of a Docker it handles the containers and provides the user with the necessary tools to manage a Docker Container 
- The **engine** is the core part of the software which handles the containerization such as docker daemons and REST APIs [study API]
- The Docker Engine comes with its own CLI used to manage and interact with the tools involved with the containerization
- **Docker Images**: Just like an image for VM these are the standalone executable packages that allow for the software to run including all the necessary tools to run it

#### Running a Docker 
-  We would have to create a docker image so that the docker engine can run the container 
- Or we could also grab a prebuilt one from this [site](https://hub.docker.com/)
- Then we make the image by putting it into a docker file which contains the list of instructions to tell the Docker engine to make the container EX: 

**Code: bash**

```bash
# Use the latest Ubuntu 22.04 LTS as the base image
FROM ubuntu:22.04

# Update the package repository and install the required packages
RUN apt-get update && \
    apt-get install -y \
        apache2 \
        openssh-server \
        && \
    rm -rf /var/lib/apt/lists/*

# Create a new user called "student"
RUN useradd -m docker-user && \
    echo "docker-user:password" | chpasswd

# Give the htb-student user full access to the Apache and SSH services
RUN chown -R docker-user:docker-user /var/www/html && \
    chown -R docker-user:docker-user /var/run/apache2 && \
    chown -R docker-user:docker-user /var/log/apache2 && \
    chown -R docker-user:docker-user /var/lock/apache2 && \
    usermod -aG sudo docker-user && \
    echo "docker-user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Expose the required ports
EXPOSE 22 80

# Start the SSH and Apache services
CMD service ssh start && /usr/sbin/apache2ctl -D FOREGROUND
```


We would use this command execute the `dockerfile`

```shell-session
00818@htb[/htb]$ docker build -t FS_docker
```

- Once we have created our image we can run the container very easily it is very similar to a VM 

####  Docker Run
- Then we can start the container with this syntax

```shell-session
00818@htb[/htb]$ docker run -p <host port>:<docker port> -d <docker container name>
```

Example of syntax:

```shell-session
00818@htb[/htb]$ docker run -p 8022:22 -p 8080:80 -d FS_docker
```


### Docker management 
We can manage Docker containers with these commands 

|**Command**|**Description**|
|---|---|
|`docker ps`|List all running containers|
|`docker stop`|Stop a running container.|
|`docker start`|Start a stopped container.|
|`docker restart`|Restart a running container.|
|`docker rm`|Remove a container.|
|`docker rmi`|Remove a Docker image.|
|`docker logs`|View the logs of a container.|

- Key takeaways from this is that once a container is made we can make changes to the container later by making a new docker file
- These commands can also be combined for various options such as (e.g., port exposure, volume mounting, environment variable setting).
- A `Dockerfile` starts with the `FROM` statement in which is necessary for commands and desired changes 
- use `Docker build` to create a new image give it a new name 
- For manageing and scaling containers use other tools like `Docker compose` or `Kubernetes` 

## Linux Containers (LXC)
A Linux Container is essentailly a Docker container but for a whole Linux machine:

- This Virtualization technology allows for multiple isolated Linux machines to run on a single host 
- Uses Kernel features such as `cgroups` and `namespaces` which allows lightweight virtualization 
- Has a rich set of tools for container management and APIs 
- To make this image we must create the root file system, installing packages and configurations 
- Isn't as robust as dockers in terms of security 

Installation for LXC

```shell-session
00818@htb[/htb]$ sudo apt-get install lxc lxc-utils -y
```

- Once it is installed we can create and manage the containers on the Linux host machine 
- It is also worth noting that the LXC requires that the Kernel supports necessary features for containerization

Creating a LXC 

```shell-session
00818@htb[/htb]$ sudo lxc-create -n linuxcontainer -t ubuntu
```

Commands for managing a LXC 

|Command|Description|
|---|---|
|`lxc-ls`|List all existing containers|
|`lxc-stop -n <container>`|Stop a running container.|
|`lxc-start -n <container>`|Start a stopped container.|
|`lxc-restart -n <container>`|Restart a running container.|
|`lxc-config -n <container name> -s storage`|Manage container storage|
|`lxc-config -n <container name> -s network`|Manage container network settings|
|`lxc-config -n <container name> -s security`|Manage container security settings|
|`lxc-attach -n <container>`|Connect to a container.|
|`lxc-attach -n <container> -f /path/to/share`|Connect to a container and share a specific directory or file.|

- We can make a LXC container on any Linux machine regardless of the environment 

## Securing a LXC 
In order to secure a LXC we must first limit the CPU usage of the Cointainer it self we can using a vim editor in the following directory 

- Location of config file:
	- `/usr/share/lxc/config/<container_name>.conf`

```shell-session
00818@htb[/htb]$ sudo vim /usr/share/lxc/config/linuxcontainer.conf
```

**Code: txt**

```txt
lxc.cgroup.cpu.shares = 512
lxc.cgroup.memory.limit_in_bytes = 512M
```

- The first line determines the CPU time share lower value limit the CPU usage 
- The second line sets the maximum usage
- Then we restart the container with 

```Shell-session 
sudo systemctl restart ixc.service
```

