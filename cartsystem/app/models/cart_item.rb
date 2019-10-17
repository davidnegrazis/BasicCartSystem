class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :product_id, presence: true
  validates :quantity, presence: true

  def price
    product.price
  end

  def total_price
    quantity * product.price
  end

  # checks if the item can be purchased in quantity + i
  def can_purchase?(i = 0)
     product.can_purchase?(quantity + i)
  end

  def product_title
    product.title
  end

  def purchase
    product.purchase(quantity)
  end

  # increases quantity by i
  def increase_quantity(i)
    self.update_columns(quantity: quantity + i)
  end
end
