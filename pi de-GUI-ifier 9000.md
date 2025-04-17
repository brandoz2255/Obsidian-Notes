## 🧠 Notes:

- `become: true` lets Ansible run this as root.
- It removes common LXDE/X11 desktop stuff used on Raspberry Pi OS.
- This will **not** remove your networking tools, terminal, SSH, or packages like `nano`, etc.
- Raspberry Pi OS (Lite) doesn’t include these packages to begin with — so this is for full RPi OS with GUI.****


## 🚀 Run It Like a Boss

Make sure your `inventory.ini` has this node under `[pi-node-1]` and then:

```bash
ansible-playbook -i inventory.ini headless-pi.yml
```

Boom. Your Pi’s gonna reboot with no GUI and just vibes ✨🐍


```yaml
---
- name: Convert Raspberry Pi to Headless Server
  hosts: pi-node-1
  become: true
  tasks:

    - name: Update apt cache
      apt:
        update_cache: yes

    - name: Remove GUI packages
      apt:
        name:
          - raspberrypi-ui-mods
          - lxsession
          - xserver-xorg
          - lightdm
          - lxde
          - lxde-common
          - x11-common
          - xinit
          - openbox
          - chromium-browser
        state: absent
        autoremove: yes
        purge: yes

    - name: Disable graphical boot target
      systemd:
        name: graphical.target
        enabled: no

    - name: Set default to multi-user target (headless)
      command: systemctl set-default multi-user.target

    - name: Reboot the system
      reboot:
        msg: "Rebooting to complete GUI removal, bye bye pretty pixels"
        pre_reboot_delay: 5
```

