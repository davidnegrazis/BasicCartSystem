###### Designed for the Shopify summer 2019 backend intern challenge
GitHub link: https://github.com/davidnegrazis/BasicCartSystem 

1. [Overview](#overview)
2. [Setup](#setup)
3. [API Overview](#api-overview)
4. [Tests](#tests)
5. [Demo](#demo)

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
```js
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

---

## Demo
Alright, so we want to buy some stuff. Let's check out the products with a GET request to `http://localhost:3000/api/v1/products`:
```js
{
    "status": "SUCCESS",
    "message": "Loaded products",
    "data": [
        {
            "id": 1,
            "title": "Durable Wool Computer",
            "price": "15.44",
            "inventory_count": 199,
            "created_at": "2019-01-20T00:32:25.000Z",
            "updated_at": "2019-01-20T00:32:25.000Z"
        },
        {
            "id": 2,
            "title": "Small Wooden Chair",
            "price": "203.53",
            "inventory_count": 18,
            "created_at": "2019-01-20T00:32:25.000Z",
            "updated_at": "2019-01-20T00:32:25.000Z"
        },
        {
            "id": 3,
            "title": "Mediocre Iron Keyboard",
            "price": "273.4",
            "inventory_count": 5,
            "created_at": "2019-01-20T00:32:25.000Z",
            "updated_at": "2019-01-20T00:32:25.000Z"
        },
        {
            "id": 4,
            "title": "Aerodynamic Paper Chair",
            "price": "127.02",
            "inventory_count": 0,
            "created_at": "2019-01-20T00:32:25.000Z",
            "updated_at": "2019-01-20T00:32:25.000Z"
        }
        ...
    ]
}
```
which is a subset of the 20 **random** items that are seeded by default.
We're going to create a cart. Also, another person will create a cart.
So, let's send the POST request
```
http://localhost:3000/api/v1/carts
```
twice, which will give the following responses, respectively:
```js
{
    "status": "SUCCESS",
    "message": "Created cart",
    "data": {
        "id": 1,
        "completed": false,
        "total": "0.0",
        "created_at": "2019-01-20T00:43:00.000Z",
        "updated_at": "2019-01-20T00:43:00.000Z"
    }
}
```
```js
{
    "status": "SUCCESS",
    "message": "Created cart",
    "data": {
        "id": 2,
        "completed": false,
        "total": "0.0",
        "created_at": "2019-01-20T00:43:32.000Z",
        "updated_at": "2019-01-20T00:43:32.000Z"
    }
}
```

Now, let's add some items to the carts. If we try to add the product with `id` 4, we can't, as it's out of stock; if we send the POST request
```
http://localhost:3000/api/v1/carts/1/add?product_id=4
```
we get
```js
{
    "status": "ERROR",
    "message": "Could not add 1 of product with id 4 to cart",
    "data": {
        "id": 1,
        "completed": false,
        "total": "0.0",
        "created_at": "2019-01-20T00:43:00.000Z",
        "updated_at": "2019-01-20T00:43:00.000Z"
    }
}
```
Let's add the product with `id` 1 to our cart, then product with `id` 2, using the following POST requests:
```
http://localhost:3000/api/v1/carts/1/add?product_id=1
```
```
http://localhost:3000/api/v1/carts/1/add?product_id=2
```
Let's check up on the cart now by sending the GET request
```
http://localhost:3000/api/v1/carts/1
```
which gets the reponse
```js
{
    "status": "SUCCESS",
    "message": "Loaded cart",
    "data": {
        "total": "218.97",
        "in_cart": {
            "1": {
                "product_title": "Durable Wool Computer",
                "product_price": "15.44",
                "quantity": 1,
                "total": "15.44"
            },
            "2": {
                "product_title": "Small Wooden Chair",
                "product_price": "203.53",
                "quantity": 1,
                "total": "203.53"
            }
        }
    }
}
```
Now, suppose we want another product with `id` 1. If we add it to my cart again and check the cart, we get
```js
{
    "status": "SUCCESS",
    "message": "Loaded cart",
    "data": {
        "total": "234.41",
        "in_cart": {
            "1": {
                "product_title": "Durable Wool Computer",
                "product_price": "15.44",
                "quantity": 2,
                "total": "30.88"
            },
            "2": {
                "product_title": "Small Wooden Chair",
                "product_price": "203.53",
                "quantity": 1,
                "total": "203.53"
            }
        }
    }
}
```

We're done! Now, the other person loves Durable Wool Computers, so they want to buy all 199 of them! They'll send the post request
```
http://localhost:3000/api/v1/carts/2/add?product_id=1&quantity=199
```
and get
```js
{
    "status": "SUCCESS",
    "message": "Added item to cart",
    "data": {
        "id": 2,
        "completed": false,
        "total": "3072.56",
        "created_at": "2019-01-20T00:43:32.000Z",
        "updated_at": "2019-01-20T00:43:32.000Z"
    }
}
```

Now, it's a race for whoever purchases it first. If we check the products using a GET request, we'll see nothing has changed (inventory has not gone down).

We're lucky and are able to make the purchase first by sending the POST request
```
http://localhost:3000/api/v1/carts/1/complete
```
which gives a success response. Our cart is now completed (`completed == true`), and product inventories go down accordingly. When the other person tries completing their cart with the same request (but using `id` 2), they get
```js
{
    "status": "ERROR",
    "message": "Could not complete cart; it is either completed or has an invalid number of items",
    "data": {
        "id": 2,
        "completed": false,
        "total": "3072.56",
        "created_at": "2019-01-20T00:43:32.000Z",
        "updated_at": "2019-01-20T00:43:32.000Z"
    }
}
```

If we try adding more items to our cart or try completing again, we are unable to, as it has already been completed.
