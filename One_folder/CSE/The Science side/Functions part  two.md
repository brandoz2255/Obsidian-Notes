# Modifying a list with a function 
In python using functions is not generally needed like in other programming languages however this language does have the option and allows for users to store blocks of code within them
	- in this sectiion we are modify  a list with a function 
	- doing this allows us to see how in python we could essentially pass a list using a function
```Python
def greet_users(names):

    """Print a simple greeting to each user in teh list"""

    for name in names:

        msg = f"hello,{name.title()}!"

        print(msg)

  

usernames = ['hannah','ty','margot']

greet_users(usernames)
```
We can see in this example that `greet_user` generally goes through the list of names in usernames and prints out the message using the list of names contained in the `usernames` variable 
	- This allows for easier access to modify later since we can easily cchange the names for this code sample without having to manuelly go through and do that 
	- it adds less code and better organiozation for the structure of the code
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
- Anytime we pass a list in a function we can modify it and the function it self would modify the rest for us as mentioned before 
- The above code is how its done without functions this is how its with functions to allow all the mentioned features 
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
- here once modified in the function it gets updated everywhere for future use 
using the `printed_models()`  statements we see  that the two parameters have a list of designs that are printed out . within these two list s we define a function in which that simulates printing each design by emptying the list we define 

# Preventing a function form modifying a list
In most cases in coding we would need to create a function form that would modify a list 
	- like for example in our case we would need to start with the list of inprinted designs then write a function to move them onto the original completed models
	- in that case we would still keep our original list but sinmce it was moved out of the original list it would still keep the list on that list
	- The notation on making a copy in python using a function is as follows 
```Python
function_name(list_name{:})
```
this is the basic syntax towards copying  a list onto a function and a variable 
how it works is that using the `:` statement allows for pythoin to make a copy of the list and send it to the function 
- However if we don't want to empty the ls list we would print the lsit like this 
```Python
print_models(unprinted_designs[:]),completed_modles
```

Now in this case the printed models can do its job in which receiving the names from unprinted  designs model and just essentially copying it from the OG one. 
# Arbitrary keywords
in some situation we will need to accept an arbitrary number of arguments with the kind of information we wont know ahead of time 
	-  we can write a function that accepts as many key value pairs the statement provides 
	- one example is getting information about the user but not knowing the type of information the user has or is giving
	- build_profile will always accept the kind of information you'll receive 
	- always takes in the first and last name but it accepts the arbitrary number of keyword arguments

```Python
def build_profile(first,last, **user_info);
""" build a dictionary containing evrything we know a bout the user."""
user_info['firstname'] = first
user_info ['last_name'] = last
return user_info

user_profile = build_profile('albert','einstein', location = 'princeton', field = 'physics')

print(user_profile)
```

- within the `build_profile` it allows as many name value pairs as they want 
- the double `asterisk` in the code ==allow for parameter user info cause Python to create a dictionary called user info which contains all the extra name value pairs==
- just like a dictionary 
using the body build function all that is needed to do is making sure  that the first and last names are implemented so that it is within the function. then the code can be modified to not only having the basic info but also adding the info such as location and field of study. 

The return dictionary is what modifies the code to add that information mentioned earlier. this just how return dictionary y works they allow variables to modify the function to add more information within the code 
# Modules 
How modules work in Python is that essentially they are code that we have used previously to re use them in newer code this allows us to save time so that we don't have to redo code that we have already done before. 
	- Helps save time with writing code 
	- useful to use other peoples code that can be implemented in our own code 
	- Also helps us with sharing code with other people ultimately creating the ultimate coding sharespace 
It works by using any file of code that ends with the .py statement this we can allow for the use coming from other files of code. 
	-  Wen doing this it also important to remember to have descriptive names in the python code to allow it for easier use 
	- To do this we need to use the `import` statement followed by the name of the file
```Python
from module_name import function_name
```
- here we import a specific function form a module which is jsuut another file of code
- to use this in the code that we have essentially we would use this syntax
```Python
module_name.function_name()
```

# ALias
We could use an alias coming form a module for a spefic name of a function like rename for the purpose of incase the name of said function is too long we could name what ever we want always remember to know what it does. 
```Python
from module_name import function_name as alias_name
```

-  this is the general syntax for renaming a function or giving it a nickname 
- However this is only for renaming a specific function withing the module to rename the module and give it an alias we would use this syntax 
```Python
import module_name as alias
```

Alternatively we could import every function from the module but if its too big it could pose a problem and when we do this we don't need to use the `.` statement to run the function heres the syntax 
```Python
from module_name *
```


# Conclusion 
Overall in python a  function is just blocks ofv code to help with saving time when making code and using other peoples code that exist online overall
- when it comes down to it is very similar to how its done in C++ but we can move functions between files and use them for information on the C++ references in this module look at [[C++]] explaining the functions part 

[[perm.vid_1]]
[[Chapter 1]]