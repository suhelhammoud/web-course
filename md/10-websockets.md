---
title: Web Applications
sub_title: Websockets
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


# Introduction to WebSocket in JavaScript

**WebSocket** is a communication protocol that enables **persistent, full-duplex** connections between a client and a server over a single TCP connection.

### 🔄 Key Characteristics:
- Bi-directional communication (client ↔ server)
- Persistent connection (no repeated handshakes like HTTP)
- Low-latency and efficient for real-time applications

> Defined by **RFC 6455**  
> Built into all modern browsers via the `WebSocket` API

<!-- end_slide -->

## Creating a WebSocket Connection

Use the `WebSocket` constructor to initiate a connection:

```javascript
const socket = new WebSocket("wss://example.com/socket");
```

### 🔧 Parameters:

* `ws://` for insecure connections (local/dev only)
* `wss://` for secure connections (required in production)

### 🔄 Connection Lifecycle:

* `onopen`: Triggered when connection is established
* `onmessage`: Called when a message is received
* `onerror`: Handles errors
* `onclose`: Triggered when the connection closes


<!-- end_slide -->

## Creating a WebSocket Connection

Example:

```javascript
socket.onopen = () => {
  console.log("Connection opened!");
  socket.send("Hello Server!");
};

socket.onmessage = (event) => {
  console.log("Received:", event.data);
};
```

<!-- end_slide -->

# Writing WebSocket Client Applications



## Creating a WebSocket Object

To communicate using the WebSocket protocol, create a `WebSocket` object:

```javascript
const webSocket = new WebSocket(url, protocols);
```

### Parameters:

* `url`: The WebSocket server URL (preferably `wss://`).
* `protocols` *(optional)*: A string or array specifying sub-protocols.

> 🛑 The constructor throws a `SecurityError` if the destination doesn't permit access (e.g., insecure `ws://` in a restricted context).

<!-- end_slide -->

# Writing WebSocket Client Applications

## Connection Errors

If an error occurs during connection:

* An `error` event is fired.
* Followed by a `close` event explaining the reason.
* The browser may log a **CloseEvent** and error message (RFC 6455 §7.4).

<!-- end_slide -->

# Writing WebSocket Client Applications

## Example: Creating a Connection

```javascript
const exampleSocket = new WebSocket(
  "wss://www.example.com/socketserver",
  "protocolOne", "protocolTwo"
);
```

`exampleSocket.protocol` will contain the protocol selected by the server.

<!-- end_slide -->

# Writing WebSocket Client Applications

## Sending Data to the Server

Send data once the connection is open using `.send()`:


> ⚠️ Make sure to wait until `onopen` fires:

```javascript
exampleSocket.onopen = (event) => {
  exampleSocket.send("Message after connection opens");
};
```

You can send: `String`, `Blob`, or `ArrayBuffer`.

<!-- end_slide -->

# Writing WebSocket Client Applications

## Using JSON to Transmit Objects

Send structured data using `JSON.stringify`:

```javascript
function sendText() {
  const msg = {
    type: "message",
    text: document.getElementById("text").value,
    id: clientID,
    date: Date.now()
  };
  exampleSocket.send(JSON.stringify(msg));
  document.getElementById("text").value = "";
}
```

<!-- end_slide -->

# Writing WebSocket Client Applications

## Receiving Messages from Server

Listen for incoming messages with `onmessage`:

```javascript
exampleSocket.onmessage = (event) => {
  console.log(event.data);
};
```

> Text is UTF-8 encoded by default.

<!-- end_slide -->
# Writing WebSocket Client Applications

## Receiving and Parsing JSON

Handle different message types from the server:

```javascript
exampleSocket.onmessage = (event) => {
  const msg = JSON.parse(event.data);
  const timeStr = new Date(msg.date).toLocaleTimeString();
  let text = "";

  handleMessage(msg);

  //
};
```
<!-- end_slide -->
# Writing WebSocket Client Applications

## Receiving and Parsing JSON

```javascript
function handleMessage(msg) {
  switch (msg.type) {
    case "id":
      // handle id
      break;
    case "username":
      // handle username
      break;
    case "message":
      // handle message
      break;
   //
  }
```

<!-- end_slide -->
# Writing WebSocket Client Applications

## Closing the Connection

Call `.close()` when done:

```javascript
exampleSocket.close();
```

Check `.bufferedAmount` to ensure all data was sent:

```javascript
if (exampleSocket.bufferedAmount === 0) {
  exampleSocket.close();
}
```

<!-- end_slide -->

## Security Considerations
<!-- incremental_lists: true -->

* Avoid using **non-secure WebSocket (`ws://`)** on HTTPS pages.
* Use `wss://` to ensure secure communication.
* Most browsers now **require** secure contexts for WebSockets.

<!-- end_slide -->
Section Two: Socket.IO package
===

<!-- end_slide -->


# Introduction to Socket.IO

