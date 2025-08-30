
# [Ansible Vault Guided Exercise – “Secret‑Safe Web App”](app://obsidian.md/Ansible%20Vault%20Guided%20Exercise%20%E2%80%93%20%E2%80%9CSecret%E2%80%91Safe%20Web%20App%E2%80%9D)

> **Objective:**  
> Learn how to create, edit, and use an Ansible Vault file to store database credentials for a simple web‑app deployment.  
> **Audience:** Community‑college students new to Ansible.

---

## 1. Scenario Overview

You’re deploying a tiny web application that needs a database username and password.  
Instead of hard‑coding these secrets in your playbook, you’ll store them in an encrypted vault file.

```
webapp/
├── playbook.yml
└── vault_db.yml   ← encrypted
```

---

## 1. Step‑by‑Step Command Walkthrough

1. **Create the vault file**
    ```bash
    ansible-vault create vault_db.yml
    ```
    
    _You’ll be prompted for a password and an editor will open._
    
2. **Add secrets**  
    In the editor that opened, type:
    
    ```yaml
    db_user: admin
    db_pass: SuperSecret123
    ```
    
    _Press `:wq` (Vim) or `Ctrl‑S` + `Ctrl‑Q` (Nano) to save and exit._
    
3. **Verify encryption**
    
    ```bash
    cat vault_db.yml
    ```
    
    _The output will start with `$ANSIBLE_VAULT;1.1;AES256` followed by gibberish._
    
4. **Create a playbook**
    
    ```bash
    nano playbook.yml
    ```
    
    Paste the following content:
    
    ```yaml
    - hosts: localhost
      vars_files:
        - vault_db.yml
      tasks:
        - name: Show DB credentials
          debug:
            msg: "User: {{ db_user }}, Pass: {{ db_pass }}"
    ```
    
5. **Run the playbook**
    
    ```bash
    ansible-playbook playbook.yml --ask-vault-pass
    ```
    
    _Enter the vault password you set earlier. The debug task will print the secrets._
    
6. **Edit the vault**
    
    ```bash
    ansible-vault edit vault_db.yml
    ```
    
    Change `db_pass` to `NewSecret456` and save.
    
7. **Re‑run the playbook**
    
    ```bash
    ansible-playbook playbook.yml --ask-vault-pass
    ```
    
    _Verify that the new password is used._
    
8. **Rekey the vault**


  ```bash
    ansible-vault rekey vault_db.yml
    ```


    _Enter the old password, then a new one._
    
1. **Test with the new key**    

```bash
    ansible-playbook playbook.yml --ask-vault-pass
    ```
 _Use the new password to decrypt._
---

## 3. Quick Reference Cheat Sheet

```bash
# Create
ansible-vault create vault_db.yml

# Edit
ansible-vault edit vault_db.yml

# View decrypted
ansible-vault view vault_db.yml

# Re‑encrypt with new password
ansible-vault rekey vault_db.yml

# Run playbook with vault prompt
ansible-playbook playbook.yml --ask-vault-pass
```

---

## 4. Mnemonic to Remember the Flow

**C**reate → **E**dit → **V**iew → **R**e‑key → **P**laybook

> **C**rypt **E**verything, **V**erify, **R**e‑encrypt, **P**lay!

---

## 5. Key Take‑aways

|Topic|Remember|
|---|---|
|**Vault file name**|`vault_<purpose>.yml`|
|**Password**|Store in a manager, never in code|
|**Permissions**|`chmod 600 vault_db.yml`|
|**Git**|Add vault files to `.gitignore`|
|**Playbook**|Use `vars_files` to load secrets|

---

## 6. Visual Aid (Optional)

