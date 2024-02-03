- Here we imported our lab 12 but only the functions from the class in order to import functions from a module effectively we specify import  module and then function 
- However in this case to save time we put the functions in a class and imported it 
- Everything we do in the code and everything that describes the code is in the remarks 
- We also decorated our program to look like the pent testing tools that are used in Kali linux look!

```Python
from colorama import Fore, Style, init
from temp import TemperatureConverter 

init(autoreset=True)



# This program will do conversions in multiple fields and will work both ways

# Function for the user greeting. Nothing in, nothing out.
def user_greeting():
    print(Fore.GREEN + Style.BRIGHT + r"""
   .____       _____ __________   ____________   ._._. 
|    |     /  _  \\______   \ /_   \_____  \  | | | 
|    |    /  /_\  \|    |  _/  |   | _(__  <  | | | 
|    |___/    |    \    |   \  |   |/       \  \|\| 
|_______ \____|__  /______  /  |___/______  /  ____ 
        \/       \/       \/              \/   \/\/ 
    """ + Fore.WHITE + Style.NORMAL)

    print("Hello and welcome to this program!")
    print(Fore.GREEN + "---------------------------------------------------" + Fore.GREEN)
    print(Fore.LIGHTYELLOW_EX + """Essentially this program will allow
     you to do conversions in multiple fields""" + Fore.GREEN + Style.BRIGHT)
    print(Fore.GREEN + "---------------------------------------------------" + Fore.GREEN)


# Function to get the conversion type and error check it. Returns the converted type.
def get_conversion_type():
    message = input(Fore.GREEN + """
    Please input the following to use this program for conversion. 
    'I' Will convert Inches to Centimeters.
    'C' Will convert Centimeters to Inches.
    'O' Will convert Ounces to Grams. 
    'G' Will convert from Grams to Ounces
    'M' Will convert from Miles to Kilometers 
    'K' Will convert Kilometers to miles
    'T' Will convert celsius to Fahrenhiet 
    Type here: """+ Fore.WHITE).lower()

    # Error checks the user input
    if message in ['i', 'c', 'o', 'g', 'm', 'k','t']:
        return message
    
       
    print(Fore.GREEN + "---------------------------------------------------" + Fore.GREEN)
    print("I'm sorry, I did not understand the value. Please type the correct value.")
    return None

# Function to get user input and perform the conversion. Prints the result.
def calculate_and_display(conversion_type):
    if conversion_type == 't':
        # Create an instance of the TemperatureConverter class
        temp_converter = TemperatureConverter()

        # Call the relevant methods from the TemperatureConverter class
        temp_converter.user_greeting()
        while True:
            temp_converter.convert_and_display()
            if not temp_converter.ask_again():
                break
    else:
        print(Fore.CYAN + "---------------------------------------------------" + Fore.RESET)
        number_1 = float(input("\n Please enter an integer: "))

        # Does the conversions
        if conversion_type == 'i':
            in_to_Cent = number_1 * 2.54
            print(f"\n{number_1} Equals: {in_to_Cent:,.2f} Centimeters")
        elif conversion_type == 'c':
            cent_to_In = number_1 * 0.3937
            print(f"\n{number_1} Equals: {cent_to_In:,.2f} Inches")
        elif conversion_type == 'o':
            ounces_to_grams = number_1 * 28.34952
            print(f"\n{number_1} Equals: {ounces_to_grams:,.2f} Grams")
        elif conversion_type == 'g':
            grams_to_ounces = number_1 / 28.34952
            print(f"\n{number_1} Equals: {grams_to_ounces:,.2f} Ounces")
        elif conversion_type == 'm':
            miles_to_kilo = number_1 * 1.609344
            print(f"\n{number_1} Equals: {miles_to_kilo:,.2f} Kilometers")
        elif conversion_type == 'k':
            kilos_to_miles = number_1 * 0.621371
            print(f"\n{number_1} Equals: {kilos_to_miles:,.2f} Miles")

# Function to ask the user if they want to continue. Returns True or False.
def ask_to_continue():
    print(Fore.GREEN + "---------------------------------------------------" + Fore.RESET)

    answer = input("Would you like to use this program again [Y/N]: ").upper()
    if answer == 'Y':
        return True
    elif answer == 'N':
        print(Fore.GREEN + "-----------------------OK--------------------------" + Fore.RESET)
        print(Fore.GREEN + "---------------------------------------------------" + Fore.RESET)
        return False
    else:
        print(Fore.GREEN + "---------------------------------------------------" + Fore.RESET)
        return False


# Function for the user exit option. Nothing in, nothing out.
def exit_message():
    print(Fore.BLUE + "---------------------------------------------------" + Fore.RESET)
    print(Fore.BLUE + "\n---------thanks for using my program!!-----------" + Fore.RESET)
    print(Fore.BLUE + "---------------------------------------------------" + Fore.RESET)
    
# Main section of the code    
user_greeting()

# Main program variable
run_main_program = True

# Main program loop
while run_main_program:
    conversion_type_main = get_conversion_type()
    if conversion_type_main is not None:
        calculate_and_display(conversion_type_main)
        run_main_program = ask_to_continue()

exit_message()

```

- Some dope shit we made kinda useless but its cool lets convert it to C++ and C