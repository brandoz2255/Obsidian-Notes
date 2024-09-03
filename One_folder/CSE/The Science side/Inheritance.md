What an inheritance is essentially that we don't always need to make a class from scratch like lets we have made one from the past and we just want to import it from another module or that we want use someone elses class.

- Essentially This is called **inheritance** we call from past class or use another one 
- The thing about inheritance is when we use this in Python there is a child and parent class where the parent class is the original and the child class is the new one 
- A child class can inherit most of the methods and instances of the parent if not all depending on the usage 
- A child class can also have its own unique methods and instances apart from the parent class 

# Init method for a child class
When using the init method for a child class that is based on the parent class we essentially tell python to take the **init** in the parent class to be used in the child one

- For example we are going to make an electric car class based off of the car class we created earlier [[Classes.py part two]] 
- The simple version for now is that we are gonna make the electirc car class and have it do everything that the car class can do

```Python
class Car:
    """A simple attempt to represent a car."""

    def __init__(self , make, model, year):
        """Initialize attributes to describe a car"""

        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0

    def get_descriptive_name(self):
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

class ElectricCar(Car):
    """Represents aspects of an Electric Car"""
    
    def __init__(self, make, model, year):
        """Initializes attributes of the parent class"""
        super().__init__(make, model, year)


my_leaf = ElectricCar('nissian','leaf','2024')
print(my_leaf.get_descriptive_name())

my_new_car = Car('audi','a4','2024')
print(my_new_car.get_descriptive_name())

my_new_car.odometer_reading = 23
my_new_car.read_odometer()


my_used_car = Car('subaru','outback',2019)
print(my_used_car.get_descriptive_name())

my_used_car.update_odometer(23_500)
my_used_car.read_odometer()

my_used_car.increment_odometer(100)
my_used_car.read_odometer()
```

- When creating a child class from a parent class the ==child must come after== the **parent** *within the same file*
- Then we define our child class as we would for a class in this instance class electric car difference is we must put the parent in the parenthesis when using a child class 
- After using the **init** we must use the super function which essentially takes the methods and instances from the parent class
- Super just tells python that the ==parent class== is the **super class** in this file and the ==child class ==is the **subclass**
- we then test it by assigning the subclass to the variable **my leaf** then we provide the attributes 


## Defining attributes and methods
Of course as we have mentoned earlier in this note is that we can add any methods and instances to a subclass [childclass] in python 

- For example since we created the child class electric car we can add attributes specific to the electric guitar such as a battery for example 

```Python

class Car:
    """A simple attempt to represent a car."""

    def __init__(self , make, model, year):
        """Initialize attributes to describe a car"""

        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0

    def get_descriptive_name(self):
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

class ElectricCar(Car):
    """Represents aspects of an Electric Car"""
    
    def __init__(self, make, model, year):
        """Initializes attributes of the parent class
        The initialized attributes specific to an electric car
        """
        super().__init__(make, model, year)
        self.battery_size = 40

    def describe_batteru(self):
        """Print a statement describing the battery life"""
        print(f"this car has a {self.battery_size}-kwh battery")


my_leaf = ElectricCar('nissian','leaf','2024')
print(my_leaf.get_descriptive_name())

my_new_car = Car('audi','a4','2024')
print(my_new_car.get_descriptive_name())

my_new_car.odometer_reading = 23
my_new_car.read_odometer()


my_used_car = Car('subaru','outback',2019)
print(my_used_car.get_descriptive_name())

my_used_car.update_odometer(23_500)
my_used_car.read_odometer()

my_used_car.increment_odometer(100)
my_used_car.read_odometer()
```

- We added the new attribute called **battery size** and gave it a value in which we can call upon using the child class
- Which would work on all instances associated with the **child class**
- We also use a method called **describe battery** so that we could print out the description 
- If we want to add onto the parent we would have to modify the code within the parent class because the code in child class is only accessible via association with the child class

## Override method from the Parent
When using a child class in Python sometimes we won't need some methods that are in the parent class such as the electric car for example:

- Lets say that the parent class car has a method for filling a gas tank we wont need this since well its an electric vehicle

