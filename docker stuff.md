
```bash
docker build -t node-docker-app .

```

```bash
docker run -p 3000:3000 node-docker-app
```



```bash
docker run -p 3000:3000 -v $(pwd):/app node-docker-app
```



