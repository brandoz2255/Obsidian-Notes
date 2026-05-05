# Passive subdomain Enumeration 

Subdomain enumeration results in the process of mapping all the available subdomains giving a domain name. This helps increase our attack surface and may uncover the hidden management back end panels or intranet web applications that network administrators keep hidden using the security is obscurity mindset
	- For now since this of course a passive subdomain enumeration we will only use the available third party resources available to us

# VirusTotal
- VirusTotal is s site in which acts like the sublist3rn we learned about in the [[Subdomain_enumeration.vid]] video essentially we just type our domain we want to look at and boom click relations and we got it there all the subdomains
	- How this site works is it was developed forr the purpose opfn preserving[ DNS resolutions ] which were made for when a users visits a URL 
### Certificates 
Another method we can use to locate subdomains within  a given domain is of course using SSL and TLS certificates 

- The main reason certificates would be helpful is such that certificate transparency which is a project that is required by every  SSL and TLS service issued by the Certificate Authority which needs to be published publically 
- we can view the CT logs to discover additional domain names and subdomains by usingg these sources  [csnsy.io](https://censys.com/) and [crt.sh](https://crt.sh/)

Using these sites we would navigate through it to the search bar and look up our domain of choice and start discorvering subdomains 
- However using websites is cool and all but we can gather more information and organize them  better using other methods 

# Certificate Transparency 
```shell-session
00818@htb[/htb]$ export TARGET="facebook.com"
00818@htb[/htb]$ curl -s "https://crt.sh/?q=${TARGET}&output=json" | jq -r '.[] | "\(.name_value)\n\(.common_name)"' | sort -u > "${TARGET}_crt.sh.txt"
```

```shell-session
00818@htb[/htb]$ head -n20 facebook.com_crt.sh.txt

*.adtools.facebook.com
*.ak.facebook.com
*.ak.fbcdn.net
*.alpha.facebook.com
*.assistant.facebook.com
*.beta.facebook.com
*.channel.facebook.com
*.cinyour.facebook.com
*.cinyourrc.facebook.com
*.connect.facebook.com
*.cstools.facebook.com
*.ctscan.facebook.com
*.dev.facebook.com
*.dns.facebook.com
*.extern.facebook.com
*.extools.facebook.com
*.f--facebook.com
*.facebook.com
*.facebookcorewwwi.onion
*.facebookmail.com
```

|   |   |
|---|---|
|`curl -s`|Issue the request with minimal output.|
|`https://crt.sh/?q=<DOMAIN>&output=json`|Ask for the json output.|
|`jq -r '.[]' "\(.name_value)\n\(.common_name)"'`|Process the json output and print certificate's name value and common name one per line.|
|`sort -u`|Sort alphabetically the output provided and removes duplicates.|

- This is how we get Certificates via from our terminal 
- We could also perform this by using a OpenSSL
```shell-session
00818@htb[/htb]$ export TARGET="facebook.com"
00818@htb[/htb]$ export PORT="443"
00818@htb[/htb]$ openssl s_client -ign_eof 2>/dev/null <<<$'HEAD / HTTP/1.0\r\n\r' -connect "${TARGET}:${PORT}" | openssl x509 -noout -text -in - | grep 'DNS' | sed -e 's|DNS:|\n|g' -e 's|^\*.*||g' | tr -d ',' | sort -u

*.facebook.com
*.facebook.net
*.fbcdn.net
*.fbsbx.com
*.m.facebook.com
*.messenger.com
*.xx.fbcdn.net
*.xy.fbcdn.net
*.xz.fbcdn.net
facebook.com
messenger.com
```

# Automating passive Subdomain Enumeration 

Since all we have done so far is using third party sites and to get useful information without directly interacting with the site and their infrastructure. now it is time for us enumerate using tools and previously mentioned information 

# The harvester 
This is an easy to use tool and veryu effective especially in the first step of penetration testing andn red team engagements 
- we can use this tool to gather information to help iddentify a companys attack surface  
- The tool collects `emails`, `names`, `subdomains`, `IP addresses`, and `URLs` using varous available public data 

|   |   |
|---|---|
|[Baidu](http://www.baidu.com/)|Baidu search engine.|
|`Bufferoverun`|Uses data from Rapid7's Project Sonar - [www.rapid7.com/research/project-sonar/](http://www.rapid7.com/research/project-sonar/)|
|[Crtsh](https://crt.sh/)|Comodo Certificate search.|
|[Hackertarget](https://hackertarget.com/)|Online vulnerability scanners and network intelligence to help organizations.|
|`Otx`|AlienVault Open Threat Exchange - [https://otx.alienvault.com](https://otx.alienvault.com/)|
|[Rapiddns](https://rapiddns.io/)|DNS query tool, which makes querying subdomains or sites using the same IP easy.|
|[Sublist3r](https://github.com/aboul3la/Sublist3r)|Fast subdomains enumeration tool for penetration testers|
|[Threatcrowd](http://www.threatcrowd.org/)|Open source threat intelligence.|
|[Threatminer](https://www.threatminer.org/)|Data mining for threat intelligence.|
|`Trello`|Search Trello boards (Uses Google search)|
|[Urlscan](https://urlscan.io/)|A sandbox for the web that is a URL and website scanner.|
|`Vhost`|Bing virtual hosts search.|
|[Virustotal](https://www.virustotal.com/gui/home/search)|Domain search.|
|[Zoomeye](https://www.zoomeye.org/)|A Chinese version of Shodan.|

- This literally works in the same method that the sublist3r does inb the video [[Subdomain_enumeration.vid]] 
- however the difference is that we must automate this task on our end in order for it to work 
```shell-session
00818@htb[/htb]$ cat sources.txt

baidu
bufferoverun
crtsh
hackertarget
otx
projecdiscovery
rapiddns
sublist3r
threatcrowd
trello
urlscan
vhost
virustotal
zoomeye
```

- Now that we have this file we can execuite the following commands to gather information 
```shell-session
00818@htb[/htb]$ export TARGET="facebook.com"
00818@htb[/htb]$ cat sources.txt | while read source; do theHarvester -d "${TARGET}" -b $source -f "${source}_${TARGET}";done

<SNIP>
*******************************************************************
*  _   _                                            _             *
* | |_| |__   ___    /\  /\__ _ _ ____   _____  ___| |_ ___ _ __  *
* | __|  _ \ / _ \  / /_/ / _` | '__\ \ / / _ \/ __| __/ _ \ '__| *
* | |_| | | |  __/ / __  / (_| | |   \ V /  __/\__ \ ||  __/ |    *
*  \__|_| |_|\___| \/ /_/ \__,_|_|    \_/ \___||___/\__\___|_|    *
*                                                                 *
* theHarvester 4.0.0                                              *
* Coded by Christian Martorella                                   *
* Edge-Security Research                                          *
* cmartorella@edge-security.com                                   *
*                                                                 *
*******************************************************************


[*] Target: facebook.com

[*] Searching Urlscan.

[*] ASNS found: 29
--------------------
AS12578
AS13335
AS13535
AS136023
AS14061
AS14618
AS15169
AS15817

<SNIP>
```

Now once its done we can get the subdomains and sort through with them using the following command 

```shell-session
00818@htb[/htb]$ cat *.json | jq -r '.hosts[]' 2>/dev/null | cut -d':' -f 1 | sort -u > "${TARGET}_theHarvester.txt"
```

now we can merge our files by:
```shell-session
00818@htb[/htb]$ cat facebook.com_*.txt | sort -u > facebook.com_subdomains_passive.txt
00818@htb[/htb]$ cat facebook.com_subdomains_passive.txt | wc -l

11947
```
