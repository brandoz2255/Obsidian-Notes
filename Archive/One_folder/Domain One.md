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

In  information Security there are three core principles one must follow 
**`Confidentiality`** **`Integrity`** and **`Availability`**

1. **Confidentiality**: This principle makes sure that those who can accesses information can.  
	1. i.e the confidentiality of a person
2. **Integrity**:  This makes sure  that the information that is accurate and has been tampered with by any means
3. **Availability**: Ensures that the processes are usable by trust worthy users. 
### Confidentiality 

- **Encryption**: converts the plain text information into non-readable data to prevent unauthorized access

Types of Encryption:
1. **Symmetric Encryption**: uses the same key for both encryption and the decryption
	1. fast and effeicient but needs secure method for key exchange 
2. **Asymmetric Encryption**: AKA public key encryption this the uses two different keys a  public key and a private key 

- **Two-Factor Authentication** (2FA): is a security process that uses two different types of accessing the suers identity via *password* and *token/device*
	- Will contain **Something You Know**
	- **Something You Have**
	- **Something you are**



```C
- **Symmetric Encryption**:
    - Key usage: Same key for encryption and decryption.
    - Use cases: Encrypting data at rest, securing communications in closed systems.
    - Key management: Challenges in securely sharing the key between parties.
- **Asymmetric Encryption**:
    - Key usage: Public key for encryption, private key for decryption.
    - Use cases: Digital signatures, secure key exchange, encrypting small amounts of data.
    - Key management: Simplified since the public key can be distributed openly.
```

As mentioned before the n acess control ensure that only authorized users can use important data.


### Integrity

**Hashing**:

- Converts plaintext into a fixed-size, unreadable hash code.
- Used for passwords, integrity checks, and digital signatures.
- Only one way can't reverse  the hash 

**Digital Signatures**:

- Verify the authenticity and integrity of documents/messages.
- Ensure data hasn't been tampered with and is from a verified source.
- Use asymmetric encryption: a private key encrypts a data hash.
- Types: document signing, email signing, code signing.
- Used in protocols like SSL/TLS.

**Public Key Infrastructure (PKI)**:

- Manages digital certificates and public-key encryption.
- Includes roles, policies, hardware, software, and procedures.

**Digital Certificates**:

- Electronic documents proving ownership of digital signatures.

**Certificate Authority (CA)**:

- Third-party source that provides digital certificates.
- Identifies the integrity of digital signatures and establishes secure connections.
- Certificates contain the public key, identity of the holder, and the CA's digital signature.

### Availability

**Information**:

- Ensures information and services are accessible and usable upon demand by authorized entities.
- **Strategies**: Redundancy, load balancing, regular maintenance, and monitoring.
- **Risks**: Hardware failures, software bugs, cyber attacks.

**Redundancy**:

- **Network Redundancy**: Multiple pathways for data to prevent downtime. Technologies: Spanning Tree Protocol (STP), link aggregation (LACP).
- **Hardware Redundancy**: Backup hardware components, like redundant power supplies.
- **Data Storage Redundancy**: Protects data through technologies like RAID (Redundant Array of Independent Disks).
- **Application Redundancy**: Duplicate instances of applications for continuous service, managed with load balancers.

**Fault Tolerance**:

- **Definition**: System’s ability to continue operating correctly despite component failures.
- **Failover Mechanisms**: Automatically redirect traffic or workload from failed components to redundant ones for uninterrupted service.
- **Error Detection and Recovery**: Mechanisms to detect errors and initiate recovery procedures, ensuring continuous operation.
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





