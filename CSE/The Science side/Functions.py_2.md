- You can pass a list in python with functions doing this will msot defintey be useful
- it can be any list 
- in this example we will make a greeting to each user the example essentially sends a list of users to print a greeting to each user 
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