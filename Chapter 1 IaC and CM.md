
in this chapter what was presented was Vagrant technology which is using `IaC` to manage infrastructure and Expansible to configure it all in one environment to ensure consistency

- Learned how to make Vagrant files 
- Learned how use ansiblel playbooks and tasks 

#theo
**Provisioning**: is that act of setting up and configuring Virtual Machines for a specific purpose
- Think of it like make our environment  for a specific use case like as a web server or web app back-end etc
- or setting a testing environment to test tools and software etc.. 
#### Key terms in DevOps field...
#Iac

**IaC**: Infrastructure as a code which is the sact of managing an infrastructure using code
- such as **Vagrant** being a `IaC` we use Ruby to manage the deployments of our VM's  
 #DevOpsTool 
- Another `IaC` respectively is **Terraform** more industry standard due to its nature more focused on cloud computing 
	- where areas vagrants hosted and manages the deployments on our machine `Terraform` does this on the cloud using cloud services such as `AWS`
#DevOpsTool 
**Vagrant**: Vagrant is a `IaC` that uses Ruby to manage the deployments of any infrastructure such as VM's

#cm
**CM**: Configuration Management an automated script to keep and manage all the configurations across the project and others machines. 
- used in conjunction to *IaC* where *Vagrant* is used to manage the deployment of the VM's **Ansible** is used to manage its configuration 
- Think of passwords what tools they have what services libraries docker images etc
#DevOpsTool
**Ansible**: a CM tool used to automate scripts to configure the environments of `Iac` services. 
- Think of passwords what tools they have what services libraries docker images etc but for the services that Vagrant `deploys` 

**Provider**: in Vagrant a provider is a plugin that knows how to manage and create a VM's resources such as `CPU` `disk` and `memory` can called by API usually. 

- **Declarative Configuration style**: This allows you to describe the desired state of the infrastructure
- **Imperative Configuration Style**: different since you must supply the minute details of the infrastructure

Ansible it self was written in Python however using it does not require us to use Python however some configuration language

- *Ansible* uses **YAML** : which stands for *Yet  Another Markup Language* which docker-compose uses as well
#keyconcepts
## Ansible Concepts
### Control Node

The machine from which you run Ansible CLI tools. Can be a laptop, desktop, or server. Used to manage remote hosts. [1](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html)

### Inventory

List of managed nodes/target hosts. Specifies info like IP addresses. Used for grouping and variable assignment. [1](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html)

### Module

Code/binaries copied/executed on managed nodes to perform actions. Specific to admin tasks on various systems/devices. [1](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html)

### Task

Definition of an action to be applied to managed hosts. Can be run individually or in playbooks. [1](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html)

### Role

Reusable collection of tasks, handlers, vars, etc. Imported into plays for consistent application. [1](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html)

### Playbook

Repeatable configuration management/deployment system. Contains plays and tasks. Written in YAML. [1](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html)

### Play

Main execution context. Maps hosts to tasks. Defines variables, roles, and ordered task lists. [1](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html)

### Key Technologies 

- [[Vagrant]] |  `IaC` used for managing `VM's`
- [[Ansible]] | CM used for managing configurations across the board
- [[Terraform]] | Iac commonly used in the industry 
- [[Documentation one]] | notes from the technical usage of these concepts

page number 10 