# Classes and instances
When working with classes which one will need to when working with many programs that will result in simulating real life scenarios we need to learn how to work with instances. 

- Since we will be working with instances one the most important things is making the attributes for those instances for example 

#### Car Class
- We are going to make a car class that provides a full description of the car the make the model and the year etc 
- Doing so we will need to modify the attributes of these instances with this we ill be able to fully understand the concept of an instance 

```Python
class Car:
	"""A simple attempt to represent a car."""

	def __init__(self , make, model, year):
		"""Initialize attributes to describe a car"""

		self.make = make
		self.model = model
		self.year = year

	def get_descriptive(self):
		"""Returns a neatly formated printed name"""
		long_name = f"{self.year} {self.make} {self.model}"
		return long_name.title()

my_new_car = Car('audi','a4','2024')
print(my_new_car.get_descriptive())
```

- Using the init method we mentioned in a previous page [[Classes.book]] we can set up the parameters that will be used in this class 
- As well as defining the self parameter **firs**t the self always comes first 
- The parameters are essentially the attributes that will be associated with the instances
- For example the new car is the instance using the attributes that we have given it 
- The variable *get descriptive* just puts it all into one variable to be executed

## Setting a default value
- when using a class it is possible to add a parameter in the class without essentially modifying the class itself 
- For example lets add a n odometer to our car in which tells how much miles we got on it on that has the mileage *odometer* and one that reads it to the user **read_odometer** 

```Python 
class Car:
    """A simple attempt to represent a car."""

    def __init__(self , make, model, year):
        """Initialize attributes to describe a car"""

        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0

    def get_descriptive(self):
        """Returns a neatly formated printed name"""
        long_name = f"{self.year} {self.make} {self.model}"
        return long_name.title()

    def read_odometer(self):
        """prints the statement for showing the cars milage"""
        print(f"This car has {self.odometer_reading} miles on it")

my_new_car = Car('audi','a4','2024')
print(my_new_car.get_descriptive())
my_new_car.read_odometer()
```

- Once Python calls the init method to create a new instance it stores the originals ones first 
- That is when python adds the new attribute we have created for our and the readable one  and sets it to 0 

### Modifying Attribute Values
We can change the value of an attribute in three ways:
- Change directly through the instance
- set it through using a method
- Or increment it by a value [add it up basically]

#### Direct approach
- We can modify the value such as in this example 0 we can modify it directly our selves by changing it from 0 to 23 

```Python

class Car:
    """A simple attempt to represent a car."""

    def __init__(self , make, model, year):
        """Initialize attributes to describe a car"""

        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0

    def get_descriptive(self):
        """Returns a neatly formated printed name"""
        long_name = f"{self.year} {self.make} {self.model}"
        return long_name.title()

    def read_odometer(self):
        """prints the statement for showing the cars milage"""
        print(f"This car has {self.odometer_reading} miles on it")

my_new_car = Car('audi','a4','2024')
print(my_new_car.get_descriptive())

my_new_car.odometer_reading = 23
my_new_car.read_odometer()
```

- We just  increased the Odometer value from 0 to 23 
- We did this by adding modifying our method read odometer and changing our value to 23 python would just automatically change its value

#### Through a method
- Sometimes we wont want to manuelly just go in and change it like if its used in many other lines of our code or simply if we are elitists and want to do it another way 
- We can using a method all we need to do is just pass the value to a method that handles updating it

```Python
class Car:
    """A simple attempt to represent a car."""

    def __init__(self , make, model, year):
        """Initialize attributes to describe a car"""

        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0

    def get_descriptive(self):
        """Returns a neatly formated printed name"""
        long_name = f"{self.year} {self.make} {self.model}"
        return long_name.title()

    def read_odometer(self):
        """prints the statement for showing the cars milage"""
        print(f"This car has {self.odometer_reading} miles on it")
    
    def update_odometer(self, milage):
        """Updates the odometer value to the given one"""
        self.odometer_reading = milage

my_new_car = Car('audi','a4','2024')
print(my_new_car.get_descriptive())

my_new_car.odometer_reading = 23
my_new_car.read_odometer()
```

