- The next step in the Prep stage is working to protect against incidents 
- The protection isn't a responsibility but it is key to know when investigating an attack and preparing it for the next one

# DMARC
- Essentially this is what is used to prevent phising email attacks that is already built on the SPF and DKIM 
- The idea is to reject the pretend emails that try to be apart of the organization when they really aren't 
- However we can't rely on this too much and must test it ourselves since it also has the ability to block legit emails 
[[DMARC.Fundamentals]]

## Endpoint Hardening && EDR
- An endpoint is how the intrudsion or malicous malware even came from when its dealing with phising attacks or a hacker penetrating into our system it all comes from one device the endpoint
- To harden our endpit we need to make sure to secure our side of the system we do this by 

    - Disable LLMNR/NetBIOS
    - Implement LAPS and remove administrative privileges from regular users
    - Disable or configure PowerShell in "ConstrainedLanguage" mode
    - Enable Attack Surface Reduction (ASR) rules if using Microsoft Defender
    - Implement whitelisting. We know this is nearly impossible to implement. Consider at least blocking execution from user-writable folders (Downloads, Desktop, AppData, etc.). These are the locations where exploits and malicious payloads will initially find themselves. Remember to also block script types such as .hta, .vbs, .cmd, .bat, .js, and similar. Please pay attention to LOLBin files while implementing whitelisting. Do not overlook them; they are really used in the wild as initial access to bypass whitelisting.
     - Utilize host-based firewalls. As a bare minimum, block workstation-to-workstation communication and block outbound traffic to LOLBins
    - Deploy an EDR product. At this point in time, AMSI provides great visibility into obfuscated scripts for antimalware products to inspect the content before it gets executed. It is highly recommended that you only choose products that integrate with AMSI.

When it comes to harden our system good is better than nothing it doenst have to be perfect 

## Network protection 
To protect business we must focus on the  security side of things such as the important systems of a business should not be directly connected to the internet it should be isolated unless its a in a DMZ

- When having our network protected web should have a **IDS or IPS** system in which it uses a [[SSL&TSL]] interception to look at traffic 
- have a secure WiFi for the company so that other thrid party devices or bring your own device (BYOD) don't harm the corporate network
- Only allow Corporate isssued devices to go in and our of the corporate network 

## Password Management 
Many ways to break into a system is using privelege escalation as shown in the red team module we do this by password stealing. 

-  One of the best workarounds for this is simply having better passwords in which we must have it as a complex password
- However our complex password cannot be weak for example`Ilovepizza!` is a complex password a better example is `ilOv3p1zZaF0rW0rk` This adds another level of complexity to our passwords 
- But as we have seen in real world experiances this is still hackable with a $3000 dollar device or a overpowerd pc one un hackable example would be `RL/mI>]p2uSRS;gO` 
- The more random the better however the best security is MFA authentication 

#### Vulnerability Scanning
- Scanning the companies systems for any High or critical vulnerabilities that are discovers the fixes are automatic but some need to be done manually 

#### User Awareness Training 
- Training employees about Cyber-security and other malicious attacks such as monthly phishing emails, dropped USB sticks in the office building, etc.

#### Active Directory Assement 
-  This is the act of thinking like a hacker one of the best ways to do this is of course learning pent testing or hiring a professional to tells us our issues 
- This is just known as finding low hanging fruits or bugs in our system that someone can exploit 

### Purple team
- The purple team is suppose to be monitoring the red team and informing the blue team what they are doping in real time for future reference 


