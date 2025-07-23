### Lab 1: Building an Ansible Inventory

This lab walks you through creating a custom static inventory file.

1. **Prepare the Lab Environment**:
    
    - First, you'll need to get the lab environment ready. Run the following command as the
        
        `student` user on the `workstation` machine:

```bash
lab start playbook-inventory
```

**Navigate to the Directory**:

- Change into the working directory for this exercise:

```bash
cd /home/student/playbook-inventory
```

**Create and Populate the Inventory File**:

- Create a new file named
    
    `inventory` in the current directory (`/home/student/playbook-inventory`).


```toml
[webservers]
servera.lab.example.com
serverb.lab.example.com
serverc.lab.example.com
serverd.lab.example.com

[raleigh]
servera.lab.example.com
serverb.lab.example.com

[mountainview]
serverc.lab.example.com

[london]
serverd.lab.example.com

[development]
servera.lab.example.com

[testing]
serverb.lab.example.com

[production]
serverc.lab.example.com
serverd.lab.example.com

[us:children]
raleigh
mountainview
```

**Verify the Inventory**:

- Use the `ansible-navigator` command with the `-i` option to check your work.
- To list all managed hosts:

```bash
ansible-navigator inventory -i inventory --stdout --list
```

To graph hosts in the

`development` group:

```bash
ansible-navigator inventory -i inventory --stdout --graph development
```

**Finish the Lab**:

- To complete the exercise and clean up the resources, run:

```bash
lab finish playbook-inventory
```


