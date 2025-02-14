Building with docker `buildx`

```bash
docker buildx create --name mybuilder
```

```bash
docker buildx use mybuilder
```

```bash
docker buildx build -t nameOfImage:tag .
```

more simply you can use docker-compose


---

#### pushing and buiding dockerfile

- with docker buildx

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t yourimage:latest --push .
```



### How to make bash script 

```bash
chmod +x nameOfScript 
```

m 

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

