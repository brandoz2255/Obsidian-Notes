### Linux namespaces 

- NET Namespace this isolates the network meaning its doing all the interfaces routing tables firewall rules isolating all that stuff 
- Its critical since its isolates the network from other containers and the host machine meaning when a web app is running on port 3000 inside the container it doesnt interfere with port 3000 on the host 
- Q8 runnign multiple containers that can all listen on port 80 ties in with the NET namespace  and port mapping 
	- each container by default is created with its own isolated network namespace this means that every container has its own private network stack which includes 
	- Its own unique IP address 
	- Its own set of network interfaces 
	- Its own routing table
	- Its own set of ports which are seperate form the hosts ports 

So if we have two containers A and B both listening on port 3000 each of those containers are listening to their respected port 3000 in its own isolated network stack 

Look at the brackets numbers in the output of `ls -l proc/$$/ns` 
what do the brackets mean 

its the unique identifier for the given process in the Namespace 

the only time it doesnt use its own stack is when we use the flag 
`--network=host` 

This allows the docker container to run outside the NET namespace into the hosts network stack. 

[Network](https://dev.to/pemcconnell/docker-networking-network-namespaces-docker-and-dns-19f1)

