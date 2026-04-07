---
title: Web Applications
sub_title: Clousers, Currying, Destructuring, Spread Operator, Rest Operator, and Generators
author: Suhel Hammoud

theme:
  override:
    code:
      alignment: left
      margin:
        percent: 3
      #   padding:
      # horizontal: 4
---

# Advanced JavaScript Features

<!-- incremental_lists: true -->

- Closures
- Currying
- Destructuring Parameters
- Spread Operator
- Rest Operator
- Generators

These features enhance expressiveness, modularity, and control flow in modern JavaScript.

<!-- end_slide -->

## Closures: Capturing State

<!-- pause -->

A **closure** is created when a function "remembers" the variables from its outer scope, even after the outer function has finished executing.

<!-- pause -->

### 🧪 Example:

```js
function makeCounter() {
  let count = 0;
  return function () {
    return ++count;
  };
}

const counter = makeCounter();
console.log(counter()); // 1
console.log(counter()); // 2
```

<!-- pause -->

✅ `count` persists across function calls — that's a closure!

<!-- end_slide -->

## Closures: Real-World Uses

<!-- incremental_lists: true -->

- Data encapsulation
- Function factories
- Maintaining private state
- Event handlers and callbacks

### 💡 Tip:

Closures are foundational in functional and asynchronous programming in JavaScript.

<!-- end_slide -->

## Currying: Breaking Functions into Steps

<!-- pause -->

**Currying** is the process of transforming a function with multiple parameters into a sequence of functions, each taking one parameter.

<!-- pause -->

### 🧪 Example:

```js
function multiply(a) {
  return function (b) {
    return a * b;
  };
}

const double = multiply(2);
console.log(double(5)); // 10
```

<!-- pause -->

✅ Each function remembers its argument through a closure.

<!-- end_slide -->

## Currying: With Arrow Functions

<!-- pause -->

You can write curried functions concisely using ES6 arrow syntax:

<!-- pause -->

```js
const add = (a) => (b) => a + b;

console.log(add(3)(4)); // 7
```

<!-- pause -->

### 💡 Why Curry?

- Enables **function reuse**
- Useful in **functional composition**
- Cleaner **partial application** of arguments

<!-- end_slide -->

## Destructuring Parameters: Unpacking Values

Destructuring allows extracting values from arrays or objects and assigning them to variables in a single step.

<!-- pause -->

### 🧪 Array Example:

```js
const [x, y] = [10, 20];
console.log(x, y); // 10 20
```

<!-- pause -->

### 🧪 Object Example:

```js
const user = { name: "Alice", age: 30 };
const { name, age } = user;
console.log(name, age); // Alice 30
```

<!-- end_slide -->

## Destructuring Function Parameters

<!-- pause -->

You can destructure directly in the function signature:

<!-- pause -->

```js
function greet({ name, age }) {
  console.log(`Hello ${name}, age ${age}`);
}

greet({ name: "Bob", age: 25 });
```

<!-- pause -->

✅ Clean and concise for objects with multiple keys

💡 Also works in array-based function params

<!-- end_slide -->

## The Spread Operator (`...`)

<!-- pause -->

The **spread operator** expands an array (or object) into individual elements.

<!-- pause -->

### 🧪 Examples:

```js
const nums = [1, 2, 3];
console.log(...nums); // 1 2 3

const arr1 = [1, 2];
const arr2 = [...arr1, 3, 4];
console.log(arr2); // [1, 2, 3, 4]

const obj1 = { a: 1, b: 2 };
const obj2 = { ...obj1, c: 3 };
console.log(obj2); // { a: 1, b: 2, c: 3 }
```

<!-- pause -->

✅ Useful for:

- Cloning arrays/objects
- Concatenation
- Passing arguments to functions

<!-- end_slide -->

## The Rest Operator (`...`)

<!-- pause -->

The **rest operator** collects remaining items into a single array or object.

<!-- pause -->

### 🧪 Function Parameters:

```js
function sum(...nums) {
  return nums.reduce((a, b) => a + b, 0);
}
console.log(sum(1, 2, 3)); // 6
```

<!-- pause -->

### 🧪 Destructuring:

```js
const [first, ...rest] = [10, 20, 30, 40];
console.log(first); // 10
console.log(rest); // [20, 30, 40]
```

<!-- pause -->

✅ Rest syntax helps capture "the rest" of a list or arguments cleanly.

<!-- pause -->

💡 Spread **expands**, Rest **gathers** — same syntax, opposite purpose depending on context.

<!-- end_slide -->

## Destructuring Function Parameters

<!-- pause -->

You can destructure directly in the function signature:
f

```js
let reverse = ([first, ...rest]) =>
  rest.length == 0 ? [first] : [...reverse(rest), first];
```

<!-- pause -->

✅ Clean and concise for objects with multiple keys

💡 Also works in array-based function params

<!-- end_slide -->

## Generators: Pausable Functions

<!-- pause -->

Generators are special functions that can **pause and resume** their execution using `yield`.

<!-- pause -->

### Syntax:

```js
function* generatorFunc() {
  yield 1;
  yield 2;
  yield 3;
}
```

<!-- incremental_lists: true -->

- Use `*` in function declaration
- Use `yield` to return values incrementally
- Call `.next()` to resume execution

<!-- end_slide -->

## Using Generators

<!-- pause -->

<!-- column_layout: [1, 1] -->
<!-- column: 0 -->

```js
function* idGenerator() {
  let id = 1;
  while (true) {
    yield id++;
  }
}
```

<!-- column: 1 -->
<!-- pause -->

```js
const gen = idGenerator();

console.log(gen.next().value); // 1
console.log(gen.next().value); // 2

const [a, b, , c, d] = idGenerator();
console.log(a, b, c, d); // 0 1 3 4
```

<!-- reset_layout -->
<!-- pause -->

✅ Generators are useful for:

<!-- incremental_lists: true -->

- Iterators
- Lazy evaluation
- Asynchronous control flows

<!-- end_slide -->

## Summary

| Feature         | Description                                        | Use Case                            |
| --------------- | -------------------------------------------------- | ----------------------------------- |
| Closures        | Functions that retain access to outer scope        | Data hiding, stateful logic         |
| Currying        | Break a function into chained calls                | Reuse, function composition         |
| Destructuring   | Extract values from objects/arrays                 | Clean code, easy parameter access   |
| Spread Operator | Expands arrays/objects into individual elements    | Merging, cloning, argument passing  |
| Rest Operator   | Collects multiple items into a single array/object | Variadic functions, flexible inputs |
| Generators      | Functions that pause with `yield`                  | Iterators, async control flow       |

<!-- end_slide -->

# References

- https://developer.mozilla.org
