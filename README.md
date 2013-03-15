# RESTHooks
## Stop polling

eg. POST api/v1/resource_subscriptions (user token in header)

```json
{
  "resource_subscription": {
    "post_url": "https://example.com/some_hook?user_id=123",
    "authentication": null,
    "version": 1,
    "resource": "beer"
  }
}
```
