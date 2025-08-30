**Chapter 3 – Quick‑Reference Summary**

- **Variables**
    
    - Reusable values that can be defined anywhere in an Ansible project.
    - **Inventory** – host‑ or group‑specific variables.
    - **Playbook** – play‑ or task‑level variables, or external variable files.
    - **Command‑line** – `-e` or `--extra-vars` override everything else.
    - **Register** – captures the output of a task into a variable for later use.
- **Ansible Vault**
    
    - Encrypts sensitive data (passwords, keys, etc.) so it can be stored safely in playbooks or variable files.
- **Facts**
    
    - Automatically discovered host attributes (OS, memory, CPU, network, etc.).
    - Treated as ordinary variables (`ansible_facts`).
    - Can be injected into the normal variable hierarchy (`Facts injected as vars`).
    - Useful for making playbooks dynamic: install the right package, start the right service, etc.
    - Custom facts can be added on the host (`/etc/ansible/facts.d/*.fact`) and merged into the fact set.
- **Key Take‑aways**
    
    1. Variables let you avoid hard‑coding and keep playbooks DRY.
    2. Vault protects anything that shouldn’t be in plain text.
    3. Facts give you a live snapshot of a host, enabling truly generic, host‑agnostic playbooks.
    4. Registering a command’s output lets you branch logic based on real‑time results.

These concepts are reinforced in the guided exercises:

- _Managing Vars and Facts_ (guided exercise)
- _Managing Secrets_ (Vault exercise)
- _Managing Facts_ (guided exercise)

Use this cheat‑sheet whenever you need to decide where to place a variable, protect secrets, or leverage facts in your playbooks.