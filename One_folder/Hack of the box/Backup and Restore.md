Of course One key thing to remember is that linux systems have Alot of tools for backing up and restoring data. This tools were desinged to be effeicent and secure while also allow us to easily access them when we need. 

- When using  a Ubuntu type system the type of data recovery tools we can use are `Rsync, Deja Dup , Duplicity` 

**Rsync**: 
- is a open source tool that essentially allows us to quickly back up the files we need and the folders as well to a remote location
- It is very useful when transferring large amounts of data over a network. It can also be used to create  backups 

**Duplicity**:
- Another graphical tool for Ubuntu that provides cohesive data protectiona d secure backups 
- Allows for the ability to encrypt data and stores them on a remote storage media 
- uses Rsync as a backend 

**Deja Cup**:
- Another graphical user tool available for Ubuntu which just simplifies the backup process allows for quick and easy access for the data
- Backups copies on a local or remote storage media 
- Also uses Rsync as  a backend 

In order to completely secure our data we must ensure taht our data is encrypeted along with the backups.
- Having Data encrypted ensures that our data is safe and secure especially the important data
- We can ecnrhypt the data useing tools such as GnuPG, eCryptfs, and LUKS.

```shell-session
00818@htb[/htb]$ sudo apt install rsync -y
```

- The syntax for installing the rsync tool for data storage backups
- This will install the latest rsync available to use 

## Back up server 

```shell-session
00818@htb[/htb]$ rsync -av /path/to/mydirectory user@backup_server:/path/to/backup/directory
```

- This command essentially backs up the data from the directory of our choice to the backup directory 
- The option a in -av tells `rsync` to keep our original directory intact and -v option tell it to provide detail output. 

```shell-session
00818@htb[/htb]$ rsync -avz --backup --backup-dir=/path/to/backup/folder --delete /path/to/mydirectory user@backup_server:/path/to/backup/directory
```

- With this command we backup the directpry to the remopte backup server preserving our original file contents the new -z allows for faster data transfers 

```shell-session
00818@htb[/htb]$ rsync -av user@remote_host:/path/to/backup/directory /path/to/mydirectory
```
- This essentially does the opposite moving our back up files towards a directory of our choice

## Encrypted Rsync
We can combine the tool such as rsync and SSH to allow complete security of our files and data transfers 

- With SSH we can encrypt said files as they are being transfered to the secure location. 
- This allows for a harder time or complete unattainable and unauthorized access towards our data
- We could also utilize firefalls and other security measures to keep our data safe from said unauthorized users

```shell-session
00818@htb[/htb]$ rsync -avz -e ssh /path/to/mydirectory user@backup_server:/path/to/backup/directory
``` 

- This is how we move our files towards a secure SSH to do the security measures that were mentioned before

# Auto Rsync
We can combine the use of Cron jobs and rsync to allow complete automation of the synchronization process. Scheduling the cron job to run intervals ensure that the contents of the two systems are kept in sync. 

- This can be useful for those businesses  and organization that need their data accessible across multiple machines 
- Also great for saving time and effort 

**Code: bash**

```bash
#!/bin/bash

rsync -avz -e ssh /path/to/mydirectory user@backup_server:/path/to/backup/directory
```

- The bash script for the automation that was mentioned before
- Make sure that the script is issued by the correct user 
- Since we need to apply the necessary permission of the data transfers 
- There so the data is not tampered by another user

```shell-session
00818@htb[/htb]$ chmod +x RSYNC_Backup.sh
```

- After script we need to create the Cron tab to run the script at the time interval we want we could also adjust the timing however we want. with
- With this above command that is 
- Refer to this for more info on cron jobs [[Cron jobs]]


**Provide conclusion later **