As we know now from C++ and Python that Functions are simply blocks of code containing expressions  

- We can define the reusable block of code with this syntax 
```JavaScript
function greet(name) {
   console.log("Hello, " + name + "!");
}

greet("John"); // Outputs: Hello, John!

```

- In JS we can assign a function to a variable as seen in this code snippet 

```JavaScript
const greet = function(name) {
   console.log("Hello, " + name + "!");
};

greet("Jane"); // Outputs: Hello, Jane!
```

- Arrow functions are another method for function expressions 

```JavaScript
const greet = function(name) {
   console.log("Hello, " + name + "!");
};

greet("Jane"); // Outputs: Hello, Jane!

```


- Functions that return values 

``` JavaScript
function multiply(x, y) {
   return x * y;
}

let result = multiply(2, 4);
console.log(result); // Outputs: 8
```






