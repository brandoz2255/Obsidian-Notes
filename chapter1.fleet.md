- **Provisioning** the act of setting and managing virtual machines for a specific purpose 
- **IaC** | Infrastructure as a Code is the act of managing infrastructure using code like VM's 
- **CM** | Configuration Management automated scripts to manage all the configurations across the project 
- **Vagrant** | IaC used for managing VM's 
	- similar to Docker it used a file called **`Vagrantfile`** to manage the VM's
- **Terraform** | Iac commonly used in the industry 
- **Ansible** | CM used for managing configurations across the board
- all on page 4
- and 6 
- **Declarative Configuration Style** | means allows you to describe the desired state of the infrastucture 
- **Imperative Configuration Style**  | requires you to supply all the minute details of the infrastructure 
- **Ansible** | written in **Python** and uses **YAML** *Yet another Markup Language* to read its instructions
- Page 7 ansible concepts

- *playbooks*
- *control node*
- *inventory*
- *Module*
- *Task*
- *Role*


### Documentation 
#doc

- Vagrant uses a Ruby style of syntax for configuring the vm's 
- **vagrant up** | creates the VM using the Vagrant files a guide 
- **vagrant destroy** | kills the VM
- **vagrant status** | Displays the active running status of the VM 
- **vagrant ssh** | Access the VM over SSH 

Example of Vagrantfile 

```Ruby
Vagrant.configure("2") do |config|
  # Ubuntu VM for AI Web App
  config.vm.define "ubuntu-vm" do |ubuntu|
    ubuntu.vm.box = "ubuntu/focal64"
    ubuntu.vm.network "private_network", type: "dhcp"
    ubuntu.vm.provision "shell", inline: <<-SHELL
      sudo apt update && sudo apt install -y python3 python3-pip
    SHELL
  end

  # Kali VM for Security Testing
  config.vm.define "kali-vm" do |kali|
    kali.vm.box = "kalilinux/rolling"
    kali.vm.network "private_network", type: "dhcp"
    kali.vm.provision "shell", inline: <<-SHELL
      sudo apt update && sudo apt install -y metasploit-framework
    SHELL
  end
end
```


- the config `vm.box` sets the box we want to use 
- same goes for this line `ubuntu.vm.network "private_network", type: "dhcp"`
	- however this one is for using the network services of that vm 

- Next is using `Ansible` for the `CM` which is the configuration management 


Page 7 ansible concepts

- *playbooks*
- *control node*
- *inventory*
- *Module*
- *Task*
- *Role*

```C
ansible-web-server/
├── ansible.cfg
├── inventory/
│   ├── hosts.yml
├── playbooks/
│   ├── site.yml
│   ├── roles/
│       ├── common/
│       │   ├── tasks/
│       │   │   └── main.yml
│       │   ├── handlers/
│       │   │   └── main.yml
│       │   ├── files/
│       │   ├── templates/
│       └── nginx/
│           ├── tasks/
│           │   └── main.yml
│           ├── handlers/
│           │   └── main.yml
│           ├── files/
│           │   └── nginx.conf
│           ├── templates/
│           │   └── default.j2
```

^ Folder structure for ansible playbooks

- file ansible.cfg 
	- this is the main config file that defines the settings for the project 

```Python
[defaults]
inventory = inventory/hosts.yml
remote_user = ubuntu
private_key_file = ~/.ssh/id_rsa
host_key_checking = False
```


#### **2. Inventory: inventory/hosts.yml**

This file lists the target servers.

```yaml
all:
  hosts:
    ubuntu-server:
      ansible_host: 192.168.1.100
      ansible_user: ubuntu
      ansible_ssh_private_key_file: ~/.ssh/id_rsa
```



#### **3. Playbook: playbooks/site.yml**

This is the main playbook that calls roles to configure the web server.

```yaml
- name: Configure Ubuntu Web Server
  hosts: all
  become: yes
  roles:
    - role: common
    - role: nginx
```

#### **4. Role: common/tasks/main.yml**

Tasks for common configurations like user privileges.

```yaml
- name: Update apt cache
  apt:
    update_cache: yes

- name: Upgrade all packages
  apt:
    upgrade: dist

- name: Create a new user
  user:
    name: webadmin
    state: present
    groups: sudo
    password: "{{ 'mypassword' | password_hash('sha512') }}"

- name: Configure SSH access for the new user
  authorized_key:
    user: webadmin
    state: present
    key: "{{ lookup('file', '~/.ssh/id_rsa.pub') }}"
```


#### **5. Role: nginx/tasks/main.yml**

Tasks for installing and configuring Nginx.

```yaml
- name: Install Nginx
  apt:
    name: nginx
    state: present

- name: Ensure Nginx is started and enabled
  service:
    name: nginx
    state: started
    enabled: yes

- name: Copy Nginx configuration
  template:
    src: default.j2
    dest: /etc/nginx/sites-available/default
  notify: Restart Nginx
```

#### **6. Role: nginx/handlers/main.yml**

Handlers for tasks that need to run upon changes.

```yaml
- name: Restart Nginx
  service:
    name: nginx
    state: restarted

```

#### **7. Template: nginx/templates/default.j2**

Template for the Nginx default configuration.

```yaml
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

commands to run the playbooks must be in the `site.yml` directory 

```bash
ansible-playbook site.yml
```

to create VM

```
vagrant up
```

analyze logs make sure you did it right if no then ->

```bash
vagrant up --debug
```

- vagrant configures *public* and *private key* 
- to see them our private key is locally in .vagrant 
- the public key is in .ssh in the authorized section within the VM 

