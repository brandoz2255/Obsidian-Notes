**Linear Recursion** is where a function calls it self in a sequence 
```Python
def factorial_using_recursion(n):
   if n == 0:
       return 1
   else:
       return n * factorial_using_recursion(n - 1)

print(factorial_using_recursion(5)) # Outputs: 120

```


**Linear iteration** on the other hand uses a loop until the comndition of the program is met 

```Python
def factorial_using_iteration(n):
   res = 1
   for i in range(2, n + 1):
       res *= i
   return res

print(factorial_using_iteration(5)) # Outputs: 120

```