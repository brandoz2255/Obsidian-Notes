this one is a **Chrome security quirk** known as **Private Network Access** (formerly “`CORS`-`RFC1918`”). Essentially, Chrome is blocking requests from an **insecure context** (HTTP) to a **private network resource** (like `localhost`).

### Why It Happens

- Your `frontend` is served over HTTP (likely `http://localhost:3000`).
- You’re calling an endpoint on `http://localhost:5000`.
- Chrome sees that you’re trying to access a **private network resource** (localhost) from an **insecure** (non-`HTTPS`) origin, and flags it as a security risk.

```bash
google-chrome-stable --disable-web-security --user-data-dir=/tmp/dev
```

### How to Fix It

1. **Serve Everything Over HTTPS**
    
    - Easiest in production is to have both the `frontend` and `backend` behind `HTTPS`.
    - For local `dev`, you can create a self-signed cert or use something like [mkcert](https://github.com/FiloSottile/mkcert) to generate local certificates.
    - Then run both your `frontend` and `backend` on `https://localhost:3000` and `https://localhost:5000`.
2. **Use Chrome Flags (Temporary Dev Hack)**
    
    - If you’re just hacking around locally, you can temporarily disable the block in Chrome.
    - Go to `chrome://flags/#block-insecure-private-network-requests` and set it to **Disabled**.