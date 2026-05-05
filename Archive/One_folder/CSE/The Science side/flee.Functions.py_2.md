[[Functions.py_2 1]]
# Modifying a list with a function
You can pass a list in python with functions doing this will most defintey be useful
- it can be any list 
- in this example we will make a greeting to each user the example essentially sends a list of users to print a greeting to each user 
- its also useful to pass a list to a function whether its a list of anything such as a dictionary 
```Python
def greet_users(names):

    """Print a simple greeting to each user in teh list"""

    for name in names:

        msg = f"hello,{name.title()}!"

        print(msg)

  

usernames = ['hannah','ty','margot']

greet_users(usernames)
```

- the greet_users() defines the lsit of names which it assigns to teh parameter names the funciton loops through the klist it recieves and prints a greeting each user 
-  Remember any time you pass a list to a function the funciton can modify the list any changes mad to the list inside the function is permanent 
- such as consider a company in which they cereate a 3d printed models of designs that the users submit. Designs that need to be printed are stored in a list look at the followign code
``` Python
#start with some designs that need to be printed
unprinted_designs = ['phone case','robot pendant','dodecahedron']
completed_models =[]
#simulate printinf each design until none are left
# move each design to completed models after printign
while unprinted_designs:
	current_designs = unprinted_designs.pop()
	print(f"printing model: {current_designs}")
	completed_models.append(current_design)

#Display all compelted tasks
print(f"\n following models have been printed: ")
for completed_model in completed_models:
print(completed_model)

```

- this program starts in the begining having a list of designs that needs to be printed 
- this while simulates the transformation of the `unprinted_designs` list and moving towards the completed models to simulate that the inforamtion is being moved 
- which would then be resulted with the current_design statement 
- these lines of code can be organized better 
```Python
def print_models(unprinted_designs, completed_models)

#simulate printinf each design until none are left
# move each design to completed models after printign
while unprinted_designs:
	current_designs = unprinted_designs.pop()
	print(f"printing model: {current_designs}")
	completed_models.append(current_design)

def show_completed_modles(completed_models):
	print(f"\n following models have been printed: ")
	for completed_model in completed_models:
	print(completedy_model)

unprinted_designs = ['phone case','robot pendant','dodecahedron']
completed_models =[]

print_models(unprinted_designs,completed_models)
show_completed_models(completed_models)
```

- with the `printed_models()` we have two parameters a list of designs that need to printed and a list of completed models 
- in these two lists we define a function in which that simulates printing each design by emtpying the list of unpritned designs and filling the list of completed models 
- we then define the function show_completed_models() with one parameter: the list ofthe name of each model that was printed 
- in the end the program has the same output  as the version without the functions but is more organized 
- if we need ti oprint more desings later on we can simply moduify printed_models() 
- if we ant to modify the printing code we can change the code for that only once 
- the fucntions in the python program will do the rest for us 
- effectively making this part of the progam easier to handle similar to what we learned in c++ 
- we should remember that every function has one specific job the first function to print the designs and the other to do both jobs 
- with this we can split any code into two functions allowign for python to perform more complex tasks easier 
# preventing  a fucntion form modifying a list
- we will need to sometimes create a function form modifyign a list
- like for example what if you would want to start with a lsuit of ubprinted designs and write a function to move  them to a list og completed models 
- we would still keep the orignal lsit of unprinted designs 
- but  since we moved them into all of them out of unpritned designs the list is gone 
- passing a function a copy will only affect the copy leaving the original intact 
`function_name(list_name[:])` 
- the slice notation of [:] makes a copy and sends it to the function 
- if we dont want ot empty the list we could call the printed models like this 
`print_models(unpirinted_designs[:], completed_models)`
- the printed models can do its work sicne it recieves the  names of all unprinted designs this time using a copy of the orignal unprinted designs list  not the actual one 
- but the original list of unpritned will be unaffected by the function  this is how we can preserve the original one we wuld alwasy do this if we have a offical reason to od this 
# using arbitary keyword arguments
in some situation we will need to accept an arbituary number of arguments with the kind of information we wont know ahead of time 
-  we can write a function that acccepts as many key value pairs the statement provides 
- one example is getting information about the user but not knowign the type of information the user has or is giving
- buld_profile will always accept the lkind of ifnormation youll receive 
- always takes in the first and last name but it accepts the arbituary number of keyword arguments
enter python code here later

```Python
def build_profile(first,last, **user_info);
""" build a dictionary containing evrything we know a bout the user."""
user_info['firstname'] = first
user_info ['last_name'] = last
return user_info

user_profile = build_profile('albert','einstein', location = 'princeton', field = 'physics')

print(user_profile)
```

- within the build_profike it allows as amny name value pairs as they want 
- the double asterisk in the code allow for paraemter user info cause Python to create a dictionary alled user info which contains all the extra name value pairs
- just like a dictionary 
learn more about this topic 
- like in the body_build function all we need to do is ass the first and last names to the user info statement 
-  then tha would be the only info we get 
- then we modify the code by adding not only the user  info as his first and last name we also add his location and field of study 
- the return dicitonary is what has the modified code containting t he information on his name and location and his occupation 
- that is how a return dictionary works  we have the variables and in the function of build profile and 
- add info with the build profile variable statement 
# storing your functions in modules 
- An advantage to using functions in coding is that they seperate code from your main program
- when coding it is important to have descriptive namesn for the functionss since it makes it much more easier to follow 
- However we can go a step further in python by storing our functions in a seperate file that contains the code 
- this would hide the code details within this function 
-  we could then use the `import` statement to have it used in our program 
- this also essentailly allows us to reuse other programs we have made and we can share other programs with other people as well as importing them
# importing an entire module
- a module is a file that contains the python code always ending in the .py extension 
- heres how it works essentially 
```Python
def make_pizza(size,*toppings):
print(f"making {size} inch pizza with the bfollowing toppings: ")
for topping in toppings
print(f"- {topping}")
``` 
- first this program is called pizza.py
- so to import it we would just tell python import pizza
then we would 

```Python

import pizza
pizza.make_pizza(16,'pepperoni')
pizza.make_pizza('mushrooms', 'green peppers','extra cheese')
```

when python reads the module it would just import the code and run it 
- in order to use the imported code it must be used in the following syntax
```Python
module_name.function_name()
```

- that would be the gerneral syntax
# specific import
- we would import a specific function in which using only the one function form said module 
- such as in the syntax 
```Python
form module_name import function_name
```

# using aslias\
-  if the function we want  to import has the same as another function or statement in our program we would or if the funciton itself has a long ass name 
example
```Python
from module_name import function_name as alias_name
```
- we could add literally anything like shirt or WP mp it doesnt matter it acts quick and efficient  

## as to give a module alias 
- Alternatively we can also give a module a alias just like we did before with the functions 
```Python
import module_name as alias
```

Alternatively we could also #import every function form a module in uising hte `**` statement in python 

```Python
from module_name *
```

- The `**` statement in python tells it to use every funcition that can be found in the module
- with this we can use the functions without the `.` to make them work however this doesnt work in larger modules

[[CSE/Functions part  two]]