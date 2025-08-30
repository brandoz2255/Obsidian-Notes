**Chapter 4 – Quick‑Reference Summary**

- **Loops** let you run a task repeatedly over a list of values (strings, dictionaries, etc.) so you can write concise, efficient playbooks.
- **Conditionals** (`when:`) allow a task or entire play to run only when a specific test is true.
- **Handlers** are special tasks that run at the end of a play when they are _notified_ by another task.
    - They are only notified when the notifying task reports a `changed` result.
- **Error handling** can be tuned per task:
    - `ignore_errors: true` – keep the play running even if the task fails.
    - `force_handlers: true` – still run notified handlers even if a task fails.
    - `failed_when` – mark a task as failed based on a custom condition.
    - `changed_when` – override the default “changed” detection.
- **Blocks** group a set of tasks together; you can run `rescue` or `always` tasks depending on whether all tasks in the block succeed.