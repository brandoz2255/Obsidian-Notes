### First from Linux sever.io 

-  A repo on Docker hub with useful docker images

```bash
docker run -d \
  --name=obsidian \
  --security-opt seccomp=unconfined `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 3000:3000 \
  -p 3001:3001 \
  -v /path/to/config:/config \
  --device /dev/dri:/dev/dri `#optional` \
  --shm-size="1gb" \
  --restart unless-stopped \
  lscr.io/linuxserver/obsidian:latest
```

