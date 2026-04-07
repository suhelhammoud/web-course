---
title: Web Applications
sub_title: Express JS
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


# What is Express?

Express is a Web Framework built upon Node.js. It is used for building networking services and applications.

# Why Use Express?

- Easy to use functionality for Web Servers
- Open Source and Free
- Easy to extend
- Very performant
- Lots of pre-built packages available

<!-- end_slide -->

## Table of Contents

<!-- column_layout: [1, 1] -->
<!-- incremental_lists: true -->
<!-- column: 0 -->
1. How to Install Express  
2. Hello, World Example  
3. Request Parameters  
4. Sending Responses  
5. JSON Responses  
6. Managing Cookies  
7. HTTP Headers  
8. Redirects  
9. Routing  
<!-- column: 1 -->
10. Templates  
11. Middleware  
12. Static Assets  
13. Sending Files  
14. Sessions  
15. Input Validation  
16. Input Sanitization  
17. Handling Forms  
18. File Uploads  

<!-- reset_layout -->
<!-- end_slide -->

# 1. How to Install Express

Initialize a Node.js project:

```bash
npm init -y
````

Install Express:

```bash
npm install express
```

<!-- end_slide -->

# 2. Hello World in Express

```js
const express = require('express')
const app = express()

app.get('/', (req, res) => res.send('Hello World!'))

app.listen(3000, () => console.log('Server ready'))
```

Run with:

```bash
node index.js
```

<!-- end_slide -->
# 2. Hello World in Express (using Modules)

- Add to package.json

```json
{
  "type":"module"
}
```
- Then use import

```js
import express from 'express';

const app = express()

```

<!-- end_slide -->

# 2. Hello World: Explanation

* `require('express')`: import Express
* `express()`: create app instance
* `app.get()`: respond to GET requests
* `res.send()`: send response
* `app.listen()`: start server

<!-- end_slide -->

# 2. HTTP Verbs in Express

```js
app.get('/', (req, res) => { /* */ })
app.post('/', (req, res) => { /* */ })
app.put('/', (req, res) => { /* */ })
app.delete('/', (req, res) => { /* */ })
app.patch('/', (req, res) => { /* */ })
```

<!-- end_slide -->

# Request and Response Objects

Express provides two key objects:

* `req`: the HTTP request
* `res`: the HTTP response

```js
(req, res) => res.send('Hello World!')
```

<!-- end_slide -->

# Request Parameters Overview

Common `req` properties:

| Property   | Description           |
| ---------- | --------------------- |
| `app`      | Express app reference |
| `baseUrl`  | Base path of app      |
| `body`     | Submitted data        |
| `cookies`  | Cookies sent          |
| `hostname` | Host header value     |
| `ip`       | Client IP             |
| `method`   | HTTP Method           |
| `params`   | Route parameters      |
| `query`    | Query strings         |
| `secure`   | HTTPS check           |

<!-- end_slide -->

# Sending a Response

```js
res.send('Hello World!')
```

* Automatically sets Content-Type
* Closes the connection

<!-- end_slide -->

# Sending a Response


```js
res.end(); // Send an empty response
```


```js
res.status(404).send('File not found'); // Set HTTP status
```


```js
res.sendStatus(404); // Shortcut
```

<!-- end_slide -->

# Sending JSON Responses

Use `res.json()`:

```js
res.json({ username: 'Flavio' })
```

* Converts object/array to JSON

<!-- end_slide -->

# Managing Cookies

```js
res.cookie('username', 'Flavio');
res.clearCookie('username');

