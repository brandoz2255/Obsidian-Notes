```Shell-session
hashcat -m <hash_mode> -a 0 <hash_file> <wordlist>
```
- General syntax for hashcat using the command you can always look up the --help or -h for more modes im the -m or hash file etc
- highly suggested to use vim to create your texts
- the word list is located in our clone directory

```Hashcat
hashcat -m 0 6475c851b56004eb96ab1404252c3a34 /path/to/wordlist.txt
```
- This is a good example of the useage of hashcat itself the powerful tool of course requires alot of reading on the help of itself 
ultimately sadly this was used to crack them https://hashes.com/en/tools/hash_identifier