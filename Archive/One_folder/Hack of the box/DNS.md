#  What is a DNS

DNS stands for Domain Name system and it basically acts like the phone book for the internet. It is essentially the way people can navigate the web without having toi manually typeout the IP of the site 
	- When we look upp something in the internet we type out the Domain like hackthebox.com or google.com  but the search engine we use translate the DNS server into something the computer can read which is the IP address like 192.168.0.0 for example
	- That is how our web browsers communicate with web servers such as the ones mentioned 
	- This was designed for easier use of the Internet so that people don't have to manually type out the IP address each time we look up something 

==Essentially how it works is that DNS converts the IP address because each device that is connected to the internet has a specific IP address==
	- The purpose of DNS servers
		- It allows names to be used instead of numbers to identify hosts.
		- It is a lot easier to remember a name than it is to recall a number.
		- By merely retargeting a name to the new numeric address, a server can change numeric addresses without having to notify everyone on the Internet.
		- A single name might refer to several hosts splitting the workload between different servers.

There is of course a sytem heirarchy in the DNS system like most things in tech the  root of the DNS is of course unamed. The top level of Domains is known as a TLD server which stands for the ==Top level Doomain== 
- What a TLD is essentially is just the ending of a DNS server for example www.facebook.com the TLD is the `com` at the end
- Most TLDs are controled by the country that the server is stated in in and aer deletgated specifically the country get the codes from this [table](https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes) 
- The ones managed by the United Nations are called country code TLDs aka ccTLDs \

The nons sepcial ones that have the country codes are called generic and they have the gTLDs name which are essentially not controlled by the country code like the others these ones aren't assigned to a specific country code. In order to  manage a TLDs we would need to set up a SLD aka Second level Domain and of course lower Domains

|   |   |
|---|---|
|`Resource Record`|A domain name, usually a fully qualified domain name, is the first part of a Resource Record. If you don't use a fully qualified domain name, the zone's name where the record is located will be appended to the end of the name.|
|`TTL`|In seconds, the Time-To-Live (`TTL`) defaults to the minimum value specified in the SOA record.|
|`Record Class`|Internet, Hesiod, or Chaos|
|`Start Of Authority` (`SOA`)|It should be first in a zone file because it indicates the start of a zone. Each zone can only have one `SOA` record, and additionally, it contains the zone's values, such as a serial number and multiple expiration timeouts.|
|`Name Servers` (`NS`)|The distributed database is bound together by `NS` Records. They are in charge of a zone's authoritative name server and the authority for a child zone to a name server.|
|`IPv4 Addresses` (`A`)|The A record is only a mapping between a hostname and an IP address. 'Forward' zones are those with `A` records.|
|`Pointer` (`PTR`)|The PTR record is a mapping between an IP address and a hostname. 'Reverse' zones are those that have `PTR` records.|
|`Canonical Name` (`CNAME`)|An alias hostname is mapped to an `A` record hostname using the `CNAME` record.|
|`Mail Exchange` (`MX`)|The `MX` record identifies a host that will accept emails for a specific host. A priority value has been assigned to the specified host. Multiple MX records can exist on the same host, and a prioritized list is made consisting of the records for a specific host.|

# Nslookup and DIG 
During a pent test we may be requested to identify the infrasturcre of the publically available information on our orgnazations IP and DNS. Doing this we may be required to dinf out the many different types requests we can do this by using a tool called `Nslookup` 
- This tool allows the user to look up different types ofb DNS requests and look at other Domains as well 
```shell-session
00818@htb[/htb]$ export TARGET="facebook.com"
00818@htb[/htb]$ nslookup $TARGET

Server:		1.1.1.1
Address:	1.1.1.1#53

Non-authoritative answer:
Name:	facebook.com
Address: 31.13.92.36
Name:	facebook.com
Address: 2a03:2880:f11c:8083:face:b00c:0:25de
```

DIG is another tool we can use too find information we need as well the only difference with DIG we can find more specified information that can also be important 

```shell-session
00818@htb[/htb]$ dig facebook.com @1.1.1.1

; <<>> DiG 9.16.1-Ubuntu <<>> facebook.com @1.1.1.1
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 58899
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;facebook.com.                  IN      A

;; ANSWER SECTION:
facebook.com.           169     IN      A       31.13.92.36

;; Query time: 20 msec
;; SERVER: 1.1.1.1#53(1.1.1.1)
;; WHEN: Mo Okt 18 16:03:17 CEST 2021
;; MSG SIZE  rcvd: 57
```

[[Other use examples ]]

[[DNS.lit]]

[[subdomain enumeration]]
[[infrastructure enumeration]]]