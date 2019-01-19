require 'faker'

# purge data
Product.delete_all

20.times do
  Product.create!({
    title: Faker::Commerce.product_name,
    price: Faker::Commerce.price(range = 0..500.00, as_string = false),
    inventory_count: Faker::Number.between(0, 200)
  })
end
