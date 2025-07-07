## adding new service

```bash
# PGADMIN
server {
    listen 80;
    server_name pgadmin.dulc3.tech;

    location / {
        proxy_pass http://pgadmin-service:80;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

# PIHOLE
server {
    listen 80;
    server_name pihole.dulc3.tech;

    location / {
        proxy_pass http://192.168.4.100/admin/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_redirect off;
    }
}
```

- we simply just add another block
## remember this done in case nginx doesn't load the site properly
## 💡 Want to serve Pi-hole directly at `/`?

If you want `pihole.dulc3.tech/` to show the UI cleanly without broken assets (served as if it's **root**), you **have to rewrite** the path.

Here’s an example:

```bash
server {
    listen 80;
    server_name pihole.dulc3.tech;

    location / {
        proxy_pass http://192.168.4.115/admin/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_redirect off;
    }
}
```


##### To restart the containers post config

```bash
kubectl rollout restart deployment nginx-pgadmin
```




