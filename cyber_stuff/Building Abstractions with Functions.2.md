## Evaluating operator combinations 
This refers to the idea when using operator combinations we must be thinking proceduraly 

- When making a Operator combinations we much think of each expression as a procedure in steps to solve our problem or task at hand 
- This idea is called **tree accumulation** which is breaking down what its doing in the procedure level

GPT def: Tree accumulation is a method of seeing an algorithim in which we can construct the answer to a problem with looking at it as a tree and as we go down the tree the ways we complete the task 

```JavaScript 
class TreeNode {
    constructor(value) {
        this.value = value;
        this.left = null;
        this.right = null;
    }
}

// Tree:
//       1
//      / \
//     2   3
//    / \
//   4   5

const root = new TreeNode(1);
root.left = new TreeNode(2);
root.right = new TreeNode(3);
root.left.left = new TreeNode(4);
root.left.right = new TreeNode(5);

// In-order traversal with accumulation
function inOrderTraversal(node, accumulator) {
    if (node !== null) {
        inOrderTraversal(node.left, accumulator);
        accumulator.push(node.value); // Accumulate values
        inOrderTraversal(node.right, accumulator);
    }
}

const result = [];
inOrderTraversal(root, result);
console.log(result); // Output: [4, 2, 5, 1, 3]
```

## Compound Functions 
Think of compound functions as user defined types in which they are functions in which we instruct multiple parameters to be used and multiple expressions to complete. 

- Can be given a name and be reffered to as a unit basically what the function is as a whole 
- and the difference between a primitive function which is a function that comes with the standard library or an imported library

``` JavaScript
function subtract(a, b) {
   return a - b;
}

function add(a, b) {
   return a + b;
}

function subtractAndAdd(x, y, z) {
   return add(subtract(x, y), z);
}

console.log(subtractAndAdd(10, 20, 30)); // Output: 40
```

- This is the example of a compound function which are functions that build off of each other keep in mind a class is just a way to manage compound functions

### Substitution model 

```JavaScript
// define the function 'double'
function double(x) {
    return x * 2;
}

// define the function 'triple'
function triple(x) {
    return x * 3;
}

// define the function 'doubleAndAdd'
function doubleAndAdd(x, y) {
    return x + y;
}

console.log(doubleAndAdd(double(5), triple(5))); // Output: 60
```

Compound functions are known as the substitution model its called this since they subsitute the placeholder of the parameter as seen in the past code snipets 
