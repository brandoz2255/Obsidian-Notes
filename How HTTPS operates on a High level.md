## HTTPS Flow

![[Pasted image 20250319155021.png]]

- If we type `http://` instead of `https://` to visit a website that enforces `HTTPS`, the browser attempts to resolve the domain and redirects the user to the `webserver` hosting the target website.
- A request is sent to port `80` first, which is the unencrypted HTTP protocol. 
- The server detects this and redirects the client to secure HTTPS port `443` instead. 
- This is done via the `301 Moved Permanently` response code, which we will discuss in an upcoming section. 

### How it works 

Next, the client (web browser) sends a "client hello" packet, giving information about itself. After this, the server replies with "server hello", followed by a [key exchange](https://en.wikipedia.org/wiki/Key_exchange) to exchange SSL certificates.

- The client verifies the key/certificate and sends one of its own. After this, an encrypted [handshake](https://www.cloudflare.com/learning/ssl/what-happens-in-a-tls-handshake) is initiated to confirm whether the encryption and transfer are working correctly.

**Note:** Depending on the circumstances, an attacker may be able to perform an `HTTP` downgrade attack, which downgrades `HTTPS` communication to `HTTP`, making the data transferred in clear-text. This is done by setting up a Man-In-The-Middle (MITM) proxy to transfer all traffic through the attacker's host without the user's knowledge. However, most modern browsers, servers, and web applications protect against this attack.

