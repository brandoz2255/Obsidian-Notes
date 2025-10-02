Docker network it self is a system that enables containers to communicate with each other, the host, and external networks. It defines how data moves between containers and across systems during containerized application execution 


These isolated enviroments provide flexible network enviroments which use built - in bridge,host,overlay, and none. Each driver supports different use cases, such as local development, Swarm based orchestration, or integration with legacy infra

docker it self uses Virtual ethernet interfaces veth pairs in which connect the containers to networks. One end is inside the container, and the other connects to a bridge or another network device on the host.

Bridge: A network bridge acts like a virtual switch that forwards traffic between containers and host. 

[docker networking](https://spacelift.io/blog/docker-networking)
