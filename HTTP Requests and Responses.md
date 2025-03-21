HTTP communications mainly consist of an HTTP request and an HTTP response. An HTTP request is made by the client (e.g. `cURL`/browser), and is processed by the server (e.g. web server).

## HTTP Request

Let's start by examining the following example HTTP request:

![[Pasted image 20250319160346.png]]

The image above shows an HTTP GET request to the URL:

- `http://inlanefreight.com/users/login.html`

| **Field** | **Example**         | **Description**                                                                                                       |
| --------- | ------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `Method`  | `GET`               | The HTTP method or verb, which specifies the type of action to perform.                                               |
| `Path`    | `/users/login.html` | The path to the resource being accessed. This field can also be suffixed with a query string (e.g. `?username=user`). |
| `Version` | `HTTP/1.1`          | The third and final field is used to denote the HTTP version.                                                         |

The next set of lines contain HTTP header value pairs, like `Host`, `User-Agent`, `Cookie`

**Note:** HTTP version 1.X sends requests as clear-text, and uses a new-line character to separate different fields and different requests. HTTP version 2.X, on the other hand, sends requests as binary data in a dictionary form.

## HTTP Response

Once the server processes our request, it sends its response. The following is an example HTTP response:

![[Pasted image 20250319161054.png]]


The first being the `HTTP version` (e.g. `HTTP/1.1`), and the second denotes the `HTTP response code` (e.g. `200 OK`).


## cURL

In our earlier examples with cURL, we only specified the URL and got the response body in return. However, cURL also allows us to preview the full HTTP request and the full HTTP responses
- To view the full HTTP request and response, we can simply add the `-v` verbose flag

```bash
00818@htb[/htb]$ curl inlanefreight.com -v

*   Trying SERVER_IP:80...
* TCP_NODELAY set
* Connected to inlanefreight.com (SERVER_IP) port 80 (#0)
> GET / HTTP/1.1
> Host: inlanefreight.com
> User-Agent: curl/7.65.3
> Accept: */*
> Connection: close
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 401 Unauthorized
< Date: Tue, 21 Jul 2020 05:20:15 GMT
< Server: Apache/X.Y.ZZ (Ubuntu)
< WWW-Authenticate: Basic realm="Restricted Content"
< Content-Length: 464
< Content-Type: text/html; charset=iso-8859-1
< 
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>

...SNIP...
```

- The request simply sent `GET / HTTP/1.1` along with the `Host`, `User-Agent` and `Accept` headers. In return, the HTTP response contained the `HTTP/1.1 401 Unauthorized`

**Exercise:** The `-vvv` flag shows an even more verbose output. Try to use this flag to see what extra request and response details get displayed with it.

## Browser DevTools

Most modern web browsers come with built-in developer tools (`DevTools`), which are mainly intended for developers to test their web applications.

- However, as web penetration testers, these tools can be a vital asset in any web assessment we perform
- as a browser (and its `DevTools`) are among the assets we are most likely to have in every web assessment exercise. 

To open the browser `devtools` in either Chrome or Firefox, we can click [`CTRL+SHIFT+I`] or simply click [`F12`]. The `devtools` contain multiple tabs

### Challenge

- [[HTTP Request challenge]]