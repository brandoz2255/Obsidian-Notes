
this is how you install Docker on windows 

1. Visit [Dockers](https://www.docker.com/) website  
	1. Click Install Docker for Windows 
	2. then click install Docker Desktop for Windows 
2. It will ask to install WSL2 just click ok 
3. Then we wioll need to restart the system so just click close and restart
4. We have successfully installed Docker on Windows! 
5. powershell
	1. `docker version`
6. Now we are good to begin *DevOps*-ing 



https://discord.gg/CzwXHuzruW

#### Ubuntu 

Docker can be install via two version the Docker CE(Community Edition) or Docker EE(Enterprise Edition)

For small Scale Projects an learning we will use Docker CE 

```C
sudo apt update
```


```C
sudo apt install docker.io -y
```


```C
sudo systemctl enable docker --now
```


```C
docker --version
```


```C
sudo docker ps
```














#### Optional 

- we can add Docker to the list of sudoers 

```C
#sudo usermod -aG docker $USER
or
#sudo usermod -aG docker ubuntu
```

```C
getent group docker
```


```C
newgrp docker
```


```C
sudo service docker restart
```


- now we can run `docker ps` as a regular user





ciso{8yearstoolong}