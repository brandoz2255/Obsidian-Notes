### 1️⃣ **Verify Packer Installation**

First, let's ensure Packer is installed on your system. Open a terminal and run:

```bash
packer --version
```

If Packer is not installed, you can install it using the following commands:

```bash
sudo pacman -Syu
sudo pacman -S packer
```

### 2️⃣ **Set Up the Packer Directory Structure**

Create a directory for your Packer configurations:

```bash
mkdir -p ~/packer_templates/{rocky,kali}/scripts
cd ~/packer_templates
```