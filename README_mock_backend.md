# Mock backend with json-server

This lightweight server is only for local development / UI testing.

## Prerequisites

1. Node.js installed (https://nodejs.org)
2. json-server installed globally:

```bash
npm install -g json-server
```

## Start the server

Inside the project root (same level as `mock_backend/`):

```bash
json-server --watch mock_backend/db.json --port 3000
```

You now have a REST API at http://localhost:3000

### Endpoints

* `GET   /users` — list users
* `GET   /users/{id}` — single user
* `GET   /users?email=demo@example.com&password=secret123` — simple login check (not secure, only for local!)
* `POST  /users` — registration (json-server auto-adds `id`)

## Using from the Flutter app

Set the base URL to `http://localhost:3000` (or `10.0.2.2:3000` on Android emulator) and call, e.g.:

```http
GET /users?email=demo@example.com&password=secret123
```

If the returned list is non-empty, credentials are valid.

➡️  Replace this mock with a real backend when ready. 