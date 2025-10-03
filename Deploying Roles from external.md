
## 1️⃣ Core – Quick‑Reference Facts

|Topic|Key Point|Typical Command|
|---|---|---|
|**Galaxy roles**|Use `ansible‑galaxy role install` or a `requirements.yml` file.|`ansible-galaxy role install -r requirements.yml -p roles`|
|**Git roles**|Specify `src`, `scm: git`, and optionally `version`.|`- src: https://github.com/user/role.git`|
|**Tarball roles**|Use `src: file://…` or an HTTP/HTTPS URL.|`- src: file:///opt/role.tar`|
|**roles_path**|Set in `ansible.cfg` or via `-p` flag.|`roles_path = roles`|
|**Removal**|`ansible-galaxy role remove <role>`|`- successfully removed nginx`|

---

## 2️⃣ Info – In‑Depth Understanding

### Why External Roles Matter

Centralized role repositories (Git, Galaxy, Automation Hub) keep every project on the same, bug‑fixed version of a role. This reduces duplication, eases maintenance, and lets teams share improvements.

### Common Sources

- **Private Git** – curated by your org.
- **Tar archives** – handy for offline distribution.
- **Ansible Galaxy** – community‑maintained, thousands of roles.
- **Content Collections** – the modern packaging format (not covered here).

### Galaxy vs. Collections

Roles can be shipped as _individual roles_ or bundled into _Content Collections_. Collections are the newer, preferred method, but the notes focus on plain roles.

### The `ansible‑galaxy` CLI

The `role` sub‑command lets you:

- `init` a skeleton role.
- `install` from Galaxy, Git, or a URL.
- `search` and `info` roles.
- `list` installed roles.
- `remove` unwanted roles.

### Requirements File (`requirements.yml`)

Acts like a dependency manifest. Each entry can pull from Galaxy, a Git repo, or a tarball.  
Typical attributes:

- `src` – role name or URL.
- `scm` – `git` if the source is a repo.
- `version` – branch, tag, or commit.
- `name` – local override.

Specifying a version is essential in production; otherwise you may get an incompatible update.

### Project Organization

- Keep `roles/requirements.yml` in the project root.
- Set `roles_path = roles` in `ansible.cfg` to avoid `-p` each time.
- Separate roles from playbooks for reusability.
- Document dependencies and pinned versions.

### Security & Best Practices

- Audit community roles before production use.
- Prefer well‑maintained, actively developed roles (high download count, recent commits).
- Test thoroughly.
- Use private hubs for enterprise control.

---

## 3️⃣ Summary – Code & Commands (with Comments)

```bash
# Show help for role actions
ansible-galaxy role -h
# └─ Lists actions: init, install, remove, list, search, info, etc.
```

```yaml
# Example requirements.yml – pulls roles from Galaxy, Git, and a local tarball
- src: geerlingguy.redis          # 1: Galaxy role name
  version: "1.5.0"                # 2: Pin to tag/branch
  name: redis_prod                # 3: Override local name

- src: https://github.com/geerlingguy/ansible-role-nginx.git
  scm: git                        # 4: Source control repo
  version: master                 # 5: Branch to use
  name: nginx                     # 6: Local name

- src: file:///opt/local/roles/myrole.tar
  name: myrole                    # 7: Local name for tarball
```

```bash
# Install all roles listed in requirements.yml into the project’s roles folder
ansible-galaxy role install -r roles/requirements.yml -p roles
# └─ Downloads, extracts, and reports success for each role
```

```bash
# List installed roles in the current project
ansible-galaxy role list
# └─ Shows role names and their pinned versions
```

```bash
# Remove a role that is no longer needed
ansible-galaxy role remove nginx
# └─ Confirms successful removal
```

---

## 4️⃣ Research – What to Explore Next

