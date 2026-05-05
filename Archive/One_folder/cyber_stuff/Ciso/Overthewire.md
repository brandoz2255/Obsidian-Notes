Using the find was useful since it would specify your search of interest 
-  the syntax that was used  find /home/bandit5/inhere -type f ! -executable -size 1033c

bandit6 is P4L4vucdmLnm8I7Vl7jG1ApGSfjYKqJU 
>ssh bandit6@bandit.labs.overthewire.org -p 2220

## Level 7
-  password is z7WtoNQU2XfjmMtWA8u5rN4vzqu4v99S 
- then do the ssh bu change it to level 7 
- find / -sixe 33c -group bandit6 2> dev/null 
z7WtoNQU2XfjmMtWA8u5rN4vzqu4v99S
## Level 8 
-  the password is TESKZC0XvTetK0S9xNwm25STk5iWrBvP
- change the ssh to level 8 

## Level 9
- might be EN632PlfYiZbn3PhVK3XOGSlNInNE00t
```
Bandit Level 8 → Level 9
Level Goal
The password for the next level is stored in the file data.txt and is the only line of text that occurs only once

Commands you may need to solve this level
grep, sort, uniq, strings, base64, tr, tar, gzip, bzip2, xxd

Helpful Reading Material
Piping and Redirection
```

- using sort command we can sort every line of text in the file alpebetacally and using the uniq command with the -u statement we can find the line of text that have the text that only occurs once 

```shell-session
sort data.txt | uniq -u
```
- move on to level 10 

## to Level 10 which is level 9 challlenge
- password is G7w8LIi6J3kTb8A7j9LgrywtEUlyyp6s
- the data.txt is a image or a none human readible text which means we must find a way to read it 
- the challenge states that it has human readible text as in strings 
- So the `strings` command is needed  but it also has unique attachments to the string such multiple = signs 
- so we need to use grep to handle this situation 
```Shell-session
strings data.txt | grep "==="
```
-  it state it was found by multiple equals signs however my mistake was using one since i didn't read it correctly but still found it that way because the passwords are unique to look at but it would help in any other situation to specify it 
- strings since it is a string and needs to be humand readable grep was used since it is as tool used to look for lines of text that is specific like in our example the =

## Level 10  going to 11
- password is 6zPeziLdR2RKNdNYFNb6nVCKzphlXHBM
- essentially easy the data.txt was encoded in the data.txt 
- so I used base64 to decrypt it and got the password 
- looked at the man page 
```Shell-session
base64 -d data.txt
```

## Level 11 going to 12
- The  password is  JVNBBFSmZwKKOP0XbFXOoW8chDz5yVRv 
- 
- essentially what was in data.txt was encrypted however we couldn't finds the to decrypt it with tr command but we found a method online 
```Shell-session
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```
* How we did it was dcode.fr jsut decrypted it 

## Level 12 going to 13 
-  