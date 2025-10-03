


## 1️⃣ Core – Quick Reference

|Topic|Key Point|Typical Command|
|---|---|---|
|**Install a collection**|`ansible-galaxy collection install <name> -p collections`|`ansible-galaxy collection install community.crypto -p collections`|
|**Requirements file**|List collections under `collections:` in `requirements.yml`|`ansible-galaxy collection install -r collections/requirements.yml -p collections`|
|**Configure sources**|`ansible.cfg` → `[galaxy] server_list` + `[galaxy_server.<name>]`|See example below|
|**View installed collections**|`ansible-navigator collections`|`ansible-navigator collections`|
|**Use a module**|`namespace.collection.module`|`community.mysql.mysql_user`|
|**Use a role**|`include_role: name: namespace.collection.role`|`include_role: name: redhat.satellite.organizations`|

---

## 2️⃣ Info – In‑Depth Understanding

### What Are Content Collections?

- **Definition**: Bundles of related modules, roles, and plugins that live outside the core Ansible code.
- **Why They Exist**: Core Ansible grew too large; separating content lets vendors ship updates independently of Ansible releases.
- **Typical Sources**:
    - _Red Hat Automation Hub_ (enterprise‑grade, supported)
    - _Ansible Galaxy_ (community‑hosted, no formal support)
    - _Private hubs_ (internal collections)
    - _Git repos_ or _tar archives_ (direct downloads)

### Namespaces

- The first part of a collection name (`namespace.collection`).
- Prevents naming collisions (e.g., `community.crypto` vs. `redhat.insights`).
- Common namespaces: `community`, `redhat`, `ansible`, `cisco`.

### Collection Paths

- `collections_paths` in `ansible.cfg` tells Ansible where to look.
- Default: `~/.ansible/collections:/usr/share/ansible/collections`.
- Projects often add a local `collections/` directory and install there with `-p collections`.

### Versioning & Pinning

- Collections are versioned (semantic).
- Pinning (`version: 1.2.0`) in `requirements.yml` guarantees reproducible environments.
- Updating is safe when tested in non‑production environments first.

### Installing from Multiple Sources

- `ansible.cfg` can list several servers (`server_list = automation_hub, galaxy`).
- Each server gets its own `[galaxy_server.<name>]` section with `url`, `auth_url`, and `token` or `username/password`.
- Environment variables (`ANSIBLE_GALAXY_SERVER_<SERVER>_<KEY>`) can replace hard‑coded credentials.

### Using Collections in Playbooks

- **Modules**: `namespace.collection.module` (e.g., `community.mysql.mysql_user`).
- **Roles**: `include_role: name: namespace.collection.role` (e.g., `redhat.satellite.organizations`).
- Documentation can be viewed with `ansible-navigator doc <FQCN>`.

### Best Practices

- Keep collections in a local `collections/` folder.
- Use a `requirements.yml` for all dependencies.
- Pin versions for production.
- Test collection upgrades in a staging environment.
- Store credentials in environment variables, not in `ansible.cfg`.
- Review community collections before use; keep them updated.

---

## 3️⃣ Summary – Code & Commands (with Comments)

```bash
# 1. Install a single collection into the local 'collections' directory
ansible-galaxy collection install community.crypto -p collections
#    ↓ Downloads community.crypto and places it in ./collections

# 2. Install all collections listed in a requirements file
ansible-galaxy collection install -r collections/requirements.yml -p collections
#    ↓ Reads requirements.yml, installs each collection, respects pinned versions

# 3. List all collections available to the current environment
ansible-navigator collections
#    ↓ Shows every collection found in collections_paths

# 4. View documentation for a specific module
ansible-navigator doc community.mysql.mysql_user
#    ↓ Prints the module's help text and examples

# 5. Upgrade collections to the latest versions defined in requirements.yml
ansible-galaxy collection install -r collections/requirements.yml -p collections --upgrade
#    ↓ Re‑installs each collection, pulling newer releases if available

# 6. Remove a collection manually (no built‑in command)
rm -rf collections/community/crypto
#    ↓ Deletes the collection directory; Ansible will no longer find it
```

