#managingvarsandfacts

Variables are values used to store data throughout the project similar to the ini however this is for the entire creations of other playbooks 

can simplify the creation and maintenance of a project and reduce the number of errors 

Examples such as 

users to create 
packages to install 
services to restart
files to remove 
archives to retrieve from the internet 

Naming vars can only contaiiner letters numbers and udnerscores 

thiis iis an example of valiid and invalid names 

**Table 3.1. Examples of Invalid and Valid Ansible Variable Names**

| Invalid variable names | Valid variable names                      |
| :--------------------- | :---------------------------------------- |
| `web server`           | `web_server`                              |
| `remote.file`          | `remote_file`                             |
| `1st file`             | `file_1`<br><br>`file1`                   |
| `remoteserver$1`       | `remote_server_1`<br><br>`remote_server1` |


defining a var thess can be defines a number of places in a project  

variable is set using the same name in two places, and those settings have different values, _precedence_ determines which value is used.


variables are a gropupd of  hosts or only individual hosts some vars are facts that can be set by ansible bassed on the config of the system 

other vars ccan be set in the playbook only one takss in that play u can also set extra vars in the `ansible-navigator run`
 command 

using `--extra-vars or -e` 

The following simplified list shows ways to define a variable, ordered from the lowest precedence to the highest:

- Group variables defined in the inventory

- Group variables defined in files in a `group_vars` subdirectory in the same directory as the inventory or the playboo    
- Host variables defined in the inventory

- Host variables defined in files in a `host_vars` subdirectory in the same directory as the inventory or the playbook    
- Host facts, discovered at runtime

- Play variables in the playbook (`vars` and `vars_files`)    
- Task variables

- Extra variables defined on the command line

a  variable that is set to affect the all host group iis overridden by a variable that has the same name and is set to affect that single host 

one recommened practice is to set the  global unique name there so  we dont choose the precendence rules 

When writing plays, you can define your own variables and then invoke those values in a task. For example, you can define a variable named `web_package` with a value of `httpd`. A task can then call the variable using the `ansible.builtin.dnf` module to install the `httpd` package.

How to call an asnible playbook 

```yaml
- hosts: all
  vars:
    user: joe
    home: /home/joe
```

It is also possible to define playbook variables in external files. In this case, instead of using a `vars` block in a play in the playbook, you can use the `vars_files` directive followed by a list of names for external variable files relative to the location of the playbook:

```yaml
- hosts: all
  vars_files:
    - vars/users.yml
```

The playbook variables are then defined in those files in YAML format:


```yaml
user: joe
home: /home/joe
```


you can use the variables in tasks. Variables are referenced by placing the variable name in double braces (`{{ }}`).


```yaml
vars:
  user: joe
tasks:
  # This line will read: Creates the user joe
  - name: Creates the user {{ user }}
    user:
      # This line will create the user named Joe
      name: "{{ user }}"
```

### Important

When a variable is used as the first element to start a value, quotes are mandatory. This prevents Ansible from interpreting the variable reference as starting a YAML dictionary. The following message appears if quotes are missing:

```yaml
ansible.builtin.dnf:
     name: {{ service }}
            ^ here
We could be wrong, but this one looks like it might be an issue with
missing quotes.  Always quote template expression brackets when they
start a value. For instance:

    with_items:
      - {{ foo }}

Should be written as:

    with_items:
      - "{{ foo }}"
```
