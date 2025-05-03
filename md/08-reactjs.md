---
title: Web Applications
sub_title: React JS
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

# Quick Start

- How to create and nest components  
- How to add markup and styles  
- How to display data  
- How to render conditions and lists  
- How to respond to events and update the screen  
- How to share data between components

<!-- end_slide -->

# Creating and Nesting Components

React apps are made out of components.  
A component is a piece of the UI that has its own logic and appearance.

<!-- column_layout: [1,1] -->
<!-- column: 0 -->

```javascript
function MyButton() {
    return (
        <button>I'm a button</button>
    );
}
````
React component names must start with a capital letter.

<!-- column: 1 -->
You can nest a component into another:

```javascript
export default function MyApp() {
  return (
    <div>
      <h1>Welcome to my app</h1>
      <MyButton />
    </div>
  );
}
```
<!-- reset_layout -->


<!-- end_slide -->

# Writing Markup with JSX

JSX is a syntax extension for JavaScript, used to describe what the UI should look like.

<!-- column_layout: [1,1] -->
<!-- column: 0 -->

```javascript
function AboutPage() {
  return (
    <>
      <h1>About</h1>
      <p>Hello there.<br />How do you do?</p>
    </>
  );
}
```
<!-- column: 1 -->
<!-- new_line -->

* JSX is stricter than HTML
* Use a parent wrapper
* Always close tags


<!-- reset_layout -->
<!-- end_slide -->

# Adding Styles

Use `className` instead of `class` in JSX.

```javascript
<img className="avatar" />
```

Define the style in CSS:

```css
.avatar {
  border-radius: 50%;
}
```

React doesn’t prescribe how you include CSS – use a `<link>` tag or a build tool.

<!-- end_slide -->

# Displaying Data

JSX lets you embed variables and expressions using `{}`.

```javascript
<h1>{user.name}</h1>
<img
  className="avatar"
  src={user.imageUrl}
/>
```

<!-- end_slide -->

# Displaying Data

Complex example:
<!-- column_layout: [4,5] -->
<!-- column: 0 -->

```javascript
const user = {
  name: 'Hedy Lamarr',
  imageUrl: 'images/img.png',
  imageSize: 90,
};

```
<!-- column: 1 -->

```javascript
export default function Profile() {
  return (
    <>
      <h1>{user.name}</h1>
      <img
        className="avatar"
        src={user.imageUrl}
        alt={'Photo of ' + user.name}
        style={{
          width: user.imageSize,
          height: user.imageSize
        }}
      />
    </>
  );
}
```

<!-- reset_layout -->
<!-- end_slide -->

# Conditional Rendering

## Use regular JS conditions or ternary operators in JSX.

```javascript
let content;
if (isLoggedIn) {
  content = <AdminPanel />;
} else {
  content = <LoginForm />;
}
return <div>{content}</div>;
```

<!-- end_slide -->

# Conditional Rendering

## Compact version:

```javascript
<div>
  {isLoggedIn ? <AdminPanel /> : <LoginForm />}
</div>
```

## Logical `&&`:

```javascript
<div>
  {isLoggedIn && <AdminPanel />}
</div>
```

<!-- end_slide -->

# Rendering Lists

Use `map()` to turn an array into JSX elements.

```javascript
const products = [
  { title: 'Cabbage', id: 1 },
  { title: 'Garlic', id: 2 },
  { title: 'Apple', id: 3 },
];

const listItems = products.map(product =>
  <li key={product.id}>{product.title}</li>
);

return <ul>{listItems}</ul>;
```

Keys help React identify list items and optimize updates.

<!-- end_slide -->

# Conditional List Styling

Use logic in props to style list items.

```javascript
const products = [
  { title: 'Cabbage', isFruit: false, id: 1 },
  { title: 'Garlic', isFruit: false, id: 2 },
  { title: 'Apple', isFruit: true, id: 3 },
];

export default function ShoppingList() {
  const listItems = products.map(product =>
    <li
      key={product.id}
      style={{color: product.isFruit ? 'magenta' : 'darkgreen'}}
    >
      {product.title}
    </li>
  );

  return <ul>{listItems}</ul>;
}
```

<!-- end_slide -->

# Responding to Events

Declare event handlers inside components.

```javascript
function MyButton() {
  function handleClick() {
    alert('You clicked me!');
  }

  return (
    <button onClick={handleClick}> Click me </button>
  );
}
```

Note: Don’t call the function in JSX (`onClick={handleClick}` not `onClick={handleClick()}`).

<!-- end_slide -->

# Updating the Screen with State

Use the `useState` hook to “remember” information.

<!-- column_layout: [1, 1] -->
<!-- column: 0 -->

```javascript
import { useState } from 'react';

function MyButton() {
  const [count, setCount] = useState(0);

  function handleClick() {
    setCount(count + 1);
  }
```
<!-- column: 1 -->

```javascript
  return (
    <button onClick={handleClick}>
      Clicked {count} times
    </button>
  );
}
```
<!-- reset_layout -->

Each instance of the component gets its own state.

<!-- end_slide -->

# Multiple Independent States

```javascript
import { useState } from 'react';

export default function MyApp() {
  return (
    <div>
      <h1>Counters that update separately</h1>
      <MyButton />
      <MyButton />
    </div>
  );
}
```

Each `<MyButton />` maintains its own independent `count`.

<!-- end_slide -->

# Using Hooks

* Hooks are functions starting with `use`
* `useState` is a built-in hook
* Hooks must be called at the top level of components (not inside loops or conditions)
* You can define your own hooks too

<!-- end_slide -->

# Sharing Data Between Components

To synchronize state between components, lift the state up to their common parent.

<!-- column_layout: [1,1] -->
<!-- column: 0 -->
```javascript
import { useState } from 'react';

function MyButton({ count, onClick }) {
  return (
    <button onClick={onClick}>
      Clicked {count} times
    </button>
  );
}

export default function MyApp() {
  const [count, setCount] = useState(0);

  function handleClick() {
    setCount(count + 1);
  }
```

<!-- column: 1 -->
```javascript
  return (
    <div>
      <h1>Updated together</h1>
      <MyButton
        count={count}
        onClick={handleClick}
      />
      <MyButton
        count={count}
        onClick={handleClick}
      />
    </div>
  );
}
```

Props let you pass data and handlers from parent to child.
<!-- reset_layout -->

<!-- end_slide -->

# Summery

You’ve learned:

* Component creation
* JSX syntax
* Styling
* Displaying data
* Handling events
* Managing state
* Lifting state

<!-- end_slide -->

Refences:
===

* [React Docs](https://react.dev/learn)

