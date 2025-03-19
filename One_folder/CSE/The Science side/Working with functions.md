```Python 
# Brandon Sanchez
#55
# 11/19/2023
#Lab 12


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
user_greeting()

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

- Everything that the code does in the remarks i suggest look back at this when we get stuck at using functions in python in case you know 