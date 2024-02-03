One of the most important skillset one can have with linux is the ability to set up web servers. Since there are so many different ways one cane set up a web server in Linux 

- One of the most used servers besides IIS and Nginx is the webserver Apache 
- Apache is the most widely used for there use of appropriate modules which can encrypt the communication between the browser and the web server
- Apache is also popular for its use of scripting lanugages on the serverside such as **PHP, Perl or Ruby.** Other langueages are also used such as **Python, Javascript, Lua and .NET** 
```shell-session
00818@htb[/htb]$ apt install apache2 -y

Reading package lists... Done
Building dependency tree       
Reading state information... Done
Suggested packages:
  apache2-doc apache2-suexec-pristine | apache2-suexec-custom
The following NEW packages will be installed:
  apache2
0 upgraded, 1 newly installed, 0 to remove and 17 not upgraded.
Need to get 95,1 kB of archives.
After this operation, 535 kB of additional disk space will be used.
Get:1 http://de.archive.ubuntu.com/ubuntu bionic-updates/main amd64 apache2 amd64 2.4.29-1ubuntu4.13 [95,1 kB]
Fetched 95,1 kB in 0s (270 kB/s)   
<SNIP>
```
- This is how we can install the Apache Webserver 
- After installing the webserver we must go to web browser and naviagete to the usual default which is http://localhost 

# cURL
This program makes a comeback we know the gist of what this does but lets dig deeper this tool allows for the user to transfer file to and from the shell over the web server protocols such as `HTTP`, `HTTPS`, `FTP`, `SFTP`, `FTPS`, or `SCP`. 

- Usually cURL is isntalled on most systems but if it isnt download it 
- This tool essentially allow us to test the website remotely we can also look at individual requests 

```shell-session
00818@htb[/htb]$ curl http://localhost

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <!--
    Modified from the Debian original for Ubuntu
    Last updated: 2016-11-16
    See: https://launchpad.net/bugs/1288690
  -->
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Apache2 Ubuntu Default Page: It works</title>
    <style type="text/css" media="screen">
...SNIP...
```

-  We can se that it is same text as the browser however it is the source code of the browser the same thing can be acheived when using ctrl u or f12 keys 

# Wget 
We used this before and we know mostly of what this does but with tool we can get downloaded files from the FTP or HTTP servers directly from our terminal this serves a good download manager. 

```shell-session
00818@htb[/htb]$ wget http://localhost

--2020-05-15 17:43:52--  http://localhost/
Resolving localhost (localhost)... 127.0.0.1
Connecting to localhost (localhost)|127.0.0.1|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 10918 (11K) [text/html]
Saving to: 'index.html'

index.html                 100%[=======================================>]  10,66K  --.-KB/s    in 0s      

2020-05-15 17:43:52 (33,0 MB/s) - ‘index.html’ saved [10918/10918]
```

With this Syntax used we can see that the index html was downloaded straigh from the site its basically going to display the same contents of cURL but we have it downloaded. 

- Alternatively this can be used to download contents the only thing we need to know is the directories of the site and we can essentially download it 

# Python 3 
[[Python]] FInally we can connect the HTB  modules and the CSE side of my life essentially there are many uses of the programming language in thje Cyber side such as creating cron jobs and virus's other cool programs and setting up web servers via Python 3. 

For this case Python 3 is also another option we can use instead of cURL and wget the cool thing about python is its ability to do anything we can get info froma  site using the -m option 

```shell-session
00818@htb[/htb]$ python3 -m http.server
```

```shell-session

Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
```

```shell-session
00818@htb[/htb]$ python3 -m http.server

Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
127.0.0.1 - - [15/May/2020 17:56:29] "GET /readme.html HTTP/1.1" 200 -
127.0.0.1 - - [15/May/2020 17:56:29] "GET /wp-admin/css/install.css?ver=20100228 HTTP/1.1" 200 -
127.0.0.1 - - [15/May/2020 17:56:29] "GET /wp-admin/images/wordpress-logo.png HTTP/1.1" 200 -
127.0.0.1 - - [15/May/2020 17:56:29] "GET /wp-admin/images/wordpress-logo.svg?ver=20131107 HTTP/1.1" 200 -
```

# NPM 
NPM is a package manager in Linux that essentially us top download a basic web server package.  It stands for the Node Package Manager This is used widely for just the Javascript projects on the server side. 

- Here are some use full commands this one is for the installation fo the http server 

```Shell-session
npm install -g http-server
```
- The -g flag means that it allows for global installation
- We can start the HTTP server with the following command 

```Shell-session 
http-server -p 8080
```


# PHP 
This one is essentially the PHP version of the NPM and Python3 im guessing that each server side scripting language has its own method of downloadign server information. 

- Here is an example of setting up a simple HTTP server with the php command that starts with the ip of 127.0.0.1 on port 8080

```shell-session
php -S 127.0.0.1:8080
```

