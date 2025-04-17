-  to find the `ip` of the `VM` made by `terraform` 
- go into machine via `vnc` and turn off pub key first in `/etc`
- then turn on password `auth` once done run the scripts and create a root user 

```bash
sudo passwd root
```

```bash
su
```

- after root was made 

```bash
 virsh -c qemu:///system domifaddr rocky1_vm
```


```bash
#!/bin/bash
# This script sets a static IP using nmcli and configures the DevOps user with your SSH key.
# Run as root or with sudo.

# --------- Static IP Configuration ---------
# Desired network settings:
STATIC_IP="192.168.122.100/24"    # Change this to your desired static IP
GATEWAY="192.168.122.1"           # Adjust as needed
DNS="8.8.8.8 8.8.4.4"

# Find the active network connection name (e.g., "Wired connection 1")
CON_NAME=$(nmcli -t -f NAME con show --active | head -n 1)
if [ -z "$CON_NAME" ]; then
    echo "No active network connection found. Exiting..."
    exit 1
fi

echo "Using connection: $CON_NAME"
echo "Configuring static IP..."

# Set the static IP settings using nmcli
nmcli con mod "$CON_NAME" ipv4.addresses "$STATIC_IP"
nmcli con mod "$CON_NAME" ipv4.gateway "$GATEWAY"
nmcli con mod "$CON_NAME" ipv4.dns "$DNS"
nmcli con mod "$CON_NAME" ipv4.method manual

# Restart the connection to apply changes
nmcli con down "$CON_NAME" && nmcli con up "$CON_NAME"

echo "Static IP configured. Verify with 'ip a' or 'ifconfig'."

# --------- SSH Key Configuration for Ansible ---------
echo "Setting up DevOps user and SSH key..."

# Create DevOps user if it doesn't exist
if ! id "DevOps" &>/dev/null; then
    useradd -m -s /bin/bash DevOps
    echo "User DevOps created."
else
    echo "User DevOps already exists."
fi

# Create the .ssh directory if it doesn't exist
mkdir -p /home/DevOps/.ssh
chmod 700 /home/DevOps/.ssh

# Add your public key to authorized_keys (replace the key below with your actual key)
cat <<'EOF' > /home/DevOps/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCyourpublickeyhere... your-comment
EOF

# Set appropriate ownership and permissions
chown -R DevOps:DevOps /home/DevOps/.ssh
chmod 600 /home/DevOps/.ssh/authorized_keys

echo "DevOps user configured with SSH key. Ansible will be able to SSH into this VM."
```

### Sudoers script

```bash
#!/bin/bash
# This script adds the DevOps user to the sudoers file for passwordless sudo.
# Run this as root or with sudo.

USER="DevOps"
SUDOERS_FILE="/etc/sudoers.d/${USER}"

echo "Creating/updating sudoers file for ${USER}..."

cat <<EOF > "${SUDOERS_FILE}"
${USER} ALL=(ALL) NOPASSWD:ALL
EOF

chmod 0440 "${SUDOERS_FILE}"
echo "Sudoers file ${SUDOERS_FILE} created. ${USER} can now use sudo without a password."
```



- full script for configuring the VMs 
- first turn off the ssh pub key authentication first then run script 
- After script put back pub key auth for security
- also after messing with sshd config in `/etc` directory 

```bash
sudo systemctl restart sshd
```

- After all that we can finally

```bash
 ssh -i /home/dulc3/.ssh/control_node_id_rsa DevOps@192.168.122.101
```

### This ssh command is better

```bash
ssh -i ~/.ssh/control_node_id_rsa DevOps@192.168.122.101
```

