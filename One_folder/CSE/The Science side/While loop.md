* the While allows for the program to keep running as long as it equals how much was inputted 
Example 
```Python Terminal
Current_number = 1
while current_number <= 5:
```
## Letting the User quit 
-  Parrot.py we make a program that will repeat what user states until the user wants to quit 
```python
prompt = "\nTell me something and I will repeat it back to you:"
prompt = "\nEnter 'quit'to end the program"

message = ""
while message != 'quit':
   message =input(prompt)
   print(message)
```
	
- We let the user know their options of course either quitting the program or entering a value
- the variable [message] keeps track on whatever the user inputs 
- Defining message as an empty string allows for python to check the first time it reaches 
- Then it compares the value of [message] to the value of ['quit']
- However if it has nothing to compare to python wont run the program in order to fix this we make sure that [message] has its value given by the user
- This program runs as long as possible as long as its value is not ['quit'] 
- However the program will display [quit] as an entered value to end the program to fix this we would need to add the [if] statement 

```Python
prompt = "\nTell me something, and I will repeat it back to you:"
prompt = "\nEnter 'quit'to end the program"

message = ""
while message != 'quit':
   message =input(prompt)

if message != 'quit':
   print(message)
```

- Issue resolved
## Flag
- A flag is used in the while statement when many possible outcomes can make the program end however having all these in one while statement makes it difficult
- Using a flag help with this issue when the variable we set is  true the program would run just as long as it is true 
- acts as a signal to our program as long as its true it keeps running as long as it hits false it ends

```Python
prompt = "\nTell me something, and I will repeat it back to you:"
prompt = "\nEnter 'quit'to end the program"

active = True
while active:
   message =input(prompt)

if message == 'quit':
   active = False
else:
  print(message)
```
- The if statement checks if the message value is quit then activates the false to end the program
- This would be useful in games and can implement the statement elif which is else if

## Break to exit
- The break statement can be used to exit a loop which ends the loop without running any additional code 
- can be used to control which lines of code you want executed when you do want it to be executed 
```python
prompt = "\nPlease enter the name of a city you have visited:"
prompt = "\nEnter 'quit'to end the program"


while True:
   city =input(prompt)

if city  == 'quit':
   break
else:
  print(f"I'd love to go to {city.title()}!")
```
- While will run forever unless it reaches a break statement 

## Continue in a Loop
- Rather than breaking out of loop and not using code when you want to you could also use the continue statement to return to the begining of the loop

```Python
current_number = 0
while current_number <10:
    current_number += 1 
    if current_number % 2 == 0:
       continue 

print(current_number)
```
-  we would set the [current_number] to 0 since it is less than 10 once the loop activates it begins counting 
- But because of the modulo it would count only odd numbers 
- remember to avoid an infinite loop in Python fix it and use crtl c to get out of it

## Lists and Dictionaries with loop
- We have only delt with one piece of information at a time inputted by a user in order to keep track of multiple piece's of information's we use dictionaries and lists with our while loops
- this example we would be moving items from one list onto another with this example we would be confirmed users and unconfirmed users 

```Python
#start with users that need to beb verified 
# and an empty list to hold confirmed users 
unconfirmed_users = ['alice','brian','candace']
confirmed_users = []

#Verify each user until there are no more unconfirmed users
#move each verified usr into the list of confirmed users 
while unconfirmed_users: 
     current_users = unconfirmed_users.pop()
 print("\n")

```





[[Code Challenge]]








[[Github student pack]]