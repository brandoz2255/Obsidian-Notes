```python
# Brandon Sanchez
# 55
# 11/1/2023
# Lab 10

# Remark: This program allows the user to input fruit names and their corresponding weights, and then displays the list of all fruits entered.

# Remark: Create the user greeting.
print("Welcome to the Fruit Weight Tracker!")

# Remark: Initialize/create two empty lists.
fruit_types = []
fruit_weights = []

# Remark: Initialize/create a variable to control the user input loop.
continue_input = True

# Remark: Create the user input loop.
while continue_input:
    # Remark: Get the input for fruit type.
    fruit_name = input("Please enter a type of fruit or press Enter to finish: ")

    if fruit_name == "":
        continue_input = False
    else: 
        # Remark: Get the input for weight.
        fruit_weight = float(input(f"Enter the weight of {fruit_name} in pounds: "))
        fruit_types.append(fruit_name)
        fruit_weights.append(fruit_weight)


# Remark: Display the list of all fruits entered.
if len(fruit_types) > 0:
    print("\nFruit Weight List:")
    print("----------------------------")
    for index in range(len(fruit_types)):
        print("{:<20} {:>10} lbs.".format(fruit_types[index], fruit_weights[index]))
else:
    print("No fruits were entered.")

# Remark: Display the closing message.
print("\nThank you for using the Fruit Weight Tracker!")
```


-  `append`: append is a method used for list. It essentially allows you to add an item to the end of a list.  like for example 
	- when you have a list called `my_list` you can then add an element to using it 
	- `my_list.append(item)` , where `item` is the value you want to add.
	- `fruits.append(user_input_1)` to add the type of fruit entered by the user to the `fruits` list. 
	- 