

## 1. Core – Quick Reference

|Feature|Syntax|What it does|
|---|---|---|
|**Single host**|`hosts: web.example.com`|Target one machine.|
|**Group**|`hosts: lab`|Target all hosts in the _lab_ group.|
|**All hosts**|`hosts: all`|Target every host in the inventory.|
|**Ungrouped**|`hosts: ungrouped`|Target hosts that aren’t in any group.|
|**Wildcard**|`hosts: '*.example.com'`|Target any host that ends with `.example.com`.|
|**List (OR)**|`hosts: lab,test`|Target hosts in _lab_ **or** _test_.|
|**AND**|`hosts: lab,&datacenter1`|Target hosts that are in **both** groups.|
|**NOT**|`hosts: all,!datacenter1`|Target all hosts **except** those in _datacenter1_.|

> **Tip** – Always quote patterns that contain `!`, `,`, or `*` to avoid shell expansion.

---

## 2. Info – Detailed, Digestible Notes

### 2.1 Why Use Host Patterns?

- **Efficiency** – One line can target dozens of machines.
- **Readability** – Group names describe intent (e.g., `web`, `db`).
- **Maintainability** – Adding a host to a group automatically updates all plays that reference that group.

### 2.2 How Host Patterns Work

1. **Inventory is parsed** into groups and host entries.
2. **Pattern is matched** against group names, host names, and IPs.
3. **Logical operators** (`&`, `!`) refine the set.
4. **Resulting host list** is passed to the play.

### 2.3 What You Can Do

- **Target a subset** of a group (`lab,!labhost2.example.com`).
- **Combine groups** (`lab,test`).
- **Exclude a host** (`all,!test2.example.com`).
- **Use wildcards** for dynamic matching (`web*`).

### 2.4 Common Pitfalls

|Problem|Fix|
|---|---|
|Pattern not quoted → shell expands `*`|Wrap in single quotes: `'*.example.com'`|
|IPs not in inventory → ignored|Add IPs to inventory or use `ungrouped`|
|Complex patterns → hard to read|Prefer descriptive groups over long expressions|

---

## 3. Main – Code Snippets with Explanations

> **Each block is commented to explain its purpose.**

```yaml
# Target a single host
hosts: web.example.com
```

```yaml
# Target all hosts in the 'lab' group
hosts: lab
```

```yaml
# Target every host in the inventory
hosts: all
```

```yaml
# Target hosts that are not in any group
hosts: ungrouped
```

```yaml
# Wildcard: all hosts ending with .example.com
hosts: '*.example.com'
```

```yaml
# List (OR logic): hosts in 'lab' or 'test'
hosts: lab,test
```

```yaml
# AND logic: hosts that belong to both 'lab' and 'datacenter1'
hosts: lab,&datacenter1
```

```yaml
# NOT logic: all hosts except those in 'datacenter1'
hosts: all,!datacenter1
```

```yaml
# Mixed list: groups, wildcards, and specific hosts
hosts: lab,data*,192.168.2.2
```

```yaml
# Exclude a specific host from a group
hosts: datacenter,!test2.example.com
```

---

## 4. Research – What’s Next?

|Topic|Why it matters|How to explore|
|---|---|---|
|**Dynamic inventories**|Lets Ansible discover hosts at runtime (e.g., from AWS).|`ansible-inventory --graph`|
|**Pattern precedence**|Understand how exclusions are applied last.|`ansible-inventory --list`|
|**Custom group variables**|Attach variables to groups for use in plays.|Add `vars` under a group in `inventory.ini`|
|**Ad‑hoc commands**|Test patterns without writing a full playbook.|`ansible all -m ping -i inventory.ini`|

---

## 5. Caveats – Things to Watch Out For

- **Quoting is mandatory** for patterns with special characters.
- **IP addresses** must be explicitly listed in the inventory; otherwise they’re ignored.
- **Order of operations**: Exclusions (`!`) are applied **after** all inclusions.
- **Complex expressions** can become unreadable; use groups whenever possible.
- **Inventory changes** (adding/removing hosts) automatically affect all plays that reference the affected group.

---



---

# Ansible Host Patterns Reference

Write sophisticated host patterns to efficiently select hosts for a play.

## Example Inventory
```ini
web.example.com
data.example.com

[lab]
labhost1.example.com
labhost2.example.com

[test]
test1.example.com
test2.example.com

[datacenter1]
labhost1.example.com
test1.example.com

[datacenter2]
labhost2.example.com
test2.example.com

[datacenter:children]
datacenter1
datacenter2

[new]
192.168.2.1
192.168.2.2
```

## Basic Host Patterns

### Single Host
```yaml
hosts: web.example.com
```

### Host Group
```yaml
hosts: lab
```

### Special Groups
```yaml
hosts: all         # All hosts in inventory
hosts: ungrouped   # Hosts not in any group
```

## Wildcards

### All Hosts
```yaml
hosts: '*'
```

### Pattern Matching
```yaml
hosts: '*.example.com'    # All hosts ending with .example.com
hosts: '192.168.2.*'      # All hosts starting with 192.168.2.
hosts: 'datacenter*'      # All groups/hosts starting with datacenter
```

**Important:** Quote patterns with special characters to avoid shell interpretation.

## Lists and Combinations

### Comma-Separated Lists (OR logic)
```yaml
hosts: lab,test                                    # All hosts in lab OR test groups
hosts: labhost1.example.com,test2.example.com     # Specific hosts
hosts: lab,data*,192.168.2.2                      # Mix of groups, wildcards, and hosts
```

### AND Logic (&)
```yaml
hosts: lab,&datacenter1    # Hosts in lab AND datacenter1
```

### NOT Logic (!)
```yaml
hosts: datacenter,!test2.example.com    # All datacenter hosts EXCEPT test2.example.com
hosts: all,!datacenter1                 # All hosts EXCEPT those in datacenter1
```

## Key Rules

1. **Quoting**: Use single quotes for patterns with special characters (`'!test,prod'`)
2. **IP Addresses**: Only use IPs explicitly listed in inventory
3. **Wildcards**: Match both host names and group names
4. **Order Matters**: In lists, exclusions (!) are processed last
5. **Precedence**: Use groups and patterns instead of complex task conditionals

## Common Patterns

| Pattern | Description |
|---------|-------------|
| `all` | All inventory hosts |
| `ungrouped` | Hosts not in any group |
| `group1,group2` | Hosts in group1 OR group2 |
| `group1,&group2` | Hosts in group1 AND group2 |
| `all,!group1` | All hosts EXCEPT those in group1 |
| `'web*'` | All hosts/groups starting with "web" |
| `host1,host2,host3` | Specific list of hosts |

## Best Practices

- Design inventory groups carefully to minimize complex patterns
- Use descriptive group names
- Prefer group-based targeting over complex wildcards
- Test patterns with `ansible-inventory --list` before using in playbooks
