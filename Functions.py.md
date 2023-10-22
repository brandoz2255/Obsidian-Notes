- Functions in python and in coding in general are essentially blocks of code saves so that you don't have to retype the code over and over again. 
- For example 

```Python
def greet_user():
"""Display a simple greeting."""
print("hello world")

greet_user()
```
- the lines of code that comes after [greet_user():] is stored in that function and everytime you print out the function it will print hello world that is what a function is
## Passing Information
- we can add information to a function however the lines of code need to be altered a bit for example 
``` Python
def greet_user(username):
"""Display a simple greeting."""
print(f"Hello, {username.title()}!")

greet_user('jesse')
```

- Would essentially print out [Hello, Jesse] and you can change the name anytime you want to rewrite it and it would still be the same output with a different name
- The variable in greet user called [username] is a key example of a parameter which is just a piece of information that a function needs to do its job

### Passing arguments 
- because a function defitition can have multiple parameters a function may need multiple arguments
- For example one can use positional arguments, which is used in the same order that parameters are used actually then need to be 
- Next would be keyword arguments where each argument would consist of a variable name and a value where each argument has a variable and a value and and lists and dictionaries

[[positional arguments ]]
