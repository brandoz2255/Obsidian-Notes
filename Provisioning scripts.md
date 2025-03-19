- `Install_docker.sh`

```bash
#!/bin/bash
sudo yum update -y
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
```

- `install_k3s.sh`:

```bash
#!/bin/bash
curl -sfL https://get.k3s.io | sh -
```

**`install_calico.sh`**:

```bash
#!/bin/bash
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```

```bash
chmod +x scripts/*.sh
```

