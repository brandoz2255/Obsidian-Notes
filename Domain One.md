# What we need to work on 

- [ ] **Control Types** is what we need to work on ]\
- [ ] **DNS SinkHole** what we need to work on 
- [ ] **GAP Analysis**: - Gap analysis is not a common source of security requirements but rather a method used to identify the difference between current security measures and required standards.
- [ ] **Types of locks**: 
# Control types 
[[SYO-701 1.1]] : Control Types

### Preventive Controls

**Purpose:** *Stop attackers from accessing systems and data.*

- **Access Control:** *Ensures only authorized users can access systems.*
    
    - **Mechanisms:**
        - **User Authentication:** Passwords, biometrics, smart cards.
        - **Access Control Lists (ACLs):** Define who can access what resources.
        - **Role-Based Access Control (RBAC):** Access based on user roles within the organization.

- **Firewalls:** *Monitor and control incoming and outgoing network traffic based on predetermined security rules.*
    
    - **Types:**
        - **Packet-Filtering Firewalls:** Inspect packets and allow or block based on rules.
        - **Stateful Inspection Firewalls:** Track the state of active connections.
        - **Proxy Firewalls:** Act as an intermediary between users and the internet.

- **Encryption:** *Protects data by converting it into an unreadable format without a decryption key.*
    
    - **Types:**
        - **Symmetric Encryption:** Same key for encryption and decryption (e.g., AES).
        - **Asymmetric Encryption:** Different keys for encryption and decryption (e.g., RSA).

- **Patching and Updating:** *Regularly updating software to fix known vulnerabilities.*
    
    - **Automated Patch Management:** Tools to automatically apply updates.


- **Security Awareness Training:** *Educating users to recognize and prevent security threats.*
    
    - **Topics:** Phishing, social engineering, safe browsing practices.

### Deterrent Controls

**Purpose:** *Discourage potential attackers from attempting to breach security.*

- **Warning Banners:** Inform users and potential attackers that unauthorized access is prohibited and monitored.
    
    - **Examples:** Login screens with legal warnings.
- **Security Guards:** Physical presence to deter unauthorized access and provide immediate response to incidents.
    
    - **Functions:** Patrols, access control, visitor management.
- **Fencing and Barriers:** Physical obstacles to prevent unauthorized access to facilities.
    
    - **Types:** Gates, bollards, turnstiles.
- **Security Cameras:** Surveillance to monitor and record activities.
    
    - **Benefits:** Provides evidence, deters criminal activity.

### Detective Controls

**Purpose:** *Identify and report security breaches.*

- **Log Analysis:** Reviewing logs from servers, firewalls, and IDS for signs of malicious activity.
    
    - **Tools:** Log management software, SIEM systems.
- **Intrusion Detection Systems (IDS):** Monitor network traffic for suspicious activities.
    
    - **Types:** Network-based (NIDS) and Host-based (HIDS).
- **Security Information and Event Management (SIEM):** Centralized platform for real-time monitoring and analysis of security events.
    
    - **Functions:** Correlates events, generates alerts, provides dashboards.
- **File Integrity Monitoring (FIM):** Detects unauthorized changes to files.
    
    - **Examples:** Tripwire, OSSEC.
- **Anomaly Detection:** Identifies deviations from normal behavior using statistical analysis or machine learning.
    
    - **Examples:** User behavior analytics (UBA), network anomaly detection.

### Corrective Controls

**Purpose:** *Respond to and fix security incidents.*

- **Recovery:** Restore normal operations and minimize damage after an incident.
    
    - **Methods:** System backups, data recovery, restoring from backups.
- **Documentation:** Conduct post-incident reviews to identify root causes and improve future security measures.
    
    - **Activities:** Incident reports, lessons learned, process improvements.

### Compensating Controls

**Purpose:** *Provide alternative measures when primary controls are not feasible.*

- **Dual Controls:** Two separate controls for a single function.
    
    - **Example:** Two-person integrity for critical operations.
- **Redundancy:** Backup systems to take over if primary systems fail.
    
    - **Examples:** Redundant power supplies, failover servers.
- **Monitoring and Alerting:** Systems to detect and alert unusual activities.
    
    - **Tools:** SIEM systems, network monitoring tools.

### Directive Controls

**Purpose:** *Establish policies, procedures, and guidelines for managing security.*

- **Policies:** Define rules and guidelines for managing and protecting information.
    
    - **Examples:** Acceptable use policy, data protection policy.
- **Procedures:** Detailed instructions for implementing policies.
    
    - **Examples:** Incident response procedures, access request procedures.
- **Guidelines:** Recommendations for best practices in implementing procedures.
    
    - **Examples:** Password creation guidelines, email security guidelines.

### Control Categories

- **Technical Controls:** *Implemented through technology.*
    
    - **Examples:** Firewalls, encryption, IDS.
- **Managerial Controls:** *Administrative controls that manage and oversee security*.
    
    - **Examples:** Security policies, risk assessments, security awareness training.
- **Operational Controls:** *Day-to-day procedures and mechanisms.*
    
    - **Examples:** Incident response plans, physical access controls, backups.
- **Physical Controls:** *Physical measures to protect systems and data.*
    
    - **Examples:** Security guards, fences, surveillance cameras.

[[chart]]
# CIA Tria

[[SYO-701 1.2]] : CIA Triad 

# AAA Servers
[[SYO-701 1.2 pt 2]] : AAA servers 


# GAP Analysis

[[SYO-701 1.2 pt3]] : GAP Analysis 

# Zero Trust
[[SYO-701 1.2 pt4]] : Zero Trust 

# Physical Security Controls
[[SYO-701 1.2 pt5]] : Physical Security controls 

# Personnel 
[[SYO-701 1.2 PT6]] : Personnel 

# Change Management a  nd  Policies
[[SYO-701 1.3 PT 1]] :  Change management and policies





