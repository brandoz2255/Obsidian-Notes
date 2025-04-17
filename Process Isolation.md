## what we will learn 
- reasons for process isolation 
- how Linux has historically done this 
- how containers use namespaces to provide isolation 
- Linux commands to create namespaces specifically 

#### Why processes need isolation 

- The whole idea began when people used to take turns submitting punch cards for a single computation 
- A process itself isnt really a independent program with its own time on the CPU it is shared acrossed the OS 
- One process it self can cause trouble for other processes such as 
	- using  too much CPU 
	- storage, network or memory 
	- orverwriting the memory of another process 
	- Extracting secret information from another process
	- sending another processes bad data 
	- flooding another process with requests so it dies 
- bugs and vulnerabilites are bad  since if there is one on a application that puts the whole machine at risk 
- where an isolated process such as  a container not so much 
- Physical objects need to be air gapped the same goes with processes on a CPU 
#### File permissions and Chroot 

- The whole point of containers is to isolate the process so it doesn't accidentally sees other processes or mess with it on purpose

Linux file permissions and security measures like `chroot` work together to control access and limit potential damage from compromised accounts. Here's a simplified breakdown:

## **1. Linux File Permissions**

## Basics

- Permissions control **read** (r), **write** (w), and **execute** (x) access for three groups:
    
    - **User** (owner)
    - **Group** (associated users)
    - **Others** (everyone else)

example 

```bash
ls -l 
-rwxr--r-- 1 root admin 4096 Apr  6 21:00 script.sh
```

`-rwxr--r-- 1 root admin 4096 Apr  6 21:00 script.sh`

- **User (root):** `rwx` (full access)
- **Group (admin):** `r--` (read-only)
- **Others:** `r--` (read-only)

## Key Commands

- `ls -ld /var/log`: Shows directory permissions (e.g., `drwxr-x---` ensures only root/admins can access `/var/log`).
- `chmod 750 file`: Grants user=7 (`rwx`), group=5 (r-x), others=0 (---).

## **2. Separating Admin vs. Root**

## Example with `auth.log`

- **Root:** Directly accesses sensitive logs like `/var/log/auth.log` (permissions: `-rw-------`[2](https://linuxhandbook.com/linux-file-permissions/)[3](https://unix.stackexchange.com/questions/409660/var-log-auth-log-permissions)
- **Admin:** A non-root user in the `adm` group can read logs via `sudo tail /var/log/auth.log`.

Sample `auth.log` entry:## **2. Separating Admin vs. Root**

## Example with `auth.log`

- **Root:** Directly accesses sensitive logs like `/var/log/auth.log` (permissions: `-rw-------`[1](https://linuxhandbook.com/linux-file-permissions/)
[2](https://unix.stackexchange.com/questions/409660/var-log-auth-log-permissions)
- **Admin:** A non-root user in the `adm` group can read logs via `sudo tail /var/log/auth.log`.

Sample `auth.log` entry:

```bash
Apr  6 21:05:01 server sudo: admin : TTY=pts/0 ; USER=root ; COMMAND=/usr/bin/apt update
```

