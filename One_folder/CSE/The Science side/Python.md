



* To run a program is [ctrl f5]
*[ message] [] ***its the variable*** = "Hello meassage" **its the variable value**
*[print('message')] [] print is the function of the string ***'message'***  
* [Variable names] [] *can only contain letters numbers and underscores 
* [can never start with a number] [] 

[[input variables ]]

[[Slicing]] 

[[While loop]]

[[Functions.py]]

[[Dictionaries]]

[[Class.py]]

[[Classes.py part two]]

[[Inheritance]]

[[Importing classes]]

[[1.2 Functions and processes]] [[Py.examples]] 

[[Lab_11]]

[[Lab 12 notes]]

## AI for Python

[[AI Libraries ]]

[[AI]]

##  projects 
[[fun graph]] 

[[Python.proj]]

[[Blue team Python Projects]] 

[[Blue team idea pt2]] 

[[Project]] with ciso
# Our labs extended
[[Working with functions]]

[[decorating a program and using classes]]

1. **Problem Statement**:
    
    - Write a Python function to find the longest word in a list of words (strings).
2. **Function Signature**:
    
    - Define a function called `find_longest_word(words)`.
3. **Input**:
    
    - The function takes a single argument, `words`, which is a list of strings.
4. **Output**:
    
    - The function should return the longest word from the list.
5. **Approach**:
    
    - Initialize a variable, `longest_word`, to an empty string. This variable will store the longest word found so far.
    - Iterate through the `words` list using a `for` loop.
    - For each word in the list:
        - Check the length of the current word using the `len()` function.
        - Compare the length of the current word to the length of `longest_word`.
        - If the current word is longer, update `longest_word` with the current word.
    - After the loop completes, `longest_word` will contain the longest word in the list.
    - Return `longest_word` as the result.
6. **Pseudocode**:
    
    pythonCopy code
    
    `def find_longest_word(words):     longest_word = ""     for word in words:         if len(word) > len(longest_word):             longest_word = word     return longest_word`
    
7. **Testing**:
    
    - Test the `find_longest_word` function with different lists of words to ensure it returns the correct result.
8. **Edge Cases**:
    
    - Consider how the function should behave for edge cases, such as an empty list or a list with multiple words of the same maximum length.
9. **Optimization** (optional):
    
    - If you'd like to optimize the function further, you can handle cases where there are multiple words of the same maximum length by storing all such words in a list and returning that list.
10. **Final Testing**:
    
    - After implementing the function, perform final testing to ensure it works as expected with various inputs.

Remember to translate these notes into Python code and test your function to verify its correctness. Good luck with the challenge!

[[PYTHON CISO]]
## Removing items from a list 
- When removing items from a list in a variable 
- We can remove a stuff from a list using pop and del like variable_name.pop or del  variables_name[0 or whatever number in the list] ***remember list start at 0 like Linux***
- You could also remove using .[remove]  such as variable_name.remove(variablename_2)
- Which variablename_2 would = something  from the list in variable_name
- [.title] also makes something from a list into a title

## Adding items on a list
* you can add it by using the [.append] to variable_name such as variable_nsme.append
* .insert is used to add into the list in any spot you want from 0- as much there is on said list. 


In summary, the `def` keyword in Python is used to define functions, allowing you to encapsulate and reuse code, pass data to functions using parameters, and return values from functions. Functions are essential for organizing code and making it more modular and maintainable.

1. **Function Definition**: When you use `def`, you are defining a new function. You provide a name for the function, followed by a set of parentheses `()`, and a colon `:`. For example:
    
    pythonCopy code
    
    `def greet(name):     print(f"Hello, {name}!")`
    
    In this example, `greet` is the name of the function, and it takes one parameter `name`.
    
2. **Code Block**: After the colon, you indent and write the code that makes up the body of the function. This code block defines what the function does when it is called. For example:
    
    pythonCopy code
    
    `def greet(name):     print(f"Hello, {name}!")`
    
    The code block here contains a single `print` statement that prints a greeting with the provided `name`.
    
3. **Reusability**: Functions allow you to encapsulate a piece of code so that you can reuse it throughout your program without duplicating the code. In the example above, you can call the `greet` function multiple times with different names to print greetings for each name.
    
    pythonCopy code
    
    `greet("Alice")  # Output: Hello, Alice! greet("Bob")    # Output: Hello, Bob!`
    
4. **Parameters**: Functions can accept parameters (also called arguments) within the parentheses. These parameters are placeholders for values that you can pass to the function when you call it. For example, `name` in the `greet` function is a parameter.
    
    pythonCopy code
    
    `def add(x, y):     return x + y`
    
    In this example, the `add` function takes two parameters, `x` and `y`, and returns their sum.
    
5. **Return Value**: Functions can also return values using the `return` statement. The value returned by the function can be assigned to a variable or used in expressions.
    
    pythonCopy code
    
    `def add(x, y):     return x + y`
    
    When you call `add(2, 3)`, it returns `5`, and you can use this value in your program.


[[Dictionaries ]]