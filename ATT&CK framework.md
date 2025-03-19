
#ATTaCK
The purpose of the **MITRE ATT&CK** framework is documentation on how adversaries attack a network or exploit a specific protocol or methodology in a specific category.

such as categories within the scope of **TTP**'s **Tactics Techniques and Procedures** 

- These are procedures and behaviors and methods employed by adverasaries for their objecticves

**Tactic**: What is the overall goal of the attacker and what they are trying to achieve
- understanding gives a better viewpoint on setting up the first step of an incident response **preparation**

**Technique**: How the adversary accomplishes the specific tactic specific method or action the attacker takes
- gives us a better understanding for setting up [check IDR notes]

**Procedure**: How the *technique* was carried out for example a technique is *phishing* where a **procedure** is *how the attacker did the phishing like email with a malicious attachment.*

- **Initial Access** (to understand how adversaries get in) | TA0001
- **Execution** (to identify how attackers run malicious commands) | TA0002
- **Persistence** (to detect long-term threats) | TA0003
- **Privilege Escalation** (to spot elevated access attempts) | TA0004
- **Defense Evasion** (to detect how attackers hide their tracks) | TA0005
- **Collection** (Once the attacker is in the system they begin stealing sensitive information) | TA0009
- **Exfiltration** (to prevent data leaks) | TA0010
- **Command and Control** (to block malicious remote access) | TA0011


#### Initial Access TA0001 

This consists of techniques that use various entry vectors in which the attacker gains their own initial foothold on the system/network. 

- access via 
- **content injection(T1659)** 
	- injecting malicious content  into systems through online network traffic. Rather than luring victims on compromise websites to malicious payloads.
		- like **Drive-by Target** 
		- or **Drive-by Compromise**
- **Drive-by Compromise(1189)**
	- gain access to the system by visiting a website through normal course of browsing where the browser it self is the target. 
- **Hardware additions(T1200)**
	- ie removable media is a great example injecting a malicious usb drive 
- **Phishing(T1566)**
	- sending phishing messages to victims to gain  a foothold on the system electronically social engineering

#### Execution TA0002

The techniques that result in the adversary running on a local or remote system. Adversary here is running malicious code on the network

for example 

- adversary's may abuse **command and scripting interpreter (T1059)** 
	- **powershell .001**
	- **AppleScript .002**
	- **Windows Command Shell .003**
	- **Unix Shell .004** 
	- **Python .006**
	- **JavaScript .007**

- **Container Administration Command (T1610)** 
	- Abuses a container administration service to execute commands within a Containers such as Docker or Kubernetes.

#### Persistence TA0003

This the action in which attackers take to keep the access they have on the systems across restarts and changed credentials. Techniques include access,action or configuration changes that let them keep their foothold on the system. 

- **Account Manipulation (T1098)**
	- Any action that preserves or modifies a compromised account such as credentials or permission groups

#### Privilege Escalation TA0004

Meaning the adversary is trying to gain higher-level permissions such as root access. Techniques that attackers use to gain higher privileged access against a system.  examples include ->

- SYSTEM/root level
- local administrator
- user account with admin-like access
- user accounts with access to specific system or perform specific function

- **Abuse Elevation Control Mechanism (T1548)**
	- Taking advantage of built in control mechanism for controlling who can gain temporary elevated privileges such as sudo in Linux
- **Boot or Logon Initialization Scripts (T1037)**
	- Adversary's may use a script that automatically elevates their privileges to a admin or root



#### Defense Evasion (TA0005)

When the adversary is trying to avoid being detected a defense evasion consists of techniques that adversaries use in order to avoid detection. Techniques such as removing or disabling security software or obfuscating/encrypting data to hide their malware. 

- **Build Image on Host (T1612)** 
	- the attacker builds a container image on the host in order to bypass defenses that monitor for retrieval of malicious images.


#### Collection  (TA0009)

Where the attacker is trying to gather data of the interest o their goal
Techniques attacker use to gather information on the sources or information collected from or relevant to the adversary objective. Next step i ex-filtration. 

- **Adversary in the Middle (T1557)**
	- Adversary's put themselves in between two or more networked devices using this technique such as *Network sniffing*, *Transmitted Data Manipulation* or *replay attacks*

#### Command and Control

here the adversary is communicating with the compromised systems to control them. This is techniques that attackers use to communicate with the systems under their control within a victim network. they minimal normal expected traffic to avoid detection. 

- **Application Layer Protocol (T1071)**
	- attackers communicate using the OSI application layer protocols to avoid detection and network filtering. thye execute commands to the remote systems. such as SSH,SMB, or RDP

#### Exfiltration (TA0010)

When the attacker is trying to steal data. this is the last technique in their steps usually when they steal data from the network. Once collected data adversaries often package it to avoid detection of them stealing it.

- **Automated Exfiltration (T1020)**
	- Uses an automated process iof stealing sensitive information after being gathered during the collection stage 

