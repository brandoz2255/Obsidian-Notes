**Chapter 5 – File Management & Jinja2 Templates**

|Item|Detail|
|---|---|
|**Goal**|Deploy, manage, and adjust files on hosts managed by Ansible.|
|**Key Concepts**|• File‑management modules (`ansible.builtin`, `ansible.posix`) handle creation, copying, editing, permissions, ownership, and SELinux context.  <br>• Jinja2 templates let you build files dynamically; they consist of variables/expressions that are rendered on the control node.  <br>• The `ansible.builtin.template` module copies the rendered file to each target host.  <br>• Jinja2 filters convert data between formats (e.g., `to_json`, `to_yaml`, `from_json`, `from_yaml`).|
|**Objectives**|• Create, install, edit, and remove files on managed hosts.  <br>• Manage file attributes (mode, owner, group, SELinux context).  <br>• Deploy customized files using Jinja2 templates.|
|**Sections Covered**|• **Modifying and Copying Files to Hosts** (with guided exercise)  <br>• **Deploying Custom Files with Jinja2 Templates** (with guided exercise and lab)|
|**Lab**|Deploying Files to Managed Hosts|

**Related Notes**

- [Modifying and Copying Files to Hosts](obsidian://open?file=Modifying%20and%20Copying%20Files%20to%20Hosts.md)
- [Guided Exercise mod and copying hiles to host](obsidian://open?file=Guided%20Exercise%20mod%20and%20copying%20hiles%20to%20host.md)
- [Deploying Custom Files with Jinja2 Templates](obsidian://open?file=Deploying%20Custom%20Files%20with%20Jinja2%20Templates.md)
    - [What is jinja2 and why its used in ansible](obsidian://open?file=What%20is%20jinja2%20and%20why%20its%20used%20in%20ansible.md)
    - [Guided exercise deploying custom files](obsidian://open?file=Guided%20exercise%20deploying%20custom%20files.md)
    - [Lab Deploying Files to Managed Hosts](obsidian://open?file=Lab%20Deploying%20Files%20to%20Managed%20Hosts.md)