- [[git]] 
- [[vim]]
- [[Docker buildx install MacOS]]
- [[vagrant course 1]]
## Create Repo

- get on project root 

```bash
git init
```

```bash
git branch -m main
```

- Only after we make the github repo!

```bash
git pull -u origin main
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
git push -u origin main
```

```bash
touch README
```

```bash
vim README
# or
nano README
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
nano Dockerfile
# or 
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
- [[what is buildx]]


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

- [[Chmod]]

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

---

- [[bash]]

#### This is the CI/CD pipeline 

- This is the `yaml` configuration file for `Github` actions

```yaml
name: Docker Buildx CI/CD

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2

      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{secrets.DOCKER_HUB_USERNAME}}
          password: ${{secrets.DOCKER_HUB_ACCESS_TOKEN}}

      - name: Build and Push Docker Image
        uses: docker/build-push-action@v5
        with:
          context: .
          platforms: linux/amd64,linux/arm64
          push: true
          tags: ${{ secrets.DOCKER_HUB_USERNAME }}/ubuntu-env:latest
```
 