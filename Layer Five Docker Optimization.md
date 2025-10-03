```Dockerfile
FROM node:18
COPY . /app
RUN npm install
RUN npm test
CMD ["node", "server.js"]
```

```Dockerfile
FROM node:18
COPY . /app
RUN npm install  --no-cache
RUN npm test
CMD ["node","server.js"]
```

- I would   add a --no-cache to npm install so it can delete the package managers index

`Union Filesystem` What is this and why is this how docker sstores its images 

Union Filesystem is the building blocks of Docker   Its  encompasses the layering system that docker runs on for making  images 

The Union filesytem is that layer of files with multiple branches such as container layers and images layers
Docker stores its  images in layers using the Union file system for disk space storage optimization keeping that lightweight  alternative towards a VM compared to ext or NFS for containers 10G og memory would be eaten up if the container was ext  or NFS rather in Union it puts it in 1GB 

Union File System Works on top of other file-systems.  


And how does docker store it in a Union Filesystem and how does this compare to other filesystems. The way Union Filesystem is designed is that its layered by mounting directories to a single root more a mounting machanism that a file system. 

- What is overlay2 and how  does iit work 

OverlayFS is a Union filesystem which docker  normally uses to sstore its images on disk it does by merging one read-only lower stack with one writable upper dir into a single merged mount. 

Why this is disk space efficient the layers are shareable across many containers and images so lets say if 50 containerss each a different web app share the same ubuntu  base layer thhen that is stored once on disk and shared by all of them . Thats the win for containers compared to 50 full copies on ext4. 

If two layers need the same images its reused not duplicated. 

Where its not more efficient 
if we only have one container or image overlayfss doesnt just magically save space it can be bit too  mujch when it comes  to  metadata overhead

Large file edits overlayfs cow is file level not block level so changing one byte of a  2gb file copies the entire file into the upper layer filessystem with block level CoW can be more space effiicient for this case like btrfs or ZFS. 

- What exactly happens when a  container writes to a  file 

Contaienr sees a merged view it hass read only lower layers + writable upper layers the container

if we write to a file system that onlky exists in a lower layher overlayFS doea  copy up it copis that whole  fiile into the upper layer then writes our chagnes there. form that point we are using the upper copy 


```Dockerfile 
# ---------- Builder: compile any source wheels ----------
FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04 AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential python3 python3-pip python3-dev curl \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /w
COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir --upgrade pip setuptools wheel

# Pre-reqs for pkuseg build
RUN pip install --no-cache-dir numpy Cython

# Install Torch (CUDA) explicitly so it doesn't reappear later
RUN pip install --no-cache-dir \
  torch==2.6.0+cu124 torchvision==0.21.0+cu124 torchaudio==2.6.0 \
  --index-url https://download.pytorch.org/whl/cu124

# Build wheels for the rest (excluding torch)
RUN grep -v "^torch" requirements.txt > requirements_no_torch.txt \
 && pip wheel --no-cache-dir -r requirements_no_torch.txt -w /wheels

# Also build a wheel for pkuseg if it comes from source
RUN pip wheel --no-cache-dir pkuseg==0.0.25 --no-build-isolation -w /wheels

# ---------- Runtime: no compilers, minimal OS deps ----------
FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip libgl1 ffmpeg tesseract-ocr tesseract-ocr-eng curl \
  && rm -rf /var/lib/apt/lists/*

# Install torch first (binary wheels) to avoid conflicts
RUN python3 -m pip install --no-cache-dir --upgrade pip setuptools wheel \
 && pip install --no-cache-dir \
    torch==2.6.0+cu124 torchvision==0.21.0+cu124 torchaudio==2.6.0 \
    --index-url https://download.pytorch.org/whl/cu124

# Install the prebuilt wheels from builder
COPY --from=builder /wheels /wheels
RUN pip install --no-cache-dir --no-index --find-links=/wheels /wheels/* \
 && rm -rf /wheels \
 && pip cache purge

# App user and app code
RUN useradd -m -u 1001 -s /bin/bash appuser
WORKDIR /app
COPY . .
RUN mkdir -p /home/appuser/.cache/whisper /home/appuser/.cache/huggingface \
  && chown -R appuser:appuser /home/appuser/.cache /app

USER appuser
ENV PYTHONPATH=/app \
    TRANSFORMERS_CACHE=/home/appuser/.cache/huggingface \
    HOME=/home/appuser
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

```

WTF is a multi stage build

Another stage it  self iis a self container build enviroment stared by a FROM a Lyer on itts won is what a dockerfile instruciuon creates insiude a stages filesystem. 

When we do a Multi stage build we use FROM as BUILDER for  a compile sstage then a second FROM for a small runtime and COPY to bring only the artifacts we need for the final stage. 

**What happens to earlier stages?**  
They’re **intermediate images** used for build cache. They are not “deleted out of” the final image (they were never in it). You can prune them later with `docker builder prune` / `docker image prune` if you want to reclaim cache space.

Why would we use so that when buiilder builds the enviroment movving the artifact towards the real runtime image where the final image is using only  what we need  

Overlay2 is just second generation from overlayfs meaning it just an upgrade and it has improvements on allowing multiple lower dirs. 

The optimization of the first dockerfile is not complete or as strong as it could be in termss of optimizations 


```Dockerfile
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm test
CMD ["node","server.js"]
```

In thhiss case it doesnt just copy everything and this way when we change the code npm install uses a cached layer 