```yaml
# Example collections/requirements.yml
---
collections:
  - name: community.crypto          # Install from Galaxy (latest)
  - name: ansible.posix
    version: 1.2.0                  # Pin to a specific version
  - name: /tmp/community-dns-1.2.0.tar.gz  # Local tarball
  - name: http://example.com/redhat-insights-1.0.5.tar.gz  # Remote archive
  - name: git+https://github.com/ansible-collections/community.general.git
    version: main                   # Branch or tag
```

```ini
# Example ansible.cfg snippet for multiple collection sources
[galaxy]
server_list = automation_hub, galaxy

[galaxy_server.automation_hub]
url = https://console.redhat.com/api/automation-hub/
auth_url = https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token
token = eyJh...Jf0o

[galaxy_server.galaxy]
url = https://galaxy.ansible.com/
```

---

## 4️⃣ Research – What’s Next to Explore

|Topic|Why It Matters|Where to Learn|
|---|---|---|
|**Ansible Collections vs. Content Collections**|Understand the newer “Content Collections” format and how it differs from classic collections.|Ansible docs – “Content Collections”|
|**Automation Hub API**|Automate collection downloads and management programmatically.|Red Hat Automation Hub API docs|
|**Private Automation Hub Setup**|Securely host internal collections and control access.|Red Hat Automation Platform docs|
|**Molecule Testing**|Verify collection modules and roles before deployment.|Molecule docs|
|**Ansible‑Navigator**|CLI for interactive collection browsing and documentation.|Ansible‑Navigator docs|
|**Semantic Versioning in Collections**|Predictable upgrades and rollback.|Ansible docs – “Versioning”|

---

## 5️⃣ Caveats – Things to Watch Out For

1. **Missing `collections_paths`** – If you set a custom path in `ansible.cfg` and omit the default directories, `ansible-navigator` may not find built‑in collections.
2. **No Remove Command** – `ansible-galaxy` can’t uninstall collections; you must delete the directory manually.
3. **Credential Exposure** – Storing tokens in `ansible.cfg` can leak secrets if the file is committed. Use environment variables instead.
4. **Community Collections** – Lack formal support; review code and update regularly.
5. **Version Conflicts** – Installing multiple versions of the same collection can cause module resolution issues. Pin versions carefully.
6. **Private Hub Access** – Requires proper authentication; otherwise, `ansible-galaxy` will fail to download.







---

# Getting Roles and Modules from Content Collections

Obtain a set of related roles, supplementary modules, and other content from an Ansible Content Collection and use them in a playbook.

## Ansible Content Collections

When Ansible was first developed, all the modules that it used were included as part of the core software package. As the number of modules increased, it became harder for the upstream project to manage all of these modules. Every module required a unique name and synchronizing module updates with updates to the core Ansible code.

With **Ansible Content Collections**, Ansible code updates are separated from updates to modules and plug-ins. An Ansible Content Collection provides a set of related modules, roles, and other plug-ins that you can use in your playbooks. This approach enables vendors and developers to maintain and distribute their collections at their own pace, independently of Ansible releases.

### Examples of Content Collections

- **`redhat.insights`**: Provides modules and roles that you can use to register a system with Red Hat Insights for Red Hat Enterprise Linux
- **`cisco.ios`**: Supported and maintained by Cisco, provides modules and plug-ins that manage Cisco IOS network appliances
- **`community.crypto`**: Provides modules that create SSL/TLS certificates

### Benefits of Content Collections

- **Flexibility**: Install only the content you need instead of installing all supported modules
- **Version control**: Select a specific version of a collection (possibly an earlier or later one)
- **Choice of support**: Choose between versions supported by Red Hat/vendors or community-provided versions
- **Independent updates**: Collections are updated independently of Ansible releases

### Version Support

