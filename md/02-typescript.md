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
      #   padding:
      # horizontal: 4
---

TypeScript for JavaScript Programmers
===

TypeScript extends JavaScript by adding a powerful type system. It catches errors early, making your code more reliable.

- **JavaScript Primitives**: `string`, `number`, etc., but no type checking.
- **TypeScript**: Adds type checking to JavaScript.
- **Benefit**: Highlights unexpected behavior, reducing bugs.

<!-- end_slide -->

## Types by Inference

TypeScript infers types automatically. For example:

```typescript
let helloWorld = "Hello World"; // TypeScript infers `helloWorld` as `string`.
```

- No need to explicitly declare types in many cases.
- Works seamlessly with tools like Visual Studio Code.

<!-- end_slide -->

## Defining Types

When TypeScript can't infer types, you can define them explicitly.

### Example: Inferred Object

```typescript
const user = {
  name: "Hayes",
  id: 0,
};
```

### Example: Explicit Interface

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

<!-- end_slide -->

### TypeScript Warnings

TypeScript warns if objects don’t match the interface:

```typescript
interface User {
  name: string;
  id: number;
}
 
const user: User = {
  username: "Hayes", // Error: 'username' does not exist in type 'User'.
  id: 0,
};
```

<!-- end_slide -->

## Classes and Interfaces

TypeScript supports classes and interfaces together:

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

## Function Annotations

Interfaces can annotate function parameters and return types:

```typescript
function deleteUser(user: User) {
  // ...
}
 
function getAdminUser(): User {
  //...
}
```

<!-- end_slide -->

## Primitive Types

TypeScript extends JavaScript’s primitives with `any`, `unknown`, `never`, and `void`.

- Prefer `interface` for defining types.
- Use `type` for advanced features.

<!-- end_slide -->

## Composing Types

Combine types using **unions** and **generics**.

### Unions

Declare a type as one of many:

```typescript
type MyBool = true | false;
type WindowStates = "open" | "closed" | "minimized";
```

### Example: Union in Functions

```typescript
function getLength(obj: string | string[]) {
  return obj.length;
}
```

<!-- end_slide -->

### Using `typeof`

Check types at runtime:

```typescript
function wrapInArray(obj: string | string[]) {
  if (typeof obj === "string") {
    return [obj];
  }
  return obj;
}
```

<!-- end_slide -->

## Generics

Generics make types reusable:

```typescript
type StringArray = Array<string>;
type NumberArray = Array<number>;
```

### Example: Custom Generics

```typescript
interface Backpack<Type> {
  add: (obj: Type) => void;
  get: () => Type;
}
 
declare const backpack: Backpack<string>;
const object = backpack.get();
backpack.add(23); // Error: 'number' is not assignable to 'string'.
```

<!-- end_slide -->

## Structural Type System

TypeScript checks the **shape** of objects, not their explicit type.

### Example: Structural Typing

```typescript +exec
interface Point {
  x: number;
  y: number;
}
 
function logPoint(p: Point) {
  console.log(`${p.x}, ${p.y}`);
}
 
const point = { x: 12, y: 26 };
logPoint(point); // Works even if `point` isn’t explicitly a `Point`.
```

<!-- end_slide -->

### Example: Shape Matching

Only required properties need to match:

```typescript  +exec
/// function logPoint(p: Point) {
///   console.log(`${p.x}, ${p.y}`);
/// }
 
const point3 = { x: 12, y: 26, z: 89 };
logPoint(point3); // Works: `x` and `y` match.

const color = { hex: "#187ABF" };
logPoint(color); // Error: Missing `x` and `y`.
```

<!-- end_slide -->

### Example: Classes and Structural Typing

Classes also conform to shapes:

```typescript  +exec

/// function logPoint(p: Point) {
///   console.log(`${p.x}, ${p.y}`);
/// }

class VirtualPoint {
  constructor( x: number,  y: number) {
    this.x = x;
    this.y = y;
  }
}
 
const newVPoint = new VirtualPoint(13, 56);
logPoint(newVPoint); // Works: `x` and `y` match.
```

<!-- end_slide -->

## Conclusion

TypeScript enhances JavaScript with:
- A robust type system.
- Better tooling and error detection.
- Advanced features like generics and unions.


<!-- end_slide -->

References:
===

- https://www.typescriptlang.org/docs/handbook/typescript-in-5-minutes.html
- 