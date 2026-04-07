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

TypeScript for JavaScript Programmers
===

TypeScript extends JavaScript by adding a powerful type system. It catches errors early, making your code more reliable.

- **JavaScript Primitives**: `string`, `number`, etc., but no type checking.
- **TypeScript**: Adds type checking to JavaScript.
- **Benefit**: Highlights unexpected behavior, reducing bugs.

<!-- end_slide -->

# The Basics

- TypeScript is a superset of JavaScript.
- Runs everywhere JavaScript runs.
- Adds static typing.

```typescript
let message: string = "Hello";
let count: number = 10;
```

<!-- end_slide -->

## Everyday Types

Common types used daily:

- `string`, `number`, `boolean`
- `array`, `object`

```typescript
let age: number = 30;
let isAdmin: boolean = true;
let names: string[] = ["Alice", "Bob"];
```

<!-- end_slide -->

## Types by Inference

TypeScript infers types automatically. For example:

```typescript
let helloWorld = "Hello World"; // inferred as string
```

- No need to explicitly declare types in many cases.
- Works seamlessly with tools like VS Code.

<!-- end_slide -->

## Defining Types

When TypeScript can't infer types, define them explicitly.

<!-- column_layout: [1, 1] -->
<!-- column: 0 -->
### Inferred Object

```typescript
const user = {
  name: "Hayes",
  id: 0,
};
```

<!-- column: 1 -->
### Explicit Interface

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

### TypeScript Warnings

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

TypeScript narrows types based on runtime checks.

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

Functions can have typed parameters and return values.

```typescript
function deleteUser(user: User) {
  // ...
}
 
function getAdminUser(): User {
  return { name: "Admin", id: 1 };
}
```

<!-- end_slide -->

## Object Types

Define shapes of objects.

```typescript
function printUser(user: { name: string; age: number }) {
  console.log(user.name);
}
```

<!-- end_slide -->

## Primitive Types

TypeScript extends JavaScript’s primitives with:

- `any`, `unknown`, `never`, `void`

- Prefer `interface`
- Use `type` for advanced cases

<!-- end_slide -->

## Composing Types

### Unions

```typescript
type MyBool = true | false;
type WindowStates = "open" | "closed" | "minimized";
```

### Example

```typescript
function getLength(obj: string | string[]) {
  return obj.length;
}
```

<!-- end_slide -->

### Using `typeof`

```typescript
function wrapInArray(obj: string | string[]) {
  if (typeof obj === "string") {
    return [obj];
  }
  return obj;
}
```

<!-- end_slide -->

## Type Manipulation

```typescript
type User = {
  name: string;
  age: number;
};

type PartialUser = Partial<User>;
```

<!-- end_slide -->

## Creating Types from Types

```typescript
type Point = { x: number; y: number };
type ReadonlyPoint = Readonly<Point>;
```

<!-- end_slide -->

## Generics

```typescript
function identity<T>(arg: T): T {
  return arg;
}
```

### Example

```typescript
interface Backpack<Type> {
  add: (obj: Type) => void;
  get: () => Type;
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

<!-- end_slide -->

## Typeof Type Operator

```typescript
const user = { name: "Alice" };
type UserType = typeof user;
```

<!-- end_slide -->

## Indexed Access Types

```typescript
type User = { name: string; age: number };
type Age = User["age"];
```

<!-- end_slide -->

## Conditional Types

```typescript
type IsString<T> = T extends string ? true : false;
```

<!-- end_slide -->

## Mapped Types

```typescript
type OptionsFlags<Type> = {
  [Property in keyof Type]: boolean;
};
```

<!-- end_slide -->

## Template Literal Types

```typescript
type Greeting = `Hello ${string}`;
```

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

<!-- end_slide -->

## Structural Type System

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

### Shape Matching

```typescript
const point3 = { x: 12, y: 26, z: 89 };
logPoint(point3);

const color = { hex: "#187ABF" };
logPoint(color); // Error
```

<!-- end_slide -->

### Classes and Structural Typing

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

```typescript
export function add(a: number, b: number) {
  return a + b;
}
```

<!-- end_slide -->

## Conclusion

TypeScript provides:

- Strong typing
- Better tooling
- Scalable architecture

<!-- end_slide -->

References:
===

- https://www.typescriptlang.org/docs/

