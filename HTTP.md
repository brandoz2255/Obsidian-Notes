- [HTTP](https://tools.ietf.org/html/rfc2616) is an application-level protocol used to access the World Wide Web resources. 
- The term `hypertext` stands for text containing links to other resources and text that the readers can easily interpret.
- The default port for HTTP communication is port `80`, though this can be changed to any other port, depending on the web server configuration.

#### How it works 

- The same requests are utilized when we use the internet to visit different websites. We enter a `Fully Qualified Domain Name` (`FQDN`) as a `Uniform Resource Locator` (`URL`) to reach the desired website, like [www.hackthebox.com](http://www.hackthebox.com).
- Resources over HTTP are accessed via a `URL`, which offers many more specifications than simply specifying a website we want to visit. Let's look at the structure of a URL:

![[Pasted image 20250319151143.png]]

This is what each component stands for:

|**Component**|**Example**|**Description**|
|---|---|---|
|`Scheme`|`http://` `https://`|This is used to identify the protocol being accessed by the client, and ends with a colon and a double slash (`://`)|
|`User Info`|`admin:password@`|This is an optional component that contains the credentials (separated by a colon `:`) used to authenticate to the host, and is separated from the host with an at sign (`@`)|
|`Host`|`inlanefreight.com`|The host signifies the resource location. This can be a hostname or an IP address|
|`Port`|`:80`|The `Port` is separated from the `Host` by a colon (`:`). If no port is specified, `http` schemes default to port `80` and `https` default to port `443`|
|`Path`|`/dashboard.php`|This points to the resource being accessed, which can be a file or a folder. If there is no path specified, the server returns the default index (e.g. `index.html`).|
|`Query String`|`?login=true`|The query string starts with a question mark (`?`), and consists of a parameter (e.g. `login`) and a value (e.g. `true`). Multiple parameters can be separated by an ampersand (`&`).|
|`Fragments`|`#status`|Fragments are processed by the browsers on the client-side to locate sections within the primary resource (e.g. a header or section on the page).|

![[Pasted image 20250319151404.png]]

- The diagram above presents the anatomy of an HTTP request at a very high level. The first time a user enters the URL (`inlanefreight.com`) into the browser, it sends a request to a `DNS` (`Domain Name System`) server to resolve the domain and get its IP.
- The `DNS` server looks up the IP for `inlanefreight.com` and returns it 
- All domains need to be handled this way

**Note:** Our browsers usually first look up records in the local `/etc/hosts` file, and if the requested domain does not exist within it, then they would contact other DNS servers. We can use the `/etc/hosts` to manually add records to for DNS resolution, by adding the IP followed by the domain name.

- Once the browser gets the IP address linked to the requested domain, it sends a `GET` request to the default HTTP port (e.g. `80`), asking for the root `/` path. 
- Then, the web server receives the request and processes it. 
- By default, servers are configured to return an index file when a request for `/` is received.

