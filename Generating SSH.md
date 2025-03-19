### Generate an SSH Key Pair

```bash
ssh-keygen -t rsa -b 2048 -f ~/.ssh/dftd
```

### To connect in CLI

```bash
ssh -i ~/.ssh/dftd DevOps@remote_server_ip
```

- This is to generate a SSH private for a user on the Ubuntu worker node 
