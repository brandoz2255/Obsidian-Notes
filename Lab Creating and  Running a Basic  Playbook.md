### Guided Exercise: Creating and Running a Basic Playbook

This lab has you create a playbook that installs and starts the Apache web server (

`httpd`) on your managed hosts.

**Prepare the Lab Environment**

- Run the following command to get started:

```bash
lab start playbook-basic
```

**Navigate to the Directory**

- Change into the project directory that was created for you:

```bash
cd /home/student/playbook-basic
```

**Create the Playbook File**

- Create a new file named
    
    `site.yml`.

Start the file with three dashes (

`---`).

Define the play by giving it a

**name** and specifying that it should run on hosts in the **web** group. The file should look like this:

``` yaml
---
- name: Install and start Apache HTTPD
  hosts: web
```

**Add Tasks to the Playbook**

- In the
    
    `site.yml` file, add the `tasks` keyword, indented by two spaces.

**Task 1: Install httpd**. Add a task that uses the

`ansible.builtin.dnf` module to ensure the `httpd` package is present.

```yaml
- name: Ensure httpd package is present
  ansible.builtin.dnf:
    name: httpd
    state: present
```

**Task 2: Copy index.html**. Add a task to copy a local file to the web server's document root using the

`ansible.builtin.copy` module.

```yaml
- name: Correct index.html is present
  ansible.builtin.copy:
    src: files/index.html
    dest: /var/www/html/index.html
```

**Task 3: Start and Enable httpd**. Add a final task to start and enable the

`httpd` service using the `ansible.builtin.service` module.

```yaml
- name: Ensure httpd is started
  ansible.builtin.service:
    name: httpd
    state: started
    enabled: true
```

Save and close the `site.yml` file. Your complete playbook should match the final version shown in the lab guide.

**Validate Your Playbook**

- Before running the playbook, check it for syntax errors:

```bash
ansible-navigator run --stdout site.yml --syntax-check
```

If you get any errors, reopen the file and correct the indentation or any typos.

**Run the Playbook**

- Execute the playbook to configure your servers:

```bash
ansible-navigator run --stdout site.yml
```

You should see "changed" in the output for each task, indicating that the playbook made changes on the managed hosts.

**Verify the Results**

- Run the playbook a second time. This time, no tasks should report being "changed," which confirms the playbook is idempotent (safe to run multiple times).

- Run the playbook a second time. This time, no tasks should report being "changed," which confirms the playbook is idempotent (safe to run multiple times).

```bash
curl serverc.lab.example.com
curl serverd.lab.example.com
```

Both commands should return "This is a test page".

**Finish the Lab**

- To complete the exercise and clean up the resources, run:

```bash
lab finish playbook-basic
```

