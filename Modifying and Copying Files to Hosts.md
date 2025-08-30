### Objectives

- Create, install, edit, and remove files on managed hosts, and manage the permissions, ownership, SELinux context, and other characteristics of those files.
    

### Describing File Modules

Most of the commonly used modules related to Linux file management are provided with `ansible-core` in the `ansible.builtin` collection. They perform tasks such as creating, copying, editing, and modifying permissions and other attributes of files. The following table provides a list of frequently used file management modules:

**Table 5.1. Commonly Used File Modules in `ansible.builtin`**

| Module name   | Module description                                                                                                                                                                                                                                                                                                                                                         |
| :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `blockinfile` | Insert, update, or remove a block of multiline text surrounded by customizable marker lines.                                                                                                                                                                                                                                                                               |
| `copy`        | Copy a file from the local or remote machine to a location on a managed host. Similar to the `file` module, the `copy` module can also set file attributes, including SELinux context.                                                                                                                                                                                     |
| `fetch`       | This module works like the `copy` module, but in reverse. This module is used for fetching files from remote machines to the control node and storing them in a file tree, organized by host name.                                                                                                                                                                         |
| `file`        | Set attributes such as permissions, ownership, SELinux contexts, and time stamps of regular files, symlinks, hard links, and directories. This module can also create or remove regular files, symlinks, hard links, and directories. A number of other file-related modules support the same options to set attributes as the `file` module, including the `copy` module. |
| `lineinfile`  | Ensure that a particular line is in a file, or replace an existing line using a back-reference regular expression. This module is primarily useful when you want to change a single line in a file.                                                                                                                                                                        |
| `stat`        | Retrieve status information for a file, similar to the Linux `stat` command.                                                                                                                                                                                                                                                                                               |



In addition, the `ansible.posix` collection, which is included in the default automation execution environment, provides some additional modules that are useful for file management:

**Table 5.2. Commonly Used File Modules in `ansible.posix`**

| Module name   | Module description                                                                                                                                                                                                                                                                                                                                |
| :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `patch`       | Apply patches to files by using GNU `patch`.                                                                                                                                                                                                                                                                                                      |
| `synchronize` | A wrapper around the `rsync` command to simplify common tasks. The `synchronize` module is not intended to provide access to the full power of the `rsync` command, but does make the most common invocations easier to implement. You might still need to call the `rsync` command directly via the `command` module depending on your use case. |


### Automation Examples with Files Modules

The following examples show ways that you can use these modules to automate common file management tasks.

#### Ensuring a File Exists on Managed Hosts

Use the `ansible.builtin.file` module to touch a file on managed hosts. This works like the `touch` command, creating an empty file if it does not exist, and updating its modification time if it does exist. In this example, in addition to touching the file, Ansible ensures that the owning user, group, and permissions of the file are set to specific values.

``` yaml
- name: Touch a file and set permissions
  ansible.builtin.file:
    path: /path/to/file
    owner: user1
    group: group1
    mode: 0640
    state: touch
```

Example outcome:

```bash
[user@host ~]$ **`ls -l file`**
-rw-r-----.  user1 group1 0 Nov 25 08:00 file
```

#### Modifying File Attributes

You can use the `ansible.builtin.file` module to ensure that a new or existing file has the correct permissions or SELinux type as well.

For example, the following file has retained the default SELinux context relative to a user's home directory, which is not the desired context.

```bash
[user@host ~]$ **`ls -Z samba_file`**
-rw-r--r--.  owner group unconfined_u:object_r:**`user_home_t`**:s0 samba_file
```

The following task ensures that the SELinux context type attribute of the `samba_file` file is the desired `samba_share_t` type. This behavior is similar to the Linux `chcon` command.

```yaml
- name: SELinux type is set to samba_share_t
  ansible.builtin.file:
    path: /path/to/samba_file
    setype: samba_share_t
```

Example outcome:

```bash
[user@host ~]$ **`ls -Z samba_file`**
-rw-r--r--.  owner group unconfined_u:object_r:**`samba_share_t`**:s0 samba_file
```

File attribute parameters are available in multiple file management modules. Use the `ansible-navigator doc` command for additional information, providing the `ansible.builtin.file` or `ansible.builtin.copy` module as an argument.

### Note

To set SELinux file contexts persistently in the policy, some options include:

- If you know how to use Ansible roles, you can use the supported `redhat.rhel_system_roles.selinux` role. That is covered in Chapter 7 of the _Red Hat Enterprise Linux Automation with Ansible_ (RH294) training course.
    
- You can use the module `community.general.sefcontext` in the community-supported `community.general` Ansible Content Collection.

the `ansible.builtin.copy` module is used to copy a file located in the Ansible working directory on the control node to selected managed hosts.

that `force: true` is set. That forces the module to overwrite the remote file if it exists but has different contents to the file being copied. If `force: false` is set,

```yaml
- name: Copy a file to managed hosts
  ansible.builtin.copy:
    src: file
    dest: /path/to/file
```

the `ansible.builtin.fetch` module. This could be used to retrieve a file such as an SSH public key from a reference system

```yaml
- name: Retrieve SSH key from reference host
  ansible.builtin.fetch:
    src: "/home/{{ user }}/.ssh/id_rsa.pub
    dest: "files/keys/{{ user }}.pub"
```

To ensure a specific single line of text exists in an existing file, use the `lineinfile` module:

```yaml
- name: Add a line of text to a file
  ansible.builtin.lineinfile:
    path: /path/to/file
    line: 'Add this line to the file'
    state: present
```


To add a block of text to an existing file, use the `ansible.builtin.blockinfile` module:

```yaml
 - name: Add additional lines to a file
  ansible.builtin.blockinfile:
    path: /path/to/file
    block: |
      First line in the additional block of text
      Second line in the additional block of text
    state: present
```

### Note

When using the `ansible.builtin.blockinfile` module, commented block markers are inserted at the beginning and end of the block to ensure idempotency.


use the `ansible.builtin.file` module with the `state: absent` parameter. The `state` parameter is optional to many modules. You should always make your intentions clear whether you want `state: present` or `state: absent` for several reasons. Some modules support other options as well.

```yaml
- name: Make sure a file does not exist on managed hosts
  ansible.builtin.file:
    dest: /path/to/file
    state: absent
```

 `ansible.builtin.stat` module retrieves facts for a file, similar to the Linux `stat` command.


 `ansible.builtin.stat` module returns a dictionary of values containing the file status data, which allows you to refer to individual pieces of information


 `ansible.builtin.stat` module task and then prints the MD5 checksum of the file that it checked.

```yaml
- name: Verify the checksum of a file
  ansible.builtin.stat:
    path: /path/to/file
    checksum_algorithm: md5
  register: result

- ansible.builtin.debug
    msg: "The checksum of the file is {{ result.stat.checksum }}"
```

The outcome should be similar to the following:

```yaml
TASK [Get md5 checksum of a file] *****************************************
ok: [hostname]

TASK [debug] **************************************************************
ok: [hostname] => {
    "msg": "The checksum of the file is 5f76590425303022e933c43a7f2092a3"
}
```

the `ansible.builtin.stat` module are documented in `ansible-navigator doc ansible.builtin.stat`, or you can register a variable

 `ansible.posix.synchronize` module is a wrapper around the `rsync` tool, which simplifies common file management tasks in your playbooks. The `rsync` tool must be installed on both the local and remote host. By default, when using the `ansible.posix.synchronize` module, the "local host" is the host that the `ansible.posix.synchronize` task originates on (usually the control node)

```yaml
- name: synchronize local file to remote files
  ansible.posix.synchronize:
    src: file
    dest: /path/to/file
```

