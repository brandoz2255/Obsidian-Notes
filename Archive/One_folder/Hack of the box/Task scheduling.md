Task scheduling is uniqe feature in Linux that allows users to schedule and automate tasks that they want within the Linux system similar or is the same as the cron jobs in Linux 
	- Whats about this feature we can set a specific time for these tasks to run like a specific schedule and and a specific frequency 
	- This was made so that the user doesn't have to start the tasks manuelly by them selves

# Systemd
Since this ends with the letter d [[System ctl]] as mentioned in another note this service would be a *daemon*. However lets not get off topic this is a service used in linux systems and distros that starts these said process at a specific frequency and time. 
- We could also set them to happen within **specific time** and ***time interval***
- We could also specify **the events** that will trigger these said process during the said event
- Of course like many computer operated systems we need to take **precautions** while performing such operations 

1. Create a timer
2. Create a service
3. Activate the timer

**These are the necessary precautions we need to focus on before we schedule a task in Linux ^**

### How to
Schedulign tasks are done via CLI like many complex tasks in linux however in order to create the tasks we need must first create the directory that the task will be stored in for ***example***

```shell-session
00818@htb[/htb]$ sudo mkdir /etc/systemd/system/mytimer.timer.d
00818@htb[/htb]$ sudo vim /etc/systemd/system/mytimer.timer
```

**Now we must make a bash script that would configure the task"**: The following is the general rules for making this script: 
- "Unit", "Timer" and "Install". The "Unit" option specifies a description for the timer. The "Timer" option specifies when to start the timer and when to activate it. Finally, the "Install" option specifies where to install the timer. 
- Lets say for example --> 
Code: txt

```txt
[Unit]
Description=My Timer

[Timer]
OnBootSec=3min
OnUnitActiveSec=1hour

[Install]
WantedBy=timers.target
```

This script all depends on the idea of how we actually want to use our script or task
- Like for example if we would want to run our script only once our system has just booted we would use the `OneBootSec` and set the timeer in the `Timer` setting 
- Alternatively if we want to use it normally we would use the `OnUnitActiveSec` statement which runs the script at regular intervals

## Creating a service

```shell-session
00818@htb[/htb]$ sudo vim /etc/systemd/system/mytimer.service
```

With this command we can specify the full path that we would want the our script to run in. The `multi-user.target` is the unit system that is activated when starting a normal multi-user mode. 

***Code: txt***

```txt
[Unit]
Description=My Service

[Service]
ExecStart=/full/path/to/my/script.sh

[Install]
WantedBy=multi-user.target
```

Then we must let the systemd service read the folders in order to include the changes 

-  **Then we would reload the service** 
```shell-session
00818@htb[/htb]$ sudo systemctl daemon-reload
```

- **and then set the timer**

```shell-session
00818@htb[/htb]$ sudo systemctl start mytimer.service
00818@htb[/htb]$ sudo systemctl enable mytimer.service
```


# Cron
Now we are on the topic we have discussed earlier in this note now we now that they systemd is just a similar tool like the one used prevously We know a Cron job is just what we have descriobed allowing a list of tasks or services  to be automated by Linux. 

- Similar to what we have done before its just now we need to write a script that tells cron to do this specific task at a specific time 
- The Difference between the two is the set up setting a *Cron* is different 
- First we would need to make a file called crontab and then tell the daemon when to run the task
- That is when we can configure the Daemon accordingly 

|**Time Frame**|**Description**|
|---|---|
|Minutes (0-59)|This specifies in which minute the task should be executed.|
|Hours (0-23)|This specifies in which hour the task should be executed.|
|Days of month (1-31)|This specifies on which day of the month the task should be executed.|
|Months (1-12)|This specifies in which month the task should be executed.|
|Days of the week (0-7)|This specifies on which day of the week the task should be executed.|

**Example of script**

***Code: txt***

```txt
# System Update
* */6 * * /path/to/update_software.sh

# Execute scripts
0 0 1 * * /path/to/scripts/run_scripts.sh

# Cleanup DB
0 0 * * 0 /path/to/scripts/clean_database.sh

# Backups
0 0 * * 7 /path/to/scripts/backup.sh
```


- With this script the system update should executed every 6th hour we can tell by the `*/6*` statement in the fourth column 
- In column one we can see that this task is executed on every first day of the month on midnight .
- This is indicated by the entries `0` and `0` in the minute and hour columns and `1` in the days-of-the-month column
- The third task is then executed every Sunday at midnight

In conclusion these are two tools that we can use to set up tasks in Linux so that we don't have to manually do them ourselves however the only difference is how they are set up. 