Flee
## Using indexes and lists with while loops 
### Example phone names and numbers 
#### Lab assignment is with state names and abbreviations 
- creates the program discription 
- Key thign is having two lists that are the same length 
- Creates a list of names and a list of phone numbers in my sense of the lab it would be the state name and the state abbreviation 
- Then he does the usaual with the what the program is and what it does with the user greeting and such 
- then he makes  the variable for the main loop 
- Mainly because we got to ask the user if they want to use it again and such 
- uses .lower to lowercase the input however our case  would .upper since the assingment states we should have it uppercase
- ![[Screenshot from 2023-11-08 17-07-13.png]]
- then he sets up an input line to check it 
- it also needs to be error checked 
- example in video 
```Python
while whichWay != 'n' and whichWay != 'p':
	whichWay = input('INPUT ERROR: please enter a n or a p: ').lower()
```
- this can be implemented in our own way of course such as 
- This is how chatgpt did it 
```Python
if user_input == 'ab':

if input_value in state_abbreviations:

index = state_abbreviations.index(input_value)

print(f"The abbreviation for state {state_list[index]}.")

else:

print(f"State abbreviation '{input_value}' not found.")
```

- the error in his 
- `if whichWay == 'n'` the variable `word = phonenumbers` 
- the double check to chekc if the phone number is in the list he uses `listTocheck = names` 

```Python
if whichWay == 'n':
	word = 'phone number:'
	listTocheck = phonenumbers
```

- in this case it going to use the input that the user put of n to essentiallyt cross referemcne to the list of phonenumbers to check the persons name
- it takes the phone number to get the person that the number matches with 
```Python
else:
	word = 'name: '
	listToCheck = names
	
```

- in this case it takes the name instead rather than the phone number
- how this professor did this to not retype the or go throught the hassle of 
```Python
print(f"enter the persons {word}: ")

#what he did instead was
userinput = input('Enter the persons ' + word)
```

- A lot more typing space used but more quickly depending on the persons typing level
- ![[Screenshot from 2023-11-09 09-40-31.png]]

- Alot of this pretty straight forword 
- One thing we are confused on 

```Python 
if whichWay == 'n':
	for mainIndex in range(len(phonenumber)):
		if userInput == phoneNumbers[mainIndex]:
			print('the persons name is' + names[mainIndex]+'.')
			
```
like the range and len 

GPT:
states that the `range `statement and` len `statement  are commonly used in loops like this one 

- ==Len()== 
	- How it works fundementally is that it returns the lenght of an object which can be sequenced in a string list or ==tuple==
	- in the lectrues case `len(phonenumber)` would return the number of elements within the phonenumber variable 
- ==range()==
	- it creates a sequence of numbers in a specified range 
	- when this is used in one argument range(n) it would generate the numbers between 0 to 1 
	- However in our case `range(len(phonenumber))` it gives the sequence of numbers from 0 to `len(phonenumber)-1` basically jsut goeing through the whole variable within the phonenumber sequence

Over all in this case the `range(len(phonenumber))` ensures that the loop itself would goe throught all the valid indices within the phonenumber list

the mainindex takes on each value produced by `range(len(phonenumber))` allowign it to access elements of phonenumbers and names at corresponding indices 

in the videos case if the user input is equal  to the element of the phone numbers list  then it would print the statement `the persons name is` `+ names[mainindex]` 

[[perm.Lab_11.notes]]