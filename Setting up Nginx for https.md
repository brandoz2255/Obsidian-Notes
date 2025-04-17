Setting up an **Nginx reverse proxy** with **HTTPS** in Docker Compose is a great way to unify your **frontend** and **backend** behind a single secure domain/URL. Below is an example approach to get you started. We’ll add a **new `Nginx` service** to your existing Compose file, configure `SSL` (self-signed or `mkcert` for local `dev`), and route traffic to the Flask and `frontend` containers.

```css
project/
├─ docker-compose.yml
├─ snort/
│   └─ Dockerfile
│   └─ snort.conf
│   └─ logs/
├─ back/
│   └─ Dockerfile
│   └─ app.py
├─ frontend/
│   └─ Dockerfile
│   └─ (React/Vue/Angular code)
└─ nginx/
    ├─ certs/
    │   ├─ cert.pem
    │   └─ key.pem
    └─ nginx.conf
```


Where:

- **nginx/certs**: Holds your SSL certificate (`cert.pem`) and private key (`key.pem`). For local `dev`, you can use a self-signed certificate or something like [mkcert](https://github.com/FiloSottile/mkcert).
- **nginx.conf**: Your `Nginx` config that sets up `HTTPS` and proxies to the Flask `backend` and `frontend` containers.

---
## Example `nginx.conf`

Here’s a minimal config to get `HTTPS` on port 443 and route:

- `/api/` → **Flask** container
- `/` → **Frontend** container

```nginx
# nginx/nginx.conf

server {
    listen 443 ssl;
    server_name localhost;

    ssl_certificate     /etc/nginx/certs/cert.pem;
    ssl_certificate_key /etc/nginx/certs/key.pem;

    # Redirect /api/* to the Flask backend
    location /api/ {
        proxy_pass http://flask-backend:5000/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Everything else goes to the frontend
    location / {
        proxy_pass http://frontend:3000/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}

# Optional: Also listen on port 80 and redirect to HTTPS
server {
    listen 80;
    server_name localhost;
    return 301 https://$host$request_uri;
}
```


### A Note on Paths

- `proxy_pass http://flask-backend:5000/;` references the **service name** from Docker Compose.
- If your Flask routes are just `/stream`, you can do `location /api/ { proxy_pass http://flask-backend:5000/; }` and call it from the `frontend` as `/api/stream`.

---


```yaml
version: "3.8"

services:
  snort:
    build:
      context: ./snort
      dockerfile: Dockerfile
    cap_add:
      - NET_ADMIN
    network_mode: "host"
    restart: unless-stopped
    volumes:
      - ./snort/snort.conf:/etc/snort/snort.conf
      - ./snort/logs:/var/log/snort

  flask-backend:
    build:
      context: ./back
      dockerfile: Dockerfile
    expose:
      - "5000"            # Expose for internal Docker networking
    depends_on:
      - snort
    restart: unless-stopped
    volumes:
      - .:/back
      - ./snort/logs:/var/log/snort
      - ./snort/snort.conf:/etc/snort/snort.conf
    environment:
      - FLASK_ENV=development

  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
    expose:
      - "3000"
    depends_on:
      - flask-backend
    restart: unless-stopped
    environment:
      # Might point to /api if you're using the Nginx route
      - REACT_APP_BACKEND_URL=https://localhost/api

  nginx:
    image: nginx:alpine
    container_name: nginx-proxy
    depends_on:
      - flask-backend
      - frontend
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/conf.d/default.conf:ro
      - ./nginx/certs:/etc/nginx/certs:ro
    ports:
      - "80:80"
      - "443:443"
    restart: unless-stopped
```

### Key Points:

1. **No direct port mapping** for **frontend** and **flask-backend**. Instead, we just `expose` those ports internally (5000 for Flask, 3000 for frontend).
2. **Nginx** is your gateway to the outside world, mapping **80** and **443**.
3. The environment variable `REACT_APP_BACKEND_URL` (or `VITE_BACKEND_URL`) can be set to `https://localhost/api`. Then your frontend code would call, for example:

```ts
fetch(`${process.env.REACT_APP_BACKEND_URL}/stream`);
```

