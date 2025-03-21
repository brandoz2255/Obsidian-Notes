## cURL for HTTPS

`cURL` should automatically handle all `HTTPS` communication standards and perform a secure handshake and then encrypt and `decrypt` data automatically.
- However, if we ever contact a website with an invalid SSL certificate or an outdated one
- then `cURL` by default would not proceed with the communication to protect against the earlier mentioned `MITM` attacks:

```bash
00818@htb[/htb]$ curl https://inlanefreight.com

curl: (60) SSL certificate problem: Invalid certificate chain
More details here: https://curl.haxx.se/docs/sslcerts.html
...SNIP...
```

- Modern web browsers would do the same, warning the user against visiting a website with an invalid `SSL` certificate.
- We may face such an issue when testing a local web application or with a web application hosted for practice purposes
- We may face such an issue when testing a local web application or with a web application hosted for practice purpose
- To skip the certificate check with cURL, we can use the `-k` flag:

```bash
00818@htb[/htb]$ curl -k https://inlanefreight.com

<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
...SNIP...
```
