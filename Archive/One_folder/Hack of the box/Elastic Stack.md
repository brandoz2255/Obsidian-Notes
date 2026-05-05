The Elastic Stack refers to an open source software that uses three main components for a  `SIEM` solution These three components work in harmony :

![[Screenshot from 2023-11-23 13-03-51.png]]

- `Elasticsearch`:  This is the search engine designed with RESTful APIs it is the core component and handles the indexing storing and querying.  Must use logstash after this
- `Logstash`:  This handles the data you put into Elastic Stack  like a the handling collecting and transforming log file records:
	- **Process Input**: Gets the data form a remote location and formats it in the way a machine can read it with the input methods 
	- **Transform and enrich log records**:  the methods used to modify a log records format many plugins allow this 
	- **Send log records to Elasticsearch:** uses the previous two to send it to Elastic search 
- `Kibana`: The file explorer for the Data in Elasticsearch
- `Beats`: This essentially simplifies the processes mentioned earlier

## SIEM Solution 
- Elastic Stack can be used as a SIEM Soluton using the Logstach method for getting data from Firefalls or IDS/IPS 
- Elasticsearch should index said data and then kibana be used to navigate the logged incidents 
- We are going to go more in depth with kibana since a Blue teamer we must look at the incident data and navigate through it 

##### Kibana Query Langauge (KQL)
- is the powerful user friendly language in the Kibana interface designed specifically for looking at and analyzing data in Kibana. 
- **Basic structure**: `KQL` uses `field:value`  to represent data and the data we look for 
- In windows system we can use Elasticsearch index to look at our system if any one has try to log in and look for source of the potential threats. 
- KQL Allows for free text search without us having to use a specific term to search for example we can type 

```shell-session
"svc-sql1"
```

- For more complex queires we use Logical operator 

```shell-session
event.code:4625 AND winlog.event_data.SubStatus:0xC0000072
```

- This command represents the sytnax mentioned earlier such as the field being the event code and value being the code it self
- Here we look up if any one has fail log in attempts  
- same thing goes for the second half except we ae looking for values that present if the account is disabled
- Comparison Operators: Would compare this to C++ but its slightly different so its not the same its used on this syntax `:`, `:>`, `:>=`, `:<`, `:<=`, `:!`

```shell-session
event.code:4625 AND winlog.event_data.SubStatus:0xC0000072 AND @timestamp >= "2023-03-03T00:00:00.000Z" AND @timestamp <= "2023-03-06T23:59:59.999Z"
```

- Here we filter data with the event code of failed log in attempts where the user name is admin or anything related to that
## How to identify Available Data
- To idenfy failed log in attempts between the itnerval of march 3rd and march 6th we must use the following syntax --> 

```shell-session
event.code:4625 AND winlog.event_data.SubStatus:0xC0000072 AND @timestamp >= "2023-03-03T00:00:00.000Z" AND @timestamp <= "2023-03-06T23:59:59.999Z"
```

- We should also utulize the Free text search system in KQL to explore data of failed attemps and other security data
- Useful [source](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/event.aspx?eventid=4625)
Using KQL's free text search we can search for "4625". In the returned records we notice event.code:4625, winlog.event_id:4625, and @timestamp

    event.code is related to the Elastic Common Schema (ECS)
    winlog.event_id is related to Winlogbeat 
    @timestamp typically contains the time extracted from the original event and it is different from event.created

[[Challenge.Elastic]]