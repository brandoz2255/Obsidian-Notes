# Applicative Order VS Normal Order
**Applicative order** is in which the expression *has all of the statements already evaluated* and **Normal order** *doesn't have all the statements evaluated* but only does so in which it is needed to be evaluated. 

Applicative Order:
``` JavaScript
function add(x, y) {
  console.log("Adding:", x, y);
  return x + y;
}

function multiply(a, b) {
  console.log("Multiplying:", a, b);
  return a * b;
}

// Applicative order: Evaluate arguments first, then apply the function
var result = multiply(add(2, 3), 4);

console.log("Result:", result);

```


Normal Order:
```JavaScript
function add(x, y) {
  console.log("Adding:", x, y);
  return x + y;
}

function multiply(a, b) {
  console.log("Multiplying:", a, b);

  // Return a function that will be evaluated later
  return function() {
    return a * b;
  };
}

// Normal order: Delay evaluation until necessary
var delayedResult = multiply(() => add(2, 3), 4);

// Force evaluation when needed
var result = delayedResult();

console.log("Result:", result);
```

- Both of these are forms of evaluation when evaluating a function programming The normal order holds a function to not be evaluated until specified otherwise and application order will evaluate it unless specified other wise as well 
## Conditional Expressions and Predicates 
A **Conditional Expressions** is *similar* to a `*switch statement* `and a *if else* statement the conditional expression occurs when *a condition is occurring* the ***function*** will do this expression. 

- However the Conditional Expression differs in a way in which this  method of doing if else in a single line to save space or just to do in a single line 

Common sytnax: 
```shell-script
condition ? expressionIfTrue : expressionIfFalse;
```

Example:
```JavaScript
var age = 25;
// condition is in parenthesis thne is if true and if false 
var message = (age >= 18) ? "You are an adult" : "You are a minor";

console.log(message);
```

**Logical Expression**: uses the `&&` symbol to say `and` in a programming language 

**Logical Dis-junction:** uses `||` to say `or` in a programming language 

**logical negation:** uses `!` to say  `not` in a programming language 

[[Exercises.sicp]]