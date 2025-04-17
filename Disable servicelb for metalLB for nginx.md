✅ Step 1: Edit the systemd service

```bash
sudo systemctl edit k3s.service
```

This opens a blank override file. Paste this into the editor:

```bash
[Service]
ExecStart=
ExecStart=/usr/local/bin/k3s server --disable servicelb
```

This **overrides** the original `ExecStart` with your custom one, disabling `ServiceLB`.

