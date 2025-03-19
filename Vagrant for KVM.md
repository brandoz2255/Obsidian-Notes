## **Solution 1: Use the `VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT` Environment Variable**

This approach disables strict dependency checks, allowing the plugin to install despite conflicts.

1. Run the following command:

```bash
VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1 vagrant plugin install vagrant-libvirt\
```

This should bypass the dependency conflict and allow the plugin to install successfully.

- Also ensure this installed as well 

```bash
VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1 vagrant plugin install vagrant-disksize
```

Yes, Rocky Linux is supported on KVM using Vagrant with the `libvirt` provider. You can use a compatible Rocky Linux box from public repositories like [Vagrant Cloud](https://app.vagrantup.com/boxes). For example:

- A commonly used box for Rocky Linux 9 is:

```bash
vagrant box add generic/rocky9 --provider=libvirt
```

```bash
vagrant box add kalilinux/rolling --provider libvirt
```

Locate the downloaded box:  
The `generic/rocky9` box is likely stored in `~/.vagrant.d/boxes/generic-VAGRANTSLASH-rocky9` on Linux/macOS
## Important 

```bash
vagrant up --provider=libvirt
```

then run  it with the specified provider

## **Solution 2: Repair and Reinstall Plugins**

If the above doesn't work, you can repair or reinstall your Vagrant plugins.

1. Repair plugins:

```bash
vagrant plugin repair
```
1
Expunge (remove) all plugins and reinstall:

```bash
vagrant plugin expunge --reinstall
```

Then, try installing `vagrant-libvirt` again:

```bash
vagrant plugin install vagrant-libvirt
```

## **Solution 3: Set `CONFIGURE_ARGS` for Compatibility**

If the issue persists, you may need to specify paths for libvirt libraries and headers during installation.

1. Export `CONFIGURE_ARGS` before installing:

```bash
export CONFIGURE_ARGS="with-libvirt-include=/usr/include/libvirt with-libvirt-lib=/usr/lib64"
```

```bash
vagrant plugin install vagrant-libvirt
```

## **Solution 4: Use a Bundled Vagrant Setup**

If none of the above works, you can use a bundled setup with `bundle exec`.

1. Create a `Gemfile` in your project directory with the following content:

```bash
source "https://rubygems.org"
gem "vagrant"
gem "vagrant-libvirt"
```

