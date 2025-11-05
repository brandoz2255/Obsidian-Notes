- [[present]]

Q16 Explain the TCP 3 way handshake. What packets are exchanged and why
Q17 Whats the difference between TCP and UDP? when would u use each
Q18 When u run `curl https://jumpstrading.com` walk me through wha happens at the network level from DNS to http response 

my questions

TCP and UDP TCP is slow pure connection meaning  no connection dropped  or possible droppings like downloading something to my internet  UDP is fast fast as it can get meaning some packets will be lagging behind due to how fast it is like streaming video or using netflix TCP is like downloading software form thhe internet UPD is like streaming something over the internet and they use thosse types connection for those different reasons 

So question from me is what is used in TCP with Linux and Docker and what is used with UDP 

TCP is mainly used when docker spins up a web service whhen one runs `docker run -p 8000:3000 nginx:latest` we are running nginx on port 8000 where docker  uses iptables rules  to forward incoming TCP traffic from the hosts port to the containers port 



Why does was TCP designed that way Whyy was UPD designed that way How does this  help and trade offs between the two 

TCP was designed for applications that require guaranteed, accurate data delivery on the other hand UDP wqas created for applicaitons where speed and low altency are more imporant than perfect reliability 

What is the TCP 3 way handshake what packets are exchanges and why  and what is a packet  and why is this best way to send informatiuon over the internet 

curl I know its a tool to send http requests over  the terminal 

like if i curl https site im sending a post request to the  site curl can be used to send different http request over the internet via the tterminal however from research it also supports other protocols 

so when itss `curl https://www.jumptrading.com/` its sending http request to www.jumptrading.com

What happens from the dns to http response the large html code that blew up my terminal is the http response the dns is responsible for giving me the ablility to type jumptrading.com

when i do a nslookup for jumptrading.com im hit with 104.16.14.68 which is the actual thing my computer is hitting not jumptrading.com when i type curl jumptrading.com its asking DNS hey whats the ip for jumptrading.com and it returns 104.16.14.68 thus curl sends a http request to 104.16.14.68 and it returns a http response in the form of html code which is what wouldve rendered on my browser if i typed the same DNS name in the url 
## curl supports

|                  |                                                                                                                                                                                                                                                                           |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Protocols        | DICT, FILE, FTP, FTPS, GOPHER, GOPHERS, HTTP, HTTPS, IMAP, IMAPS, LDAP, LDAPS, MQTT, POP3, POP3S, RTMP, RTMPS, RTSP, SCP, SFTP, SMB, SMBS, SMTP, SMTPS, TELNET, TFTP, WS, WSS                                                                                             |
| Proxies          | SOCKS4, SOCKS5, HTTP, HTTPS (HTTP/1 and HTTP/2), tunneling, via unix domain sockets, haproxy, SOCKS+HTTP proxy chain                                                                                                                                                      |
| HTTP             | GET, POST, PUT, HEAD, multipart formpost, HTTP/0.9, HTTP/1.0, HTTP/1.1, HTTP/2 (h2c, h2, prior knowledge), HTTP/3 (dual connect h1/h2 + h3 or h3-only), HSTS, Alt-Svc, cookies, PSL, etags, transfer compression, ranges, custom headers, custom method, follow redirects |
| FTP              | IPv6 (EPRT, EPSV), STLS, upload/download, append, range, passive/active, kerberos, directory listing, custom commands                                                                                                                                                     |
| SCP + SFTP       | known hosts, md5/sha256 fingerprint, compression, upload/download, directory listing                                                                                                                                                                                      |
| TLS              | 1.0 - 1.3, mutual authentication, STARTTLS, OCSP stapling, ECH, False Start, key pinning, PQC ready, session resumption, early data, export/import sessions                                                                                                               |
| QUIC             | 0RTT handshakes                                                                                                                                                                                                                                                           |
| Auth             | Basic, Plain, Digest, CRAM-MD5, SCRAM-SHA, NTLM, Negotiate, Kerberos, Bearer tokens, AWS Sigv4, SASL, .netrc                                                                                                                                                              |
| HTTP compression | gzip, brotli and zstd                                                                                                                                                                                                                                                     |
| Name resolving   | DNS-over-HTTPS, custom address for host, name+port redirect, custom DNS servers, DNS caching, HTTPS RR                                                                                                                                                                    |
| Connection       | connection reuse, Interface binding, Happy Eyeballs, IPv4/IPv6-only, unix domain sockets, TCP keepalive, TCP Fast Open, TCP Nodelay, MPTCP, VLAN priority, IP Type Of Service                                                                                             |
| Transfers        | transfer rate limiting, request rate limiting, stall detection, retries, timeouts                                                                                                                                                                                         |
| URLs             | Unlimited amount, parallel and serial transfers, globbing                                                                                                                                                                                                                 |
| Output           | IDN hostnames, custom info from transfer, metadata as JSON, per content-disposition, libcurl source code, bold headers                                                                                                                                                    |

TCP 3 way handshake is one it sets up a realiable connection and agrees on options then picks a randon ISN on both ssides and then finally confirms both directiions are reachable 

