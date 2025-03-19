Install Vagrant and a provider:

- On Mac:

```bash
brew install --cask vagrant
brew install --cask virtualbox
```

On Linux:

```bash
sudo apt update
sudo apt install vagrant virtualbox
```

On Windows (WSL):

```bash
sudo apt update
sudo apt install vagrant
```

```bash
mkdir ubuntu-vagrant
cd ubuntu-vagrant
```

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = 2
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y nginx
  SHELL
end
```

This script:

- Uses the Ubuntu 20.04 LTS (Focal Fossa) box
- Allocates 1GB of RAM and 2 CPUs to the VM
- Installs nginx as an example[2](https://sourabhbajaj.com/mac-setup/Vagrant/)[3](https://sourabhbajaj.com/mac-setup/Vagrant/README.html)

```bash
vagrant up
vagrant ssh
vagrant halt 
```

