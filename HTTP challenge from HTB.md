### Raw Documentation 
![[Pasted image 20250319153102.png]]
### Example 

```bash
00818@htb[/htb]$ curl -O inlanefreight.com/index.html
00818@htb[/htb]$ ls
index.html
```

### Real command 

```bash
curl http://94.237.59.30:51634/download.php -o flag.txt
```

```bash
cat flag.txt
```
##### Output of cat:

```bash
HTB{64$!c_cURL_u$3r}
```

- What we did here was curl the download code and ran it and we displayed the output of the download in `flag.txt` using -o flag
- with that we cat the `flag.txt` to get the flag for this challenge 
----

### Refined Documentation