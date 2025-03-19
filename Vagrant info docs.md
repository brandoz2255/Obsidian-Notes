- `Vagrantfile` is a set of instructions for Vagrant to create VMs using Virtualbox
- but other VMs managers can be used as well 

```ruby
Vagrant.configure("2") do |config|
```

- This option tells vagrant to use the version 2 syntax 

#### Creates the VM 

```ruby
config.vm.define "ubuntu-vm1" do |ubuntu|
```

- this names the `VM` to the value set in the `string` 

```ruby
ubuntu.vm.box = "ubuntu/focal64"
```

- This tells it what version of `Ubuntu` to use 

```ruby
ubuntu.vm.hostname = "ubuntu-vm1"
```

- Gives the `VM` a `hostname` 

```ruby
ubuntu.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
```

- This connects the `VM` to my PCs real network


```ruby
ubuntu.vm.provider "virtualbox" do |vb|
  vb.memory = "1024"
  vb.cpus = 2
end
```

- This options sets the resources for the `VM` 
- `vb.memory` is the amount of ram usage
- `vb.cpus` is the amount of cores to use 

#### what else to add

```ruby
ubuntu.vm.network "public_network", ip: "192.168.1.100"
```

- This sets the `VMs` to have a static IP address
