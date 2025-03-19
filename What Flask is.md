Flask acts as a bridge between `frontend` interactions and `backend` logic by routing HTTP requests to Python functions. Here's how it works in practice:

## Core Mechanism

1. **Routing**: Flask maps URLs to Python functions (called _view functions_) using `@app.route()` decorators. For example:

```python
@app.route('/api/data')
def get_data():
    return jsonify({"message": "Hello from Flask!"})
```

Accessing `/api/data` triggers `get_data()`[1](https://www.digitalocean.com/community/tutorials/how-to-make-a-web-application-using-flask-in-python-3)

- **Request Handling**: When a frontend (JavaScript) sends a request, Flask:
    
    - Parses incoming data (`URL` parameters, `JSON`, forms)
    - Executes the associated view function
    - Returns `HTTP` responses (`HTML`, `JSON`, etc.)

## Connecting Python Modules

You can organize code into separate modules:

```python
# database_handler.py
def fetch_records():
    return ["item1", "item2"]

# app.py (Flask)
from database_handler import fetch_records

@app.route('/items')
def show_items():
    return jsonify(fetch_records())
```

This separation keeps business logic modular and testable[1](https://www.digitalocean.com/community/tutorials/how-to-make-a-web-application-using-flask-in-python-3)[2](https://flatirons.com/blog/what-is-flask-overview-of-the-flask-python-framework-2024/).

## Frontend Communication

JavaScript interacts with Flask using the Fetch API:


```js
// Frontend JavaScript
fetch('/items')
  .then(response => response.json())
  .then(data => console.log(data)); // ["item1", "item2"]
```

Flask handles this request through the `/items` route[](https://www.coursehorse.com/blog/learn/python/how-to-connect-frontend-javascript-with-flask-backend)

## Full Workflow Example

1. **Frontend Trigger**: User clicks a button in the browser
2. **JavaScript**: Sends POST request with user input

```js
fetch('/process', {
  method: 'POST',
  headers: {'Content-Type': 'application/json'},
  body: JSON.stringify({input: "user text"})
})
```

