- Dictionaries are essentially the how you connect pieces of related information in python 
- They basically just store information and can store a limitless amount of information
Example 
``` Python
# Create a dictionary to store information about a person
person = {
    'first_name': 'John',
    'last_name': 'Doe',
    'age': 30,
    'city': 'New York'
}

# Access and print values from the dictionary
print("First Name:", person['first_name'])
print("Last Name:", person['last_name'])
print("Age:", person['age'])
print("City:", person['city'])

# Modify a value in the dictionary
person['age'] = 31

# Add a new key-value pair to the dictionary
person['email'] = 'john.doe@email.com'

# Print the updated dictionary
print("\nUpdated Dictionary:")
print(person)

# Iterate through the dictionary and print key-value pairs
print("\nKey-Value Pairs:")
for key, value in person.items():
    print(key + ":", value)

```