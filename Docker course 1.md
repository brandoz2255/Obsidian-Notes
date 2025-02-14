
## Create Repo

- get on project root 

```bash
git init
```

```bash
git branch main
```

```bash
git add .
```

```bash
git commit -m "first commit"
```

```bash
git remote add origin <your_repo_url>`
```

```bash
git push -u origin main`
```

```bash
touch README
```

```bash
vim README
```

```bash
git add README
```

## Creating a Dockerfile 

```bash
touch Dockerfile
```

or 

```bash
vim Dockerfile
```

then make `Dockerfile` with basic syntax 

```Dockerfile
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
  tmux \
  vim \
  # Add any other packages you need
  && rm -rf /var/lib/apt/lists/*

# Set the default command to run tmux
CMD ["tmux"]
```

### Actual Dockerfile


### Building Dockerfile 

- [[Docker buildx]]

```bash
sudo docker build -t nameOfimage .
```

### then running it

```bash
sudo docker run -it nameOfimage
```




--- 


### Pushing to Docker hub 

- Go to Dockerhub 
- create a repository 
- name whatever you want 


```bash 
docker login
```

``` bash
docker push nameOfImage:latest
```



### How to make bash script 

```bash
chmod +x nameOfScript 
```


### Git commands 

after bash script 

```bash
git add .
```

``` bash
git commit -m "the commit comment"
```

``` bash
git push origin main
```

