### Basic tools 

- `cURL`
- and its flags

### What it is
- we will be sending web requests through two of the most important tools for any web penetration tester, a Web Browser, like Chrome or Firefox, and the `cURL` command line tool.

##### CURL

- [cURL](https://curl.haxx.se/) (client URL) is a command-line tool and library that primarily supports HTTP along with many other protocols.
- makes it a good candidate for scripts as well as automation, making it essential for sending various types of web requests from the command line
- which is necessary for many types of web penetration tests.

```bash
00818@htb[/htb]$ curl inlanefreight.com

<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
...SNIP...
```

- We see that cURL does not render the HTML/JavaScript/CSS code, unlike a web browser, but prints it in its raw format.
- we are mainly interested in the request and response context 
- which usually becomes much faster and more convenient than a web browser.


### Downloading something

- We may also use cURL to download a page or a file and output the content into a file using the `-O` flag. 
- If we want to specify the output file name, we can use the `-o` flag and specify the name.

```bash
00818@htb[/htb]$ curl -O inlanefreight.com/index.html
00818@htb[/htb]$ ls
index.html
```

We can silent the status with the `-s` flag, as follows:

```bash
00818@htb[/htb]$ curl -s -O inlanefreight.com/index.html
```

Finally, we may use the `-h` flag to see what other options we may use with cURL:

```bash
00818@htb[/htb]$ curl -h
Usage: curl [options...] <url>
 -d, --data <data>   HTTP POST data
 -h, --help <category> Get help for commands
 -i, --include       Include protocol response headers in the output
 -o, --output <file> Write to file instead of stdout
 -O, --remote-name   Write output to a file named as the remote file
 -s, --silent        Silent mode
 -u, --user <user:password> Server user and password
 -A, --user-agent <name> Send User-Agent <name> to server
 -v, --verbose       Make the operation more talkative

This is not the full help, this menu is stripped into categories.
Use "--help category" to get an overview of all categories.
Use the user manual `man curl` or the "--help all" flag for all options.
```

### Challenge

- [[HTTP challenge from HTB]]