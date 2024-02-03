## Variables and Data types 

**Variables** in JS are declared using the argument of `var` `let` or `const` 

```JavaScript
var myVar = 42;
let myVar2 = "Hello";
const PI = 3.14;

```

**Data Types** in JS Im assuming they are the same in other programming lanuages such as integers floats , and strings , characters 

``` JavaScript
let num = 42;        // Number
let text = "Hello";  // String
let isTrue = true;   // Boolean

```

**Operators** Arithmetic, assignment, comparison, logicak operators, etc.

```JavaScript
let result = 5 + 3;
let isEqual = (result === 8);

```

**Control Flow** such as the if else else if statments 

```JavaScript 
if (condition) {
   // code to execute if the condition is true
} else {
   // code to execute if the condition is false
}

```

also wtith statements such as for and while loops 

```JavaScript
for (let i = 0; i < 5; i++) {
   // code to repeat
}

```

**Define Functions** in JS with the `function` statement 

```JavaScript
function greet(name) {
   return "Hello, " + name + "!";
}

// Function invocation
let greeting = greet("John");

```

There are also arrow functions 

```JavaScript
const greet = (name) => "Hello, " + name + "!";

```


Arrays we can create and manipulate arrays in JS 

```JavaScript
let fruits = ["apple", "orange", "banana"];
fruits.push("grape");

```

Creating objects in JS

```JavaScript
let person = {
   name: "John",
   age: 25,
   isStudent: false
};

```

DOM for HTML web servers with client side interaction

```JavaScript
// Select an element by its ID
let myElement = document.getElementById("myId");

// Change its content
myElement.innerHTML = "New content";

```

