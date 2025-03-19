An Array has to do with sequences of identically typed variables in C++
- An array type is the contained type and the number of contained elements
- we connect all this together with this syntax 

```C++
int my_array[100];
```

- As we can see the syntax is the data type followed by the name of the array and enclosed by brackets is the numerical value

## Array initialization
- Using braces we can intitialize an array such as 

```C++
int array[] = {1, 2, 3, 4};
```

- we can omit the length of the array since it can be called upon within the braces by the time it is compiled

### Accessing Array Elements 
- In order to access an array of elements it must be done using square brackets as seen in our previous code snipet 
- Just like in most programming languages and computer databases the index starts at 0 instead of 1 

```C++
#include <cstdio>

int main() {
    int arr[] = {1, 2, 3, 4};
    printf("The third element is %d.\n", arr[2]);
    arr[2] = 100;
    printf("The third element is %d.\n", arr[2]);
}
```

- This makes a four element array named arr the elements being 1 2 3 4 
- The following lines call upon printing the third element 2 and then applying that element to equal 100 then reprinting that statement 

### For loops tour
Using For loops allows us to repeat a process in our code in which the execution of a statement for a specified number of times 

- Using For loops we can specifiy how much it repeats itself or on what situation it repeats itself 
- For example if the situation equals true the process of the program repeats its self until it ends up a false then the process terminates 
- the init statement in C++ must execute first in order before the other iterations taht were used in the loop
- conditional is whats evaluated for each iteration 
-  General syntax for for loops

**Syntax**:
```C++
for (init-statement;conditional;iteration-statement){

}
```

```C++
#include <cstddef>
#include <cstdio>

int main(){
	unsigned long maximum = 0;
	unsigned long values[] = {10, 50, 20, 40, 0};
	for(size_t i=0; i < 5; i++) {
		if (values[i] > maximum) maximum = values[i];
	}
	printf("the maximum value is %lu", maximum);

}
```

- This is how we would use a for loop in example we used it here to find the maximum of an array
- In the first line the maximum is initialized in the second we initialized the array of values in the third we iterate it using the for loop 
- then we check if it is greater than the current maximum and then set the new value    
		- Initialization: int i = 1 initializes the loop control variable i to 1.
	    - Condition: i <= 5 is the condition. The loop continues as long as i is less than 5.
	    - Update: i++ increments the value of i by 1 after each iteration.


## Number of elements in an array 
- The Sizeof (array) operator evaluates the the total size in bytes of an array 
- We can determine by dividing the size of the array by the size of the single element 

```C++
short array[] = {104, 105, 32, 98, 105, 108, 0};
size_t n_elements = sizeof(array) / sizeof(short);

```

- This is the general syntax for evaluating the number of elements the array has 
- The short array is the total size in bytes of the array that is given 
- The `division` here is `just to calculate the total number of elements in the array `
- Which is then stored in the variable `n_elements` which is number of elements 

We will learn in part two of the book how we can safely store other data in C++ however for now lets just stick to using the std namespace with the `<iterator>` header

- std size can also be used with any container like all the ones mentioned in chapter 13 and how we can use it in chapter 6 

[[C-style strings]]