class Product < ApplicationRecord
  validates_presence_of :title, :price, :inventory_count

  # returns true if inventory_count - n >= 0, false otherwise
  def can_purchase?(n)
    return false if inventory_count - n < 0
    true
  end

  # reduces inventory_count by n
  # assumes can_purchase?(n) == true
  def purchase(n)
    self.update_columns(inventory_count: self.inventory_count - n)
  end
end
