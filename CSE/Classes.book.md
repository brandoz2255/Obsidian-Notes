# OOP 
- OOP aka **Object oriented programming** is the most effective way of programming in which we write **classes** to represent real world things and situations 
- Then we define that general behavior in which we give a class and give functions to the class which are called **instances**

## Classes
- when creating a object in a class we automatically create objects with a general behavior 
- Such as real world situations can be programmed Using classes. 
- Doing this is called **Instantiation** and One real good example is programming an animal we give the name of the class the animals name then we give some descriptions of the animal as [[instances]] and what the animals does 

### Method
- The goal is store objects [Classes] in modules and and then importing them we can do the same with other code we find online as a programmer we need this method of programming 
- This can essentially help in telling us about any bug that occurs in our code so learning how to do OOP is the biggest thing so we can think like a programmer

## Create a Class
- Lets say for example we need to program a dog we need to think what do most dogs currently have:
	- For starters they all have **names and a age** so that's gonna go in our class and what do dogs do they **sit and roll over** so that's going in our class
	- This will tell python how to make an object *dog* so that we can program individual instances 

```Python
class Dog:
"""A simple attempt to model a dog!"""

	def __init__(self,name,age):
	"""Makes the name and age attributes"""
	self.name = name
	self.age = age

	def sit(self):
	"""Simulate a dog sitting text based"""
	print(f"{self.name} is now sitting")

	def roll_over(self):
	"""The dog rolls over"""
	print(f"{self.name} rolled over!")
```


**From what i can tell using class this is essentially a function for a function how we store the blocks of codes in a block of code look at snippet for what i mean**

- When creating the class from scratch we don't need the parenthesis to tell python to display it that's for later [maybe]

## __ init __ () Method 
- Using a function within a class is actually a method everything that revolves around methods is linked to the use of functions 
- Essentially goes with that one workaround in C++ we look at this [[C++]]
- Basically is just a way to call upon our class without python messing it up it has to be with  **two underscores**
- when using this method we must have the self first since this is an object of the dog such as its movement of sit and roll the self must always be first 
- in our case the `Self` has two variable functions that would print out two displays such as roll over and sit 
- If this were a more complex program it can do an animation of rolloing over and sitting down

### Using a Class
A class is a set of instruciions that tells the instances what to do

```Python
class Dog:
"""A simple attempt to model a dog!"""

	def __init__(self,name,age):
	"""Makes the name and age attributes"""
	self.name = name
	self.age = age

	def sit(self):
	"""Simulate a dog sitting text based"""
	print(f"{self.name} is now sitting")

	def roll_over(self):
	"""The dog rolls over"""
	print(f"{self.name} rolled over!")

my_dog = Dog('Willie',6)
my_dog.sit()
my_dog.roll_over()
```

- we are still using the same dog class that we have previously used before 
- However in this snipbet we are calling upon the class and defining it with a  name and age 
- We then use dot notation to print out the name associated with the Instances and link it with the variable
- Usually in programming thinking  a capital variable is a class and a lowercase one is a variable 

### Acessing a tribute 
Dot notation is how we can acess a tribute the syntax would be 
```Python
my_dog.name
```

- with the `.name` coming from the Dog class using the block of code that defines the name fucntion and statement 

### Calling Methods 
- Calling an instance we also use the dot notation when we are calling it from our defined Dog class 
- it does this in which we use the instance we want to call over by typeing it and then using the dot to use the method we want to use such as my_dog.sit() will use the contents in my dog and the class method that called upon by the dot

## Creating multiple instances 
Using a class in python we have the ability to use a class with multiple instances 
-  For example lets create an instance called your dog python wont get confused so as long you give it another variable name 

```Python 
class Dog:
"""A simple attempt to model a dog!"""

	def __init__(self,name,age):
	"""Makes the name and age attributes"""
	self.name = name
	self.age = age

  

	def sit(self):
	"""Simulate a dog sitting text based"""
	print(f"{self.name} is now sitting")

	def roll_over(self):
	"""The dog rolls over"""
	print(f"{self.name} rolled over!")

my_dog = Dog('Willie',6)
your_dog = Dog('Lucy',3)

my_dog.sit()
my_dog.roll_over()

print(f"My dogs name is{my_dog.name}")
print(f"My dog is {my_dog.age} years old") 

print(f"\nYour dog's name is {your_dog.name}")
print(f"Your dog's age is {your_dog.age}")
```

[[Classes.py part two]]