```Python 
class ElectricCar(Car):
    """Represents aspects of an Electric Car"""
    
    def __init__(self, make, model, year):
        """Initializes attributes of the parent class
        The initialized attributes specific to an electric car
        """
        super().__init__(make, model, year)
        self.battery_size = 40

    def describe_batteru(self):
        """Print a statement describing the battery life"""
        print(f"this car has a {self.battery_size}-kwh battery")

    def fill_gas(self):
        """Electric vehicles dont have gas tanks"""
        print("This car doesn't have a gas tank!")

```

- we override the fill gas method by taking it from the **parent class** and giving it a different **output** that prints ==hey you cant do that on a EV!==
- We can essentially override anything we don't need in a child class from a parent class 

## Instances as an attribute
As we work on the same class trying to code something using the OOP [[Classes.book]]
method of propgramming our classes are gonna get lengthy the method to fix this is called **composition** 

- Essentially its which we have the parent class and the child class then add a new class that is linked to either the child class or parent class depending on what it is we want more description on 

***The process of taking a bigger class and dividing it into smaller ones***

- For our case the EV we would make a seperate class for the method battery in the Electric car class 
- This would work if we are adding more detail towards the cars battery 

```Python
class Car:
    """A simple attempt to represent a car."""

    def __init__(self , make, model, year):
        """Initialize attributes to describe a car"""

        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0

    def get_descriptive_name(self):
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

class Battery:
    """A simple attempt to create the battery class"""

    def __init__(self,battery_size = 40):
        """Intitializes the batteries size"""
        self.battery_size = battery_size

    def describe_battery(self):
        """Initializes the description of the battery size"""
        print(f"This size of the battery is {self.battery_size}-kwh battery")

class ElectricCar(Car):
    """Represents aspects of an Electric Car"""
    
    def __init__(self, make, model, year):
        """Initializes attributes of the parent class
        The initialized attributes specific to an electric car
        """
        super().__init__(make, model, year)
        self.battery = Battery()

    def describe_battery(self):
        """Print a statement describing the battery life"""
        print(f"this car has a {self.battery}-kwh battery")

    def fill_gas(self):
        """Electric vehicles dont have gas tanks"""
        print("This car doesn't have a gas tank!")


my_leaf = ElectricCar('nissian','leaf','2024')
print(my_leaf.get_descriptive_name())
my_leaf.battery.describe_battery()


my_new_car = Car('audi','a4','2024')
print(my_new_car.get_descriptive_name())

my_new_car.odometer_reading = 23
my_new_car.read_odometer()


my_used_car = Car('subaru','outback',2019)
print(my_used_car.get_descriptive_name())

my_used_car.update_odometer(23_500)
my_used_car.read_odometer()

my_used_car.increment_odometer(100)
my_used_car.read_odometer()
```

- In this snipet we define a new class called batter in which it doesn't inherit anything from any other class 
- Its just gonna get linked to one in this case the child class
- Since its a composition class we give it one parameter for the description we are using of course we could add more if wanted to
- we set the default size to 40 if no value is provided and descriobe battery has been move to this class 
- Now a new attribute is added to the in the child class so that python can create the new instance

```Python 
My_leaf.battery.describe_battery()
```

- This essentially takes the code from child 
```Python 

    def get_range(self):
        """Print a statement about the range"""
        if self.battery_size == 40:
            range = 150
        elif self.battery_size == 65:
            range = 225
        print(f"this car can go about {range} miles on a full charge")

```

- We would essentially add this to our electric car class and then -->
- With this new method we added it uses the get range statement to set the range at its given input in such if the value is 40 it tells what the mileage is same goes for 65 

# Conclusion
Overall these notes together are how we work with the OOP object oriented programming this is a key step into programming we cant just make a program to do this certain task when working with simulating real world examples. we must use a constructed formulated plan in which for example is the battery its own class or does it belong to the child class. Such question will get us thinking yea when talking about one specific car but when we work with the idea of doing many different types of models this poses the idea oh now we must move it to the child class again and create another class for each model with giving it its own inheritance. Or we could also add new parameter model 

- The general idea is that there is no right or wrong answers its just the best way to program said simulation

Next notes from 173 to 181

[[Importing classes]]



[[challenge page 173]]: First we have to do the one on page 162 in order to do this one