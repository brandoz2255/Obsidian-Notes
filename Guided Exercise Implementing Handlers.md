

As the `student` user on the `workstation` machine, use the `lab` command to prepare your system for this exercise.

This command prepares your environment and ensures that all required resources are available.

```bash
[student@workstation ~]$ **`lab start control-handlers`**
```

On the `workstation` machine, open a new terminal and change to the `/home/student/control-handlers` directory.


```bash
[student@workstation ~]$ **`cd ~/control-handlers`**
[student@workstation control-handlers]$
```


Edit the `configure_webapp.yml` playbook file. This playbook installs and configures a web application server. When the web application server configuration changes, the playbook triggers a restart of the appropriate service.


Review the `configure_webapp.yml` playbook. It begins with the initialization of some variables:

```yaml
---
- name: Web application server is deployed
  hosts: webapp
  vars:
    packages: ![1](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/1.svg)
      - nginx
      - php-fpm
      - firewalld
    web_service: nginx ![2](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/2.svg)
    app_service: php-fpm ![3](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/3.svg)
    firewall_service: firewalld ![4](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/4.svg)
    firewall_service_rules: ![5](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/5.svg)
      - http
    web_config_src: files/nginx.conf.standard ![6](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/6.svg)
    web_config_dst: /etc/nginx/nginx.conf ![7](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/7.svg)
    app_config_src: files/php-fpm.conf.standard ![8](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/8.svg)
    app_config_dst: /etc/php-fpm.conf ![9](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/9.svg)

  tasks:
```

