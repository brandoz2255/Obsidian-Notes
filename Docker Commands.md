In this part of the Docker training its just the basic usage of Docker and how to use it and command it on what to do 

Docker is an Open-Source Project that automates the deployment of applications 

- you can run these independent containers either locally or in the cloud 
- there is alot of commands in docker but we will look at just the top commands
- `docker run <image_name>`
	- used to run containers from an image 
	- combination of the docker start and docker create commands 
- `docker run --name <container_name> <image_name>`
- `docker run redis`
- `docker pull <image_name>`
	- This command allows to pull any image you want 
	- which only if its present in the registry of docker or *Docker Hub*
- `docker ps`
	- kinda like ls but for docker just lists all of the running containers 
		- `-a` flag means show all the containers stopped or running 
		- `-l` flag shows the latest containers
		- `-q` shows only the id of the containers 
- `docker ps [options...]` 
- `docker stop <container_ID>`
	- this command allows for you to stop a container in case it crashes or if you just want to stop it
- `docker start <container_ID>`
	- this command allows you to start the stopped container again  
- `docker rm`
	- this container allows fort he deletion of a container you can use the id or the name of the container
		- `-f` flag allows to remove the container forcefully 
		- `-v` flag allows you to remove the volumes
		- `-l` flagremoves the specific link 
- `docker rmi <image ID/ image name>` 
	- This command allows for the deletion of the image in docker 
	- Helps with freeing up space by removing useless images from the docker local storage
- `docker images`
	- lists all of the puiled images that are present in the system 
- `docker exec`
	- this command allows you to run new commands in a container
	- Only works whent he container is running 
		- `-d` flag is for running commands in the background
		- `-i` flag will keep the STDIN open 
		- `-e` flag sets the environment variables 
- docker ports (mapping)
- in order to use a container in docker we must map the ports onto our host 
- `docker run -d -p <port_on_host>`
- `docker login`
	- allows you to login and authenticate with docker hub so that we can push and pull our images at will 
- `docker push <image name/ image id>`
	- once we make a image using a docker file we need to store the image remotely 
	- DockeHub is where one would do it 
	- This is the command to do it
- `docker build -t image_name:tag`
	- This is the build to build docker images using dockerfile
- `docker stop container_name_or_id` 
	- we can stop a container or start wherever we want to do maintenance for the containers with this command
- `docker stop container1 container2 container3` 
	- instead of stopping a single container we can stop multiple at a time 
- `docker restart container_name_or_id` 
	-  this restarts the container id if one detects errors or if it fails to start 
- `docker inspect container_name/id`
	- can debug the containers errors in real time with this command 
- `docker commit container_name_or_id` 
	- we can make updates to the containers with this command 