
- A vast majority of people create their passwords according to simplicity instead of security 
- in order to eliminate this weakness a password polices would need to be created om all systems that determine how a password should look
- This would mean that the password would ne to recognize that the password itself contains capital letters, special charcters and numbers
- In addition most password policies require a minimum length of eight characters in a password
- in the prevous sections we guessed very simple passwords but it becomes much more difficult to adapt this in systems to apply policies that force the creation of more complex passwords 
- Unfortunately the tendancy for users to create weak passwords also occurs despite the existance of complex passwords policies 
- Many employees follow the same pattern when creating a password such as having the companies names in the passwords 
- It can also contain things such as pets friends sports hobbies and many other elements of life. OSINT information gathering can be very helpful for findign out more about a users prefeerance and may assit with password guessing 
- FINALLY AN OSINT [module](https://academy.hackthebox.com/course/preview/osint-corporate-recon)

|**Description**|**Password Syntax**|
|---|---|
|First letter is uppercase.|`Password`|
|Adding numbers.|`Password123`|
|Adding year.|`Password2022`|
|Adding month.|`Password02`|
|Last character is an exclamation mark.|`Password2022!`|
|Adding special characters.|`P@ssw0rd2022!`|

- Many people want to keep their password as simple as possible despite password policies 
- based on the password statistics most passwords lenghts are not longer than ten charcters 
- with this information we can pick specific terms that are at least five characters long and seem to be the most familiar to the users such as the names of their pets hobbies preference etc
- Like an easy access is that if a password is created like having a single word such as the month then the current year followed by a special character that would automatically reach the ten-chararacter requirement 
- Considering that most companies require regular passwords changes a user can then modify theri pasword by just changing the name of a month or a single number, etc

Example 

## Password list 
```Shell-session
00818@htb[/htb]$ cat password.list

password
```
- We can use a tool called Hashcat something I wanted to use for a while
- we can use this to combien a  list of potential names and labels with specific mutation rules to create a custom wordlist
- a Module to consider and you must check out later this [hashcat](https://academy.hackthebox.com/course/preview/cracking-passwords-with-hashcat) module
- Hashcat uses a specific syntax for defining characters and words and how they can be modified
- The complete list of this syntax ca be found in the official documents of hashcat 
- however here are enough to learn 

|**Function**|**Description**|
|---|---|
|`:`|Do nothing.|
|`l`|Lowercase all letters.|
|`u`|Uppercase all letters.|
|`c`|Capitalize the first letter and lowercase others.|
|`sXY`|Replace all instances of X with Y.|
|`$!`|Add the exclamation character at the end.|

- Each rule in hashcat is written on a new line which determines how the word should be mutated 
- like for example 
```shell-session
00818@htb[/htb]$ cat custom.rule

:
c
so0
c so0
sa@
c sa@
c sa@ so0
$!
$! c
$! so0
$! sa@
$! c so0
$! c sa@
$! so0 sa@
$! c so0 sa@
```

- Hashcat applies the rules of `custom.rule` for each word in `password.list` and store the mutated version in our` mut_password.list` then we can result in fifteen mutated words in this case

## Generating Rule-based Wordlist

```shell-session
00818@htb[/htb]$ hashcat --force password.list -r custom.rule --stdout | sort -u > mut_password.list
00818@htb[/htb]$ cat mut_password.list

password
Password
passw0rd
Passw0rd
p@ssword
P@ssword
P@ssw0rd
password!
Password!
passw0rd!
p@ssword!
Passw0rd!
P@ssword!
p@ssw0rd!
P@ssw0rd!
```

- `Hashcat` and `John`  come with their own pre-built lists that we can then use for our password genration and cracking purposes 
- One of the most used rules is` best64.rule` 
- Which can often lead to good results 
- One important thing to takeaway is that password cracking and the creation of your own wordlist is a just a guessing game 
- How ever with more information we can narrowj our guessing  about the password policy and take into account the company name the region and other topics that users may use on their passwords
- The only exceptions are when passwords of course get leaked and then can be found 

## Hashcat Existing Rules 

```shell-session
00818@htb[/htb]$ ls /usr/share/hashcat/rules/

best64.rule                  specific.rule
combinator.rule              T0XlC-insert_00-99_1950-2050_toprules_0_F.rule
d3ad0ne.rule                 T0XlC-insert_space_and_special_0_F.rule
dive.rule                    T0XlC-insert_top_100_passwords_1_G.rule
generated2.rule              T0XlC.rule
generated.rule               T0XlCv1.rule
hybrid                       toggles1.rule
Incisive-leetspeak.rule      toggles2.rule
InsidePro-HashManager.rule   toggles3.rule
InsidePro-PasswordsPro.rule  toggles4.rule
leetspeak.rule               toggles5.rule
oscommerce.rule              unix-ninja-leetspeak.rule
rockyou-30000.rule
```

- At this point we can now use another tool called CeWL to scan potential words from the companys website and save them in a seprate list
	- We then can use this desired rules and create a customized password list that hasa a higher proboability of guessing a correct password 
- we just need to specifiy some parameters like the depth `-d` the minninmum lenght of the word `-m` the storage of the found words in lowercase `--lowercase` and the results `-w`
- Cewl example to create our own wordlist 
```shell-session
00818@htb[/htb]$ cewl https://www.inlanefreight.com -d 4 -m 6 --lowercase -w inlane.wordlist
00818@htb[/htb]$ wc -l inlane.wordlist

326
```