- The only thing that was changed was the update odometer method which takes in the value and assigns it the odometer reading 
- we then reference update odometer with 23 to update it

We can also some more cool shit with this method watch this -->

```Python 

class Car:
    """A simple attempt to represent a car."""

    def __init__(self , make, model, year):
        """Initialize attributes to describe a car"""

        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0

    def get_descriptive(self):
        """Returns a neatly formated printed name"""
        long_name = f"{self.year} {self.make} {self.model}"
        return long_name.title()

    def read_odometer(self):
        """prints the statement for showing the cars milage"""
        print(f"This car has {self.odometer_reading} miles on it")
    
    def update_odometer(self, milage):
        """
        Set the odometer reading to the given value reject the 
        change if it attempts to roll the odometer back
        """
        if milage >= self.odometer_reading:
            self.odometer_reading = milage
        
        else:
            print("You cant roll back on an odometer!!")

my_new_car = Car('audi','a4','2024')
print(my_new_car.get_descriptive())

my_new_car.odometer_reading = 23
my_new_car.read_odometer()
```

- Here we check if the update odometer was increased from the intitial value and let it happen
- However if someone where to try to decrease we simply say hey you can't do that
-  We simply just updated the update odometer and added an if and else statement 
```Python 
    def update_odometer(self, milage):
        """
        Set the odometer reading to the given value reject the 
        change if it attempts to roll the odometer back
        """
        if milage >= self.odometer_reading:
            self.odometer_reading = milage
        
        else:
            print("You cant roll back on an odometer!!")

```

- This how we can't allow any one to decrease the value 
#### Incrementing an Attributes value
- Lets say for example we buy a used car we cant just add a new fixed number to the odometer we must increase by how much it had when we bought it! 

```Python
    def increment_odometer(self, miles):
        """Add the given amount to the odometer reading"""
        self.odometer_reading += miles


my_used_car = Car('subaru','outback',2019)
print(my_used_car.get_descriptive())

my_used_car.update_odometer(23_500)
my_used_car.read_odometer()

my_used_car.increment_odometer(100)
my_used_car.read_odometer()
```

- We added the increment method to essentially add up how much mileage we drove from buying our car to registering it 
- we updated the used car with the update odometer as before from 23 to 23,500
- then we uses increment to add 100 so that it could add to the update method so we gave increment 100 which would add 100 to the update method 
- essentially this is how it looks on the full code 

```Python

class Car:
    """A simple attempt to represent a car."""

    def __init__(self , make, model, year):
        """Initialize attributes to describe a car"""

        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0

    def get_descriptive(self):
        """Returns a neatly formated printed name"""
        long_name = f"{self.year} {self.make} {self.model}"
        return long_name.title()

    def read_odometer(self):
        """prints the statement for showing the cars milage"""
        print(f"This car has {self.odometer_reading} miles on it")
    
    def update_odometer(self, milage):
        """
        Set the odometer reading to the given value reject the 
        change if it attempts to roll the odometer back
        """
        if milage >= self.odometer_reading:
            self.odometer_reading = milage
        
        else:
            print("You cant roll back on an odometer!!")
    
    def increment_odometer(self, miles):
        """Add the given amount to the odometer reading"""
        self.odometer_reading += miles

my_new_car = Car('audi','a4','2024')
print(my_new_car.get_descriptive())

my_new_car.odometer_reading = 23
my_new_car.read_odometer()


my_used_car = Car('subaru','outback',2019)
print(my_used_car.get_descriptive())

my_used_car.update_odometer(23_500)
my_used_car.read_odometer()

my_used_car.increment_odometer(100)
my_used_car.read_odometer()
```

We can also modify this code to allow negative increments so that the message of **hey you can't do that** pops up as well
	- Using this allows for secruritiy of our code if anyone has access to it they can modify it to an extent on our say so

[[challenge pg166]]

[[Inheritance]] 