```

With options:

```js
res.cookie('username', 'Flavio', {
  domain: '.example.com',
  path: '/admin',
  secure: true,
  expires: new Date(Date.now() + 900000),
  httpOnly: true
})
```

<!-- end_slide -->

# Working with Headers

Access headers:

```js
req.headers
req.header('User-Agent')
```

Set headers:

```js
res.set('Content-Type', 'text/html')
```

Shortcuts:

```js
res.type('json') // application/json
```

<!-- end_slide -->

# Handling Redirects

Basic:

```js
res.redirect('/new-path')
```

Permanent:

```js
res.redirect(301, '/new-path')
```

Back:

```js
res.redirect('back')
```

<!-- end_slide -->

# Express Routing

Basic route:

```js
app.get('/', (req, res) => { /* ... */ })
```

Named parameters:

```js
app.get('/upper/:value', (req, res) =>
  res.send(req.params.value.toUpperCase()))
```

<!-- end_slide -->

# Regex Routing

Use regex to match paths:

```js
app.get(/post/, (req, res) => { /* ... */ })
```

Matches: `/post`, `/post/first`, `/posting`, etc.

<!-- end_slide -->

# Templates in Express

Set view engine:

```js
app.set('view engine', 'pug')
app.set('views', './views')
```

Render view:

```js
app.get('/about', (req, res) => {
  res.render('about', { name: 'Flavio' })
})
```

Pug template (`views/about.pug`):

```pug
p Hello from #{name}
```

<!-- end_slide -->

# Using Handlebars with Express

Handlebars is a popular templating engine supported by Express.

1. Install the required packages:
```bash
npm install express express-handlebars
````

<!-- end_slide -->
# Using Handlebars with Express

2. Set up the view engine in your Express app:

```js
const express = require('express')
const exphbs = require('express-handlebars')

const app = express()

app.engine('handlebars', exphbs.engine())
app.set('view engine', 'handlebars')
app.set('views', './views')
```

This tells Express to use Handlebars templates located in the `views/` folder.
<!-- end_slide -->


# Creating and Rendering a Handlebars Template

1. Create a `home.handlebars` file in the `views/` directory:
```handlebars
<h1>Hello, {{name}}!</h1>
````

2. Create a route in your Express app to render it:

```js
app.get('/', (req, res) => {
  res.render('home', { name: 'Flavio' })
})
```

This will render the HTML with "Hello, Flavio!" in an `<h1>` tag.

You can pass any object to the `res.render()` call and use its properties in the template.


<!-- end_slide -->

# Express Middleware

Middleware example:

```js
app.use((req, res, next) => {
  // Middleware logic
  next()
})
```

Use in a specific route:

```js
app.get('/', myMiddleware, handler)
```

<!-- end_slide -->

# Using Cookie-Parser Middleware

Install and use:

```bash
npm install cookie-parser
```

```js
const cookieParser = require('cookie-parser')
app.use(cookieParser())
```

<!-- end_slide -->

# Static Assets with Express

Serve static files:

```js
app.use(express.static('public'))
```

Files in `public/` are served from root path.

<!-- end_slide -->

# Sending Files to the Client

Download file:

```js
res.download('./file.pdf')
```

With custom name and callback:

```js
res.download('./file.pdf', 'download.pdf', (err) => {
  if (err) { /* handle error */ }
})
```

<!-- end_slide -->

# Sessions in Express

Install session middleware:

```bash
npm install express-session
```

Basic setup:

```js
app.use(session({ secret: 'your-secret-key' }))
```

Store data:

```js
req.session.name = 'Flavio'
```

<!-- end_slide -->

# Session Storage Options

Can store session data in:

* Memory (dev only)
* Databases (MySQL, Mongo)
* Caches (Redis, Memcached)

Client receives session ID via cookie.

<!-- end_slide -->

# Input Validation in Express

Install validator:

```bash
npm install express-validator
```

Use in route:

```js
const { check, validationResult } = require('express-validator')

app.post('/form', [
  check('name').isLength({ min: 3 }),
  check('email').isEmail(),
  check('age').isNumeric()
], (req, res) => {
  const errors = validationResult(req)
  if (!errors.isEmpty()) {
    return res.status(422).json({ errors: errors.array() })
  }
})
```

<!-- end_slide -->