![Vault Flow Diagram](https://i.imgur.com/3ZbXK5L.png)

---

## 7. Final Checklist

- [ ] Created `vault_db.yml` and encrypted it.
- [ ] Added `db_user` and `db_pass`.
- [ ] Wrote `playbook.yml` that uses the vault.
- [ ] Ran the playbook with `--ask-vault-pass`.
- [ ] Edited the vault and verified changes.
- [ ] Rekeyed the vault and tested again.

Congratulations! You’ve just mastered the basics of Ansible Vault. Keep this note handy for future projects.



---
## Guided Exercise: Managing Secrets

Encrypt sensitive variables with Ansible Vault to protect them, and then run a playbook that uses those variables.

**Outcomes**

- Execute a playbook using variables defined in an encrypted file.
    

As the `student` user on the `workstation` machine, use the `lab` command to prepare your system for this exercise.

This command prepares your environment and ensures that all required resources are available.

[student@workstation ~]$ **`lab start data-secret`**

**Instructions**

1. Change into the `/home/student/data-secret` directory.
    
    [student@workstation ~]$ **`cd ~/data-secret`**
    [student@workstation data-secret]$
    
2. Edit the contents of the encrypted `secret.yml` file. The file can be decrypted using `redhat` as the password. Uncomment the `username` and `pwhash` variable entries.
    
    1. Edit the encrypted `/home/student/data-secret/secret.yml` file. Enter `redhat` as the Vault password when prompted. The encrypted file opens in the default editor, `vim`.
        
        [student@workstation data-secret]$ **`ansible-vault edit secret.yml`**
        Vault password: **`redhat`**
        
    2. Uncomment the two variable entries (`username` and `pwhash`) by removing the pound sign (`#`) at the start of each line, and then save and close the file.
        
3. Create a playbook named `/home/student/data-secret/create_users.yml`. The playbook should contain one play (`Create user accounts for all our servers` in the following example), which uses the variables defined in the `/home/student/data-secret/secret.yml` encrypted file.
    
    Configure the play to use the `devservers` host group. Run this play as the `devops` user on the remote managed host. Configure the play to create the `ansibleuser1` user defined by the `username` variable. Set the user's password using the password hash stored in the `pwhash` variable.
    
    ---
    - name: Create user accounts for all our servers
      hosts: devservers
      become: true
      remote_user: devops
      vars_files:
        - secret.yml
      tasks:
        - name: Creating user from secret.yml
          ansible.builtin.user:
            name: "{{ username }}"
            password: "{{ pwhash }}"
    
4. Verify the syntax of your `create_users.yml` playbook by running the `ansible-navigator run -m stdout --syntax-check` command.
    
    Use the `--vault-id @prompt` option so that Ansible interactively prompts you for the Vault password that decrypts the `secret.yml` file. Use either the `--pae false` or the `--playbook-artifact-enable false` option to disable the creation of playbook artifacts.
    
    Resolve any syntax errors in your playbook before you continue.
    
    [student@workstation data-secret]$ **`ansible-navigator run -m stdout \`**
    > **`--pae false create_users.yml --syntax-check --vault-id @prompt`**
    Vault password (default): **`redhat`**
    
    playbook: /home/student/data-secret/create_users.yml
    
5. Create a password file named `vault-pass` that contains the password for `ansible-navigator` to use instead of prompting you for a password when it runs the `create_users.yml` playbook. The file must contain the plain text `redhat` as the Vault password. Change the permissions of the file to `0600`.
    
    [student@workstation data-secret]$ **`echo 'redhat' > vault-pass`**
    [student@workstation data-secret]$ **`chmod 0600 vault-pass`**
    
6. Run the Ansible Playbook to create the `ansibleuser1` user on a remote system, using the Vault password in the `vault-pass` file to decrypt the hashed password for that user. That password is stored as a variable in the `secret.yml` Ansible Vault encrypted file.
    
    [student@workstation data-secret]$ **`ansible-navigator run \`**
    > **`-m stdout create_users.yml --vault-password-file=vault-pass`**
    
    PLAY [Create user accounts for all our servers] ********************************
    
    TASK [Gathering Facts] *********************************************************
    ok: [servera.lab.example.com]
    
    TASK [Creating users from secret.yml] ******************************************
    changed: [servera.lab.example.com]
    
    PLAY RECAP *********************************************************************
    servera.lab.example.com    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
    
7. Verify that the playbook ran correctly. The `ansibleuser1` user should exist and have the correct password on the `servera.lab.example.com` machine.
    
    Test this by using `ssh` to log in to the `servera.lab.example.com` machine as the `ansibleuser1` user with `redhat` as the password.
    
    To make sure that SSH only tries to authenticate by password and not by using an SSH key, use the `-o PreferredAuthentications=password` option when you log in.
    
    Log off from `servera` when you have successfully logged in.
    
    [student@workstation data-secret]$ **`ssh -o PreferredAuthentications=password \`**
    > **`ansibleuser1@servera.lab.example.com`**
    ansibleuser1@servera.lab.example.com's password: **`redhat`**
    _...output omitted..._
    [ansibleuser1@servera ~]$ **`exit`**
    logout
    Connection to servera.lab.example.com closed.
    

**Finish**

On the workstation machine, change to the `student` user home directory and use the `lab` command to complete this exercise. This step is important to ensure that resources from previous exercises do not impact upcoming exercises.

[student@workstation ~]$ **`lab finish data-secret`**