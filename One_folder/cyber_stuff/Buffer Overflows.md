A buffer  is how we can interact with memory without abstraction this is done with a bracket operator or with a pointer arithmetic

- A buffer is a method of temporarily holding data while its being transferred to the RAM or the disk drives or from RAM to disk drives 
- The **overflow** happens when the data exceeds the size of the buffer which is bad and we must never do 

```C
char buffer[50];

gets(buffer); // The user can enter more than 50 characters, causing a buffer overflow
```

- what to do instead to stop overflow

```C
char buffer[50];

fgets(buffer, sizeof(buffer), stdin); // The user cannot enter more than 50 characters, preventing a buffer overflow
```



## Concection between brackets 
The connection between the two is that when using a arithmetic pointer and the bracket operators can both result in the same overflow problems 

- The brackets specify what sections you want to manipulate 
- the pointers point to where you want to manipulate so the same problem can arise

Example and comparison of both usage 
```C
int arr[5] = {1, 2, 3, 4, 5};

printf("%d\n", arr[0]); // Equivalent to *(arr+0) using pointer arithmetic
printf("%d\n", arr[1]); // Equivalent to *(arr+1) using pointer arithmetic
printf("%d\n", arr[2]); // Equivalent to *(arr+2) using pointer arithmetic
```

Note: in C++ we don't need format specifiers

### Void pointers and std::byte pointers
- A void pointer is used generally when the pointed-to data is irrelevent so the void just C++ that it is so
- The std::byte is the pointer for when we want to point to something on the byte level of data 
# Null Ptr and Bool expressions 
- A nullptr is when you tell C++ to stop since it has run out of memory to allocate so with a bool expression we return nullptr to indicate false in a bool expression 
## References 

- A version of the pointers that generally have a simpler syntax they can used with the & decelerator and then the type name 
- It is called a reference sinc it in't pointing new data to a varaible it just simpley refernces a variable 

``` C
int num = 10;
int &ref = num; // 'ref' is a reference to 'num'

cout << ref << endl; // Outputs 10, the value of 'num'

ref = 20; // Updates the value of 'num' through the reference

cout << num << endl; // Outputs 20, the new value of 'num'
```

### Usage of pointers and references 

- A pointer points a variable to a different memory location changing its data type 
- When on the other hand a reference changes it data but uses the same memory location throughout its lifetime 
- If you want to change the data location of reference that is when you use a pointer