- **Ansible 2.9 and later** support Ansible Content Collections
- **Ansible Base 2.10** and **Ansible Core 2.11** unbundled most modules from core Ansible code and placed them in collections
- **Red Hat Ansible Automation Platform 2.2** provides automation execution environments based on Ansible Core 2.13 that inherit this feature

**Note**: You can develop your own collections to provide custom roles and modules to your teams. Creating Ansible Content Collections is covered in the Developing Advanced Automation with Red Hat Ansible Automation Platform (DO374) course.

## Namespaces for Ansible Content Collections

To make it easier to specify collections and their contents by name, collection names are organized into **namespaces**. Vendors, partners, developers, and content creators can use namespaces to assign unique names to their collections without conflicting with other collections.

### Namespace Examples

- **`community`** namespace: All collections that the Ansible community maintains
  - `community.crypto`
  - `community.postgresql`
  - `community.rabbitmq`

- **`redhat`** namespace: Ansible Content Collections that Red Hat directly maintains and supports
  - `redhat.rhv`
  - `redhat.satellite`
  - `redhat.insights`

The namespace is the first part of a collection name, providing clear organization and avoiding naming conflicts.

## Selecting Sources of Ansible Content Collections

Regardless of whether you are using `ansible-navigator` with the minimal automation execution environment or `ansible-playbook` on bare metal Ansible Core, you always have at least one Ansible Content Collection available: **`ansible.builtin`**.

Your automation execution environment might have additional collections built into it, for example, the default execution environment used by Red Hat Ansible Automation Platform 2.2, `ee-supported-rhel8`.

### Content Collection Sources

If you need additional Ansible Content Collections, you can add them to the `collections` subdirectory of your Ansible project. You might obtain collections from several sources:

#### 1. Automation Hub

**Automation hub** is a service provided by Red Hat to distribute Red Hat Certified Ansible Content Collections that are supported by Red Hat and ecosystem partners. As an end customer, you can open a support ticket with Red Hat for these collections.

- **Requirements**: Valid Red Hat Ansible Automation Platform subscription
- **Access**: Use the automation hub web UI at https://console.redhat.com/ansible/automation-hub/
- **Support**: Formal support guarantees from Red Hat and ecosystem partners

#### 2. Private Automation Hub

Your organization might have its own on-site private automation hub, and might also use that hub to distribute its own Ansible Content Collections.

- **Included with**: Red Hat Ansible Automation Platform
- **Use case**: Internal organizational collections and curated external collections

#### 3. Ansible Galaxy

**Ansible Galaxy** is a community-supported website that hosts Ansible Content Collections submitted by various Ansible developers and users.

- **Access**: Public library at https://galaxy.ansible.com/
- **Support**: No formal support guarantees, not curated by Red Hat
- **Examples**: `community.crypto`, `community.postgresql`, `community.rabbitmq`

#### 4. Third-Party Git Repository or Archive File

You can download Ansible Content Collections from:
- Git repositories
- Local or remote tar archive files

Similar to how you can download roles.

## Installing Ansible Content Collections

Before your playbooks can use content from an Ansible Content Collection, you must ensure that the collection is available in your automation execution environment.

### Collections Path Configuration

The Ansible configuration `collections_paths` setting specifies a colon-separated list of paths where Ansible looks for installed collections.

**Default value:**
```
~/.ansible/collections:/usr/share/ansible/collections
```

You can set this directive in the `ansible.cfg` configuration file.

**Important**: If you set `collections_paths` to some other value in your project's `ansible.cfg` file and eliminate those two directories, then `ansible-navigator` cannot find the Ansible Content Collections provided inside the automation execution environment.

### Installing Collections with ansible-galaxy

The following example uses the `ansible-galaxy collection install` command to download and install the `community.crypto` Ansible Content Collection:

```bash
[user@controlnode ~]$ ansible-galaxy collection install community.crypto \
> -p collections
```

**Important**: You must specify the `-p collections` option or `ansible-galaxy` installs the collection based on your current `collections_paths` setting, or into your `~/.ansible/collections/` directory by default. The `ansible-navigator` command does not load this directory into the automation execution environment.

