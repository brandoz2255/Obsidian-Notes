**Why do we gather facts and use them in Ansible playbooks?**

|Why|What it gives you|How it helps a student|
|---|---|---|
|**Automatic discovery**|`ansible_facts` contains host‑specific data (OS, memory, CPU, network, etc.)|Lets you write generic tasks that adapt to each machine without hard‑coding values.|
|**Conditional logic**|You can test a fact (`processor_count > 4`) and run a task only when the condition is true.|Avoids unnecessary work on hosts that don’t need it (e.g., a web server that only needs a package install).|
|**Debugging & learning**|`ansible.builtin.debug` prints the fact values to the console.|Shows you exactly what Ansible sees, so you can verify that your playbook is using the right data.|
|**Custom host data**|`ansible_facts['ansible_local']` holds facts you create yourself (e.g., `web_package = httpd`).|Lets you store configuration‑specific information on the host and reuse it in templates or conditionals, just like built‑in facts.|
|**Performance control**|`gather_facts: false` skips the automatic `setup` module.|Speeds up a play when you know you won’t need any facts, or when the host can’t run `setup` yet.|
|**Subset selection**|`gather_subset` limits the amount of data collected.|Reduces load on large or busy hosts and keeps the output focused on what you actually need.|

In short, **facts are Ansible’s way of “talking to the host”**—they give you a snapshot of the machine’s state. By pulling that snapshot into `ansible_facts` (or `ansible_local` for custom data) you can write playbooks that are:

1. **Dynamic** – adapt to each host’s real configuration.
2. **Reusable** – the same play can run on many hosts with different values.
3. **Transparent** – `debug` lets you see the data, so you can troubleshoot or confirm that the play is using the right values.