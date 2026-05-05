When scanning for services on a network the ports of 80 and 443 will often be found these ports are valuable targets for pent testing. 
* [[Gobusteer]]: after discovering a web application it is always worth checking if we could find any hidden files or directories on the webserver 
* *Gobuster* is a useful tool to perfomr sugoch actions we could also use **ffuf** 
* [Directory/ File Enumeration]
* **Gobuster** is a versatile tool that allows for perfomring DNS, vhost, and directory brute-forcing. 
* The tool has additional functionality such as enumeration of AWS S3 buckets 
* we are interest in directory and brute-forcing modes with the **dir** 
* Wordpress is the most commonly 
```shell-session
00818@htb[/htb]$ gobuster dir -u http://10.10.10.121/ -w /usr/share/dirb/wordlists/common.txt

===============================================================
Gobuster v3.0.1
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@_FireFart_)
===============================================================
[+] Url:            http://10.10.10.121/
[+] Threads:        10
[+] Wordlist:       /usr/share/dirb/wordlists/common.txt
[+] Status codes:   200,204,301,302,307,401,403
[+] User Agent:     gobuster/3.0.1
[+] Timeout:        10s
===============================================================
2020/12/11 21:47:25 Starting gobuster
===============================================================
/.hta (Status: 403)
/.htpasswd (Status: 403)
/.htaccess (Status: 403)
/index.php (Status: 200)
/server-status (Status: 403)
/wordpress (Status: 301)
===============================================================
2020/12/11 21:47:46 Finished
===============================================================
```

* An HTTPS status code of 200 reveals that the resources request wass successful

## DNS Subdomain Enumeration
```shell-session
00818@htb[/htb]$ git clone https://github.com/danielmiessler/SecLists
```
* There are also essential resources on subdomains that could be exploited such as admin panels or applications
* **GoBuster** can be used to enumerate available subdomains of a given domain using **dns** example 
```shell-session
00818@htb[/htb]$ git clone https://github.com/danielmiessler/SecLists
```
* We cloned the [[SecList]] github  repo ^ Then isntalled said SecLis 
```shell-session
00818@htb[/htb]$ sudo apt install seclists -y
```
Go buster and DNS 
```shell-session
gobuster dns -d inlanefreight.com -w /usr/share/SecLists/Discovery/DNS/namelist.txt
```
## Web Enumeration Tips
*  cURL can be used to retieve server header information which is another tool for pent testing 
```shell-session
00818@htb[/htb]$ curl -IL https://www.inlanefreight.com
```
[[Eyewitness8]]

* [Whatweb][]  can be used to extract versions of web servers, supporting frameworks, and applications.  We can search for potential vulnerabilities
*  

[[Web enemuration challenge]]




kl