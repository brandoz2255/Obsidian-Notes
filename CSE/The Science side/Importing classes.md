- We have imported a Class before in Python we did by making our Lab 13 and combining it with Lab 12 
- The easiest way to do this was turning Lab 12 into a class that python can read and make our code work 

```Python
from module_name import class_name
```

-  here we have acess to all the instances and methods from the class as well as the functions and everything we need 

Here is an example 

```Python
# module1.py

class Car:
    def __init__(self, make, model, year):
        self.make = make
        self.model = model
        self.year = year
        self.mileage = 0

    def display_info(self):
        print(f"{self.year} {self.make} {self.model}, Mileage: {self.mileage} miles")

    def drive(self, miles):
        print(f"Driving {miles} miles...")
        self.mileage += miles
        print(f"Total mileage: {self.mileage} miles")

```

- This is a simple class of a car descirption 
- now lets import it to another module 

```Python 
# module2.py

# Import the Car class from module1
from module1 import Car

# Create an instance of Car
my_car = Car(make="Toyota", model="Camry", year=2020)

# Display car information
my_car.display_info()

# Drive the car
my_car.drive(100)

# Display updated car information
my_car.display_info()

```

- Using classes in Python  is the most effective method to implement into our programming concepts