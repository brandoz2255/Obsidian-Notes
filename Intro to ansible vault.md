# [Ansible Vault Intro](app://obsidian.md/Ansible%20Vault%20Intro)

## Quick‑Look Cheat Sheet

|Action|Command|What it does|
|---|---|---|
|**Create** a new vault file|`ansible‑vault create secrets.yml`|Opens an editor, encrypts file with your password|
|**Edit** an existing vault|`ansible‑vault edit secrets.yml`|Decrypts, lets you modify, then re‑encrypts|
|**View** decrypted contents|`ansible‑vault view secrets.yml`|Shows plain text in terminal (no editor)|
|**Re‑encrypt** with a new password|`ansible‑vault rekey secrets.yml`|Prompts for old and new passwords, re‑encrypts|
|**Run a playbook** that uses a vault|`ansible‑playbook playbook.yml --ask‑vault‑pass`|Prompts for vault password each run|
|**Use multiple vault passwords**|`ansible‑playbook playbook.yml --vault‑id prod@vault_pass.txt`|Loads password from file for `prod` vault ID|

> **Tip:** Keep the password in a secure manager, not in a plain‑text file.

---

## 1. What is Ansible Vault?

- **Vault** is a built‑in Ansible tool that lets you **encrypt any file** (YAML, JSON, etc.) so that secrets (passwords, API keys, certificates) stay hidden.
- Think of it like a **lockbox**: you put your secrets in, lock it with a password, and only people who know the password can open it.

---

## 2. Why use it?

| Problem                                | Vault solves it                                        |
| -------------------------------------- | ------------------------------------------------------ |
| Storing plain text passwords in a repo | Encrypts them so the repo stays safe                   |
| Sharing playbooks with teammates       | Everyone can run the playbook without exposing secrets |
| Compliance / audit                     | Keeps sensitive data out of logs and history           |

---

## 3. How it works (simple diagram)

