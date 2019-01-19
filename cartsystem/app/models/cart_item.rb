class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def price
    product.price
  end

  def total_price
    quantity * product.price
  end

  def can_purchase?
     product.can_purchase?(quantity)
  end

  def product_title
    product.title
  end

  def purchase
    product.purchase(quantity)
  end
end
