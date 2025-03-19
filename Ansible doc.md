
### Directories
`Ansible` directories

- **inventories/**: Contains inventory files for different environments (e.g., production, staging).
- **group_vars/**: Holds variables assigned to host groups.
- **host_vars/**: Contains variables specific to individual hosts.
- **roles/**:
    - **common/**: Tasks common to all servers.
    - **docker/**: Tasks to install and configure Docker.
    - **app_deployment/**: Tasks to deploy your Docker services.
- **playbooks/**: Stores your main playbooks.
- **ansible.cfg**: Ansible configuration file.

### Make inventory.ini has this 

```yaml
[ubuntu_vms]
ubuntu-vm1 ansible_host=127.0.0.1 ansible_port=2200 ansible_user=vagrant ansible_ssh_common_args='-F ./vagrant_ssh_config'
ubuntu-vm2 ansible_host=127.0.0.1 ansible_port=2201 ansible_user=vagrant ansible_ssh_common_args='-F ./vagrant_ssh_config'
```

- make sure the `inventory.ini` has this configuration file in it 
- also make sure that `ansible` has access to the ssh private key

```bash
ansible-playbook -i inventory.ini ubuntu-vm.yml
```

- takes the instructions from the `inventory.ini` then runs the instructions from ubuntu-vm.yml 

- [[ansible playbooks]]