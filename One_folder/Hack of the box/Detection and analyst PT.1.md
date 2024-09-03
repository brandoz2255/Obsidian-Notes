- This phase of the blue teams objectives is essentially to detect and anlyze what the red team did essentially look at the incident and making a report
- Incidents such as utilizing sensors, logs, and trained personnel
- These types of anylysts that are useful comes from  employees that notice 

    - An employee that notices abnormal behavior
    - An alert from one of our tools (EDR, IDS, Firewall, SIEM, etc.)
    - Threat hunting activities
    - A third-party notification informing us that they discovered signs of our -organization being compromised

We could also detect these on the software side by configuring these devices 

- Detection at the network perimeter (using firewalls, internet-facing network intrusion detection/prevention systems, demilitarized zone, etc.)
- Detection at the internal network level (using local firewalls, host intrusion detection/prevention systems, etc.)
- Detection at the endpoint level (using antivirus systems, endpoint detection & response systems, etc.)
- Detection at the application level (using application logs, service logs, etc.)

## Initial investigation 
- Once the security incident is detected and reported we look at the context before assemnling the team 
- In which we must know information about the event such as what IP it used and the endpoint and how it did what it was capapble of doing 
- Time zone of the Red users is also important --> 


    - Date/Time when the incident was reported. Additionally, who detected the incident and/or who reported it?
    - How was the incident detected?
   -  What was the incident? Phishing? System unavailability? etc.
    - Assemble a list of impacted systems (if relevant)
   -  Document who has accessed the impacted systems and what actions have been taken. Make a note of whether this is an ongoing incident or the suspicious activity has been stopped
    - Physical location, operating systems, IP addresses and hostnames, system owner, system's purpose, current state of the system
    - (If malware is involved) List of IP addresses, time and date of detection, type of malware, systems impacted, export of malicious files with forensic information on them (such as hashes, copies of the files, etc.)

- This would help on discover whose machine was compromised 
- Then we create a time line essentially perform forensics 

|`Date`|`Time of the event`|`hostname`|`event description`|`data source`|
|---|---|---|---|---|

|`Date`|`Time of the event`|`hostname`|`event description`|`data source`|
|---|---|---|---|---|
|09/09/2021|13:31 CET|SQLServer01|Hacker tool 'Mimikatz' was detected|Antivirus Software|
## Incident questions 
Questions we should ask our selves:

- What is the exploitation impact?
- What are the exploitation requirements?
- Can any business-critical systems be affected by the incident?
- Are there any suggested remediation steps?
- How many systems have been impacted?
- Is the exploit being used in the wild?
- Does the exploit have any worm-like capabilities?

## Confidentiality 
- Such reports on such incididents should be reported to the approtiate people such as law enforcement if instructed or someone with higher clearance 