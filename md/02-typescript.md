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



# TypeScript Types Overview

TypeScript provides a rich type system for safer and more expressive code.

* Types describe the shape of data
* Enable better tooling and error checking
* Useful for large-scale applications

<!-- end_slide -->

# Type Aliases

Type aliases give names to types:

```typescript
type UserID = string;
type Point = { x: number; y: number };
```

* Improves readability
* Reusable across code

<!-- end_slide -->

## Type vs Interface

Both describe shapes, but differ:

* `interface` → best for object shapes
* `type` → more flexible

```typescript
interface User {
  name: string;
}

type Admin = User & { role: string };
```

* Types support unions, intersections, and more

<!-- end_slide -->

## Object Literal Types

Define object structures inline:

```typescript
type Product = {
  name: string;
  price: number;
  inStock?: boolean;
};
```

* Optional fields with `?`
* Strong structure enforcement

<!-- end_slide -->

## Function Types

Describe callable structures:

```typescript
type Callback = (value: string) => void;
```

* Can define parameters and return types

<!-- end_slide -->

## Union Types

A value can be one of many types:

```typescript
type Size = "small" | "medium" | "large";
```

* Useful for fixed sets of values

<!-- end_slide -->

## Intersection Types

Combine multiple types:

```typescript
type A = { x: number };
type B = { y: number };

type C = A & B; // { x: number, y: number }
```

* Merges properties

<!-- end_slide -->

## Tuple Types

Fixed-length arrays with known types:

```typescript
type Data = [number, string];
```

* Each position has a specific type

<!-- end_slide -->

## Type from Value

Extract types from existing values:

```typescript
const data = { name: "Alice" };

type Data = typeof data;
```

* Keeps types in sync with values

<!-- end_slide -->


## Indexed Access Types

Access part of a type:

```typescript
type Response = { data: string };

type Data = Response["data"];
```

* Extracts nested types

<!-- end_slide -->

## Conditional Types

Types with logic:

```typescript
type IsString<T> = T extends string ? true : false;
```

* Works like `if` in type system

<!-- end_slide -->

## Template Literal Types

Build types using strings:

```typescript
type Lang = "en" | "pt";
type Section = "header" | "footer";

type IDs = `${Lang}_${Section}_id`;
```

* Combines string unions

<!-- end_slide -->

## Mapped Types

Transform existing types:

```typescript
type Subscriber<T> = {
  [K in keyof T]: (value: T[K]) => void;
};
```

* Iterates over properties
* Creates new structures

<!-- end_slide -->

## Utility Types

<!-- incremental_lists: true -->

- Create new types from existing ones

- Built-in helpers:

  * `Partial<T>`

  * `Readonly<T>`

  * `Pick<T, K>`

  * `ReturnType<T>`

- Simplify common patterns
- Avoid duplication
- Improve maintainability

<!-- end_slide -->



<!-- pause -->

## Partial Type
```typescript
type User = { name: string; age: number;};
type PartialUser = Partial<User>;
```
<!-- pause -->
Constructs a type with all properties of 'User' to optional

<!-- pause -->
## Readonly Type

```typescript
type Point = { x: number; y: number };
type ReadonlyPoint = Readonly<Point>;
```
<!-- pause -->
Constructs a type with all properties of 'Point' set to readonly

<!-- end_slide -->


## Keyof Type Operator
<!-- pause -->

```typescript
type User = { name: string; id: number };
type Keys = keyof User;
```
<!-- pause -->

* Produces union of keys

<!-- pause -->


## Typeof Type Operator

```typescript
const user = { name: "Alice" };
type UserType = typeof user;
```
<!-- pause -->

* Extracts type from value

<!-- end_slide -->

## Pick from type
Syntax: `Pick<OriginalType, 'key1' | 'key2'>`

```typescript
interface User {
  id: number;
  name: string;
  email: string;
  password: string;
}

// Pick only public fields, exclude password one
type PublicUser = Pick<User, 'id' | 'name' | 'email'>;
```
<!-- end_slide -->