![Vault Flow](https://i.imgur.com/3ZbXK5L.png)  
_The file is encrypted with a symmetric key derived from your password. Ansible decrypts it on‑the‑fly when running a playbook._

---

## 4. Getting Started

### 4.1 Create a vault file

```bash
ansible-vault create secrets.yml
```

- You’ll be prompted for a password.
- The editor opens; add your secrets in YAML:

```yaml
db_user: admin
db_pass: superSecret123
```

- Save and exit. The file now looks like:

```
$ANSIBLE_VAULT;1.1;AES256
...
```

### 4.2 Edit an existing vault

```bash
ansible-vault edit secrets.yml
```

- Same password prompt.
- You can modify values; save to re‑encrypt.

### 4.3 View encrypted content

```bash
ansible-vault view secrets.yml
```

- Shows the decrypted data in the terminal (no editor).

### 4.4 Use in a playbook

```yaml
- hosts: webservers
  vars_files:
    - secrets.yml
  tasks:
    - name: Deploy app
      copy:
        src: app.tar.gz
        dest: /var/www/
      vars:
        db_user: "{{ db_user }}"
        db_pass: "{{ db_pass }}"
```

- When you run `ansible-playbook`, Ansible automatically decrypts `secrets.yml` using the password you provide.

### 4.5 Changing the password

```bash
ansible-vault rekey secrets.yml
```

- Enter old password, then new one. All data is re‑encrypted.

---

## 5. Best Practices

| Tip                                          | Why                                                        |
| -------------------------------------------- | ---------------------------------------------------------- |
| **Use a strong, unique password**            | Prevents brute‑force attacks.                              |
| **Store the password securely**              | Use a password manager, not a plain text file.             |
| **Limit vault file size**                    | Large files can slow playbook execution.                   |
| **Avoid hard‑coding passwords in playbooks** | Keeps secrets out of source control.                       |
| **Use `--ask-vault-pass`**                   | Prompts for password each run (safer for shared machines). |
| **Consider `--vault-id`**                    | Allows multiple vault passwords for different files.       |

---

## 6. Quick Reference Cheat Sheet

```bash
# Create
ansible-vault create file.yml

# Edit
ansible-vault edit file.yml

# View
ansible-vault view file.yml

# Re‑encrypt with new password
ansible-vault rekey file.yml

# Run playbook with vault password prompt
ansible-playbook playbook.yml --ask-vault-pass
```

---

### Mnemonic to remember the flow

**C**reate → **E**dit → **V**iew → **R**e‑key → **P**laybook

> **C**rypt **E**verything, **V**erify, **R**e‑encrypt, **P**lay!

---

## 7. Further Reading

- [Ansible Vault Documentation](app://obsidian.md/Ansible%20Vault%20Documentation)
- [Ansible Playbook Basics](app://obsidian.md/Ansible%20Playbook%20Basics)
- [Password Management Tips](app://obsidian.md/Password%20Management%20Tips)

Feel free to copy this note into your vault and refer back whenever you need a quick refresher on Ansible Vault!






----



Ansible usually will need access to sensitive data such as passwords or api keys to configure the hosts now niormally this info is stored in plain text in the plays however this is not optimal or secure this is where ansible vault comes from


ansible vault which is included with ansible can be used to encrypt and decrypty any data file used  by ansible we use ansible  vault with the cli tool

ansible-vault to create edit encrypt decrypt and view files 

ansible vault can encrypt any data file used by ansible this might include inventory vars 

passed arguments when executing plays 


### Important

Ansible Vault does not implement its own cryptographic functions but rather uses an external Python toolkit. Files are protected with symmetric encryption using AES256 with a password as the secret key. Note that the way this is done has not been formally audited by a third party.



to create a new ansible secrete its `ansible-vault create filename`

this prompts u for a passphrase then opens a file using vi we can change the editor tho to nvim or vim or nano 

```bash
[student@demo ~]$ **`ansible-vault create secret.yml`**
New Vault password: **`redhat`**
Confirm New Vault password: **`redhat`**
```

Instead of entering the Vault password through standard input, you can use a Vault password file to store the Vault password. You need to carefully protect this file using file permissions and other means.

```bash
[student@demo ~]$ **`ansible-vault create --vault-password-file=vault-pass secret.yml`**
```

this cipher uses AES256 but the  erlier versions might use 128-bit AES 


to view an encrypted file we can use absible-vault view filename 


```bash
[student@demo ~]$ **`ansible-vault view secret1.yml`**
Vault password: **`secret`**
my_secret: "yJJvPqhsiusmmPPZdnjndkdnYNDjdj782meUZcw"
```

Editing an existing encrypted file 

we can edit an encrypted file using ansible vault wich provides the `ansible-vault edit filename` command which decrypts the file to a temp file so we can edit it 


```bash
[student@demo ~]$ **`ansible-vault edit secret.yml`**
Vault password: **`redhat`**
```

### Note

The `edit` subcommand always rewrites the file, so you should only use it when making changes. This can have implications when the file is kept under version control. You should always use the `view` subcommand to view the file's contents without making changes.


to encrypt an existing file we can use the `ansible-vault encrypt filename` which can take names of multiple files to encrypt


```bash
[student@demo ~]$ **`ansible-vault encrypt secret1.yml secret2.yml`**
New Vault password: **`redhat`**
Confirm New Vault password: **`redhat`**
Encryption successful
```

Use the `--output=OUTPUT_FILE` option to save the encrypted file with a new name. You can only use one input file with the `--output` option.

Decrypting an existing file 


once a file is existing an encrypted file can permanently decrypt by using the `ansible-vault decrypt filename` command with decrypting a single file we can use the `--output` option 

```bash
[student@demo ~]$ **`ansible-vault decrypt secret1.yml --output=secret1-decrypted.yml`**
Vault password: **`redhat`**
Decryption successful
```

changing the password of an encrypted file 

we can use the `ansible-vault rekey filename` which changes the password of a encrypted file 
this comamnd can rekey mult data files at the same it does prompt for the og password then the new password 

```bash
[student@demo ~]$ **`ansible-vault rekey secret.yml`**
Vault password: **`redhat`**
New Vault password: **`RedHat`**
Confirm New Vault password: **`RedHat`**
Rekey successful
```

When using a Vault password file, use the `--new-vault-password-file` option:

```bash
[student@demo ~]$ **`ansible-vault rekey \`**
> **``--new-vault-password-file=_`NEW_VAULT_PASSWORD_FILE`_ secret.yml``**
```


### Playbooks and Ansible Vault

To run a playbook that accesses files encrypted with Ansible Vault, you need to provide the encryption password to the `ansible-navigator` command. If you do not provide the password, the playbook returns an error:

```bash
[student@demo ~]$ **`ansible-navigator run -m stdout test-secret.yml`**
ERROR! Attempting to decrypt but no vault secrets found
```

You can provide the Vault password using one of the following options:

- Prompt interactively
- Specify the Vault password file
- Use the `ANSIBLE_VAULT_PASSWORD_FILE` environment variable

To provide the Vault password interactively, use `--playbook-artifact-enable false` (or `--pae false`) and `--vault-id @prompt` as illustrated in the following example:

```bash
[student@demo ~]$ **`ansible-navigator run -m stdout --pae false site.yml \`**
> **`--vault-id @prompt`**
```

### Important

You must disable playbook artifacts to enter the Vault password interactively. The `ansible-navigator` command hangs if it needs to prompt you for an interactive Vault password and playbook artifacts are not disabled. Playbook artifacts are enabled by default.


You can use the `ansible-navigator --pae false` command to disable playbook artifacts.

You can also disable playbook artifacts by modifying your project `ansible-navigator.yml` file or the `.ansible-navigator.yml` file in your home directory. Set the `playbook-artifact` setting in that file to `enable: false`.

The following minimal `ansible-navigator.yml` file disables playbook artifacts:

```yaml
ansible-navigator:
  playbook-artifact:
    enable: false
```

you can specify a file that stores the encryption password in plain text by using the `--vault-password-file` option.

The password must be a string stored as a single line in the file. Because that file contains the sensitive plain text password

```bash
[student@demo ~]$ **`ansible-navigator run -m stdout site.yml \`**
> **`--vault-password-file=vault-pw-file`**
```

### mportant

You can use multiple Ansible Vault passwords with `ansible-navigator`.

To use multiple passwords, pass multiple `--vault-id` or `--vault-password-file` options to the `ansible-navigator` command.


```bash
[student@demo ~]$ **`ansible-navigator run -m stdout --pae false site.yml \`**
> **`--vault-id one@prompt --vault-id two@prompt`**
Vault password (one):
Vault password (two):
_...output omitted..._
```

The Vault IDs `one` and `two` preceding `@prompt` can be anything, and you can even omit them entirely. If you use the ``--vault-id _`id`_`` option when you encrypt a file with the `ansible-vault` command, then the password for the matching ID is the first password tried when running the `ansible-navigator` command. If it does not match, then `ansible-navigator` tries the other passwords that you provided. The Vault ID `@prompt` with no ID is actually shorthand for `default@prompt`, which means to prompt for the password for Vault ID `default`.