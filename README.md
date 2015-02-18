# Auth0 Demo Activity Stream API

A backend API for the Auth0 SSO example build with Ruby on Rails.

## Consuming Platform Events

This project has a message consumer for all published messages. As each message
is consumed it is added to an activity stream. This is a simple example of how
developers can build small projects to tap into the platform events of interest
and build useful data from them.

## Security
All requests to the API are protected. Requests must include a JWT token for an
authorized user. This example demonstrates course-grained authorization. Users
who have the role `admin` will be allowed to see all platform events.

## Environmental Variables

```
AUTH0_CLIENT_ID
AUTH0_CLIENT_SECRET
AUTH0_DOMAIN
```