### Installation from Various Sources

#### From Local Tar Archive
```bash
[user@controlnode ~]$ ansible-galaxy collection install \
> /tmp/community-dns-1.2.0.tar.gz -p collections
```

#### From Remote Tar Archive
```bash
[user@controlnode ~]$ ansible-galaxy collection install \
> http://www.example.com/redhat-insights-1.0.5.tar.gz -p collections
```

#### From Git Repository
```bash
[user@controlnode ~]$ ansible-galaxy collection install \
> git@git.example.com:organization/repo_name.git -p collections
```

**Note**: A Git repository must have a valid `galaxy.yml` or `MANIFEST.json` file that provides metadata about the collection, such as its namespace and version number.

### Warning About Collection Paths

When you install collections, you might see a warning that your Ansible project's playbooks might not find the collection because the specified path is not part of the configured Ansible collections path.

**You can safely ignore this warning** because your Ansible project checks the local `collections` subdirectory before checking directories specified by the `collections_paths` setting.

## Installing Ansible Content Collections with a Requirements File

If your Ansible project needs additional Ansible Content Collections, you can create a `collections/requirements.yml` file in the project directory that lists all the collections that the project requires.

**Automation controller** detects this file and automatically installs the specified collections before running your playbooks.

### Requirements File Structure

A requirements file for Ansible Content Collections is a YAML file that consists of a `collections` dictionary key that has the list of collections to install as its value:

```yaml
---
collections:                                                           # 1
  - name: community.crypto                                             # 2

  - name: ansible.posix
    version: 1.2.0                                                     # 3

  - name: /tmp/community-dns-1.2.0.tar.gz                            # 4

  - name: http://www.example.com/redhat-insights-1.0.5.tar.gz        # 5

  - name: git+https://github.com/ansible-collections/community.general.git  # 6
    version: main
```

### Requirements File Attributes

1. **`collections`**: The value of this dictionary key is the list of collections required by the Ansible project
2. **Basic collection**: Install the `community.crypto` collection from the first available source
3. **Versioned collection**: Install version 1.2.0 of the `ansible.posix` collection (good practice to specify versions)
4. **Local archive**: Install from a particular local tar archive file
5. **Remote archive**: Install from the tar archive at the specified remote URL
6. **Git repository**: Install from a public Git repository, selecting the version in the main branch (version can be branch, tag, or commit hash)

### Installing from Requirements File

The `ansible-galaxy` command can use the `collections/requirements.yml` file to install all collections:

```bash
[root@controlnode ~]# ansible-galaxy collection install \
> -r collections/requirements.yml -p collections
```

**Options:**
- `--requirements-file` (or `-r`): Specify the requirements file
- `-p collections`: Install collections into the collections subdirectory

## Configuring Ansible Content Collection Sources

By default, the `ansible-galaxy` command uses **Ansible Galaxy** at https://galaxy.ansible.com/ to download Ansible Content Collections. You might prefer **automation hub** or your own **private automation hub**, or want to try multiple sources in order.

### Configuration in ansible.cfg

You can configure the sources that `ansible-galaxy` uses in your Ansible project's `ansible.cfg` file:

```ini
...output omitted...
[galaxy]
server_list = automation_hub, galaxy                                   # 1

[galaxy_server.automation_hub]
url=https://console.redhat.com/api/automation-hub/                     # 2
auth_url=https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token  # 3
token=eyJh...Jf0o                                                      # 4

[galaxy_server.galaxy]
url=https://galaxy.ansible.com/
```

### Configuration Parameters

