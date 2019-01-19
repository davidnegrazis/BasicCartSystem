class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def price
    product.price
  end

  def total_price
    quantity * product.price
  end

  # checks if the item can be purchased in quanity + i
  def can_purchase?(i = 0)
     product.can_purchase?(quantity + i)
  end

  def product_title
    product.title
  end

  def purchase
    product.purchase(quantity)
  end

  def increase_quantity(i)
    self.quantity += i
    self.save
  end
end
