A Firewall essentially is what is in charge of monitorying and controling network traffic deciding either to permit or block packets based on its predefined rules. 

- Prevents unauthorized access from the internet and allows packets that is needed from the internet not ones that are unneeded. 
- Such as malware other intrusions 
- Think of a firewall as a security guard only allowing packets that are trusted or specified by the configuration to let in personnel that belong(packets) 

## IP tables 
An IP table is a CLI tool when configuring a firewall we basically specify how the packets should behave when they enter our network traffic

-  Also responsible for what type of network should be permitted or denied onto our system 
- It can also report certain traffic coming in on port from an IP
- Exactly the same as the what the firewall does this is just the process that it is called so it is like a bouncer at a club making sure who is allowed in and who isn't 
- Essentially the Firewall is the bouncer and IP tables is the list of who gets in and who doesn't 

|**Component**|**Description**|
|---|---|
|`Tables`|Tables are used to organize and categorize firewall rules.|
|`Chains`|Chains are used to group a set of firewall rules applied to a specific type of network traffic.|
|`Rules`|Rules define the criteria for filtering network traffic and the actions to take for packets that match the criteria.|
|`Matches`|Matches are used to match specific criteria for filtering network traffic, such as source or destination IP addresses, ports, protocols, and more.|
|`Targets`|Targets specify the action for packets that match a specific rule. For example, targets can be used to accept, drop, or reject packets or modify the packets in another way.|

There are other memthods of doing the bouncer list AKA what packets enter and what packets don't:

`NFTables`: A newer version of the IP tables and more secure in which it doesn't only focus on `IPs` but also `ipv6` `netfilter` frameworks and much more. Also managed the packet filtering better. 

`EX`:  This is like security on a corporate building or government setting in which the guard(`NFTables`) not only checks who gets in but categorizes then based on the rules specified. 

`UFW`: Stands for Uncomplicated firewall which is what it says it is a easy to use CLI interface for setting up a secure firewall has a easier to read syntax for setting up the firewall rules

`EX`: The `UFW` is the coordinator directing guests to the specific line so that the bouncer(`IPtable`) can check them i

`Firewalld`: This is supposed to simplify the firewall setup in Linux in which is uses zones and services to define security

`EX`: Same thing as `UFW` a coordinator but `catagorizes` the the packets coming in and out making it easier for the IPtable(bouncer)

## Tables 

|*Table Name*|*Description*|*Built-in Chains*|
|---|---|---|
|`filter`|Used to filter network traffic based on IP addresses, ports, and protocols.|INPUT, OUTPUT, FORWARD|
|`nat`|Used to modify the source or destination IP addresses of network packets.|PREROUTING, POSTROUTING|
|`mangle`|Used to modify the header fields of network packets.|PREROUTING, OUTPUT, INPUT, FORWARD, POSTROUTING|

### Chains
These are essentially how we specify what in the network traffic should be monitored and filtered twp types of chains exist

- Built in chains
- User defined chains 

## Rules and Targets

|*Target Name*|*Description*|
|---|---|
|`ACCEPT`|Allows the packet to pass through the firewall and continue to its destination|
|`DROP`|Drops the packet, effectively blocking it from passing through the firewall|
|`REJECT`|Drops the packet and sends an error message back to the source address, notifying them that the packet was blocked|
|`LOG`|Logs the packet information to the system log|
|`SNAT`|Modifies the source IP address of the packet, typically used for Network Address Translation (NAT) to translate private IP addresses to public IP addresses|
|`DNAT`|Modifies the destination IP address of the packet, typically used for NAT to forward traffic from one IP address to another|
|`MASQUERADE`|Similar to SNAT but used when the source IP address is not fixed, such as in a dynamic IP address scenario|
|`REDIRECT`|Redirects packets to another port or IP address|
|`MARK`|Adds or modifies the Netfilter mark value of the packet, which can be used for advanced routing or other purposes|

- Let us illustrate a rule and consider that we want to add a new entry to the INPUT chain that allows incoming TCP traffic on port 22 (SSH) to be accepted. The command for that would look like the following:

```shell-session
00818@htb[/htb]$ sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
```

# Matches 
This is just what allows whether a firewall should be applied to the specified packet or connection 

|*Match Name*|*Description*|
|---|---|
|`-p` or `--protocol`|Specifies the protocol to match (e.g. tcp, udp, icmp)|
|`--dport`|Specifies the destination port to match|
|`--sport`|Specifies the source port to match|
|`-s` or `--source`|Specifies the source IP address to match|
|`-d` or `--destination`|Specifies the destination IP address to match|
|`-m state`|Matches the state of a connection (e.g. NEW, ESTABLISHED, RELATED)|
|`-m multiport`|Matches multiple ports or port ranges|
|`-m tcp`|Matches TCP packets and includes additional TCP-specific options|
|`-m udp`|Matches UDP packets and includes additional UDP-specific options|
|`-m string`|Matches packets that contain a specific string|
|`-m limit`|Matches packets at a specified rate limit|
|`-m conntrack`|Matches packets based on their connection tracking information|
|`-m mark`|Matches packets based on their Netfilter mark value|
|`-m mac`|Matches packets based on their MAC address|
|`-m iprange`|Matches packets based on a range of IP addresses|


```shell-session
00818@htb[/htb]$ sudo iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
```

- Specifies the matches available 

