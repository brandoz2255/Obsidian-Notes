**Chapter 6 – Quick Summary**

- **Host Patterns**
    
    - Specify which machines a play targets.
    - The `hosts:` directive can list multiple patterns (e.g., `webservers, dbservers`).
- **Importing Playbooks**
    
    - `ansible.builtin.import_playbook` pulls an entire playbook into the current one.
    - It is a **static** operation: the content is parsed before the playbook runs.
    - Must appear at the top level of a playbook (cannot be nested inside a play).
- **Including/Importing Task Files**
    
    - `ansible.builtin.import_tasks` – static inclusion of a task list.
    - `ansible.builtin.include_tasks` – dynamic inclusion, processed during execution.
    - Both allow you to keep large playbooks modular and reusable.
- **Dynamic vs. Static Processing**
    
    - **Include**: evaluated at runtime; can be conditional or looped.
    - **Import**: evaluated at parse time; all tasks are fixed before the run starts.

This structure lets you write concise, maintainable playbooks while still targeting the right hosts and reusing common task sets.