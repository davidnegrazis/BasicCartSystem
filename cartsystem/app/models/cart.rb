class Cart < ApplicationRecord
  has_many :cart_items

  # price of all unit prices of items times their quantities
  def total_price
    total = 0
    cart_items.collect do |item|
      total += item.total_price
    end

    total
  end

  # returns the current order of the cart
  def order
    h = {}

    cart_items.collect do |item|
      s = { title: item.title, price: item.price, quantity: item.quantity }
      hash[item.product_id] = s
    end

    h
  end

  def empty?
    cart_items.collect do |item|
      return false if item.quantity > 0
    end

    true
  end

  # complete cart. returns true if cart was completed, false otherwise
  # a cart can be completed if it's non-empty and its items are in stock
  def complete
    return false if completed || self.empty?

    cart_items.collect do |item|
      return false if !item.can_purchase?
    end

    cart_items.collect do |item|
      item.purchase
    end

    self.update_columns(completed: true)
    true
  end

  # adds an item to the cart (i.e. creates a new item related to the cart)
  # returns true if successful, false otherwise
  def add(product_id, quantity)
    return false if self.completed

    new_item = cart_items.new({
      cart_id: id, product_id: product_id, quantity: quantity
    })

    return true if new_item.can_purchase? && new_item.save
    false
  end

  # 
  def info
    i = {total: total}
    items = {}

    cart_items.collect do |item|
      items[item.product_id] = {
        product_title: item.product_title,
        product_price: item.price,
        quantity: item.quantity,
        total: item.total_price
      }
    end

    i[:in_cart] = items

    i
  end
end