**Socket.IO** is a JavaScript library for real-time web applications. It enables **real-time, bidirectional, event-based communication** between clients and servers over WebSockets — with automatic fallbacks.

<!-- incremental_lists: true -->
- Ideal for apps like:  
- 🗨️ Chat applications  
- 📈 Live dashboards  
- 🎮 Multiplayer games  
- 📡 Real-time notifications

<!-- end_slide -->

# Introduction to Socket.IO

## Installing Socket.IO

### 🔧 Server-side (Node.js)

Install via npm:

```bash
npm install socket.io
```
<!-- end_slide -->

# Introduction to Socket.IO

### 🧑‍💻 Client-side (Browser)

<!-- pause -->
Option 1: Install via npm and serve it yourself:

```bash
npm install socket.io-client
```

<!-- pause -->
Option 2: Use a CDN:

```html
<script src="https://cdn.socket.io/4.7.2/socket.io.min.js"></script>
```

> Both the **client** and **server** must use compatible versions of Socket.IO.

<!-- end_slide -->
# Introduction to Socket.IO

## Key Features of Socket.IO
<!-- incremental_lists: true -->

* ✅ **Event-based API** using `.on()` and `.emit()`
* 🔁 **Automatic reconnection** on network failure
* 🌐 **Room and namespace support**
* 💬 **Broadcasting** to multiple clients
* 🧰 **Middleware support** (on the server)
* 📦 **Binary and JSON** message support
* 🛡️ **Fallback support** (long polling for older browsers)

> Socket.IO goes beyond raw WebSockets — it's a full **real-time engine**.

<!-- end_slide -->



Section Three:WebSocket API vs Socket.IO
===

The difference between **JavaScript WebSocket API** and **Socket.IO** is significant in terms of **abstraction, features, compatibility, and use cases**.

<!-- end_slide -->

## 🔌 1. WebSocket API (Native JavaScript)

```javascript
const exampleSocket = new WebSocket("wss://www.example.com/socketserver", "protocolOne");
```

### ✅ Pros:
<!-- incremental_lists: true -->

* **Standardized**: Built into modern browsers.
* **Lightweight**: No extra library required.
* **Fast**: Low overhead, pure WebSocket protocol.
* **Good for custom implementations** where you control both client and server.



<!-- end_slide -->

## 🔌 1. WebSocket API (Native JavaScript)


### ❌ Cons:
<!-- incremental_lists: true -->

**Low-level**: You must handle:
* Reconnection logic
* Heartbeats/pings
* Message encoding/decoding (e.g., JSON)
* Fallbacks for old browsers
* No automatic event-based abstraction (you manually use `onmessage`, `onopen`, etc.)

<!-- end_slide -->

## 🔌 2. Socket.IO (Third-party Library)

```javascript
const socket = io("https://www.example.com");
```

<!-- pause -->
### ✅ Pros:

<!-- pause -->
**Abstraction over WebSockets** with extra features:
<!-- incremental_lists: true -->

* Automatic reconnections
* Broadcasting
* Rooms/namespaces
* Event-based communication
* JSON support out of the box
* Fallbacks (e.g., long polling) for older browsers
* Middleware support (on server side)
* Works well in complex real-time apps (e.g., chat, live updates, games)


<!-- end_slide -->

## 🔌 2. Socket.IO (Third-party Library)

```javascript
const socket = io("https://www.example.com");
```

<!-- pause -->
### ❌ Cons:
<!-- incremental_lists: true -->

* **Heavier**: Adds client/server library overhead.
* **Not a pure WebSocket protocol** — uses a custom protocol on top of WebSockets (or falls back to HTTP polling).
* Requires both **client and server to use Socket.IO**.

<!-- end_slide -->

## 📊 Feature Comparison

| Feature                   | WebSocket API      | Socket.IO           |
| ------------------------- | ------------------ | ------------------- |
| Standard Protocol         | ✅ Yes (RFC 6455)   | ❌ Custom on top     |
| Built-in Browser Support  | ✅ Yes              | ❌ Needs client lib  |
| Reconnection Handling     | ❌ No               | ✅ Yes               |
| Fallbacks (e.g., polling) | ❌ No               | ✅ Yes               |
| Event-based Messaging     | ❌ No (`onmessage`) | ✅ Yes (`socket.on`) |
| Rooms / Broadcasting      | ❌ No (manual)      | ✅ Yes               |
| Binary Support            | ✅ Yes              | ✅ Yes               |
| Custom Protocol Support   | ✅ Yes              | ✅ Yes               |

<!-- end_slide -->

## Summary

### Use **WebSocket API** if:
<!-- incremental_lists: true -->

* You want full control over the protocol
* You're building a minimal or custom system
* You want lightweight, standards-based communication

### Use **Socket.IO** if:
<!-- incremental_lists: true -->

* You want easier development with built-in features
* You need reconnection, event system, or broadcasting
* You’re building a complex real-time app (e.g., chat, dashboard, multiplayer)

<!-- end_slide -->

References:
===
- https://developer.mozilla.org/




