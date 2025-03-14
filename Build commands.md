
```bash
cd ~/packer_templates
```

Initialize and build the Rocky Linux VM image:

```bash
cd rocky
packer init .
packer build rocky.pkr.hcl
```

Initialize and build the Kali Linux VM image:

```bash
cd ../kali
packer init .
packer build kali.pkr.hcl
```


First before build 

### 2. Validate the Packer Template Syntax

**Why:** To catch any syntax errors in your HCL files before building.  
**Commands:**

```bash
packer validate rocky.pkr.hcl
packer validate kali.pkr.hcl
```

