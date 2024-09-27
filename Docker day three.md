# Activity One 

Fix broken Container 
Make a broken container that wont start unless they fix it  have the docker file with a txt that has the flag within however they need to show me that they cat it within the container if  they find another way to open it
- we could make a large file with a lot of annoying numbers and unreadable stuff in it then hide the flag within it and they need to use cat and grep to find it within the container after they fix it 


Cheat Sheet 

```C
# -d, --detach: Runs the container in detached mode (in the background)
docker run -d nginx
# ^ Starts an nginx container in the background.

# -p, --publish: Publishes a container's port to the host (host_port:container_port)
docker run -p 8080:80 nginx
# ^ Maps port 80 in the container to port 8080 on the host machine.

# --name: Assigns a name to the container
docker run --name my_nginx -d nginx
# ^ Starts a container with the name 'my_nginx'.

# -e, --env: Sets environment variables in the container
docker run -e ENV_VAR=value myapp
# ^ Passes 'ENV_VAR' with 'value' into the running container.

# -v, --volume: Binds a volume (host_directory:container_directory)
docker run -v /host/data:/container/data myapp
# ^ Mounts '/host/data' on the host to '/container/data' in the container.

# -it: Combines -i (interactive) and -t (TTY), for running containers interactively
docker run -it ubuntu /bin/bash
# ^ Runs an Ubuntu container and opens an interactive bash shell.

# --rm: Automatically removes the container when it exits
docker run --rm myapp
# ^ Cleans up the container when it's stopped.

# --network: Specifies the network mode (e.g., bridge, host, none)
docker run --network host myapp
# ^ Runs the container on the host's network.

# --restart: Specifies the restart policy ('no', 'on-failure', 'always', 'unless-stopped')
docker run --restart unless-stopped myapp
# ^ Restarts the container unless it's explicitly stopped.

# --cpus: Limits the number of CPUs (e.g., 0.5 for half a CPU, 1.0 for one CPU)
docker run --cpus=1.5 myapp
# ^ Limits the container to 1.5 CPUs.

# --memory: Limits the container's memory (e.g., 512m, 2g)
docker run --memory=512m myapp
# ^ Limits the container to 512 MB of RAM.

# -u, --user: Specifies the user to run the container as (user:group)
docker run -u 1000:1000 myapp
# ^ Runs the container with user ID 1000 and group ID 1000.

# --entrypoint: Overrides the default ENTRYPOINT of the image
docker run --entrypoint /bin/sh myapp
# ^ Starts the container with '/bin/sh' as the entrypoint.

# --log-driver: Specifies the logging driver (e.g., 'json-file', 'syslog', 'none')
docker run --log-driver=syslog myapp
# ^ Uses the syslog logging driver for the container.

# --detach-keys: Overrides the key sequence for detaching a container (default: Ctrl-p Ctrl-q)
docker run --detach-keys="ctrl-x" myapp
# ^ Uses 'ctrl-x' to detach from the running container.

# --cap-add, --cap-drop: Adds or drops Linux capabilities
docker run --cap-add NET_ADMIN myapp
# ^ Grants the container the NET_ADMIN capability, which allows network-related operations.

# --security-opt: Modifies security options (e.g., seccomp, apparmor)
docker run --security-opt seccomp=unconfined myapp
# ^ Runs the container without seccomp filtering.

# -h, --hostname: Sets the container's hostname
docker run -h myapp-container myapp
# ^ Sets the container's hostname to 'myapp-container'.

```

----

# Activity Two 

Make a mini project using Python have have them make a github repo 
add a CI/CD pipeline 
have them push it to dockerhub via actions
have them push it to github 
Make a dockerfile for the python app simple calculator 
test the container 

---