## Return Type Extraction

Get function return types:

```typescript
function createUser() {
  return { name: "Alice" };
}

type User = ReturnType<typeof createUser>;
```




<!-- end_slide -->

# TypeScript Classes Overview

<!-- incremental_lists: true -->
TypeScript builds on JavaScript classes with additional type features.

* Adds type safety to class members
* Includes compile-time checks
* Keeps JavaScript runtime behavior

<!-- end_slide -->

# Defining a Class

Basic class syntax:

```typescript
class User {
  name: string;
  id: number;

  constructor(id: number, name: string) {
    this.id = id;
    this.name = name;
  }
}
```

* Constructor initializes fields
* Types are enforced during development

<!-- end_slide -->

## Creating Instances

Create objects using `new`:

```typescript
const user = new User(1, "Alice");
```

* `new` calls the constructor
* Returns an instance of the class

<!-- end_slide -->

## Access Modifiers

Control visibility of properties:

* `public` (default)
* `private`
* `protected`

```typescript
class Account {
  private balance: number;

  constructor(balance: number) {
    this.balance = balance;
  }
}
```

* `private` is only checked at compile time

<!-- end_slide -->

## private vs #private

Two types of privacy:

```typescript
class Example {
  private x = 1;   // Type-only
  #y = 2;          // Runtime private
}
```

* `private` → TypeScript only
* `#private` → Enforced in JavaScript runtime

<!-- end_slide -->

## Methods and this

The value of `this` depends on how a function is called.

```typescript
class Counter {
  count = 0;

  increment() {
    this.count++;
  }
}
```

* Use arrow functions or `bind` to fix `this`
```typescript
  increment = () => this.count++;
```

<!-- end_slide -->

## Getters and Setters

Control access to properties:

```typescript
class User {
  private _name: string = "";

  get name() {
    return this._name;
  }

  set name(value: string) {
    this._name = value;
  }
}
```

* Encapsulates logic
* Provides controlled access

<!-- end_slide -->

## Static Members

Belong to the class, not instances:

```typescript
class Config {
  static version = "1.0";

  static getVersion() {
    return Config.version;
  }
}
```

* Access using class name
* Shared across all instances

<!-- end_slide -->

## Parameter Properties

Shortcut for defining and initializing fields:

```typescript
class Point {
  constructor(public x: number, public y: number) {}
}
```

* Automatically creates and assigns properties

<!-- end_slide -->

## Inheritance

Extend classes using `extends`:

```typescript
class Animal {
  speak() {
    console.log("Some sound");
  }
}

class Dog extends Animal {
  speak() {
    console.log("Bark");
  }
}
```

* Enables code reuse
* Supports method overriding

<!-- end_slide -->

## Implements

Ensure a class follows a structure:

```typescript
interface Serializable {
  serialize(): string;
}

class User implements Serializable {
  serialize() {
    return "user";
  }
}
```

* Enforces contracts

<!-- end_slide -->

## Abstract Classes

Cannot be instantiated directly:

```typescript
abstract class Animal {
  abstract getName(): string;

  printName() {
    console.log("Hello " + this.getName());
  }
}
```

* Used as base classes
* Can include abstract methods

<!-- end_slide -->

## Generics in Classes

Reusable type-safe classes:

```typescript
class Box<T> {
  contents: T;

  constructor(value: T) {
    this.contents = value;
  }
}
```

* Works with different types
* Improves flexibility

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
  x:number; y: number;
  
  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

const newVPoint = new VirtualPoint(13, 56);
logPoint(newVPoint);
```
<!-- end_slide -->

## Decorators

Add metadata to classes and members:

```typescript
@sealed
class User {
  name: string;
}
```
<!-- incremental_lists: true -->

* Used for frameworks and advanced patterns.
* Common Use Cases: Logging, Validation, Caching, Serialization, etc.
* Require "experimentalDecorators": true in tsconfig.json.

<!-- end_slide -->

## References
* [](https://www.typescriptlang.org/docs/handbook)
