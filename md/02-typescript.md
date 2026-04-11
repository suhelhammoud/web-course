---
title: Web Applications
sub_title: TypeScript
author: Suhel Hammoud

theme:
  override:
    code:
      alignment: left
      margin:
        percent: 3
---

# TypeScript for JavaScript Programmers

TypeScript extends JavaScript by adding a powerful type system. It catches errors early, making your code more reliable.

* Static typing helps detect bugs during development
* Improves IDE support (autocomplete, refactoring)
* Scales better for large applications

<!-- end_slide -->

# The Basics

* TypeScript is a superset of JavaScript
* You can gradually adopt it
* Compiles to plain JavaScript

```typescript
let message: string = "Hello";
let count: number = 10;
```

* Types are erased at runtime

<!-- end_slide -->

## Everyday Types

Common types used daily:

* `string`, `number`, `boolean`
* Arrays: `string[]`
* Objects: `{}`

```typescript
let age: number = 30;
let isAdmin: boolean = true;
let names: string[] = ["Alice", "Bob"];
```

* These are the building blocks of all programs

<!-- end_slide -->

## Types by Inference

TypeScript infers types automatically.

```typescript
let helloWorld = "Hello World";
```

* Reduces verbosity
* Keeps code readable
* Still provides full type safety

<!-- end_slide -->

## Defining Types

When inference is not enough, define types explicitly.

* Improves readability
* Documents intent

<!-- column_layout: [1, 1] -->

<!-- column: 0 -->

```typescript
const user = {
  name: "Hayes",
  id: 0,
};
```

<!-- column: 1 -->

```typescript
interface User {
  name: string;
  id: number;
}

const user: User = {
  name: "Hayes",
  id: 0,
};
```

<!-- reset_layout -->

<!-- end_slide -->

## TypeScript Warnings

* Helps catch mistakes early
* Prevents runtime bugs

```typescript
interface User {
  name: string;
  id: number;
}

const user: User = {
  username: "Hayes", // Error
  id: 0,
};
```

<!-- end_slide -->

## Narrowing

<!-- incremental_lists: true -->
TypeScript can refine types based on conditions.

* Uses `typeof`, `instanceof`, and checks
* `typeof` for checking primitive types
* `instanceof` for checking arrays and class types
* Makes unions safe to use

```typescript
function printId(id: number | string) {
  if (typeof id === "string") {
    console.log(id.toUpperCase());
  } else {
    console.log(id);
  }
}
```
<!-- end_slide -->

## More on Functions

* Parameters and return types can be typed
* Functions are first-class citizens

```typescript
function deleteUser(user: User) {}

function getAdminUser(): User {
  return { name: "Admin", id: 1 };
}
```

* Helps enforce contracts between components

<!-- end_slide -->

## Object Types

* Define structure of objects
* Can be inline or reusable

```typescript
function printUser(user: { name: string; age: number }) {
  console.log(user.name);
}
```

* Useful for APIs and data models

<!-- end_slide -->

## Primitive Types

<!-- incremental_lists: true -->
Additional types:

* `any`: disables type checking

* `unknown`: safer alternative to `any`

* `never`: represents unreachable values

* `void`: no return value

* Prefer strict typing over `any`

<!-- end_slide -->


## Optional properties

```typescript
type User = {
  name: string;
  age?: number; // optional
};
```
👉 age? means: it can exist (number) or be missing (undefined)

<!-- end_slide -->

## Accessing optional properties

### Handle Undefined:

```typescript
function printAge(user: User) {
  if (user.age !== undefined) {
    console.log(user.age.toFixed(0));
  }
}
```
<!-- end_slide -->

## Accessing optional properties II

### Use Optional Chaining:

```typescript
user.age?.toFixed(0);
```

### Optional + destructuring

```typescript
function show({ age }: User) {
  console.log(age ?? "No age");
}
```
<!-- end_slide -->

## Composing Types

### Unions

```typescript
type MyBool = true | false;
type WindowStates = "open" | "closed" | "minimized";
```

