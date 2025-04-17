## Generating a Self-Signed Certificate

If you just want local `HTTPS` (and you don’t mind a browser warning or manually trusting the cert), you can run:

```bash
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout nginx/certs/key.pem \
  -out nginx/certs/cert.pem \
  -subj "/CN=localhost"
```



Then your browser will likely warn you about an “insecure” self-signed cert. You can manually trust it for local dev.

Alternatively, [mkcert](https://github.com/FiloSottile/mkcert) is a great tool that sets up a local CA and issues certificates that your browser trusts automatically.