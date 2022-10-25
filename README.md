Fetch Rewards Coding Exercise
----------------------------------------
### Ted Staros

![Ruby](https://img.shields.io/badge/Ruby-v2.7.2-red)
![Rails](https://img.shields.io/badge/Rails-v6.0.6-red)
---
## Schema
```` ruby

Table "transactions" {
  "id" varchar
  "payer" string
  "points" integer
  "created_at" datetime
  "updated_at" datetime
}
````

## Tech Stack:
- Rails 6.0.6
- Ruby 2.7.2
- PostgreSQL
- RSpec
- Postman

##
Setup
* Clone or Fork this repository
* Install required Gems utilizing Bundler: <br>
- In terminal, use Bundler to install any missing Gems. If Bundler is not installed, first run the following command.
```shell
$ gem install bundler
```

- If Bundler is already installed or after it has been installed, run the following command.
```shell
$ bundle install
```
* From the command line, install gems and set up your DB:
    * `rails db:{drop,create,migrate}`
* Run the test suite with `bundle exec rspec`
* Run your development server with `rails s`, to see the application run.
* To access on your local machine use http://localhost:3000
##
Endpoints
----------------------------------------

- Add transactions for a specific payer and date

````ruby
POST /api/v1/user_points

{ "payer": "DANNON", "points": 1000, "timestamp": "2020-11-02T14:00:00Z" }

````
- Spend points
- Example: User wants to use 5000 points
````ruby
PATCH /api/v1/user_points?points=5000

[
  { "payer": "DANNON", "points": -100 },
  { "payer": "UNILEVER", "points": -200 },
  { "payer": "MILLER COORS", "points": -4,700 }
]
````
- Return all payer point balances
````ruby
GET /api/v1/user_points

{
  "DANNON": 1000,
  ”UNILEVER” : 0,
  "MILLER COORS": 5300
}
````
