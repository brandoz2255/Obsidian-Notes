# Modifying our previous lab
For lab the assignment is to essentially modify our lab 5 and add two Functions in the program lets recall what a function is using these two notes [[Functions.py]] and [[CSE/The Science side/Functions part  two|Functions part  two]]

- That we can recoall from these two notes is part two explains essentially what you can do with Functions in python and part one explains what is a function 
- A function is a block of code and this applies to any programming language 
- We use this to save time and make code look better to when modifying it


## Completion 
Ok we completed it we essentially added the two functions as instructed and implemented True and False and then we reiterated in the main program here it is to look at it 

```Python
# Brandon Sanchez
#55
# 9/27/2023
#Lab 4
# Remark: This program converts degrees Celsius to degrees Fahrenheit.
#Functuons
# User greeting funtions
def user_greeting():

print("Hello welcome!")


print("\nThis program will convert degrees Celsius to degrees Fahrenheit.")  

# creates the ask again function

def askAgain():

while True:

print("\nWould you like to run this program again:")

print("------------------------------------------")

userinput = input("If so please enter either [y/n]:")

if userinput == 'y':

return True

elif userinput =='n':

print("----------------------------------------")

print("Ok then have a nice day!")

return False

else:

print("-----------------------------------------")

print("Did not compute please try again!")

  
  

#prints the user greeting using said function

print(user_greeting())

  

# Controls the main program loop

mainloop = True

  

# Is the main program

while mainloop == True:

# Get user input and assign to a variable (float data type)

celsius = float(input("\nPlease enter the temperature in degrees Celsius; you may use decimals: "))

  

# Perform the temperature conversion and assign the result to a variable

fahrenheit = (celsius * 9/5) + 32

  

# Display the results with one decimal point

print("\n {:.1f} degrees Celsius is equal to {:.1f} degrees Fahrenheit.".format(celsius, fahrenheit))

  

# Goes through what happens in the askAgain function to determine the status of the main program

mainloop = askAgain()

  
  

# this is just the Exit message

print("\nHave a great day!\n")

print("-------------------------------------------")
```



- This is the entireity of Lab 12 done it was simple uses the principles described in the Functions notes 