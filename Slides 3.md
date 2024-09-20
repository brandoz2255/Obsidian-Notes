```C
FROM node:14-alpine
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
CMD ["node", "index.js"]
```

#### **Step 2: Building the Image**

- Docker builds the image by reading the Dockerfile using the command:
```C
docker build -t myapp .
```
-  **Layers:** Each instruction in the Dockerfile creates a new layer in the Docker image.
    - **Caching:** Docker caches layers, so if a layer hasn't changed, it won't be rebuilt (improving efficiency).
    - **Image Tagging:** Images can be tagged (`-t myapp`), making it easier to version and reference.

