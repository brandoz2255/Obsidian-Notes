### SSH
Expand on **what logs** or **events** you would monitor in Splunk:

- Look for **multiple failed login attempts** (`Failed password for invalid user` in `/var/log/auth.log`).
- Use **Splunk queries** to search for repeated authentication failures:

- **Enabling fail2ban** to automatically block repeated failed logins.
- **Disabling password authentication** and using **SSH keys** instead.
- **Changing the default SSH port** to reduce exposure.  
    This demonstrates a **layered defense approach.**


### DNS

I would search for **large DNS queries or responses**, **high-frequency DNS requests** to suspicious domains, or **DNS TXT records** that contain encoded data.

**Clarify the Process of DNS Tunneling:**

- The comparison to **SQL injection or XSS** is **not quite accurate**. DNS tunneling doesn’t inject malicious code into a vulnerable application – rather, it **encodes malicious data within DNS queries and responses**.

**Detection Depth – What to Look For:**

- DNS tunneling can be detected by **analyzing DNS traffic patterns**. Add details like:
    - **Abnormally large DNS queries** or responses.
    - **High-frequency DNS requests** to domains with strange or random subdomains (e.g., `abc123.malicious.com`).
    - **Unusual DNS record types** (TXT records are often used for tunneling).
    - Use **queries in Splunk** to detect large DNS requests:


#### Docker 

**as for Improvement:**

1. **Clarify the Process:**
    
    - While the core idea is solid, the description can be a bit more **structured and detailed**. For example, explain briefly **what Docker Compose does** before diving into how you used it.
    - Example:  
        _"Docker Compose allows you to define and run multi-container applications using a YAML configuration file. Instead of running individual `docker run` commands on each Raspberry Pi, I wrote a `docker-compose.yml` to automate the deployment of Juice Shop and AFL++."_


____

#### IoC

Examples of **IoCs**:

- Unusual network traffic patterns
- Suspicious login attempts
- Unknown executables/files
- Registry or system file modifications
- DNS requests to unfamiliar domains
- Large transfers of data
- Activity from unexpected geographic locations

**Containment and Mitigation Steps:**

- Expand on **what actions** you would take beyond containment. For example:
    - **Isolate the affected system**
    - **Patch vulnerabilities**
    - **Monitor post-containment for further suspicious behavior**  
        This will show that you’re thinking beyond detection and moving into **incident response phases**.
    - Instead of just saying _“use Splunk’s search query function”_, mention **specific logs** you might analyze (e.g., SSH logs, firewall logs).