* Combine multiple possible values

### Example

```typescript
function getLength(obj: string | string[]) {
  return obj.length;
}
```

<!-- end_slide -->

## Type Guards with `typeof`

```typescript
function wrapInArray(obj: string | string[]) {
  if (typeof obj === "string") {
    return [obj];
  }
  return obj;
}
```

* Enables safe operations on unions

<!-- end_slide -->

## Type Manipulation

<!-- incremental_lists: true -->

* Create new types from existing ones
* Use utility types
* Helps reduce duplication and keep types consistent across your codebase
* Makes it easier to build flexible and reusable type definitions
* Avoid duplication
* Improve maintainability

<!-- end_slide -->

## Creating Types from Types

<!-- pause -->

### Partial Type
```typescript
type User = { name: string; age: number;};
type PartialUser = Partial<User>;
```
<!-- pause -->
Constructs a type with all properties of 'User' to optional

<!-- pause -->
### Readonly Type

```typescript
type Point = { x: number; y: number };
type ReadonlyPoint = Readonly<Point>;
```
<!-- pause -->
Constructs a type with all properties of 'User' set to readonly



<!-- end_slide -->

## Generics

* Reusable, flexible types

```typescript
function identity<T>(arg: T): T {
  return arg;
}
```

* Works with any type

<!-- end_slide -->

## Generics Example

```typescript
interface Backpack<T> {
  add: (obj: T) => void;
  get: () => T;
}

declare const backpack: Backpack<string>;
const object = backpack.get();
backpack.add(23); // Error
```

<!-- end_slide -->

## Keyof Type Operator

```typescript
type User = { name: string; id: number };
type Keys = keyof User;
```

* Produces union of keys

<!-- end_slide -->

## Typeof Type Operator

```typescript
const user = { name: "Alice" };
type UserType = typeof user;
```

* Extracts type from value

<!-- end_slide -->

## Indexed Access Types

```typescript
type User = { name: string; age: number };
type Age = User["age"];
```

* Access property types directly

<!-- end_slide -->

## Conditional Types

```typescript
type IsString<T> = T extends string ? true : false;
```

* Enables logic in types

<!-- end_slide -->

## Mapped Types

```typescript
type OptionsFlags<Type> = {
  [Property in keyof Type]: boolean;
};
```

* Transform all properties of a type

<!-- end_slide -->

## Template Literal Types

```typescript
type Greeting = `Hello ${string}`;
```
Valid Example:

```typescript
const g1: Greeting = "Hello Alice";
const g2: Greeting = "Hello world";
const g3: Greeting = "Hello 123";
```
* Build dynamic string types

<!-- end_slide -->

## Classes and Interfaces

```typescript
interface User {
  name: string;
  id: number;
}

class UserAccount {
  constructor(public name: string, public id: number) {}
}

const user: User = new UserAccount("Murphy", 1);
```

* Supports OOP patterns

<!-- end_slide -->

## Structural Type System

* TypeScript checks structure, not name

```typescript
interface Point {
  x: number;
  y: number;
}

function logPoint(p: Point) {
  console.log(`${p.x}, ${p.y}`);
}

const point = { x: 12, y: 26 };
logPoint(point);
```

<!-- end_slide -->

## Shape Matching

```typescript
const point3 = { x: 12, y: 26, z: 89 };
logPoint(point3);

const color = { hex: "#187ABF" };
logPoint(color); // Error
```

<!-- end_slide -->

## Classes and Structural Typing

```typescript
class VirtualPoint {
  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

const newVPoint = new VirtualPoint(13, 56);
logPoint(newVPoint);
```

<!-- end_slide -->

## Modules

* Split code into files
* Use `export` and `import`

```typescript
export function add(a: number, b: number) {
  return a + b;
}
```

<!-- end_slide -->

## Conclusion

TypeScript provides:

* Strong typing
* Better tooling
* Scalable architecture

<!-- end_slide -->

# References:

* [https://www.typescriptlang.org/docs/](https://www.typescriptlang.org/docs/)
