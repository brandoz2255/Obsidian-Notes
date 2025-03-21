# Hypertext Transfer Protocol Secure (HTTPS)


- `HTTPS` is just the secure version of HTTP it encrypts the data
	- Meaning `HTTP` is just in clear plain text 
- This means that anyone between the source and destination can perform a `Man-in-the-middle` (`MiTM`) attack to view the transferred data.

### What does that mean

[HTTPS (HTTP Secure) protocol](https://tools.ietf.org/html/rfc2660) was created, in which all communications are transferred in an encrypted format
- so even if a third party does intercept the request, they would not be able to extract the data out of it. 
- For this reason, `HTTPS` has become the mainstream scheme for websites on the internet
- HTTP is being phased out, and soon most web browsers will not allow visiting HTTP websites.

### Why HTTP is bad 

If we examine an HTTP request, we can see the effect of not enforcing secure communications between a web browser and a web application. For example, the following is the content of an HTTP login request:

![[Pasted image 20250319154345.png]]

- as we can see from this packet capture using `wireshark` 
- the login credentials can be viewed in clear-text
- makes it easy for someone on the same network (such as a public wireless network) 
- to capture the request and reuse the credentials for malicious purposes

In contrast, when someone intercepts and analyzes traffic from an HTTPS request:

![[Pasted image 20250319154543.png]]

As we can see, the data is transferred as a single encrypted stream

- Websites that enforce `HTTPS` can be identified through `https://` in their URL (e.g. https://www.google.com)
- And the Lock icon in the top left of the browser


**Note:** Although the data transferred through the `HTTPS` protocol may be encrypted, the request may still reveal the visited URL if it contacted a clear-text `DNS` server. For this reason, it is recommended to utilize encrypted `DNS` servers (e.g. 8.8.8.8 or 1.1.1.1), or utilize a `VPN` service to ensure all traffic is properly encrypted.

