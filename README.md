# RESTHooks
## Stop polling

### Create resources

All requests must contain HTTP_AUTHORIZATION header with "Token token="USER-TOKEN-PREVIOUSLY-PROVIDED""

There are two main resources. They are called Beers and Burguers, and both have a deliciousness field.


#### Create beers and burguers

All examples will use beers. For burguers, please replace beers and use burguers instead.

You can create beers by posting to /api/v1/beers with the following payload:

```json
{
  "beer": {
    "deliciousness": 3
  }
}
```

##### Example using curl

```shell
curl "http://localhost/api/v1/beers" \
  -H 'Accept: application/json' -H 'Content-type: application/json' \
  -H "Authorization: Token token=TOKEN-HERE" \
  -X POST \
  -d '{
        "beer": {
          "deliciousness": 3
        }
      }'
```

#### Update beers and burguers

You can update them by putting to /api/v1/beers/ID with the following payload:

```json
{
  "beer": {
    "deliciousness": 4
  }
}
```

##### Example using curl

```shell
curl "http://localhost/api/v1/beers/1" \
  -H 'Accept: application/json' -H 'Content-type: application/json' \
  -H "Authorization: Token token=TOKEN-HERE" \
  -X PUT \
  -d '{
        "beer": {
          "deliciousness": 4
        }
      }'
```

### Using the resthooks for your service

So now you've got beers and burguers, your service can be subscribed to receive updates when they get modified/created/destroyed.

You need to post to /api/v1/resource_subscriptions (user token in header)

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

##### Example using curl

```shell
curl "http://localhost/api/v1/resource_subscriptions
  -H 'Accept: application/json' -H 'Content-type: application/json' \
  -H "Authorization: Token token=TOKEN-HERE" \
  -X PUT \
  -d '{
    "resource_subscription": {
      "post_url": "https://example.com/some_hook?user_id=123",
      "authentication": null,
      "version": 1,
      "resource": "beer"
    }
  }'
```

### LICENSE
MIT 2013.