|   |   |
|---|---|
|[![1](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/1.svg)](https://rha.ole.redhat.com/rha/app/#_instructions_12-CO8-1)|`packages` specifies the name of the packages to install for the web application services.|
|[![2](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/2.svg)](https://rha.ole.redhat.com/rha/app/#_instructions_12-CO8-2)|`web_service` specifies the name of the web server service.|
|[![3](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/3.svg)](https://rha.ole.redhat.com/rha/app/#_instructions_12-CO8-3)|`app_service` specifies the name of the application server service.|
|[![4](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/4.svg)](https://rha.ole.redhat.com/rha/app/#_instructions_12-CO8-4)|`firewall_service` specifies the name of the firewall service.|
|[![5](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/5.svg)](https://rha.ole.redhat.com/rha/app/#_instructions_12-CO8-5)|`firewall_service_rules` specifies a list of services to allow through the firewall.|
|[![6](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/6.svg)](https://rha.ole.redhat.com/rha/app/#_instructions_12-CO8-6)|`web_config_src` specifies the location of the web server configuration file to install.|
|[![7](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/7.svg)](https://rha.ole.redhat.com/rha/app/#_instructions_12-CO8-7)|`web_config_dst`: specifies the location of the installed web server configuration file on the managed hosts.|
|[![8](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/8.svg)](https://rha.ole.redhat.com/rha/app/#_instructions_12-CO8-8)|`app_config_src` specifies the location of the application server configuration file to install.|
|[![9](https://rha.ole.redhat.com/rol/static/roc/Common_Content/images/9.svg)](https://rha.ole.redhat.com/rha/app/#_instructions_12-CO8-9)|`web_config_dst`: specifies the location of the installed application server configuration file on the managed hosts.|

In the `configure_webapp.yml` file, define a task that uses the `ansible.builtin.dnf` module to install the required packages as defined by the `packages` variable.

The task should read as follows:

```yaml
  tasks:
    - name: "{{ packages }} packages are installed"
      ansible.builtin.dnf:
        name: "{{ packages }}"
        state: present
```

Add a task to start and enable the required services. Use a loop to perform the action for the three defined services:


```yaml
    - name: Make sure services are running
      ansible.builtin.service:
        name: "{{ item }}"
        state: started
        enabled: true
      loop:
        - "{{ web_service }}"
        - "{{ app_service }}"
        - "{{ firewall_service }}"
```

Add a task that loops through the items in the `firewall_service_rules` variable. Allow each service through the firewall:


### Note

Although the `firewall_service_rules` variable only contains one item at this point, you can add items to the variable (such as adding the `https` service) without changing the task.

```yaml
   - name: Allow services through the firewall
      ansible.posix.firewalld:
        service: "{{ item }}"
        state: enabled
        immediate: true
        permanent: true
      loop: "{{ firewall_service_rules }}"
```

Add a task to download `nginx.conf.standard` to `/etc/nginx/nginx.conf` on the managed host, using the `ansible.builtin.copy` module. Add a condition that notifies the `restart web service` handler to restart the web server service after a configuration file change. The task should read as follows:


```yaml
1.     - name: The {{ web_config_dst }} file has been deployed
          ansible.builtin.copy:
            src: "{{ web_config_src }}"
            dest: "{{ web_config_dst }}"
            mode: "0644"
          notify:
            - restart web service
```

Add a task to download `php-fpm.conf.standard` to `/etc/php-fpm.conf` on the managed host, using the `ansible.builtin.copy` module. Add a condition that notifies the `restart app service` handler to restart the application server service after a configuration file change. The task should read as follows:


```yaml
    - name: The {{ app_config_dst }} file has been deployed
      ansible.builtin.copy:
        src: "{{ app_config_src }}"
        dest: "{{ app_config_dst }}"
        mode: "0644"
      notify:
        - restart app service
```

Add the `handlers` keyword to define the start of the handler tasks. Define the first handler, `restart web service`, which restarts the `nginx` service. The handler should read as follows:

```yaml
  handlers:
    - name: restart web service
      ansible.builtin.service:
        name: "{{ web_service }}"
        state: restarted
```

Define the second handler, `restart app service`, which restarts the `php-fpm` service. The handler should read as follows:

```yaml
    - name: restart app service
      ansible.builtin.service:
        name: "{{ app_service }}"
        state: restarted
```

The completed playbook should consist of the following content:

```yaml
---
- name: Web application server is deployed
  hosts: webapp
  vars:
    packages:
      - nginx
      - php-fpm
      - firewalld
    web_service: nginx
    app_service: php-fpm
    firewall_service: firewalld
    firewall_service_rules:
      - http
    web_config_src: files/nginx.conf.standard
    web_config_dst: /etc/nginx/nginx.conf
    app_config_src: files/php-fpm.conf.standard
    app_config_dst: /etc/php-fpm.conf

  tasks:
    - name: "{{ packages }} packages are installed"
      ansible.builtin.dnf:
        name: "{{ packages }}"
        state: present

    - name: Make sure services are running
      ansible.builtin.service:
        name: "{{ item }}"
        state: started
        enabled: true
      loop:
        - "{{ web_service }}"
        - "{{ app_service }}"
        - "{{ firewall_service }}"

    - name: Allow services through the firewall
      ansible.posix.firewalld:
        service: "{{ item }}"
        state: enabled
        immediate: true
        permanent: true
      loop: "{{ firewall_service_rules }}"

    - name: The {{ web_config_dst }} file has been deployed
      ansible.builtin.copy:
        src: "{{ web_config_src }}"
        dest: "{{ web_config_dst }}"
        mode: "0644"
      notify:
        - restart web service

    - name: The {{ app_config_dst }} file has been deployed
      ansible.builtin.copy:
        src: "{{ app_config_src }}"
        dest: "{{ app_config_dst }}"
        mode: "0644"
      notify:
        - restart app service

  handlers:
    - name: restart web service
      ansible.builtin.service:
        name: "{{ web_service }}"
        state: restarted

    - name: restart app service
      ansible.builtin.service:
        name: "{{ app_service }}"
        state: restarted
```

Before running the playbook, verify that its syntax is correct by running `ansible-navigator` with the `--syntax-check` option. Correct any reported errors before moving to the next step. You should see output similar to the following:

```bash
1. [student@workstation control-handlers]$ **`ansible-navigator run \`**
    > **`-m stdout configure_webapp.yml --syntax-check`**
    playbook: /home/student/control-handlers/configure_webapp.yml
```

Run the `configure_webapp.yml` playbook. The output shows that the handlers are being executed.

```bash
1. [student@workstation control-handlers]$ **`ansible-navigator run \`**
    > **`-m stdout configure_webapp.yml`**
    
    PLAY [Web application server is deployed] **************************************
    
    TASK [Gathering Facts] *********************************************************
    ok: [servera.lab.example.com]
    
    TASK [['nginx', 'php-fpm', 'firewalld'] packages are installed] ****************
    changed: [servera.lab.example.com]
    
    TASK [Make sure services are running] ******************************************
    changed: [servera.lab.example.com] => (item=nginx)
    changed: [servera.lab.example.com] => (item=php-fpm)
    ok: [servera.lab.example.com] => (item=firewalld)
    
    TASK [Allow services through the firewall] *************************************
    changed: [servera.lab.example.com] => (item=http)
    
    TASK [The /etc/nginx/nginx.conf file has been deployed] ************************
    changed: [servera.lab.example.com]
    
    TASK [The /etc/php-fpm.conf file has been deployed] ****************************
    changed: [servera.lab.example.com]
    
    RUNNING HANDLER [restart web service] ******************************************
    changed: [servera.lab.example.com]
    
    RUNNING HANDLER [restart app service] ******************************************
    changed: [servera.lab.example.com]
    
    PLAY RECAP *********************************************************************
    servera.lab.example.com    : ok=8    changed=7    unreachable=0    failed=0  ...
```

Run the playbook again.

```bash
[student@workstation control-handlers]$ **`ansible-navigator run \`**
> **`-m stdout configure_webapp.yml`**

PLAY [Web application server is deployed] **************************************

TASK [Gathering Facts] *********************************************************
ok: [servera.lab.example.com]

TASK [['nginx', 'php-fpm', 'firewalld'] packages are installed] ****************
ok: [servera.lab.example.com]

TASK [Make sure services are running] ******************************************
ok: [servera.lab.example.com] => (item=nginx)
ok: [servera.lab.example.com] => (item=php-fpm)
ok: [servera.lab.example.com] => (item=firewalld)

TASK [Allow services through the firewall] *************************************
ok: [servera.lab.example.com] => (item=http)

TASK [The /etc/nginx/nginx.conf file has been deployed] ************************
ok: [servera.lab.example.com]

TASK [The /etc/php-fpm.conf file has been deployed] ****************************
ok: [servera.lab.example.com]

PLAY RECAP *********************************************************************
servera.lab.example.com    : ok=6    changed=0    unreachable=0    failed=0  ...
```



```bash
[student@workstation ~]$ **`lab finish control-handlers`**
```

