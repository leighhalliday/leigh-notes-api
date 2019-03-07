# Notes API

The URL for this service is: [https://leigh-notes-api.herokuapp.com/](https://leigh-notes-api.herokuapp.com/)

## Authentication Header

This API uses a JWT token which is passed using the Authorization Bearer header. Example in Axios (to end user session):

```js
Axios.delete("/session", {
  headers: { Authorization: `Bearer: ${token}` }
});
```

## Login

POST `/session`

```json
{
  "email": "",
  "password": ""
}
```

## Signup

POST `/users`

```json
{
  "user": {
    "name": "",
    "email": "",
    "password": ""
  }
}
```

## Signout (Authenticated)

DELETE `/session`

## Create Note (Authenticated)

POST `/notes`

```json
{
  "note": {
    "body": ""
  }
}
```

## List Notes (Authenticated)

GET `/notes`