|Topic|Why It Helps|Where to Learn|
|---|---|---|
|**Ansible Collections**|Modern packaging; includes modules, plugins, and roles.|Ansible docs – Collections|
|**Automation Hub**|Enterprise‑grade role hosting with RBAC.|Red Hat Automation Hub docs|
|**Ansible‑Lint**|Detects style and best‑practice violations.|`ansible-lint` GitHub|
|**Automation Controller**|GUI for running playbooks and managing roles.|Red Hat Automation Platform docs|
|**GitOps for Roles**|Version‑controlled role updates.|GitOps tutorials|
|**Role Testing with Molecule**|Ensures roles work before production.|Molecule docs|

---

## 5️⃣ Caveats – Things to Watch Out For

1. **Unspecified Versions** – Without `version`, you get the latest, which may break your playbook.
2. **roles_path Conflicts** – If you omit `-p roles`, roles install to the global path (`~/.ansible/roles`), which may not be available in Automation Controller or `ansible‑navigator`.
3. **Community Role Trust** – Galaxy roles are community‑maintained; Red Hat does not audit them. Use at your own risk.
4. **Unknown Version** – Tarball roles may show `(unknown version)`; consider tagging releases in the repo.
5. **Removal Side‑Effects** – `ansible-galaxy role remove` only deletes the local copy; it does not affect the upstream repo.
6. **Security Audits** – External roles can contain vulnerabilities; always review the code or use a private hub.



---













# Deploying Roles from External Content Sources

Select and retrieve roles from external sources such as Git repositories or Ansible Galaxy, and use them in your playbooks.

## External Content Sources

If you are using roles in your Ansible Playbooks, then you should get those roles from some centrally managed source. This practice ensures that all your projects have the current version of the role and that each project can benefit from bug fixes discovered by other projects with which they share the role.

### Common Sources for Roles

- **Private Git repositories**: Roles created and curated by your organization
- **Tar archive files**: Distributed from websites or other means
- **Ansible Galaxy**: Open source community-maintained roles (not officially supported by Red Hat)
- **Ansible Content Collections**: Increasingly common packaging method

### Content Collections vs Individual Roles

**Important**: It is increasingly common for roles to be packaged as Ansible Content Collections and offered through various methods:

- **Red Hat Certified Ansible Content Collections**: From Red Hat hosted automation hub at https://console.redhat.com, or through a private automation hub
- **Private content**: Packaged from a private automation hub
- **Community content**: From Ansible Galaxy at https://galaxy.ansible.com

**Note**: This section covers how to get roles that are **not** packaged into Ansible Content Collections.

## Introducing Ansible Galaxy

A public library of Ansible content written by a variety of Ansible administrators and users is available at **Ansible Galaxy**. This library contains thousands of Ansible roles, and it has a searchable database that helps you identify roles that might help you accomplish an administrative task.

The `ansible-galaxy` command that you use to download and manage roles from Ansible Galaxy can also be used to download and manage roles from your own Git repositories.

## The Ansible Galaxy Command Line Tool

You can use the `ansible-galaxy` command-line tool with the `role` argument to search for, display information about, install, list, remove, or initialize roles.

```bash
[user@host project]$ ansible-galaxy role -h
usage: ansible-galaxy role [-h] ROLE_ACTION ...

positional arguments:
  ROLE_ACTION
    init      Initialize new role with the base structure of a role.
    remove    Delete roles from roles_path.
    delete    Removes the role from Galaxy. It does not remove or alter the actual GitHub repository.
    list      Show the name and version of each role installed in the roles_path.
    search    Search the Galaxy database by tags, platforms, author and multiple keywords.
    import    Import a role into a galaxy server
    setup     Manage the integration between Galaxy and the given source.
    info      View more details about a specific role.
    install   Install role(s) from file(s), URL(s) or Ansible Galaxy

optional arguments:
  -h, --help   show this help message and exit
```

## Installing Roles Using a Requirements File

If you have a playbook that must have specific roles installed, then you can create a `roles/requirements.yml` file in the project directory that specifies which roles are needed. This file acts as a dependency manifest for the playbook project that enables playbooks to be developed and tested separately from any supporting roles.

### Requirements File Structure

