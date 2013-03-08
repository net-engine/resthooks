# RESTHooks
## Stop polling

eg. POST api/v1/event_subscriptions (user_id from token in header)

```json
{
  "post_url": "https://example.com/some_hook?user_id=123",
  "authentication": null,
  "resources": [
    {
      "type": "beer",
      "events": ["all"]
    },
    {
      "type": "burgers",
      "events": ["create, update"]
    }
  ]
}
```
