to keep those mkcert-generated certs out of your repo (because sensitive info is best kept private), just update your `.gitignore`. For example, if your certificates are stored in `nginx/certs/`, add the following line to your `.gitignore`:

```bash
# Ignore SSL certificates (mkcert generated)
nginx/certs/
```

