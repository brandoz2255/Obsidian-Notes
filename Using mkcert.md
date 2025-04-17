### Linux


On Linux, first install `certutil`.

```bash
sudo apt install libnss3-tools
    -or-
sudo yum install nss-tools
    -or-
sudo pacman -S nss
    -or-
sudo zypper install mozilla-nss-tool
```

```bash
yay -S mkcert
```

```bash
mkcert -key-file key.pem -cert-file cert.pem example.com *.example.com
```


### First 

```bash
# 1. Install mkcert's local CA (if you haven't already)
mkcert -install

# 2. Generate a cert and key for localhost (and optionally 127.0.0.1, ::1)
mkcert -key-file key.pem -cert-file cert.pem localhost 127.0.0.1 ::1
```

### Why Those Hosts?

- **`localhost`** is the usual domain for local dev.
- **`127.0.0.1`** is the `IPv4 loopback` address.
- **`::1`** is the `IPv6 loopback` address.

creates two files in your current directory:

- **`key.pem`** — your private key
- **`cert.pem`** — the certificate that’s signed by `mkcert’s` local CA

- [[k8s dashboard web app]]
- [[AI ITR]]
- [[Personal Portfolio website]]