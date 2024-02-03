In order to effiectively defend our system from a DOS and DDOS attack we must first secure and config our machine from ping probes. 

```
sudo iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
```

- We can do so with this following command it blocks and drops ip ping probes form attacking machines 

#### Next step 
- Configure Snort a open source NIDS system detects and alerts the user of intrusion all various types 

```Bash
sudo apt-get install snort

```

- We can install Snort with the following command 
- Then we edit Snort properly to configure it to our needs we do this in the  `.conf` path is usually `/etc/snort/snort.conf` 

### Config
When configuring snort  we should define the type of traffic anylissis it should perform and capture how ti should handle said threats 

- The HOME_NET is how we can define the network we are tasked with monitoring we would need to set the home net to the ip address our ip 

- `etc/snort/rules` and `etc/snort/so_rules/` need to be configured with our own custom rules more on how to configure these later just note this is part of the process 

- Pre-processors Rules are scripts that basically parse packet data and generate the metadata that is used in detection rules  
	- Some examples are the `http_inspec` , `ftp_server`, and `smtp` Pre-processors

Output Plugins: these are plugins that which define where snorts sends  alerts such common outputs are `alert_fasting`, `alert_full`, and `alert_syslog` each plugin can be configured with different options. 


- Where rules are located in snort is in the local.rules
- `include $RULE_PATH/local.rules ` modify this line this is how can configure 

```Bash
# Define the home network
ipvar HOME_NET 192.168.1.0/24

# Enable preprocessors
preprocessor http_inspect: global iis_unicode_map unicode.map 1252
preprocessor http_inspect_server: server default

# Specify output plugins
output alert_fastlog: /var/log/snort/fastlog.txt
output alert_full: /var/log/snort/fulllog.txt

# Include rule files
include $RULE_PATH/local.rules

```

- Also we should create a unicode.map in the /etc/snort/ path file for maping the unicode 
- Also important we should change the IP address of our network the one we are defending

For more info [source](https://www.howtogeek.com/devops/how-to-use-the-snort-intrusion-detection-system-on-linux/) [source 2](https://docs.snort.org/start/configuration)

