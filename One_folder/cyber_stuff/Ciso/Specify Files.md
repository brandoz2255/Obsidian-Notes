


- If you wanted to have a file with a space in its you would need to specify it in `""` since the space character give the shell the impression that you are adding another argument!


```Shell-session
[user@host ~]$ pwd
/home/user
[user@host ~]$ cd Videos
[user@host Videos]$ pwd
/home/user/Videos
[user@host Videos]$ cd /home/user/Documents
[user@host Documents]$ pwd
/home/user/Documents
[user@host Documents]$ cd
[user@host ~]$ pwd
/home/user
[user@host ~]$
```

- `Absolute path`: is the full path of the file directory in which starting from the root directory to the file specified. 

- `Relative Path`: identifies unique location and specifies only the path needed works when the file looking for it is in the same folder. 

- `PWD`: Displays the full command

- `Touch` Command updates the time stamp of a file to the current date and time without modifying the file
- This is useful for creating empty files and can be used for practice 
- The tilde `~` character in combination with other commands adds for better interaction with the home directory 
- `cd` just by itself allows the user to return to the home  directory assuming's that the current working directory is /tmp

```C++
[user@host ~]$ **`ls -l`**
total 0
drwxr-xr-x. 2 user user 6 Mar  2 02:45 Desktop
drwxr-xr-x. 2 user user 6 Mar  2 02:45 Documents
drwxr-xr-x. 2 user user 6 Mar  2 02:45 Downloads
drwxr-xr-x. 2 user user 6 Mar  2 02:45 Music
drwxr-xr-x. 2 user user 6 Mar  2 02:45 Pictures
drwxr-xr-x. 2 user user 6 Mar  2 02:45 Public
drwxr-xr-x. 2 user user 6 Mar  2 02:45 Templates
drwxr-xr-x. 2 user user 6 Mar  2 02:45 Videos
[user@host ~]$ **`ls -la`**
total 40
drwx------. 17 user user 4096 Mar  2 03:07 .
drwxr-xr-x.  4 root root   35 Feb 10 10:48 ..
drwxr-xr-x.  4 user user   27 Mar  2 03:01 .ansible
-rw-------.  1 user user  444 Mar  2 04:32 .bash_history
-rw-r--r--.  1 user user   18 Aug  9  2021 .bash_logout
-rw-r--r--.  1 user user  141 Aug  9  2021 .bash_profile
-rw-r--r--.  1 user user  492 Aug  9  2021 .bashrc
drwxr-xr-x.  9 user user 4096 Mar  2 02:45 .cache
drwxr-xr-x.  9 user user 4096 Mar  2 04:32 .config
drwxr-xr-x.  2 user user    6 Mar  2 02:45 Desktop
drwxr-xr-x.  2 user user    6 Mar  2 02:45 Documents
_...output omitted..._
```
- files that begin with `.` are hidden 

- `cd -` returns the working directory before the current working directory
- `touch -/helloworld.py` creates a hello world file in the home directory
- `mkdir` can make more than one directory at once 

```C++
[user@host ~]$ **`cd Documents`**
[user@host Documents]$ **`mkdir ProjectX ProjectY ProjectZ`**
[user@host Documents]$ **`ls`**
ProjectX  ProjectY ProjectZ
```


- `mkdir -p` flag allows for the admin user to create a file within a file for example `A file within the directory`
``` C++
[user@host Documents]$ **`mkdir -p Thesis/Chapter1 Thesis/Chapter2 Thesis/Chapter3`**
[user@host Documents]$ **`ls -R Thesis/`**
Thesis/:
Chapter1  Chapter2  Chapter3

Thesis/Chapter1:

Thesis/Chapter2:

Thesis/Chapter3:
```

- `cp` copies files from one directory onto another if you choose to
```C++
[user@host Documents]$ **`cp thesis_chapter1.txt thesis_chapter2.txt Thesis ProjectX`**
cp: -r not specified; omitting directory 'Thesis'
[user@host Documents]$ **`ls Thesis ProjectX`**
ProjectX:
thesis_chapter1.txt  thesis_chapter2.txt

Thesis:
Chapter1  Chapter2  Chapter3
```

- to copy the whole directory you would use the -r flag with the cp command `cp -r`

```C++
[user@host Documents]$ **`cd ProjectY`**
[user@host ProjectY]$ **`cp -r ../Thesis/ .`**
[user@host ProjectY]$ **`ls -lR`**
.:
total 0
drwxr-xr-x. 5 user user 54 Mar  7 15:08 Thesis

./Thesis:
total 0
drwxr-xr-x. 2 user user 6 Mar  7 15:08 Chapter1
drwxr-xr-x. 2 user user 6 Mar  7 15:08 Chapter2
drwxr-xr-x. 2 user user 6 Mar  7 15:08 Chapter3

./Thesis/Chapter1:
total 0

./Thesis/Chapter2:
total 0

./Thesis/Chapter3:
total 0
```

- `mv` command moves one file any where specified 
	-  moving a file is just as same as renaming a file
just specify the path

mv with the -v  flag prints out a more specified version of the operation `mv -v`

```C++
[user@host Documents]$ **`ls Thesis/Chapter1`**
[user@host Documents]$
[user@host Documents]$ **`mv -v thesis_chapter1.txt Thesis/Chapter1`**
renamed 'thesis_chapter1.txt' -> 'Thesis/Chapter1/thesis_chapter1.txt'
[user@host Documents]$ **`ls Thesis/Chapter1`**
thesis_chapter1.txt
[user@host Documents]$ **`ls -l`**
-rw-r--r--. 1 user user 11431 Mar  7 14:39 thesis_chapter2_reviewed.txt
_...output omitted..._
```

- `rm` command removes a files 
- `rm -r` with the -r flag aka the recursive option enables the rm command to move the directories and its contents

```C++
[user@host Documents]$ **`ls -l Thesis/Chapter1`**
-rw-r--r--. 1 user user 7100 Mar  7 14:37 thesis_chapter1.txt
[user@host Documents]$ **`rm Thesis/Chapter1/thesis_chapter1.txt`**
[user@host Documents]$ **`rm Thesis/Chapter1`**
rm: cannot remove 'Thesis/Chapter1': Is a directory
[user@host Documents]$ **`rm -r Thesis/Chapter1`**
[user@host Documents]$ **`ls -l Thesis`**
drwxr-xr-x. 2 user user 6 Mar  7 12:37 Chapter2
drwxr-xr-x. 2 user user 6 Mar  7 12:37 Chapter3
```

- `rm -ri` the -i gives the user a full detailed report on what rm is gonna delete before doing so. 

lab in module 3 