For example, you could have a role in a public repository on a Git server at `https://git.example.com/someuser/someuser.myrole`. A simple `requirements.yml` to install `someuser.myrole` might contain the following content:

```yaml
- src: https://git.example.com/someuser/someuser.myrole
  scm: git
  version: "1.5.0"
```

### Requirements File Attributes

- **`src`**: Specifies the source of the role (URL for Git repository, or SSH format like `git@git.example.com:someuser/someuser.myrole`)
- **`scm`**: Indicates that this role is from a Git repository
- **`version`**: Optional, specifies the version to install (branch name, tag, or Git commit hash)

**Important**: Specify the version of the role in your `requirements.yml` file, especially for playbooks in production. If you don't specify a version, you get the latest version, which might introduce incompatible changes.

### Installing Roles from Requirements File

To install roles using a role requirements file, run the `ansible-galaxy role install` command from within your project directory:

```bash
[user@host project]$ ansible-galaxy role install -r roles/requirements.yml \
> -p roles
Starting galaxy role install process
- downloading role from https://git.example.com/someuser/someuser.myrole
- extracting myrole to /home/user/project/roles/someuser.myrole
- someuser.myrole (1.5.0) was installed successfully
```

### Installation Options

- **`-r roles/requirements.yml`**: Specify the location of your requirements file
- **`-p roles`**: Install the role into a subdirectory of the roles directory

**Important**: If you don't specify the `-p roles` option, then `ansible-galaxy role install` uses the first directory in the default `roles_path` setting (usually `~/.ansible/roles`), which is outside the project directory and unavailable to the execution environment if you use `ansible-navigator`.

### Alternative: Configure roles_path

To avoid needing to specify `-p roles`, add the following setting in the `defaults` section of your project's `ansible.cfg` file:

```ini
roles_path = roles
```

### Installing from Tar Archives

If you have a tar archive file that contains a role, you can use `roles/requirements.yml` to install that file from a URL:

```yaml
# from a role tar ball, given a URL;
#   supports 'http', 'https', or 'file' protocols
- src: file:///opt/local/roles/tarrole.tar
  name: tarrole

- src: https://www.example.com/role-archive/someuser.otherrole.tar
  name: someuser.otherrole
```

**Note**: Red Hat recommends using version control with roles, storing them in a version control system such as Git. If a recent change to a role causes problems, using version control allows you to roll back to a previous, stable version of the role.

## Finding Community-managed Roles in Ansible Galaxy

The open source Ansible community operates a public server, **https://galaxy.ansible.com**, that contains roles and Ansible Content Collections shared by other Ansible users.

**Warning**: These roles can be useful, but they are not supported by Red Hat, nor does Red Hat audit or review this code. Volunteers in the Ansible community maintain this site. Use these roles at your own risk.

### Browsing Ansible Galaxy for Roles

The **Search** tab on the left side of the Ansible Galaxy website home page gives you access to information about the roles published on Ansible Galaxy. You can search for an Ansible role by:

- Name
- Tags
- Other role attributes

Results are presented in descending order of the **Best Match** score, which is a computed score based on:
- Role quality
- Role popularity  
- Search criteria

### Galaxy Role Information

Ansible Galaxy reports:
- **Download count**: Number of times each role has been downloaded
- **GitHub statistics**: Number of watchers, forks, and stars the role's GitHub repository has
- **Activity indicators**: Help determine how active development is and how popular it is in the community

### Search Filters

The **Filters** menu allows searches by:
- Type
- Contributor type
- Contributor
- Cloud platform
- Deprecated status
- Platform (e.g., EL for Red Hat Enterprise Linux, Fedora)
- Tags (up to 20 single-word strings set by role author)

**Important**: 
- **Keyword searches**: Match words or phrases in README file, content name, or content description
- **Tag searches**: Specifically match tag values that the author set for the role

## Searching for Roles from the Command Line

### Basic Search

The `ansible-galaxy role search` command searches Ansible Galaxy for roles.

