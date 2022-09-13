# Beer Festival app

A Ruby on Rails app that utilizes an external source of data in
order to expose a simple RESTful JSON API.

All RESTful endpoints get data from The Punk API(https://punkapi.com/documentation/v2)

The JSON definition of a beer:
```bash
{
  "identifier": 1,
  "name": "Example Beer name",
  "description": "This is an example of a beer that will be returned by your API"
}
```

## Quickstart

First, clone this repository. Then:

```bash
> bundle install

> bin/rails server # Start the server at localhost:3000
```
## Functionality

- get a beer for a given ID
```bash
http://127.0.0.1:3000/beers/[id]
```

- get ALL beers
```bash
http://127.0.0.1:3000/beers
```

- search all beers for a given name (Substitute 'buzz' with the name you want to search, case insensitive!)
```bash
http://127.0.0.1:3000/beers?name=buzz
```

## Testing

In order to Test-Drive my application, for every new API endpoint, I first write a simple controller test with the expectation of successful HTTP response.
I chose to go with integration tests over unit tests, so requests tests were the best kind to go forward with. All requests to the third-party API are mocked, since The Punk API has a rate limit, and in real life we would not make real HTTP requests for every test every time.

In order to run the 2 different test files:

```bash
> rspec rspec ./test/requests/beers_request_test.rb

> rspec ./test/controllers/beers_controller_test.rb
```
## Ruby on Rails version
Rails 7.0.4

## Dependencies
Main Gems required:
```bash
rest-client
rspec-rails
```

* Extra question:
- What happens if in a couple of months, we are asked to get beers from 2 different external APIs? What would we have to change?

If we want to add another source:

Get one beer:
Would look in both sources before raising 404

Get all:
Would grab all beers from all sources, then deduplicate and return the enriched set of beers

Search:
Would search on all sources and consolidate/deduplicate results

On all:
If one source is unreachable, then try the other one(s), and fail only if all of them fail

