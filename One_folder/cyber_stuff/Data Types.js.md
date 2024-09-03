The Fundamentals of different data types  in JavaScript and how to set them as  a variable in JS 

# Primitive Data Types 

Java scripts has 6 different primitive data types 

- A **Number** is a integer type of a data type in JS it represents numerical values from integers and real numbers 

```JavaScript
let age = 25;
let price = 19.99;

```

- Another data type in JS is the **string data** type represents any textual based data 

```JavaScript
let name = "John";
let message = 'Hello, World!';
```

- Another type of data is th **Boolean** data that in which represents the values of true or false 

```JavaScript
let isStudent = true;
let hasLicense = false;
```

- **Undefined** Represents the absence of a value or an uninitialized variable

```JavaScript
let undefinedVar;
```

- **Null** A  complicated data type that represents the intentional absence of any object value 

```JavaScript
let nullVar = null;
```

- **Symbol** is a data type that is supposed to represent a unique identifier used for property keys 

```JavaScript
let uniqueKey = Symbol("description");

```

Now that we have gone over the different data types and their example of the usage we can look at the `Variables` and how they can be set 

## Variables 
- in JavaScript you can use `var`, `let`, or `const` to declare variables 

A `var`: in JS is the general method to display a variable however it has issue in complicated scenarios such as function scoping 

```JavaScript
var x = 10;
```

B `let` introduced in the ES6 update of JS has the ability of block-scoping 

```JavaScript
let y = 20;
```

Block Scoping is 

C `const` also introduced in ES6 which basically declares a variable to be a literal constant aka unchangeable variable 

```JavaScript
const PI = 3.14;
```


### Type conversion 
We can combine data and convert them to convert a string into a number type we can do the following 

Implicit conversion
```JavaScript
let numString = "25";
let num = parseInt(numString);
```

explicit coversion
```Javascript
let numString = "25";
let num = parseInt(numString);
```

To combine strings 

```JavaScript 
let firstName = "John";
let lastName = "Doe";
let fullName = firstName + " " + lastName;
```

We can combine multiple boolean values with operators refer to the SICP and C++ on what a operator is 

```JavaScript
let isTrue = true;
let isFalse = false;
let andResult = isTrue && isFalse; // false
let orResult = isTrue || isFalse; // true
```