```bash
# Search by keyword
[user@host ~]$ ansible-galaxy role search 'redis' --platforms EL

Found 232 roles matching your search:

 Name                                Description
 ----                                -----------
 ...output omitted...
 aboveops.ct_redis                   Ansible role for creating Redis container
 adfinis-sygroup.redis               Ansible role for Redis
 adriano-di-giovanni.redis           Ansible role for Redis
 AerisCloud.redis                    Installs redis on a server
 alainvanhoof.alpine_redis           Redis for Alpine Linux
 ...output omitted...
```

### Search Options

- `--author`: Search by author (e.g., `ansible-galaxy role search --author geerlingguy`)
- `--platforms`: Filter by platform (e.g., `--platforms EL`)
- `--galaxy-tags`: Filter by tags

### Getting Role Information

The `ansible-galaxy role info` command displays detailed information about a role:

```bash
[user@host ~]$ ansible-galaxy role info geerlingguy.redis

Role: geerlingguy.redis
        description: Redis for Linux
...output omitted...
        created: 2023-05-08T20:50:00.204075Z
        download_count: 1306420
        github_branch: master
        github_repo: ansible-role-redis
        github_user: geerlingguy
        id: 10990
        imported: 2022-09-26T12:10:34.707632-04:00
        modified: 2023-10-29T18:44:43.771821Z
        path: ('/home/student/.ansible/roles', '/usr/share/ansible/roles', '/etc/ansible/roles')
        upstream_id: 468
        username: geerlingguy
```

## Downloading Roles from Various Sources

### Complete Requirements File Example

```yaml
# from Ansible Galaxy, using the latest version
- src: geerlingguy.redis                          # 1

# from Ansible Galaxy, overriding the name and using a specific version
- src: geerlingguy.redis
  version: "1.5.0"                                # 2
  name: redis_prod

# from any Git based repository, using HTTPS
- src: https://github.com/geerlingguy/ansible-role-nginx.git
  scm: git                                        # 3
  version: master
  name: nginx

# from a role tar ball, given a URL;
#   supports 'http', 'https', or 'file' protocols
- src: file:///opt/local/roles/myrole.tar         # 4
  name: myrole                                    # 5
```

### Requirements File Attribute Reference

1. **`src`**: Specifies the Ansible Galaxy role name, or role's URL if not hosted on Galaxy
2. **`version`**: Specifies role version (branch, tag, or commit hash from the role's repository)
3. **`scm`**: Required if the role is hosted in a source control repository
4. **Archive sources**: For Galaxy or tar archive roles, omit the `scm` keyword
5. **`name`**: Used to override the local name of the role

## Managing Downloaded Roles

### List Installed Roles

The `ansible-galaxy role list` command lists the local roles:

```bash
[user@host project]$ ansible-galaxy role list
# /home/user/project/roles
- geerlingguy.redis, 1.7.0
- redis_prod, 1.5.0
- nginx, master
- myrole, (unknown version)
...output omitted...
```

### Remove Roles

You can remove a role with the `ansible-galaxy role remove` command:

```bash
[user@host ~]$ ansible-galaxy role remove nginx
- successfully removed nginx
```

## Best Practices

### Version Management
- **Always specify versions** in production environments
- **Use version control** (Git) for role storage
- **Pin specific versions** in requirements files to avoid unexpected changes

### Role Selection
- **Review community roles** carefully before use
- **Check role activity**: download counts, GitHub stars, recent commits
- **Prefer well-maintained roles** with active communities
- **Test roles thoroughly** before production deployment

### Project Organization
- **Use requirements.yml** for dependency management
- **Configure roles_path** in ansible.cfg for consistent behavior
- **Keep roles separate** from playbook code for better reusability
- **Document role dependencies** and versions used

### Security Considerations
- **Audit external roles** before using in production
- **Use trusted sources** when possible
- **Keep roles updated** to benefit from security fixes
- **Consider private automation hubs** for enterprise environments

## Automation Controller Integration

**Note**: If you use automation controller, it automatically downloads roles specified in your `roles/requirements.yml` file when it runs your playbook.