Sometimes you might want to create a new variable that uses the value of a different variable. One reason to create a new variable is to minimize typing.

The previous example created custom facts on managed hosts. In that example, you can use the `ansible_facts['ansible_local']['custom']` variable to reference those custom facts. That variable has the `packages` and `users` keys. If your play contains several references to those custom facts, then you might benefit from creating a new variable.

You can use the `ansible.builtin.set_fact` module to create a new variable associated to the current host. For example, you might define the `custom_host` variable and use the `ansible_facts['ansible_local']['custom']` variable as its value.


```yaml
- name: Set custom_host
  ansible.builtin.set_fact:
    custom_host: "{{ ansible_facts['ansible_local']['custom'] }}"
```

By defining this new variable, your play can use the shorter `custom_host['packages']` and `custom_host['users']` variables rather than the longer `ansible_facts['ansible_local']['custom']['packages']` and `ansible_facts['ansible_local']['custom']['users']` variables.

You might also use the `ansible.builtin.set_fact` module to minimize typing for regular system facts or for registered variables. For example:


```yaml
- name: Set vda_parts
  ansible.builtin.set_fact:
    vda_parts: "{{ ansible_facts['devices']['vda']['partitions'] }}"
```

After adding this task, your play can use the `vda_parts['vda1']['size']` variable rather than the longer `ansible_facts['devices']['vda']['partitions']['vda1']['size']` variable.

### Using Magic Variables

Ansible sets some special variables automatically.

These _magic variables_ can also be useful to get information specific to a particular managed host.

Magic variable names are reserved, so you should not define variables with these names.

Four of the most useful magic variables are:

`hostvars`

Contains the variables for managed hosts, and can be used to get the values for another managed host's variables. It does not include the managed host's facts if they have not yet been gathered for that host.

`group_names`

Lists all groups that the current managed host is in.

`groups`

Lists all groups and hosts in the inventory.

`inventory_hostname`

Contains the hostname for the current managed host as configured in the inventory. This might be different from the hostname reported by facts for various reasons.

One way to get insight into their values is to use the `ansible.builtin.debug` module to display the contents of these variables.

For example, the following task causes every host that runs the play to print out a list of all network interfaces on the `demo2.example.com` host. This task works as long as facts were gathered for `demo2` earlier in the play or by a preceding play in the playbook. It uses the `hostvars` magic variable to access the `ansible_facts['interfaces']` fact for that host.


```yaml
 - name: Print list of network interfaces for demo2
      ansible.builtin.debug:
        var: hostvars['demo2.example.com']['ansible_facts']['interfaces']
```

