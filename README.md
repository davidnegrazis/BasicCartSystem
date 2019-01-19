###### Designed for the Shopify summer 2019 backend intern challenge

1. [Overview](#overview)
2. [Setup](#setup)
3. [API Overview](#api-overview)
4. [Tests](#tests)

## Overview
This API features the ability to get products, create a cart, add products to the cart, and purchase items/complete the cart. The database used is [MySQL](https://www.mysql.com/downloads/), and the framework used is [Ruby on Rails](https://guides.rubyonrails.org/v5.0/getting_started.html#installing-rails). Assure these are installed on your computer.
Testing is done with [MiniTest](https://rubygems.org/gems/minitest/versions/5.11.3).

## Setup
Follow these steps to get the application running:
1. `git clone git@github.com:davidnegrazis/BasicCartSystem.git`
2. `cd BasicCartSystem/cartsystem`
3. `bundle install`
4. You'll need to go into `config/database.yml` and set your MySQL `username` and `password` accordingly
5. `rake db:create db:migrate db:seed`
6. `rails s` to start the development server

> The server will listen on `http://localhost:3000/`

Jump into something like [Postman](https://www.getpostman.com/) and try out the API!

## API Overview
### Products
#### GET
##### Get all products
```
http://localhost:3000/api/v1/products
```
##### Get specific product (by id)
```
http://localhost:3000/api/v1/products/<product_id>
```
##### Get only available products
```
http://localhost:3000/api/v1/products?available=true
```

---

### Cart
#### GET
##### Get all carts
```
http://localhost:3000/api/v1/carts
```

##### See specific cart's items/data (by id)
```
http://localhost:3000/api/v1/carts/<cart_id>
```
*Sample response*:
```
{
    "status": "SUCCESS",
    "message": "Loaded cart",
    "data": {
        "total": "12761.45",
        "in_cart": {
            "1": {
                "product_title": "Rustic Bronze Car",
                "product_price": "269.26",
                "quantity": 2,
                "total": "538.52"
            },
            "2": {
                "product_title": "Fantastic Cotton Car",
                "product_price": "35.48",
                "quantity": 1,
                "total": "35.48"
            },
            "3": {
                "product_title": "Ergonomic Marble Wallet",
                "product_price": "122.85",
                "quantity": 5,
                "total": "614.25"
            }
}
```
The keys of the `in_cart` hash are `product_id`s.

#### POST
##### Create new cart
```
http://localhost:3000/api/v1/carts
```

##### Add item to cart
```
http://localhost:3000/api/v1/carts/<cart_id>/add?product_id=<product_id>&quantity=<natural>
```
where `quantity` is optional. If `quantity` is not passed, 1 of the item is added. `quantity` must be > 0.
If the product is already in the cart, then its quantity will be increased accordingly.

##### Complete cart
```
http://localhost:3000/api/v1/carts/<cart_id>/complete
```
which requires that the cart is non-empty and its items which it will purchase are in-stock.

## Tests
There are some unit tests that do basic tests on the API and some model methods.
To test, run `rails t`. You may start a server in `test` by killing the development server if it's running and then executing `rails s -e test`, which will allow for querying the test database (`cart-test`) that will be fixed with some special test data.
