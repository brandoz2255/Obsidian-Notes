- Information gathering it self is a phase in the first step of penetration testing where we need  to simulate external attackers without internal information from the target organization 
- this phase is of course crucial in which poor and rushed information is gonna result in poor and rushed results otherwise having thorough enumeration would have been better 
- This phase helps us understand the attack surface technologies used and in some cases discover development   the discover development environment even a forgotten and unmaintained infrastructure can lead us to an internal network access as they are usually less protects and monitored 
- Gathering information is always a iterative process
- As we discover other assets we can use like a subdomain or virtual host we will need to fingerprint the technologies in use look for hidden pages/directories, etc, which may lead us to discover another subdomain and start t he process all over again 
- Like for example we can think of it  as stumbling across new subdomains during one of our penetration tests based on the SSL certificate 
- However if we look at this subdomain like a deeper look we can see that we will often see different technologies in use that the main company website itself 
- subdomains and v host are mostly used to present other information and perform other task that have been separated from the homepage
- Therefore it is essential to find out which technologies are used what purpose they serve and how they work during the process 
- Then main goal us to identify as much information as possible 

|Area|Description|
|---|---|
|Domains and Subdomains|Often, we are given a single domain or perhaps a list of domains and subdomains that belong to an organization. Many organizations do not have an accurate asset inventory and may have forgotten both domains and subdomains exposed externally. This is an essential part of the reconnaissance phase. We may come across various subdomains that map back to in-scope IP addresses, increasing the overall attack surface of our engagement (or bug bounty program). Hidden and forgotten subdomains may have old/vulnerable versions of applications or dev versions with additional functionality (a Python debugging console, for example). Bug bounty programs will often set the scope as something such as `*.inlanefreight.com`, meaning that all subdomains of `inlanefreight.com`, in this example, are in-scope (i.e., `acme.inlanefreight.com`, `admin.inlanefreight.com`, and so forth and so on). We may also discover subdomains of subdomains. For example, let's assume we discover something along the lines of `admin.inlanefreight.com`. We could then run further subdomain enumeration against this subdomain and perhaps find `dev.admin.inlanefreight.com` as a very enticing target. There are many ways to find subdomains (both passively and actively) which we will cover later in this module.|
|IP ranges|Unless we are constrained to a very specific scope, we want to find out as much about our target as possible. Finding additional IP ranges owned by our target may lead to discovering other domains and subdomains and open up our possible attack surface even wider.|
|Infrastructure|We want to learn as much about our target as possible. We need to know what technology stacks our target is using. Are their applications all ASP.NET? Do they use Django, PHP, Flask, etc.? What type(s) of APIs/web services are in use? Are they using Content Management Systems (CMS) such as WordPress, Joomla, Drupal, or DotNetNuke, which have their own types of vulnerabilities and misconfigurations that we may encounter? We also care about the web servers in use, such as IIS, Nginx, Apache, and the version numbers. If our target is running outdated frameworks or web servers, we want to dig deeper into the associated web applications. We are also interested in the types of back-end databases in use (MSSQL, MySQL, PostgreSQL, SQLite, Oracle, etc.) as this will give us an indication of the types of attacks we may be able to perform.|
|Virtual Hosts|Lastly, we want to enumerate virtual hosts (vhosts), which are similar to subdomains but indicate that an organization is hosting multiple applications on the same web server. We will cover vhost enumeration later in the module as well.|

- with this we can break information gathering process into two main categories 

|Category|Description|
|---|---|
|Passive information gathering|We do not interact directly with the target at this stage. Instead, we collect publicly available information using search engines, whois, certificate information, etc. The goal is to obtain as much information as possible to use as inputs to the active information gathering phase.|
|Active information gathering|We directly interact with the target at this stage. Before performing active information gathering, we need to ensure we have the required authorization to test. Otherwise, we will likely be engaging in illegal activities. Some of the techniques used in the active information gathering stage include port scanning, DNS enumeration, directory brute-forcing, virtual host enumeration, and web application crawling/spidering.|

-  It is always crucial to keep the information that we collected well-organized as we will need various pieces of data as inputs for later phasing of the testing process
- Depending on the type of assessment we are performing we may need to include some of this enumeration data in our final report deliverable 
- When writing up a bug we will only need to include details that are relevant specifically in this scenario the bug we are reporting 
- Keep in mind that it would be worth setting up an account at hackerons perusing the program list and choosing a few targets reproduce all the examples in this module 
- remember that practice makes perfect so continuously practicing these techniques will help hone our craft of information gathering 
- As we get comfortable with these  web tools we will end up developing our own repeatable methodology 
- we will find that we like our tools and specific command line techniques for some phases information gathering we prefer other phases and tools 
- we would then develop our own habit of creating our scripts to automate some of these phases

## Moving on 
- for this module there will be a lot of examples and exercises we will focus on such asd facebook, bug bounty, paypal,  tesla
- also While performing the information gathering examples, we must be sure not to stray from the program scope, which lists in-scope and out-of-scope websites and applications and out-of-scope attacks such as physical security attacks, social engineering, the use of automated vulnerability scanners, man-in-the-middle attacks, etc.

[[info gathering pt2 ]]