1. **`server_list`**: List all repositories that `ansible-galaxy` must use in order. For each name, add a `[galaxy_server.name]` section with connection parameters
2. **`url`**: The URL to access the repository
3. **`auth_url`**: The URL for authentication (required for automation hub)
4. **`token`**: Authentication token associated with your account (get from https://console.redhat.com/ansible/automation-hub/token/)

### Alternative Authentication Methods

#### Using Username and Password
```ini
[galaxy_server.automation_hub]
url=https://cloud.redhat.com/api/automation-hub/
username=operator1
password=Sup3r53cR3t
```

**Security Note**: You might not want to expose credentials in the `ansible.cfg` file because it could get committed to version control.

#### Using Environment Variables

Remove authentication parameters from `ansible.cfg` and define them in environment variables:

```bash
export ANSIBLE_GALAXY_SERVER_<server_id>_<key>=value
```

**Parameters:**
- **`server_id`**: Server identifier in uppercase (name from `server_list`)
- **`key`**: Parameter name in uppercase

**Example:**
```bash
[user@controlnode ~]$ cat ansible.cfg
...output omitted...
[galaxy_server.automation_hub]
url=https://cloud.redhat.com/api/automation-hub/
auth_url=https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token

[user@controlnode ~]$ export \
> ANSIBLE_GALAXY_SERVER_AUTOMATION_HUB_TOKEN='eyJh...Jf0o'

[user@controlnode ~]$ ansible-galaxy collection install ansible.posix \
> -p collections
```

## Using Resources from Ansible Content Collections

After you install an Ansible Content Collection in your Ansible project, you can use it with that project's Ansible Playbooks.

### Viewing Collections

You can use the `ansible-navigator collections` command in your Ansible project directory to list all collections installed in your automation execution environment. This includes collections in your project's `collections` subdirectory.

**Interactive mode:**
- Select the line number of the collection to view its contents
- Select the line number of a module, role, or plug-in to see its documentation
- Use `ansible-navigator doc` with the FQCN (Fully Qualified Collection Name) of a module to view documentation

### Using Modules from Collections

The following playbook invokes the `mysql_user` module from the `community.mysql` collection:

```yaml
---
- name: Create the operator1 user in the test database
  hosts: db.example.com

  tasks:
    - name: Ensure the operator1 database user is defined
      community.mysql.mysql_user:
        name: operator1
        password: Secret0451
        priv: '.*:ALL'
        state: present
```

### Using Roles from Collections

The following playbook uses the `organizations` role from the `redhat.satellite` collection:

```yaml
---
- name: Add the test organizations to Red Hat Satellite
  hosts: localhost

  tasks:
    - name: Ensure the organizations exist
      include_role:
        name: redhat.satellite.organizations
      vars:
        satellite_server_url: https://sat.example.com
        satellite_username: admin
        satellite_password: Sup3r53cr3t
        satellite_organizations:
          - name: test1
            label: tst1
            state: present
            description: Test organization 1
          - name: test2
            label: tst2
            state: present
            description: Test organization 2
```

## Best Practices

### Version Management
- **Pin specific versions** in requirements files for production environments
- **Test collection updates** in non-production environments first
- **Use semantic versioning** when available

### Source Configuration
- **Prioritize trusted sources** in your server_list
- **Use environment variables** for sensitive authentication information
- **Configure multiple sources** for redundancy

### Project Organization
- **Store collections locally** using `-p collections` option
- **Use requirements files** for dependency management
- **Document collection dependencies** in your project README

### Security Considerations
- **Review collections** before use, especially from community sources
- **Keep collections updated** to benefit from security fixes
- **Use private automation hub** for enterprise environments
- **Avoid storing credentials** in configuration files

### Collection Development
- **Follow namespacing conventions** when creating custom collections
- **Provide clear documentation** for your collections
- **Use semantic versioning** for your collection releases
- **Test collections** across different Ansible versions

## Common Collection Management Tasks

### List Installed Collections
```bash
ansible-navigator collections
```

### View Collection Documentation
```bash
ansible-navigator doc community.mysql.mysql_user
```

### Install Specific Version
```bash
ansible-galaxy collection install community.crypto:1.9.0 -p collections
```

### Upgrade Collections
```bash
ansible-galaxy collection install -r collections/requirements.yml -p collections --upgrade
```

### Remove Collections
Collections must be manually removed from the filesystem as `ansible-galaxy` doesn't provide a remove command for collections.