 
- How does Docker make the images 

Docker images are layers that are merged into a Union filesystem at runtime Each Layer with its own filesystem changes relative to the previous layer in the stack. This is better for image effciency as layers can be cached and reused by other builds 

The layering system it self was designed to be as transparent as it can be for containers and developers we don't need to know how it works to create images however understanding can help since it allows for faster builds and smaller sizes

[Docker builds](layers that are merged into a union filesystem at runtime.)


- Why does docker make the images Why do we need docker images

The Image contains all the libraries, dependencies, and files that a container would need to run. The docker image is shareable and portable, so we can deploy the same image in multiple locations. 

[why docker images](https://aws.amazon.com/compare/the-difference-between-docker-images-and-containers/)


- How does it build it directly from the file
  
  Docker builds images by reading the instructions from the Dockerfile The Dockerfile it self is a list instruciton on how to make the docker image

[Dockerfiles](https://docs.docker.com/build/concepts/dockerfile/)
  
- How does docker make layers 

How docker creates a image is from Dockerfile however each line/ isntruction from the Dockerfile is the result of docker creating a new layer

[What is a docker image layer](https://www.geeksforgeeks.org/devops/what-is-docker-image-layer/)

the Docker image it self is a Immutable file

- and why does docker do use layers instead one file

It does this to improve efficiency as layers can be cached and reused at any time by other builds

Question that need to be answered 

```dockerfile
FROM alpine:3.18
RUN apk add --no-cache curl
RUN apk add --no-cache wget
COPY app.js /app/
CMD ["node", "app.js"]
```

`FROM alpine:3.18`

Docker starts the apline base image this is the first layer of the new image

Caching here Docker checks if the image is in local cache if not it downloads from registry

`RUN apk add --no-cache curl`

Docker runs the apk command to install curl this new read-only layer is created to contain the changes made by this command

Caching: The `--no-cache` flag tells apk to delete the package managers index after installation to keep the layer size small. 

`RUN apk add --no-cache wget`

Docker runs the second apk command to install wget creates another layer

Caching here is a new instruction because of the older --no-cache so docker must re-run it

`COPY app.js /app/`

Docker copies the app.js from your local machine into the image. This  creates a fourth layer 

Caching This part is powerful if we change the contents of app.js docker will rerun this command if not docker will skip since it already has this layer cached for reuse 

`CMD ["node","app.js"]` 

This instruction sets the default command to be executed when a container starts 

caching: `CMD` does not create a new file system layer that adds to the image instead it just add metadata to the images final layer. 

Q12 thus it only creates 4 layers the ones cached are app.js layer and alpine layer 

Where does docker store the images

Docker stores its images on containers on the hosts disk using a specialized filesystem typically called a `Union filesystem` like `overlay2` managed by the `storage driver` 
which operates at dockers data directory `/var/lib/docker/`
on linux



Q10: An image is a blueprint but what is an image technically? How is it stored on disk

An image is layers of filesystems that make up the image  each line from the Dockerfile is just a new layer  for docker to run and create towards the total final docker image in short an image is a bundle layers and all those layers make up the entire images filesystem

How its stored on the disk is it uses  a union filesystem typicallyu overlay2 in /var/lib/docker/overlay2/

Q11: Docker Images are made of layers. What are layers, and why does docker them instead one big file 

Docker images use layer for efficiency as layers can be cached which then can be reused for other images A docker layer is a set of filesystem changes created after each instruction from the Dockerfile 

A Docker image is composed of a stack of these read-only layers, which a Union Filesystem combines into a single, cohesive filesystem.

dockerfile from Harvis has 20 layers

```output
ocker.io/library/nginx:alpine
IMAGE          CREATED        CREATED BY                                      SIZE      COMMENT
4a86014ec699   7 weeks ago    RUN /bin/sh -c set -x     && apkArch="$(cat …   40.1MB    buildkit.dockerfile.v0
<missing>      7 weeks ago    ENV NJS_RELEASE=1                               0B        buildkit.dockerfile.v0
<missing>      7 weeks ago    ENV NJS_VERSION=0.9.1                           0B        buildkit.dockerfile.v0
<missing>      7 weeks ago    CMD ["nginx" "-g" "daemon off;"]                0B        buildkit.dockerfile.v0
<missing>      7 weeks ago    STOPSIGNAL SIGQUIT                              0B        buildkit.dockerfile.v0
<missing>      7 weeks ago    EXPOSE map[80/tcp:{}]                           0B        buildkit.dockerfile.v0
<missing>      7 weeks ago    ENTRYPOINT ["/docker-entrypoint.sh"]            0B        buildkit.dockerfile.v0
<missing>      7 weeks ago    COPY 30-tune-worker-processes.sh /docker-ent…   4.62kB    buildkit.dockerfile.v0
<missing>      7 weeks ago    COPY 20-envsubst-on-templates.sh /docker-ent…   3.02kB    buildkit.dockerfile.v0
<missing>      7 weeks ago    COPY 15-local-resolvers.envsh /docker-entryp…   389B      buildkit.dockerfile.v0
<missing>      7 weeks ago    COPY 10-listen-on-ipv6-by-default.sh /docker…   2.12kB    buildkit.dockerfile.v0
<missing>      7 weeks ago    COPY docker-entrypoint.sh / # buildkit          1.62kB    buildkit.dockerfile.v0
<missing>      7 weeks ago    RUN /bin/sh -c set -x     && addgroup -g 101…   4.13MB    buildkit.dockerfile.v0
<missing>      7 weeks ago    ENV DYNPKG_RELEASE=1                            0B        buildkit.dockerfile.v0
<missing>      7 weeks ago    ENV PKG_RELEASE=1                               0B        buildkit.dockerfile.v0
<missing>      7 weeks ago    ENV NGINX_VERSION=1.29.1                        0B        buildkit.dockerfile.v0
<missing>      7 weeks ago    LABEL maintainer=NGINX Docker Maintainers <d…   0B        buildkit.dockerfile.v0
<missing>      2 months ago   CMD ["/bin/sh"]                                 0B        buildkit.dockerfile.v0
<missing>      2 months ago   ADD alpine-minirootfs-3.22.1-x86_64.tar.gz /…   8.31MB    buildkit.dockerfile.v0
            "Layers": [
                "sha256:418dccb7d85a63a6aa574439840f7a6fa6fd2321b3e2394568a317735e867d35",
                "sha256:b6ff0212304efd5de6311b4e727f4bd05fc63af88535439035f997cebdc5d009",
                "sha256:7978a9c91f722f830483a8564f1f45ea2de69467ae9eb202744651a7cded90d7",
                "sha256:16ca725632e5c0cb9010a6a0a703017a42ba36997de90b62d9aa9f152b6f3db5",
                "sha256:917b2c97271ec45eedfc9bc6aa3f52cf3e88550e5de87b4273736472db4247b1",
                "sha256:a2b76470e8f1cd1ec142fd58ab96656d719d62944029299b14ab6a418df84fa0",
                "sha256:d208138be39ddf6e3327493a5b1298a4e577faef5c09c2b91d82e2ca42698a84",
                "sha256:f9985d3fc94dfae94021c560b6c8878e21f19f39a4c1f58051a535d2f0c2b165"
            ]
        },
        "Metadata": {
            "LastTagTime": "0001-01-01T00:00:00Z"
        },
        "Config": {
            "Cmd": [
                "nginx",
                "-g",
                "daemon off;"
            ],
            "Entrypoint": [
[dulc3@dulc3-top ~]$ 
```
