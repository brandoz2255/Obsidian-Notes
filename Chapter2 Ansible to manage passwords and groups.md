## Enforcing complex passwords 

Since we have built out `VM`'s we need to navigate to the daily tasks of a `DevOps` engineer which is administration securing users groups and permissions using automation. 

This is a Deep dive into `Ansible` with hands on guide on how to use it to configure password security users and groups etc basic Admin tasks


#### Setting up complex complex passwords 

never let anyone decide what a complex password is especially when you got to Admin over 1000 machines we got `Ansible` for this and `PAM` 

**PAM (Pluggable Authentication Modules):** A user Authentication framework that most Linux distribution employ. 
- Using `Ansible` we can configure out `VM`'s to follow a specified PAM configuration to harden passwords
- is available in the Ubuntu Software package as `libpam-pwquality`

```yml
- name: Install libpam-pwquality
   package: 
     name: "libpam-pwquality"
     state: present
```

how we would configure it in `Ansible` to download PAM. 

- **Module Name:** `- name` describes the task for clarity.
- **Action Type:** `package` defines the `Ansible` module for package management.
- **Package Target:** `name` specifies the package to install or manage.
- **State Control:** `state: present` ensures the package is installed.

`Ansible` automates tasks efficiently, like enforcing password policies across 1,000 machines. It eliminates reliance on subjective definitions of complexity or human error, ensuring consistent security.

Most default configuration for password complexity is 6 words and no other specification especially on Ubuntu 

Using PAM and Ansible we can change this 

 - `/etc/pam.d/common-password` is the common file place for the basic passwords structures 

```YAML
- name: Configure pam_pwquality
  lineinfile:
    path: "/etc/pam.d/common-password"
    regexp: "pam_pwquality.so"
    line: "password required pam_pwquality.so minlen=12 lcredit=-1 ucredit=-1 dcredit=-1 ocredit=-1 retry=3 enforce_for_root"
    state: present

```

This Ansible Module states the basic password structure to minimum of 12 characters with at least one lowercase,uppercase,numeric,alphanumeric, only three retries and disable root override 

- used the `lineinfile` module from `Ansible` to change the configurations 
- **`lineinfile`**: Module in `Ansible` , allows you to change a line in a file or check if the file exists or not

#### Linux user types 

Three user types 

- **user**: this is the human account the one that is the home user or a guest user of the machine 
- **system**:This is similar to the human account but a process using resources to do its task such as a `Nginx` server is a system account
- **root**:This the user that has access to the entire machine can do anything to the machine as it pleases it is the one in charge

All three of these users are separated by their User ids (UID)
such as the root UID is always `0`

`Ansibles` user module: makes managing users and groups easy handles the hassle of managing users,shells, keys and groups

#### Creating a user with Ansible 

```YAML
- name: Create user 'bender'
  user:
    name: bender
    shell: /bin/bash
    password: (truncated)
    state: present
```

#### Generating complex password 

In order to generate a complex password based on the configurations we made before  with `pam`

```bash
sudo apt update
sudo apt install pwgen whois
pass='pwgen --secure --capitalize --numerals --symbols 12 1`
```

```bash
echo $pass | mkpasswd --stdin --method=sha-512; echo $pass
```

these commands generate a complex password based on the needs we have made using `pam`

now we need to use a tool like `ansible` to automate the password linkage to the account bender to protect the passwords and keeping them out of the configs files


#### Linux groups

Using Linux groups is a great way to limit access to resources on a host machine 


```YAML
- name: Ensure group 'developers' exists
  group:
    name: developers
    state: present
```

to add a user to a group 


```YAML
- name: Assign 'bender' to the 'developers' group
  user:
    name: bender
    groups: developers
    append: yes
```

Using Ansible we can create protected resources 


```YAML
- name: Created a directory named 'engineering'
  file:
    path: /opt/engineering
    state: directory
    mode: 0750
    group: developers
```

#### adding a file 

```YAML
- name: Create a file in the engineering directory
  file:
    path: "/opt/engineering/private.txt"
    state: touch
    mode: 0770
    group: developers
```


- next update all the changes made to provision yml file 

```bash
vagrant ssh
```

to access the `VM`

#### Summary

All `ansible` modules covered

- `package` 
- `lineinfile` 
- `user` 
- `group` 
- `file` 







