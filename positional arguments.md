-  When calling a  function python must matche each argument in the funtion which is called a parameter
- The easiest way to use parameters is called positional argumenst whicch is using parameters in s specific order for example 


```Python
def describe_pet(animal_type,pet_name):
"""displays infromation about a pet"""
print(f"\nI Have a{animal_type}.")
print(f"my {animal_type}'s name is {pet_name.title()}.")

described_pet('hamster','harry')
```
- This would print out the message [I have a hamster My hamster's name is Harry]
- Every time you change the decryption assigned to the parameter would change the output. 

## Multiple Functions 
- You can call multiple functions at once
- Here we can describe a second different pet all we need to do is just add one more call to [describe_pet()]
```Python
def describe_pet(animal_type,pet_name):
  """Displays information about a pet"""
  print(f"\nI have a{animal_type}.")
  print(f"my{animal_type}'s name is {pet_name.title()}.")

described_pet('hamster','harry')
described_pet('dog','willie')
```

- Remember the order matters if its not in order ut will print it out in a different order jsut try with hamster and harry
- If you want to print it out with a different order but still want to function properly 
```Python
def describe_pet(animal_type,pet_name):
  """Displays information about a pet"""
  print(f"\nI have a{animal_type}.")
  print(f"my{animal_type}'s name is {pet_name.title()}.")

described_pet('hamster','harry')
```
- you could also 

```Python
def describe_pet(pet_name,animal_type='dog'):
  """Displays information about a pet"""
  print(f"\nI have a{animal_type}.")
  print(f"my{animal_type}'s name is {pet_name.title()}.")

described_pet(pet_name='willie')
```
- Note when you use defualt values, any parameter with a default value needs to be liste dafter all the parameters that don't have values